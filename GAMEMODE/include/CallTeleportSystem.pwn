#include <YSI-Includes\YSI_Coding\y_hooks>
new bool: controlt[MAX_PLAYERS];
stock Teleport(playerid, Float:x, Float:y, Float:z){
	return CallRemoteFunction("Teleport", "dfff", playerid, x, y, z);
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