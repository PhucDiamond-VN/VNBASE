#include <open.mp>
#include <YSI-Includes\YSI_Coding\y_hooks>
stock IsGod(playerid){
	return CallRemoteFunction("IsGod", "d", playerid);
}
stock SetGod(playerid, bool:statee){
	return CallRemoteFunction("SetGod", "db", playerid, statee);
}
forward OnPlayerEnterGodMode(playerid);
forward OnPlayerExitGodMode(playerid);