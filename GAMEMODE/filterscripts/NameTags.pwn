#define debug 0
#include <open.mp>
#include <streamer>
#include <YSI-Includes\YSI_Data\y_iterate>
#include <YSI-Includes\YSI_Coding\y_va>
#define Max_Row_Len 25
#define Max_Rows 4
new Float:draw_radius;
new STREAMER_TAG_3D_TEXT_LABEL:PlayerTags[MAX_PLAYERS];
forward AddTag(playerid, const text[]);
public AddTag(playerid, const text[]){
	new i, alltag[Max_Rows*Max_Row_Len+34*Max_Rows+Max_Rows-1], tag[Max_Row_Len];
	for(new oldtaglen, row=1; ; i++){
		if(!GetPVarType(playerid, va_return("PlayerStringTags_%d", i))){
			if(isnull(alltag))strcat(alltag, va_return("{000000}<{ffffff}%s{000000}>{ffffff}", text));
			else {
				if(oldtaglen+strlen(text) > Max_Row_Len){
					if(row == Max_Rows)return -1;
					strcat(alltag, va_return("\n{000000}<{ffffff}%s{000000}>{ffffff}", text));
					row++;
				}
				else strcat(alltag, va_return("{000000}<{ffffff}%s{000000}>{ffffff}", text));
			}
			SetPVarString(playerid, va_return("PlayerStringTags_%d", i), text);
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
	return i;
}
forward RemoveTag(playerid, index);
public RemoveTag(playerid, index){
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
	return 1;
}
public OnFilterScriptInit(){
	print(" ");
	print("  -----------------------------------------------------------");
	print("  |  Copyright 2025 PhucDiamond-VN/VNBASE - NameTags System |");
	print("  -----------------------------------------------------------");
	print(" ");
	draw_radius = GetConsoleVarAsFloat("game.nametag_draw_radius");
	printf("nametag_draw_radius: %.2f", draw_radius);

	foreach(new playerid :Player){
		new alltag[Max_Rows*Max_Row_Len+34*Max_Rows+Max_Rows-1], tag[Max_Row_Len];
		new Float:p[3];GetPlayerPos(playerid, p[0], p[1], p[2]);
		PlayerTags[playerid] = CreateDynamic3DTextLabel("", -1, p[0], p[1], p[2], draw_radius, playerid);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerTags[playerid], E_STREAMER_Z, p[2]);
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
		if(!isnull(alltag))UpdateDynamic3DTextLabelText(PlayerTags[playerid], -1, alltag);
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
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	ClearTags(playerid);
	DestroyDynamic3DTextLabel(PlayerTags[playerid]);
	return 1;
}