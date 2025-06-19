#define FILTERSCRIPT
#include <open.mp>
#include <streamer>
forward waitloadingmap(playerid);
public waitloadingmap(playerid){
	DeletePVar(playerid, "waitloadingmap");
	if(CallRemoteFunction("OnPlayerTeleportSuccess", "d", playerid)) TogglePlayerControllable(playerid, true);
	return 1;
}
forward Teleport(playerid, Float:x, Float:y, Float:z, vw, int);
public Teleport(playerid, Float:x, Float:y, Float:z, vw, int){
	TogglePlayerControllable(playerid, false);
	Streamer_UpdateEx(playerid, x, y, z, vw, int);
	SetPlayerVirtualWorld(playerid, vw);
	SetPlayerInterior(playerid, int);
	SetPlayerPos(playerid, x, y, z);
	if(GetPVarType(playerid, "waitloadingmap"))KillTimer(GetPVarInt(playerid, "waitloadingmap"));
	SetPVarInt(playerid, "waitloadingmap", SetTimerEx("waitloadingmap", 2000, false, "d", playerid));
}
public OnPlayerDisconnect(playerid, reason){
	if(GetPVarType(playerid, "waitloadingmap")){
		KillTimer(GetPVarInt(playerid, "waitloadingmap"));
		DeletePVar(playerid, "waitloadingmap");
	}
	return 1;
}
