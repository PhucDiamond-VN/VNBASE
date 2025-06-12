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