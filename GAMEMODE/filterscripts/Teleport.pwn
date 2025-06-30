#define FILTERSCRIPT
#include <open.mp>
#include <crashdetect>
#include <streamer>
#include <Pawn.RakNet>
#include "../include/CallSetGodSystem"
#include "../include/CallSplashScreen"
#include "../include/CallNameTagSystem"
enum eTele{
	bool:Istele,
	Float:tele_pos[3],
	tele_vw,
	tele_int
}
static PlayerTeleInfo[MAX_PLAYERS][eTele];
forward waitloadingmap(playerid);
public waitloadingmap(playerid){
	SetPlayerVirtualWorld(playerid, PlayerTeleInfo[playerid][tele_vw]);
	SetPlayerInterior(playerid, PlayerTeleInfo[playerid][tele_int]);
	SetPlayerPos(playerid, PlayerTeleInfo[playerid][tele_pos][0], PlayerTeleInfo[playerid][tele_pos][1], PlayerTeleInfo[playerid][tele_pos][2]);
	DeletePVar(playerid, "waitloadingmap");
	if(CallRemoteFunction("OnPlayerTeleportSuccess", "d", playerid)) TogglePlayerControllable(playerid, true);
	SplashScreen(playerid, "TeleportScreen", 1);
	return 1;
}
public OnOutgoingRPC(playerid, rpcid, BitStream:bs){
	if(rpcid == 156){// SetInterior 
		new bInteriorID;
		BS_ReadUint8(bs, bInteriorID);
		if(PlayerTeleInfo[playerid][tele_int] != bInteriorID)PlayerTeleInfo[playerid][tele_int] = bInteriorID;
	}
	if(rpcid == 48){
        new vw;
        BS_ReadUint8(bs, vw);
        if(vw != PlayerTeleInfo[playerid][tele_vw])PlayerTeleInfo[playerid][tele_vw] = vw;
    }
	return 1;
}
forward Teleport(playerid, Float:x, Float:y, Float:z);
public Teleport(playerid, Float:x, Float:y, Float:z){
	SetGod(playerid, true);
	AddTag(playerid, "{f70702}Teleporting");
	PlayerTeleInfo[playerid][Istele] = true;
	TogglePlayerControllable(playerid, false);
	PlayerTeleInfo[playerid][tele_pos][0] = x;
	PlayerTeleInfo[playerid][tele_pos][1] = y;
	PlayerTeleInfo[playerid][tele_pos][2] = z;
	SplashScreen(playerid, "TeleportScreen", 0);
}
forward TeleportScreen(playerid, statee);
public TeleportScreen(playerid, statee){
	Streamer_UpdateEx(playerid, PlayerTeleInfo[playerid][tele_pos][0], PlayerTeleInfo[playerid][tele_pos][1], PlayerTeleInfo[playerid][tele_pos][2], PlayerTeleInfo[playerid][tele_vw], PlayerTeleInfo[playerid][tele_int]);
	if(statee == 0){
		SetPlayerVirtualWorld(playerid, PlayerTeleInfo[playerid][tele_vw]);
		SetPlayerInterior(playerid, PlayerTeleInfo[playerid][tele_int]);
		SetPlayerPos(playerid, PlayerTeleInfo[playerid][tele_pos][0], PlayerTeleInfo[playerid][tele_pos][1], PlayerTeleInfo[playerid][tele_pos][2]);
		if(GetPVarType(playerid, "waitloadingmap"))KillTimer(GetPVarInt(playerid, "waitloadingmap"));
		SetPVarInt(playerid, "waitloadingmap", SetTimerEx("waitloadingmap", 2000, false, "d", playerid));
	}
	else{
		PlayerTeleInfo[playerid][Istele] = false;
		RemoveTag(playerid, "{f70702}Teleporting");
		SetGod(playerid, false);
	}
}
public OnPlayerDisconnect(playerid, reason){
	if(GetPVarType(playerid, "waitloadingmap")){
		KillTimer(GetPVarInt(playerid, "waitloadingmap"));
		DeletePVar(playerid, "waitloadingmap");
	}
	if(PlayerTeleInfo[playerid][Istele]){
		SetPlayerInterior(playerid, PlayerTeleInfo[playerid][tele_int]);
		SetPlayerVirtualWorld(playerid, PlayerTeleInfo[playerid][tele_vw]);
		SetPlayerPos(playerid, PlayerTeleInfo[playerid][tele_pos][0], PlayerTeleInfo[playerid][tele_pos][1], PlayerTeleInfo[playerid][tele_pos][2]);
		PlayerTeleInfo[playerid][Istele] = false;
	}
	PlayerTeleInfo[playerid][tele_vw] = 0;
	PlayerTeleInfo[playerid][tele_int] = 0;
	return 1;
}
public OnFilterScriptInit(){
	SetCrashDetectLongCallTime(GetConsoleVarAsInt("crashdetect.long_call_time"));
	print(" ");
	print("  -----------------------------------------------------------");
	print("  |  Copyright 2025 PhucDiamond-VN/VNBASE - Teleport System |");
	print("  -----------------------------------------------------------");
	print(" ");
}
public OnFilterScriptExit(){
	print(" ");
	print("  **  Unloading - Teleport System **");
	print(" ");
	print(" ");
	print("  **  Unload Success - Teleport System **");
	print(" ");
	return 1;
}