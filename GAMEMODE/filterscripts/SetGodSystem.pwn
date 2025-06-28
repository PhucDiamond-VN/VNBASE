#define debug 0
#include <open.mp>
#include <Pawn.RakNet>
#include <streamer>
#include <YSI-Includes\YSI_Data\y_iterate>

#define func%0(%1) forward %0(%1); public %0(%1)
func IsGod(playerid)return GetPVarType(playerid, "Godstate");
func SetGod(playerid, bool:statee){
	if(statee){
		if(IsGod(playerid))return 1;
		new Float:hp, Float:ar;
		GetPlayerHealth(playerid, hp);
		GetPlayerArmour(playerid, ar);
		SetPVarFloat(playerid, "offgodset_HP", hp);
		SetPVarFloat(playerid, "offgodset_AR", ar);
		SetPlayerHealth(playerid, 255);
		SetPlayerArmour(playerid, 255);
		SetPVarInt(playerid, "Godstate", 1);
	}
	else{
		if(!IsGod(playerid))return 1;
		DeletePVar(playerid, "Godstate");
		SetPlayerHealth(playerid, GetPVarFloat(playerid, "offgodset_HP"));
		SetPlayerArmour(playerid, GetPVarFloat(playerid, "offgodset_AR"));
		DeletePVar(playerid, "offgodset_HP");
		DeletePVar(playerid, "offgodset_AR");
	}
	return 1;
}

static SendSetPlayerHealth(playerid, Float:hp){
	new BitStream:cbs = BS_New();
	BS_WriteValue(cbs,
		PR_FLOAT, hp
	);
	PR_SendRPC(cbs, playerid, 14);
	BS_Delete(cbs);
	return 1;
}
static SendSetPlayerArmour(playerid, Float:armor){
	new BitStream:cbs = BS_New();
	BS_WriteValue(cbs,
		PR_FLOAT, armor
	);
	PR_SendRPC(cbs, playerid, 66);
	BS_Delete(cbs);
	return 1;
}
public OnIncomingPacket(playerid, packetid, BitStream:bs){
	if(packetid == 206){//BulletSync 
		new bulletData[PR_BulletSync];
	    BS_IgnoreBits(bs, 8);
	    BS_ReadBulletSync(bs, bulletData);
	    if(bulletData[PR_hitType] == 1 && IsGod(bulletData[PR_hitId]))return 0;
	}
	if(!IsGod(playerid))return 1;
	if(packetid == 207){//OnFootSync
		new onFootData[PR_OnFootSync], bool:change;
	    BS_IgnoreBits(bs, 8);
	    BS_ReadOnFootSync(bs, onFootData);
		if(onFootData[PR_health] != 255){
			onFootData[PR_health] = 255;
			SendSetPlayerHealth(playerid, 255);
			change = true;
		}
		if(onFootData[PR_armour] != 255){
			onFootData[PR_armour] = 255;
			SendSetPlayerArmour(playerid, 255);
			change = true;
		}
		if(change){
			BS_SetWriteOffset(bs, 8);
            BS_WriteOnFootSync(bs, onFootData);
		}
	}
	if(packetid == 200){//InCarSync
		new inCarData[PR_InCarSync], bool:change;
	    BS_IgnoreBits(bs, 8);
	    BS_ReadInCarSync(bs, inCarData);
		if(inCarData[PR_playerHealth] != 255){
			inCarData[PR_playerHealth] = 255;
			SendSetPlayerHealth(playerid, 255);
			change = true;
		}
		if(inCarData[PR_armour] != 255){
			inCarData[PR_armour] = 255;
			SendSetPlayerArmour(playerid, 255);
			change = true;
		}
		if(change){
			BS_SetWriteOffset(bs, 8);
            BS_WriteInCarSync(bs, inCarData);
		}
	}
	if(packetid == 211){//PassengerSync 
		new passengerData[PR_PassengerSync], bool:change;
	    BS_IgnoreBits(bs, 8);
	    BS_ReadPassengerSync(bs, passengerData);
		if(passengerData[PR_playerHealth] != 255){
			passengerData[PR_playerHealth] = 255;
			SendSetPlayerHealth(playerid, 255);
			change = true;
		}
		if(passengerData[PR_playerArmour] != 255){
			passengerData[PR_playerArmour] = 255;
			SendSetPlayerArmour(playerid, 255);
			change = true;
		}
		if(change){
			BS_SetWriteOffset(bs, 8);
            BS_WritePassengerSync(bs, passengerData);
		}
	}
	return 1;
}
public OnOutgoingRPC(playerid, rpcid, BitStream:bs){
	if(rpcid == 14){
		if(IsGod(playerid)){
			new Float:hp;
			BS_ReadFloat(bs, hp);
			if(hp== 0){
				SetGod(playerid, false);
				return 1;
			}
			else SetPVarFloat(playerid, "offgodset_HP", hp);
			return 0;
		}
	}
	if(rpcid == 66){
		if(IsGod(playerid)){
			new Float:ar;
			BS_ReadFloat(bs, ar);
			SetPVarFloat(playerid, "offgodset_AR", ar);
			return 0;
		}
	}
	return 1;
}
public OnFilterScriptInit(){
	print(" ");
	print("  ---------------------------------------------------------");
	print("  |  Copyright 2025 PhucDiamond-VN/VNBASE - SetGod System |");
	print("  ---------------------------------------------------------");
	print(" ");
	foreach(new playerid : Player){
		if(IsGod(playerid))SetGod(playerid, true);
	}
	return 1;
}
public OnFilterScriptExit(){
	SetCrashDetectLongCallTime(GetConsoleVarAsInt("crashdetect.long_call_time"));
	foreach(new playerid:Player){
		if(IsGod(playerid)){
			SendSetPlayerHealth(playerid, GetPVarFloat(playerid, "offgodset_HP"));
			SendSetPlayerArmour(playerid, GetPVarFloat(playerid, "offgodset_AR"));
		}
	}
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	SetGod(playerid, false);
	return 1;
}