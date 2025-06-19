stock DeleteDoor(did){
	return CallRemoteFunction("DeleteDoor", "d", did);
}
stock IsDoorExist(did){
	return CallRemoteFunction("IsDoorExist", "d", did);
}
stock GetFreeDoorid(){
	return CallRemoteFunction("GetFreeDoorid");
}
stock SetDoorExtPos(did, Float:x, Float:y, Float:z){
	return CallRemoteFunction("SetDoorExtPos", "dfff", did, x, y, z);
}
stock SetDoorIntPos(did, Float:x, Float:y, Float:z){
	return CallRemoteFunction("SetDoorIntPos", "dfff", did, x, y, z);
}
stock SetDoorExtAngle(did, Float:Angle){
	return CallRemoteFunction("SetDoorExtAngle", "df", did, Angle);
}
stock SetDoorIntAngle(did, Float:Angle){
	return CallRemoteFunction("SetDoorIntAngle", "df", did, Angle);
}
stock SetDoorExtModelPickup(did, modelid){
	return CallRemoteFunction("SetDoorExtModelPickup", "dd", did, modelid);
}
stock SetDoorIntModelPickup(did, modelid){
	return CallRemoteFunction("SetDoorIntModelPickup", "dd", did, modelid);
}
stock SetDoorTextLabelContent(did, const text[]){
	return CallRemoteFunction("SetDoorTextLabelContent", "ds", did, text);
}
stock SetDoorExtInterior(did, interior){
	return CallRemoteFunction("SetDoorExtInterior", "dd", did, interior);
}
stock SetDoorIntInterior(did, interior){
	return CallRemoteFunction("SetDoorIntInterior", "dd", did, interior);
}
stock SetDoorExtVirtualWorld(did, virtualworld){
	return CallRemoteFunction("SetDoorExtVirtualWorld", "dd", did, virtualworld);
}
stock SetDoorIntVirtualWorld(did, virtualworld){
	return CallRemoteFunction("SetDoorIntVirtualWorld", "dd", did, virtualworld);
}
forward OnPlayerEnterExitDoor(playerid, response);