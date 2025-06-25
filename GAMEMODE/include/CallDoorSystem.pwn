stock DeleteDoor(did){
	// xóa một cánh cổng chỉ định
	// trả về 0 nếu id không hợp lệ, và trả về 1 nếu door không tồn tại hoặc xóa thành công
	return CallRemoteFunction("DeleteDoor", "d", did);
}
stock IsDoorExist(did){
	// kiểm tra sự tồn tại của door
	// trả về 1 nếu door tồn tại, và trả về 0 nếu id door không hợp lệ hoặc không tồn tại
	return CallRemoteFunction("IsDoorExist", "d", did);
}
stock GetFreeDoorid(){
	// lấy id door trống không sử dụng
	// trả về -1 nếu door đã đạt giới hạn tối đa
	return CallRemoteFunction("GetFreeDoorid");
}
stock SetDoorExtPos(did, Float:x, Float:y, Float:z){
	// đặt vị trí cổng vào (exterior) của door
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi đặt vị trí thành công
	return CallRemoteFunction("SetDoorExtPos", "dfff", did, x, y, z);
}
stock SetDoorIntPos(did, Float:x, Float:y, Float:z){
	// đặt vị trí nội thất (interior) của door
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi đặt vị trí thành công
	return CallRemoteFunction("SetDoorIntPos", "dfff", did, x, y, z);
}
stock SetDoorExtAngle(did, Float:Angle){
	// đặt hướng của nhân vật khi ra door
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorExtAngle", "df", did, Angle);
}
stock SetDoorIntAngle(did, Float:Angle){
	// đặt hướng của nhân vật khi vào door
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorIntAngle", "df", did, Angle);
}
stock SetDoorExtModelPickup(did, modelid){
	// đặt biểu tượng (model) của door ở cổng vào
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorExtModelPickup", "dd", did, modelid);
}
stock SetDoorIntModelPickup(did, modelid){
	// đặt biểu tượng (model) của door ở cổng ra
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorIntModelPickup", "dd", did, modelid);
}
stock SetDoorTextLabelContent(did, const text[]){
	// đặt văn bản trên cổng vào và ra
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorTextLabelContent", "ds", did, text);
}
stock SetDoorExtInterior(did, interior){
	// đặt id nội thất của cổng vào 
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorExtInterior", "dd", did, interior);
}
stock SetDoorIntInterior(did, interior){
	// đặt id nội thất của cổng ra
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorIntInterior", "dd", did, interior);
}
stock SetDoorExtVirtualWorld(did, virtualworld){
	// đặt id thế giới của cổng vào
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorExtVirtualWorld", "dd", did, virtualworld);
}
stock SetDoorIntVirtualWorld(did, virtualworld){
	// đặt id thế giới của cổng ra
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorIntVirtualWorld", "dd", did, virtualworld);
}
stock SetDoorRangeEnterExit(did, Float:range){
	// đặt khoảng cách giữ người chơi và cổng khi ra vào
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorRangeEnterExit", "df", did, range);
}
stock SetDoorOpen(did, bool:Open){
	// đặt trạng thái khóa của cổng
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
	return CallRemoteFunction("SetDoorOpen", "dd", did, Open);
}
stock SetDoorTestLos(did, bool:TestLos){
	// đặt trạng thái nhìn xuyên vật thể để thấy door
	// TestLos = 1 sẽ chặn không cho người chơi nhìn thấy door khi tầm nhìn bị khuất
	// TestLos = 0 sẽ nhìn xuyên tất cả vật thế để thấy door
	// trả về 0 (false) nếu id door không hợp lệ, trả về 1 khi thực hiện thành công
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





// response = 1 tức là người chơi đang muốn đi vào bên trong door, response = 0 thì người chơi đang ở bên trong và muốn ra ngoài
forward OnPlayerEnterExitDoor(playerid, doorid, response, Float:x, Float:y, Float:z, virtualworld, interior);