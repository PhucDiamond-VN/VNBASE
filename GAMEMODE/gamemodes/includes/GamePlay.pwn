#include <YSI-Includes\YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid)
{
	SetSpawnInfo(playerid, NO_TEAM, 0, 2495.3547, -1688.2319, 13.6774, 351.1646);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    new
        szString[64],
        playerName[MAX_PLAYER_NAME];

    GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

    new szDisconnectReason[5][] =
    {
        "Timeout/Crash",
        "Quit",
        "Kick/Ban",
        "Custom",
        "Mode End"
    };

    format(szString, sizeof szString, "%s left the server (%s).", playerName, szDisconnectReason[reason]);

    SendMessageToNearbyPlayers(playerid, 10, 0xC4C4C4FF, szString);
    return 1;
}

hook OnPlayerRequestClass(playerid, classid)
{
	SpawnPlayer(playerid);
	return 1;
}
hook OnPlayerRequestSpawn(playerid)
{
	SpawnPlayer(playerid);
	return 1;
}

hook OnPlayerSpawn(playerid)
{	
	SetPlayerInterior(playerid, 0);
	return 1;
}
