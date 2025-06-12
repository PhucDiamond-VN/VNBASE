#include <YSI-Includes\YSI_Coding\y_hooks>
enum pInfo{
	mysqlid,
	playername[32],		
}
new PlayerInfo[MAX_PLAYERS][pInfo];
hook function SetPlayerName(playerid, const name[]){
	format(PlayerInfo[playerid][playername], 32, name);
	return 	SetPlayerName(playerid, name);
}
hook OnPlayerConnect(playerid){
	GetPlayerName(playerid, PlayerInfo[playerid][playername]);
	return 1;	
}