#include <YSI-Includes\YSI_Coding\y_hooks>
new bool: controlt[MAX_PLAYERS];
stock Teleport(playerid, Float:x, Float:y, Float:z, vw = -1, int = -1){
	if(vw == -1)vw = GetPlayerVirtualWorld(playerid);
	if(int == -1)int = GetPlayerInterior(playerid);
	return CallRemoteFunction("Teleport", "dfffdd", playerid, x, y, z, vw, int);
}
forward OnPlayerTeleportSuccess(playerid);
public OnPlayerTeleportSuccess(playerid){
	return controlt[playerid];
}
hook function TogglePlayerControllable(playerid, bool:controllable){
	controlt[playerid] = controllable;
	if(GetPVarType(playerid, "waitloadingmap")){
		return 1;
	}
	return continue(playerid, controllable);
}