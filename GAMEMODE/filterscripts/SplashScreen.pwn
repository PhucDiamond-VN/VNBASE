#define FILTERSCRIPT
#define NO_TAGS
#define debug 0
#include <open.mp>
#include <YSI-Includes\YSI_Coding\y_va>
#include <YSI-Includes\YSI_Coding\y_timers>
#define func%0(%1) forward %0(%1); public %0(%1)
static PlayerText:ASPLASH_Screen[MAX_PLAYERS] = {PlayerText:-1,...};
static PlayerText:ASPLASH_Screen1[MAX_PLAYERS] = {PlayerText:-1,...};
public OnFilterScriptInit(){
	print(" ");
	print("  ---------------------------------------------------------------");
	print("  |  Copyright 2025 PhucDiamond-VN/VNBASE - SplashScreen System |");
	print("  ---------------------------------------------------------------");
	print(" ");
	SetCrashDetectLongCallTime(GetConsoleVarAsInt("crashdetect.long_call_time"));
	return 1;
}
public OnFilterScriptExit(){
	print(" ");
	print("  **  Unloading - SplashScreen System **");
	print(" ");
	foreach(new i:Player){
		if(GetPVarType(i, "ASplashScreen_Timer"))KillTimer(GetPVarInt(i, "ASplashScreen_Timer"));
		if(ASPLASH_Screen[i] != PlayerText:-1)PlayerTextDrawDestroy(i, ASPLASH_Screen[i]);
		if(ASPLASH_Screen1[i] != PlayerText:-1)PlayerTextDrawDestroy(i, ASPLASH_Screen1[i]);
	}
	print(" ");
	print("  **  Unload Success - SplashScreen System **");
	print(" ");
	return 1;
}
func StartASplashScreen(playerid, const CallBack[], statee){
	if(GetPVarType(playerid, "ASplashScreen_Timer")){
		KillTimer(GetPVarInt(playerid, "ASplashScreen_Timer"));
		new ASPLASH_CallBack[32];GetPVarString(playerid, "ASPLASH_CallBack", ASPLASH_CallBack, sizeof ASPLASH_CallBack);
		DeletePVar(playerid, "ASPLASH_CallBack");
		if(!isnull(ASPLASH_CallBack))CallRemoteFunction(ASPLASH_CallBack, "ii", playerid, statee);
	}

	if(ASPLASH_Screen[playerid] == PlayerText:-1)
		ASPLASH_Screen[playerid] = CreatePlayerTextDraw(playerid, -1.000000, -1.000000, "LD_SPAC:black");
	PlayerTextDrawFont(playerid, ASPLASH_Screen[playerid], 4);
	PlayerTextDrawLetterSize(playerid, ASPLASH_Screen[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ASPLASH_Screen[playerid], 644.000000, 451.500000);
	PlayerTextDrawSetOutline(playerid, ASPLASH_Screen[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ASPLASH_Screen[playerid], 0);
	PlayerTextDrawAlignment(playerid, ASPLASH_Screen[playerid], 1);
	PlayerTextDrawBackgroundColour(playerid, ASPLASH_Screen[playerid], 255);
	PlayerTextDrawBoxColour(playerid, ASPLASH_Screen[playerid], 50);
	PlayerTextDrawUseBox(playerid, ASPLASH_Screen[playerid], true);
	PlayerTextDrawSetProportional(playerid, ASPLASH_Screen[playerid], true);
	PlayerTextDrawSetSelectable(playerid, ASPLASH_Screen[playerid], false);

	new sc;
	if(!GetPVarType(playerid, "Old_Sc") || !statee){
		sc = random(14)+1;
		SetPVarInt(playerid, "Old_Sc", sc);
	}
	else{
		sc = GetPVarInt(playerid, "Old_Sc");
	}
	if(ASPLASH_Screen1[playerid] == PlayerText:-1)
		ASPLASH_Screen1[playerid] = CreatePlayerTextDraw(playerid, -1.000000, -1.000000, va_return("loadsc%d:loadsc%d", sc, sc));
	PlayerTextDrawFont(playerid, ASPLASH_Screen1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, ASPLASH_Screen1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ASPLASH_Screen1[playerid], 644.000000, 451.500000);
	PlayerTextDrawSetOutline(playerid, ASPLASH_Screen1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ASPLASH_Screen1[playerid], 0);
	PlayerTextDrawAlignment(playerid, ASPLASH_Screen1[playerid], 1);
	PlayerTextDrawBackgroundColour(playerid, ASPLASH_Screen1[playerid], 255);
	PlayerTextDrawBoxColour(playerid, ASPLASH_Screen1[playerid], 50);
	PlayerTextDrawUseBox(playerid, ASPLASH_Screen1[playerid], true);
	PlayerTextDrawSetProportional(playerid, ASPLASH_Screen1[playerid], true);
	PlayerTextDrawSetSelectable(playerid, ASPLASH_Screen1[playerid], false);

	if(statee == 0)SetPVarInt(playerid, "ASplashScreen_Value", 0);
	else SetPVarInt(playerid, "ASplashScreen_Value", 255);
	PlayerTextDrawColour(playerid, ASPLASH_Screen[playerid], 255 << 24 | 255 << 16 | 255 << 8 | GetPVarInt(playerid, "ASplashScreen_Value"));
	PlayerTextDrawShow(playerid, ASPLASH_Screen[playerid]);
	PlayerTextDrawColour(playerid, ASPLASH_Screen1[playerid], 255 << 24 | 255 << 16 | 255 << 8 | GetPVarInt(playerid, "ASplashScreen_Value"));
	PlayerTextDrawShow(playerid, ASPLASH_Screen1[playerid]);

	SetPVarString(playerid, "ASPLASH_CallBack", CallBack);
	SetPVarInt(playerid, "ASplashScreen_Timer", SetTimerEx("ASplashScreenUpdate", 50, true, "ii", playerid, statee));
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	if(GetPVarType(playerid, "ASplashScreen_Timer")){
		KillTimer(GetPVarInt(playerid, "ASplashScreen_Timer"));
		DeletePVar(playerid, "ASplashScreen_Timer");
		DeletePVar(playerid, "ASPLASH_CallBack");
		ASPLASH_Screen1[playerid] = PlayerText:-1;
		ASPLASH_Screen[playerid] = PlayerText:-1;
	}
	return 1;
}
func IsSplashScreenExist(playerid)return GetPVarType(playerid, "ASplashScreen_Timer");
func ASplashScreenUpdate(playerid, statee){
	if(statee == 0){
		SetPVarInt(playerid, "ASplashScreen_Value", GetPVarInt(playerid, "ASplashScreen_Value")+25);
		if(GetPVarInt(playerid, "ASplashScreen_Value") > 255){
			PlayerTextDrawColour(playerid, ASPLASH_Screen[playerid], 255 << 24 | 255 << 16 | 255 << 8 | 255);
			PlayerTextDrawColour(playerid, ASPLASH_Screen1[playerid], 255 << 24 | 255 << 16 | 255 << 8 | 255);
			PlayerTextDrawShow(playerid, ASPLASH_Screen[playerid]);
			PlayerTextDrawShow(playerid, ASPLASH_Screen1[playerid]);
			
			KillTimer(GetPVarInt(playerid, "ASplashScreen_Timer"));
			DeletePVar(playerid, "ASplashScreen_Timer");

			new ASPLASH_CallBack[32];GetPVarString(playerid, "ASPLASH_CallBack", ASPLASH_CallBack, sizeof ASPLASH_CallBack);
			DeletePVar(playerid, "ASPLASH_CallBack");
			if(!isnull(ASPLASH_CallBack))CallRemoteFunction(ASPLASH_CallBack, "ii", playerid, statee);
			return;
		}
		else{
			PlayerTextDrawColour(playerid, ASPLASH_Screen[playerid], 255 << 24 | 255 << 16 | 255 << 8 | GetPVarInt(playerid, "ASplashScreen_Value"));
			PlayerTextDrawColour(playerid, ASPLASH_Screen1[playerid], 255 << 24 | 255 << 16 | 255 << 8 | GetPVarInt(playerid, "ASplashScreen_Value"));
		}
	}
	else{
		SetPVarInt(playerid, "ASplashScreen_Value", GetPVarInt(playerid, "ASplashScreen_Value")-25);
		if(GetPVarInt(playerid, "ASplashScreen_Value") < 0){
			KillTimer(GetPVarInt(playerid, "ASplashScreen_Timer"));
			DeletePVar(playerid, "ASplashScreen_Timer");
			PlayerTextDrawDestroy(playerid, ASPLASH_Screen[playerid]);
			ASPLASH_Screen[playerid] = PlayerText:-1;
			PlayerTextDrawDestroy(playerid, ASPLASH_Screen1[playerid]);
			ASPLASH_Screen1[playerid] = PlayerText:-1;
			
			new ASPLASH_CallBack[32];GetPVarString(playerid, "ASPLASH_CallBack", ASPLASH_CallBack, sizeof ASPLASH_CallBack);
			DeletePVar(playerid, "ASPLASH_CallBack");
			if(!isnull(ASPLASH_CallBack))CallRemoteFunction(ASPLASH_CallBack, "ii", playerid, statee);
			return;
		}
		else{
			PlayerTextDrawColour(playerid, ASPLASH_Screen[playerid], 255 << 24 | 255 << 16 | 255 << 8 | GetPVarInt(playerid, "ASplashScreen_Value"));
			PlayerTextDrawColour(playerid, ASPLASH_Screen1[playerid], 255 << 24 | 255 << 16 | 255 << 8 | GetPVarInt(playerid, "ASplashScreen_Value"));
		}
	}
	PlayerTextDrawShow(playerid, ASPLASH_Screen[playerid]);
	PlayerTextDrawShow(playerid, ASPLASH_Screen1[playerid]);
	return;
}