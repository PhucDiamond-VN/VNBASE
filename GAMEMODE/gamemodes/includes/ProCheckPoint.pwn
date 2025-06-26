#if defined PCP_INC_
    #endinput
#endif
#define PCP_INC_
#include <YSI-Includes\YSI_Coding\y_hooks>
#define CP:%0(%1) forward CP_%0(%1); public CP_%0(%1)
forward OnPlayerDisableCheckPoint(playerid);
forward OnPlayerNewCheckPoint(playerid, Float:x, Float:y, Float:z, Float:size);


stock SetPlayerProCheckpoint(playerid, Float:x, Float:y, Float:z, Float:size, const fStr[] = ""){
	if(!isnull(fStr)){
		SetPVarString(playerid, "ProCPFunction", fStr);
		SetPVarFloat(playerid, "ProCP_x", x);
		SetPVarFloat(playerid, "ProCP_y", y);
		SetPVarFloat(playerid, "ProCP_z", z);
		SetPVarFloat(playerid, "ProCP_size", size);
	}
	else{
		DeletePVar(playerid, "ProCPFunction");
		DeletePVar(playerid, "ProCP_X");
		DeletePVar(playerid, "ProCP_y");
		DeletePVar(playerid, "ProCP_z");
		DeletePVar(playerid, "ProCP_size");
	}
	if(GetPVarType(playerid, "CheckPointActive")){
		DeletePVar(playerid, "CheckPointActive");
		CallLocalFunction("OnPlayerDisableCheckPoint", "i", playerid);
	}
	SetPVarInt(playerid, "CheckPointActive", 1);
	CallLocalFunction("OnPlayerNewCheckPoint", "iffff", playerid, x, y, z, size);
	SetPlayerCheckpoint(playerid, x, y, z, size);
	return 1;
}
#if defined _ALS_SetPlayerCheckpoint
  #undef SetPlayerCheckpoint
#else
	#define _ALS_SetPlayerCheckpoint
#endif
#define SetPlayerCheckpoint SetPlayerProCheckpoint

hook function DisablePlayerCheckpoint(playerid){
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	new i = GetPVarType(playerid, "CheckPointActive");
	DeletePVar(playerid, "CheckPointActive");
	if(i)CallLocalFunction("OnPlayerDisableCheckPoint", "i", playerid);
	return continue(playerid);
}

hook OnPlayerDisconnect(playerid, reason){
	DeletePVar(playerid, "CheckPointActive");
	DeletePVar(playerid, "ProCPFunction");
	DeletePVar(playerid, "ProCP_x");
	DeletePVar(playerid, "ProCP_y");
	DeletePVar(playerid, "ProCP_z");
	DeletePVar(playerid, "ProCP_size");
}


hook OnPlayerEnterCheckpoint(playerid){
	if(GetPVarType(playerid, "ProCPFunction") && IsPlayerInRangeOfPoint(playerid, GetPVarFloat(playerid, "ProCP_size")+2.0, GetPVarFloat(playerid, "ProCP_x"), GetPVarFloat(playerid, "ProCP_y"), GetPVarFloat(playerid, "ProCP_z"))){
		new fstr[32];
		GetPVarString(playerid, "ProCPFunction", fstr, 32);
		if(strcmp("null", fstr, true) == 0)return DisablePlayerCheckpoint(playerid);
		CallLocalFunction(va_return("CP_%s",fstr), "i", playerid);
		return ~1;
	}
	return 1;
}