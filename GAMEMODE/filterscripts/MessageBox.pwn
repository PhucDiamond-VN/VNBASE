#define FILTERSCRIPT
#define debug 0
#include <open.mp>
#include <progress2>
#include <YSI-Includes\YSI_Coding\y_va>
#include <YSI-Includes\YSI_Data\y_iterate>
#include <textdraw-streamer>
#define HIDE 0
#define ALL 1
#define BUTTON 2
#define TIME 3
#define MAX_BAR_VALUE 100.0
new Text: Text_Global[4];
new PlayerText: Text_Player[MAX_PLAYERS][2];
new PlayerBar:bar1;
static bool:isplayerinit[MAX_PLAYERS];
static bool:isplayershow[MAX_PLAYERS];
static playertimerbar[MAX_PLAYERS] = {-1,...};
static MB_Func[MAX_PLAYERS][32];
static MB_Timer[MAX_PLAYERS];
static Init(playerid){
	if(isplayerinit[playerid])return 1;
	isplayerinit[playerid] = true;
	Text_Player[playerid][0] = CreatePlayerTextDraw(playerid, 327.000, 300.000, "New textdraw");
	PlayerTextDrawLetterSize(playerid, Text_Player[playerid][0], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][0], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, Text_Player[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][0], 2);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][0], 255);
	PlayerTextDrawFont(playerid, Text_Player[playerid][0], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][0], true);

	Text_Player[playerid][1] = CreatePlayerTextDraw(playerid, 117.000, 322.000, "message");
	PlayerTextDrawLetterSize(playerid, Text_Player[playerid][1], 0.200, 1.399);
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][1], 536.000, 211.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][1], 2);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][1], 255);
	PlayerTextDrawFont(playerid, Text_Player[playerid][1], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][1], true);

	bar1 = CreatePlayerProgressBar(playerid, 115.0, 428.0, 423.0, 1.0, 0x32a852FF, MAX_BAR_VALUE, BAR_DIRECTION_RIGHT);
	return 1;
}
static Show(playerid, type){
	if(!isplayerinit[playerid])return 0;
	new bool:slec = true;
	for(new t; t<sizeof Text_Global;t++){
		if(t == 3 && (type == 3 || type == 0)){
			slec = false;
			TextDrawHideForPlayer(playerid, Text_Global[t]);
		}
		else TextDrawShowForPlayer(playerid, Text_Global[t]);
	}
	if(slec)SelectTextDraw(playerid, 0x32a852FF);
	for(new t; t<sizeof Text_Player[];t++)PlayerTextDrawShow(playerid, Text_Player[playerid][t]);
	if(type == 0 || type == 2)HidePlayerProgressBar(playerid, bar1);
	else {
		SetPlayerProgressBarValue(playerid, bar1, 0);
		ShowPlayerProgressBar(playerid, bar1);
		if(playertimerbar[playerid] == -1)playertimerbar[playerid] = SetTimerEx("timerbar", 100, true, "d", playerid);
	}
	isplayershow[playerid] = true;
	return 1;
}
forward timerbar(playerid);
public timerbar(playerid){
	new Float:value = GetPlayerProgressBarValue(playerid, bar1), Float:addvalue = MAX_BAR_VALUE/10/MB_Timer[playerid];
	if(value + addvalue >= MAX_BAR_VALUE){
		new func[32];
		func = MB_Func[playerid];
		Hide(playerid);
		if(!isnull(func))CallRemoteFunction(func, "d", playerid);
		KillTimer(playertimerbar[playerid]);
		playertimerbar[playerid] = -1;
		return 1;
	}
	else{
		SetPlayerProgressBarValue(playerid, bar1, value + addvalue);
	}
	return 1;
}
static Hide(playerid){
	if(isplayershow[playerid]){
		CancelSelectTextDraw(playerid);
		if(playertimerbar[playerid] != -1){
			KillTimer(playertimerbar[playerid]);
			playertimerbar[playerid] = -1;
		}
		isplayershow[playerid] = false;
	}
	for(new t; t<sizeof Text_Global;t++){
		TextDrawHideForPlayer(playerid, Text_Global[t]);	
	}
	if(isplayerinit[playerid]){
		for(new t; t<sizeof Text_Player[];t++)PlayerTextDrawDestroy(playerid, Text_Player[playerid][t]);
		DestroyPlayerProgressBar(playerid, bar1);
		isplayerinit[playerid] = false;
	}
	format(MB_Func[playerid], 32, "");
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	Hide(0);
	return 1;
}
public OnFilterScriptExit(){
	print(" ");
	print("  **  Unloading - MessageBox System **");
	print(" ");
	foreach(new playerid : Player){
		Hide(playerid);
	}
	for(new t; t<sizeof Text_Global;t++){
		TextDrawDestroy(Text_Global[t]);
	}
	print(" ");
	print("  **  Unload Success - MessageBox System **");
	print(" ");
	return 1;
}
public OnFilterScriptInit(){
	print(" ");
	print("  -------------------------------------------------------------");
	print("  |  Copyright 2025 PhucDiamond-VN/VNBASE - MessageBox System |");
	print("  -------------------------------------------------------------");
	print(" ");
	SetCrashDetectLongCallTime(GetConsoleVarAsInt("crashdetect.long_call_time"));

	Text_Global[0] = TextDrawCreate(112.000, 296.000, "LD_SPAC:white");
	TextDrawTextSize(Text_Global[0], 429.000, 136.000);
	TextDrawAlignment(Text_Global[0], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[0], 156);
	TextDrawSetShadow(Text_Global[0], 0);
	TextDrawSetOutline(Text_Global[0], 0);
	TextDrawBackgroundColour(Text_Global[0], 255);
	TextDrawFont(Text_Global[0], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(Text_Global[0], true);

	Text_Global[1] = TextDrawCreate(112.000, 296.000, "LD_SPAC:white");
	TextDrawTextSize(Text_Global[1], 429.000, 5.000);
	TextDrawAlignment(Text_Global[1], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[1], 156);
	TextDrawSetShadow(Text_Global[1], 0);
	TextDrawSetOutline(Text_Global[1], 0);
	TextDrawBackgroundColour(Text_Global[1], 255);
	TextDrawFont(Text_Global[1], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(Text_Global[1], true);

	Text_Global[2] = TextDrawCreate(259.000, 319.000, "LD_SPAC:white");
	TextDrawTextSize(Text_Global[2], 133.000, 2.000);
	TextDrawAlignment(Text_Global[2], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[2], 156);
	TextDrawSetShadow(Text_Global[2], 0);
	TextDrawSetOutline(Text_Global[2], 0);
	TextDrawBackgroundColour(Text_Global[2], 255);
	TextDrawFont(Text_Global[2], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(Text_Global[2], true);

	Text_Global[3] = TextDrawCreate(520.000, 268.000, "Thoat");
	TextDrawLetterSize(Text_Global[3], 0.300, 1.500);
	TextDrawTextSize(Text_Global[3], 15.000, 39.000);
	TextDrawAlignment(Text_Global[3], TEXT_DRAW_ALIGN_CENTER);
	TextDrawColour(Text_Global[3], -2147483393);
	TextDrawSetShadow(Text_Global[3], 1);
	TextDrawSetOutline(Text_Global[3], 1);
	TextDrawBackgroundColour(Text_Global[3], 150);
	TextDrawFont(Text_Global[3], TEXT_DRAW_FONT_1);
	TextDrawSetProportional(Text_Global[3], true);
	TextDrawSetSelectable(Text_Global[3], true);
	return 1;
}
public OnClickDynamicTextDraw(playerid, Text:textid)
{
	if(!isplayershow[playerid])return 0;
	if(textid == Text_Global[3] || textid == INVALID_TEXT_DRAW){
		new func[32];
		func = MB_Func[playerid];
		Hide(playerid);
		if(strcmp(func, "null") != 0)CallRemoteFunction(func, "d", playerid);
		return 1;
	}
    return 0;
}

forward MessageBox(playerid, const title[], const content[], exittimer, bool:exitbutton, const func[]);
public MessageBox(playerid, const title[], const content[], exittimer, bool:exitbutton, const func[]){
	Init(playerid);

	PlayerTextDrawSetString(playerid, Text_Player[playerid][0], title);
	PlayerTextDrawSetString(playerid, Text_Player[playerid][1], content);
	
	if(exittimer > 0 && exitbutton)Show(playerid, ALL);
	else if(exittimer <= 0 && exitbutton)Show(playerid,BUTTON);
	else if(exittimer > 0 && !exitbutton)Show(playerid, TIME);
	else Show(playerid, HIDE);

	if(exittimer > 0)MB_Timer[playerid] = exittimer;
	if(!isnull(func))format(MB_Func[playerid], 32, func);
	else format(MB_Func[playerid], 32, "");
	return 1;
}
forward ExitMessageBox(playerid);
public ExitMessageBox(playerid){
	return Hide(playerid);
}