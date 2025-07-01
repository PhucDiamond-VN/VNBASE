#define debug 0
#include <open.mp>
#include <a_mysql>
#include <streamer>
#include <YSI-Includes\YSI_Coding\y_va>
#include "../include/CallSetGodSystem"
#include "../include/CallNameTagSystem"
#define MAX_SAFEZONE 500
enum eSafeZone{
	Float:pos[3],
	vw,
	int,
	Float:size,
	STREAMER_TAG_PICKUP:Pickup,
	STREAMER_TAG_3D_TEXT_LABEL:Label,
	SaveTimer
}
const STREAMER_TAG_PICKUP:Invalid_pickup = STREAMER_TAG_PICKUP:-1;
const STREAMER_TAG_3D_TEXT_LABEL:Invalid_label = STREAMER_TAG_3D_TEXT_LABEL:-1;
static SafeZone[MAX_SAFEZONE][eSafeZone];
static LoadSizeZone(){
	mysql_pquery(MYSQL_DEFAULT_HANDLE, "SELECT * FROM `SafeZone`", "OnSafeZoneDataLoaded");
	return 1;
}
forward StartSave(szid);
public StartSave(szid){
	SafeZone[szid][SaveTimer] = -1;
	return SaveSafeZone(szid, true);
}
static SaveSafeZone(szid, bool:save = false){
	if(!save){
		if(SafeZone[szid][SaveTimer] != -1)KillTimer(SafeZone[szid][SaveTimer]);
		SafeZone[szid][SaveTimer] = SetTimerEx("StartSave", 60000, false, "d", szid);
		return 1;
	}
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `SafeZone` SET `pos[0]` = %.1f WHERE `id` = %d",
        SafeZone[szid][pos][0],
        szid+1), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `SafeZone` SET `pos[1]` = %.1f WHERE `id` = %d",
        SafeZone[szid][pos][1],
        szid+1), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `SafeZone` SET `pos[2]` = %.1f WHERE `id` = %d",
        SafeZone[szid][pos][2],
        szid+1), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `SafeZone` SET `size` = %.1f WHERE `id` = %d",
        SafeZone[szid][size],
        szid+1), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `SafeZone` SET `vw` = %d WHERE `id` = %d",
        SafeZone[szid][vw],
        szid+1), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `SafeZone` SET `int` = %d WHERE `id` = %d",
        SafeZone[szid][int],
        szid+1), false);
	return 1;
}
static bool:IsSafeZoneExist(szid){
	if(SafeZone[szid][pos][0] + SafeZone[szid][pos][1] + SafeZone[szid][pos][2] != 0)return true;
	return false;
}
static UpdateSafeZone(szid){
	if(SafeZone[szid][Label] != Invalid_label){
		DestroyDynamic3DTextLabel(SafeZone[szid][Label]);
		SafeZone[szid][Label] = Invalid_label;
	}
	if(SafeZone[szid][Pickup] != Invalid_pickup){
		DestroyDynamicPickup(SafeZone[szid][Pickup]);
		SafeZone[szid][Pickup] = Invalid_pickup;
	}
	if(IsSafeZoneExist(szid)){
		SafeZone[szid][Label] = CreateDynamic3DTextLabel(va_return("{34ebeb}[SafeZone | ID:%d]\n{03fc90}Noi nay duoc bao ve\n{03fc90}Tai day, ban khong the tang cong!\n{05fa3e}Hieu luc trong ban kich {f7ec1e}%.1fm", szid, SafeZone[szid][size]), -1, SafeZone[szid][pos][0], SafeZone[szid][pos][1], SafeZone[szid][pos][2], 50, .testlos = 1, .worldid = SafeZone[szid][vw], .interiorid = SafeZone[szid][int]);
		SafeZone[szid][Pickup] = CreateDynamicPickup(1242, -1, SafeZone[szid][pos][0], SafeZone[szid][pos][1], SafeZone[szid][pos][2], SafeZone[szid][vw], SafeZone[szid][int]);
	}
	return 1;
}
static GetPlayerSafeZone(playerid){
	new pvw = GetPlayerVirtualWorld(playerid), pint = GetPlayerInterior(playerid);
	for(new szid; szid<MAX_SAFEZONE; szid++){
		if(SafeZone[szid][vw] == pvw && SafeZone[szid][int] == pint && IsSafeZoneExist(szid) && IsPlayerInRangeOfPoint(playerid, SafeZone[szid][size], SafeZone[szid][pos][0], SafeZone[szid][pos][1], SafeZone[szid][pos][2]))
			return szid;
	}
	return -1;
}
public OnFilterScriptInit(){
	print(" ");
	print("  -----------------------------------------------------------");
	print("  |  Copyright 2025 PhucDiamond-VN/VNBASE - SafeZone System |");
	print("  -----------------------------------------------------------");
	print(" ");
	SetCrashDetectLongCallTime(GetConsoleVarAsInt("crashdetect.long_call_time"));
	mysql_connect_file("mysql.ini");
	new error = mysql_errno(MYSQL_DEFAULT_HANDLE);
	if (MYSQL_DEFAULT_HANDLE == MYSQL_INVALID_HANDLE || (error != 0 && error != 1060))
	{
		print("MySQL connection failed. Server is shutting down.");
		SendRconCommand("exit"); // close the server if there is no connection
		return 1;
	}
	print("MySQL connection is successful.");

	mysql_query(MYSQL_DEFAULT_HANDLE,
    "CREATE TABLE IF NOT EXISTS `SafeZone` (\
        `id` INT AUTO_INCREMENT PRIMARY KEY\
    )", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `SafeZone` ADD COLUMN `pos[0]` Float DEFAULT 0", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `SafeZone` ADD COLUMN `pos[1]` Float DEFAULT 0", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `SafeZone` ADD COLUMN `pos[2]` Float DEFAULT 0", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `SafeZone` ADD COLUMN `size` Float DEFAULT 0", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `SafeZone` ADD COLUMN `vw` int DEFAULT 0", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `SafeZone` ADD COLUMN `int` int DEFAULT 0", false);

    new Cache:cache = mysql_query(MYSQL_DEFAULT_HANDLE, "SELECT `size` FROM `SafeZone`");
    if(cache_num_rows() < MAX_SAFEZONE){
	    for(new szid; szid < MAX_SAFEZONE; szid++){
	    	mysql_query(MYSQL_DEFAULT_HANDLE, "INSERT INTO `SafeZone` (`size`) VALUES ('0')", false);
	    }
    }
    cache_delete(cache);

    LoadSizeZone();
	return 1;
}
forward OnSafeZoneDataLoaded();
public OnSafeZoneDataLoaded(){
	for(new szid; szid<MAX_SAFEZONE; szid++){
		SafeZone[szid][Pickup] = Invalid_pickup;
		SafeZone[szid][Label] = Invalid_label;
		SafeZone[szid][SaveTimer] = -1;
		cache_get_value_name_float(szid, "pos[0]", SafeZone[szid][pos][0]);
		cache_get_value_name_float(szid, "pos[1]", SafeZone[szid][pos][1]);
		cache_get_value_name_float(szid, "pos[2]", SafeZone[szid][pos][2]);
		cache_get_value_name_float(szid, "size", SafeZone[szid][size]);
		cache_get_value_name_int(szid, "vw", SafeZone[szid][vw]);
		cache_get_value_name_int(szid, "int", SafeZone[szid][int]);
		if(IsSafeZoneExist(szid))UpdateSafeZone(szid);
	}
	return 1;
}
public OnFilterScriptExit(){
	print(" ");
	print("  **  Unloading - SafeZone System **");
	print(" ");
	for(new szid;szid<MAX_SAFEZONE;szid++){
		if(SafeZone[szid][SaveTimer] != -1){
			KillTimer(SafeZone[szid][SaveTimer]);
			SaveSafeZone(szid, true);
		}
		if(IsSafeZoneExist(szid)){
			if(SafeZone[szid][Label] != Invalid_label){
				if(SafeZone[szid][Label] != Invalid_label)DestroyDynamic3DTextLabel(SafeZone[szid][Label]);
			}
			if(SafeZone[szid][Pickup] != Invalid_pickup){
				if(SafeZone[szid][Pickup] != Invalid_pickup)DestroyDynamicPickup(SafeZone[szid][Pickup]);
			}
		}
	}
	print(" ");
	print("  **  Unload Success - SafeZone System **");
	print(" ");
	return 1;
}
static GetFreeSafeZone(){
	for(new szid; szid<MAX_SAFEZONE; szid++){
		if(!IsSafeZoneExist(szid))return szid;
	}
	return -1;
}
forward CreateSafeZone(Float:x, Float:y, Float:z, Float:siz, virtualworld, interiorid);
public CreateSafeZone(Float:x, Float:y, Float:z, Float:siz, virtualworld, interiorid){
	new szid = GetFreeSafeZone();
	if(szid == -1)return -1;
	SafeZone[szid][pos][0] = x;
	SafeZone[szid][pos][1] = y;
	SafeZone[szid][pos][2] = z;
	SafeZone[szid][size] = siz;
	SafeZone[szid][vw] = virtualworld;
	SafeZone[szid][int] = interiorid;
	UpdateSafeZone(szid);
	SaveSafeZone(szid);
	return szid;
}
forward DeleteSafeZone(szid);
public DeleteSafeZone(szid){
	if(szid < 0 || szid >= MAX_SAFEZONE)return 0;
	SafeZone[szid][pos][0] = SafeZone[szid][pos][1] = SafeZone[szid][pos][2] = 0;
	UpdateSafeZone(szid);
	return 1;
}
forward IsPlayerInSafeZone(playerid);
public IsPlayerInSafeZone(playerid){
	return GetPVarType(playerid, "InSafeZone");
}
public OnPlayerUpdate(playerid){
	new szid = GetPlayerSafeZone(playerid);
	if(szid != -1 && !GetPVarType(playerid, "InSafeZone")){
		SetPVarInt(playerid, "InSafeZone", szid);
		CallRemoteFunction("OnPlayerEnterSafeZone", "dd", playerid, szid);
	}
	if(szid == -1 && GetPVarType(playerid, "InSafeZone")){
		DeletePVar(playerid, "InSafeZone");
		CallRemoteFunction("OnPlayerExitSafeZone", "dd", playerid, szid);
	}
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	DeletePVar(playerid, "InSafeZone");
	return 1;
}
forward OnPlayerEnterSafeZone(playerid, szid);
public OnPlayerEnterSafeZone(playerid, szid){
    SetGod(playerid, true);
    AddTag(playerid, "{03fc90}SafeZone bao ve");
    return 1;
}
forward OnPlayerExitSafeZone(playerid, szid);
public OnPlayerExitSafeZone(playerid, szid){
    SetGod(playerid, false);
    RemoveTag(playerid, "{03fc90}SafeZone bao ve");
    return 1;
}
public OnPlayerExitGodMode(playerid){
	if(IsPlayerInSafeZone(playerid))SetGod(playerid, true);
}