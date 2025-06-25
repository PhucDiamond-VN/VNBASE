stock AddTag(playerid, const text[]){
	return CallRemoteFunction("AddTag", "ds", playerid, text);
}
stock RemoveTag(playerid, const tagrm[]){
	return CallRemoteFunction("RemoveTag", "ds", playerid, tagrm);
}
stock ClearTags(playerid){
	return CallRemoteFunction("ClearTags", "d", playerid);
}
stock TagExist(playerid, const tagexist[]){
	return CallRemoteFunction("TagExist", "ds", playerid, tagexist);
}