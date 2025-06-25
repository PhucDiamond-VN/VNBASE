stock AddTag(playerid, const text[]){
	// thêm một tag cho người chơi
	// nếu tag có độ dài vược giới hạn Max_Row_Len thì sẽ trả về 0 (false), tag này sẽ không được tạo ra
	// nếu tag đã tồn tại trả về 2 (true)
	// nếu tag được tạo thành công trả về 1 (true)
	return CallRemoteFunction("AddTag", "ds", playerid, text);
}
stock RemoveTag(playerid, const tagrm[]){
	// xóa một tag được chỉ định
	return CallRemoteFunction("RemoveTag", "ds", playerid, tagrm);
}
stock ClearTags(playerid){
	// Xóa tất cả tag người chơi đang sở hữu
	return CallRemoteFunction("ClearTags", "d", playerid);
}
stock TagExist(playerid, const tagexist[]){
	// Kiểm tra sự tồn tại của tag
	// nếu người chơi đã có tag này sẽ trả về 1 (true) ngược lại là 0 (false)
	return CallRemoteFunction("TagExist", "ds", playerid, tagexist);
}