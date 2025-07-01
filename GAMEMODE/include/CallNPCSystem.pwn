stock CreateNPC(const ncpname[], skinid, Float:x, Float:y, Float:z, Float:angle, virtualworld){
	return CallRemoteFunction("CreateNPC", "sdffffd", ncpname, skinid, x, y, z, angle, virtualworld);
}
stock DestroyNPC(npcid){
	return CallRemoteFunction("DestroyNPC", "d", npcid);
}
stock SetNPCPos(npcid, Float:x, Float:y, Float:z){
	return CallRemoteFunction("SetNPCPos", "dfff", npcid, x, y, z);
}
forward OnPlayerTalkingToNPC(playerid, npcid);