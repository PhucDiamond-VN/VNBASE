#define FILTERSCRIPT
#include <open.mp>
#include <crashdetect>
#include <streamer>
#include "../include/CallSplashScreen"
enum eTele{
	Float:tele_pos[3],
	tele_vw,
	tele_int
}
static PlayerTeleInfo[MAX_PLAYERS][eTele];
forward waitloadingmap(playerid);
public waitloadingmap(playerid){
	DeletePVar(playerid, "waitloadingmap");
	if(CallRemoteFunction("OnPlayerTeleportSuccess", "d", playerid)) TogglePlayerControllable(playerid, true);
	SplashScreen(playerid, "TeleportScreen", 1);
	return 1;
}
forward Teleport(playerid, Float:x, Float:y, Float:z, vw, int);
public Teleport(playerid, Float:x, Float:y, Float:z, vw, int){
	TogglePlayerControllable(playerid, false);
	SetPlayerVirtualWorld(playerid, MAX_PLAYERS+playerid);
	PlayerTeleInfo[playerid][tele_pos][0] = x;
	PlayerTeleInfo[playerid][tele_pos][1] = y;
	PlayerTeleInfo[playerid][tele_pos][2] = z;
	PlayerTeleInfo[playerid][tele_vw] = vw;
	PlayerTeleInfo[playerid][tele_int] = int;
	SplashScreen(playerid, "TeleportScreen", 0);
}
forward TeleportScreen(playerid, statee);
public TeleportScreen(playerid, statee){
	Streamer_UpdateEx(playerid, PlayerTeleInfo[playerid][tele_pos][0], PlayerTeleInfo[playerid][tele_pos][1], PlayerTeleInfo[playerid][tele_pos][2], PlayerTeleInfo[playerid][tele_vw], PlayerTeleInfo[playerid][tele_int]);
	if(statee == 0){
		SetPlayerInterior(playerid, PlayerTeleInfo[playerid][tele_int]);
		SetPlayerPos(playerid, PlayerTeleInfo[playerid][tele_pos][0], PlayerTeleInfo[playerid][tele_pos][1], PlayerTeleInfo[playerid][tele_pos][2]);
		if(GetPVarType(playerid, "waitloadingmap"))KillTimer(GetPVarInt(playerid, "waitloadingmap"));
		SetPVarInt(playerid, "waitloadingmap", SetTimerEx("waitloadingmap", 2000, false, "d", playerid));
	}
	else{
		SetPlayerVirtualWorld(playerid, PlayerTeleInfo[playerid][tele_vw]);
	}
}
public OnPlayerDisconnect(playerid, reason){
	if(GetPVarType(playerid, "waitloadingmap")){
		KillTimer(GetPVarInt(playerid, "waitloadingmap"));
		DeletePVar(playerid, "waitloadingmap");
	}
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