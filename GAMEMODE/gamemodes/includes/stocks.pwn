
stock SendMessageToNearbyPlayers(playerid, Float:range, color, const message[])
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    foreach(new i:Player){
        if (IsPlayerInRangeOfPoint(i, range, x, y, z) && 
			GetPlayerInterior(i) == GetPlayerInterior(playerid) &&
			GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)
		)
        {
            SendClientMessage(i, color, message);
        }
    }
}
forward OnPlayerLevelChange(playerid, oldlevel, newlevel);
hook function SetPlayerScore(playerid, score){
    new oldlevel = GetPlayerScore(playerid);
    if(oldlevel != score)CallLocalFunction("OnPlayerLevelChange", "ddd", playerid, oldlevel, score);
    return continue(playerid, score);
}
hook function ClearAnimations(playerid, FORCE_SYNC:forceSync = SYNC_ALL){
    return continue(playerid, forceSync);
}
hook function SetPlayerName(playerid, const name[]){
    format(PlayerInfo[playerid][username], 32, name);
    return continue(playerid, name);
}
stock strtoupper(const string[])
{
    new upperString[256];
    for (new character = 0; character < strlen(string); character++)
    {
        upperString[character] = toupper(string[character]);
    }
    return upperString;
}
stock strtolower(const string[])
{
    new upperString[256];
    for (new character = 0; character < strlen(string); character++)
    {
        upperString[character] = tolower(string[character]);
    }
    return upperString;
}
