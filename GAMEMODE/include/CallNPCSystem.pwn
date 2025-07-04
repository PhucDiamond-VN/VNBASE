stock CreateNPC(const ncpname[], skinid, Float:x, Float:y, Float:z, Float:angle, virtualworld){
	return CallRemoteFunction("CreateNPC", "sdffffd", ncpname, skinid, x, y, z, angle, virtualworld);
}
stock DestroyNPC(npcid){
	return CallRemoteFunction("DestroyNPC", "d", npcid);
}
stock ApplyNPCAnimation(npcid, const animationLibrary[], const animationName[], Float:delta, bool:loop, bool:lockX, bool:lockY, bool:freeze, time){
	return CallRemoteFunction("ApplyNPCAnimation", "dssfbbbbd", npcid, animationLibrary, animationName, Float:delta, bool:loop, bool:lockX, bool:lockY, bool:freeze, time);
}
stock SetNPCPos(npcid, Float:x, Float:y, Float:z){
	return CallRemoteFunction("SetNPCPos", "dfff", npcid, x, y, z);
}
forward OnPlayerTalkingToNPC(playerid, npcid);