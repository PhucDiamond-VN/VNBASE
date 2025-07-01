#include <YSI-Includes\YSI_Coding\y_hooks>
stock IsGod(playerid){
	return CallRemoteFunction("IsGod", "d", playerid);
}
stock SetGod(playerid, bool:statee){
	return CallRemoteFunction("SetGod", "db", playerid, statee);
}
forward OnPlayerEnterGodMode(playerid);
forward OnPlayerExitGodMode(playerid);
hook function GetPlayerHealth(playerid, &Float:health){
	if(IsGod(playerid)){
		health = GetPVarFloat(playerid, "offgodset_HP");
		return 1;
	}
	return continue(playerid, health);
}
hook function GetPlayerArmour(playerid, &Float:armour){
	if(IsGod(playerid)){
		armour = GetPVarFloat(playerid, "offgodset_AR");
		return 1;
	}
	return continue(playerid, armour);
}