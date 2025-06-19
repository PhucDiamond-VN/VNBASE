CMD:cdoor(playerid){
	if(IsPlayerAdmin(playerid)){
		new did = GetFreeDoorid(), Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		SetDoorExtPos(did, pos[0], pos[1], pos[2]);
		SetDoorIntPos(did, pos[0], pos[1], pos[2]);
		SetDoorExtInterior(did, GetPlayerInterior(playerid));
		SetDoorIntInterior(did, GetPlayerInterior(playerid));
		SetDoorExtVirtualWorld(did, GetPlayerVirtualWorld(playerid));
		SetDoorIntVirtualWorld(did, GetPlayerVirtualWorld(playerid));
		return 1;
	}
	return 0;
}
public OnPlayerEnterExitDoor(playerid, doorid, response, Float:x, Float:y, Float:z, virtualworld, interior){
	Teleport(playerid, x, y, z, virtualworld, interior);
	return 1;
}