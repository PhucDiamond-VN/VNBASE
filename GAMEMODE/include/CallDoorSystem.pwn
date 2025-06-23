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
stock SetDoorRangeEnterExit(did, Float:range){
	return CallRemoteFunction("SetDoorRangeEnterExit", "df", did, range);
}
stock SetDoorOpen(did, bool:Open){
	return CallRemoteFunction("SetDoorOpen", "dd", did, Open);
}
stock SetDoorTestLos(did, bool:TestLos){
	return CallRemoteFunction("SetDoorTestLos", "dd", did, TestLos);
}







stock GetDoorExtAngle(did){
	return CallRemoteFunction("GetDoorExtAngle", "d", did);
}
stock GetDoorIntAngle(did){
	return CallRemoteFunction("GetDoorIntAngle", "d", did);
}
stock GetDoorExtModelPickup(did){
	return CallRemoteFunction("GetDoorExtModelPickup", "d", did);
}
stock GetDoorIntModelPickup(did){
	return CallRemoteFunction("GetDoorIntModelPickup", "d", did);
}
stock GetDoorExtInterior(did){
	return CallRemoteFunction("GetDoorExtInterior", "d", did);
}
stock GetDoorIntInterior(did){
	return CallRemoteFunction("GetDoorIntInterior", "d", did);
}
stock GetDoorExtVirtualWorld(did){
	return CallRemoteFunction("GetDoorExtVirtualWorld", "d", did);
}
stock GetDoorIntVirtualWorld(did){
	return CallRemoteFunction("GetDoorIntVirtualWorld", "d", did);
}
stock GetDoorRangeEnterExit(did){
	return CallRemoteFunction("GetDoorRangeEnterExit", "d", did);
}
stock GetDoorOpen(did){
	return CallRemoteFunction("GetDoorOpen", "d", did);
}
stock GetDoorTestLos(did){
	return CallRemoteFunction("GetDoorTestLos", "d", did);
}
stock GaetDoorExtPos(did, &Float:x, &Float:y, &Float:z){
	CallRemoteFunction("GetDoorExtPos", "dfff", did, x, y, z);
	x = GetSVarFloat("GetDoorExtPos_x");
	y = GetSVarFloat("GetDoorExtPos_y");
	z = GetSVarFloat("GetDoorExtPos_z");
	return 1;
}
stock GaetDoorIntPos(did, &Float:x, &Float:y, &Float:z){
	CallRemoteFunction("GetDoorIntPos", "dfff", did, x, y, z);
	x = GetSVarFloat("GetDoorIntPos_x");
	y = GetSVarFloat("GetDoorIntPos_y");
	z = GetSVarFloat("GetDoorIntPos_z");
	return 1;
}






forward OnPlayerEnterExitDoor(playerid, doorid, response, Float:x, Float:y, Float:z, virtualworld, interior);