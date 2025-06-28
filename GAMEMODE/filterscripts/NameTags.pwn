#define debug 0
#include <open.mp>
#include <streamer>
#include <YSI-Includes\YSI_Data\y_iterate>
#include <YSI-Includes\YSI_Coding\y_va>
#define Max_NameTag_Len 100
#define Max_Row_Len 50
#define Max_Rows 4
static Float:draw_radius;
static STREAMER_TAG_3D_TEXT_LABEL:PlayerTags[MAX_PLAYERS];
static updatetag(playerid){
	new alltag[Max_Rows*Max_Row_Len+34*Max_Rows+Max_Rows-1], tag[Max_NameTag_Len];
	for(new i, oldtaglen, row=1; ; i++){
		if(!GetPVarType(playerid, va_return("PlayerStringTags_%d", i))){
			break;
		}
		else{
			GetPVarString(playerid, va_return("PlayerStringTags_%d", i), tag);
			if(isnull(alltag)){
				strcat(alltag, va_return("{000000}<{ffffff}%s{000000}>{ffffff}", tag));
				oldtaglen = strlen(tag);
			}
			else {
				if(oldtaglen+strlen(tag) > Max_Row_Len){
					if(row == Max_Rows){
						strcat(alltag, "...");
						break;
					}
					strcat(alltag, va_return("\n{000000}<{ffffff}%s{000000}>{ffffff}", tag));
					oldtaglen = strlen(tag);
					row++;
				}
				else{
					strcat(alltag, va_return("{000000}<{ffffff}%s{000000}>{ffffff}", tag));
					oldtaglen += strlen(tag);
				}
			}
		}
	}
	if(!isnull(alltag))UpdateDynamic3DTextLabelText(PlayerTags[playerid], -1, alltag);
	return 1;
}
forward TagExist(playerid, const tagexist[]);
public TagExist(playerid, const tagexist[]){
	for(new i; ;i++){
		if(!GetPVarType(playerid, va_return("PlayerStringTags_%d", i))){
			break;
		}
		else{
			new tag[Max_NameTag_Len];
			GetPVarString(playerid, va_return("PlayerStringTags_%d", i), tag);
			if(strcmp(tagexist, tag, true) == 0){
				return 1;
			}
		}
	}
	return 0;
}
forward AddTag(playerid, const text[]);
public AddTag(playerid, const text[]){
	if(strlen(text) > Max_Row_Len)return 0;
	if(TagExist(playerid, text))return 2;
	new i, alltag[Max_Rows*Max_Row_Len+34*Max_Rows+Max_Rows-1], tag[Max_NameTag_Len];
	for(new oldtaglen, row=1; ; i++){
		if(!GetPVarType(playerid, va_return("PlayerStringTags_%d", i))){
			SetPVarString(playerid, va_return("PlayerStringTags_%d", i), text);
			if(isnull(alltag))strcat(alltag, va_return("{000000}<{ffffff}%s{000000}>{ffffff}", text));
			else {
				if(oldtaglen+strlen(text) > Max_Row_Len){
					if(row == Max_Rows){
						strcat(alltag, "...");
						break;
					}
					strcat(alltag, va_return("\n{000000}<{ffffff}%s{000000}>{ffffff}", text));
					row++;
				}
				else strcat(alltag, va_return("{000000}<{ffffff}%s{000000}>{ffffff}", text));
			}
			break;
		}
		else{
			GetPVarString(playerid, va_return("PlayerStringTags_%d", i), tag);
			if(isnull(alltag)){
				strcat(alltag, va_return("{000000}<{ffffff}%s{000000}>{ffffff}", tag));
				oldtaglen = strlen(tag);
			}
			else {
				if(oldtaglen+strlen(tag) > Max_Row_Len){
					if(row == Max_Rows)break;
					strcat(alltag, va_return("\n{000000}<{ffffff}%s{000000}>{ffffff}", tag));
					oldtaglen = strlen(tag);
					row++;
				}
				else{
					strcat(alltag, va_return("{000000}<{ffffff}%s{000000}>{ffffff}", tag));
					oldtaglen += strlen(tag);
				}
			}
		}
	}
	UpdateDynamic3DTextLabelText(PlayerTags[playerid], -1, alltag);
	return 1;
}
forward RemoveTag(playerid, const tagrm[]);
public RemoveTag(playerid, const tagrm[]){
	for(new i; ;i++){
		if(!GetPVarType(playerid, va_return("PlayerStringTags_%d", i))){
			break;
		}
		else{
			new tag[Max_NameTag_Len];
			GetPVarString(playerid, va_return("PlayerStringTags_%d", i), tag);
			if(strcmp(tagrm, tag, true) == 0){
				DeletePVar(playerid, va_return("PlayerStringTags_%d", i));
				for(new j=i+1; ;j++, i++){
					if(GetPVarType(playerid, va_return("PlayerStringTags_%d", j))){
						GetPVarString(playerid, va_return("PlayerStringTags_%d", j), tag);
						SetPVarString(playerid, va_return("PlayerStringTags_%d", i), tag);
					}
					else{
						DeletePVar(playerid, va_return("PlayerStringTags_%d", i));
						break;
					}
				}
				updatetag(playerid);
				return 1;
			}
		}
	}
	return 1;
}
forward ClearTags(playerid);
public ClearTags(playerid){
	for(new i; ; i++){
		if(GetPVarType(playerid, va_return("PlayerStringTags_%d", i))){
			DeletePVar(playerid, va_return("PlayerStringTags_%d", i));
		}
		else break;
	}
	UpdateDynamic3DTextLabelText(PlayerTags[playerid], -1, "");
	return 1;
}
public OnFilterScriptInit(){
	print(" ");
	print("  -----------------------------------------------------------");
	print("  |  Copyright 2025 PhucDiamond-VN/VNBASE - NameTags System |");
	print("  -----------------------------------------------------------");
	print(" ");
	SetCrashDetectLongCallTime(GetConsoleVarAsInt("crashdetect.long_call_time"));
	draw_radius = GetConsoleVarAsFloat("game.nametag_draw_radius");
	printf("nametag_draw_radius: %.2f", draw_radius);

	foreach(new playerid :Player){
		new Float:p[3];GetPlayerPos(playerid, p[0], p[1], p[2]);
		PlayerTags[playerid] = CreateDynamic3DTextLabel("", -1, p[0], p[1], p[2], draw_radius, playerid);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerTags[playerid], E_STREAMER_Z, p[2]+1);
		updatetag(playerid);
	}
	return 1;
}
public OnFilterScriptExit(){
	foreach(new playerid:Player){
		DestroyDynamic3DTextLabel(PlayerTags[playerid]);
	}
	return 1;
}
public OnPlayerConnect(playerid){
	new Float:p[3];GetPlayerPos(playerid, p[0], p[1], p[2]);
	PlayerTags[playerid] = CreateDynamic3DTextLabel("", -1, p[0], p[1], p[2], draw_radius, playerid);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerTags[playerid], E_STREAMER_Z, p[2]+1);
	ClearTags(playerid);
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	DestroyDynamic3DTextLabel(PlayerTags[playerid]);
	return 1;
}