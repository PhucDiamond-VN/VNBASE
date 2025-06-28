stock IsPlayerInSafeZone(playerid){
	return CallRemoteFunction("IsPlayerInSafeZone", "d", playerid);
}
stock CreateSafeZone(Float:x, Float:y, Float:z, Float:siz, virtualworld, interior){
	return CallRemoteFunction("CreateSafeZone", "ffffdd", x, y, z, siz, virtualworld, interior);
}
stock DeleteSafeZone(szid){
	return CallRemoteFunction("DeleteSafeZone", "d", szid);
}
forward OnPlayerEnterSafeZone(playerid, szid);
forward OnPlayerExitSafeZone(playerid, szid);