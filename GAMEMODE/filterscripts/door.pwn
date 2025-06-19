#include <open.mp>
#include <a_mysql>
#include <streamer>
#include <YSI-Includes\YSI_Coding\y_va>
#include <YSI-Includes\YSI_Coding\y_timers>
#include <YSI-Includes\YSI_Data\y_iterate>
#define MAX_DOORS 2000
#define DOOR_LABEL_TEXT_SIZE 256
enum dinfo{
	Float:dPos_Ext[4],
	dIntId_Ext,
	dVwId_Ext,
	dModelPickup_Ext,
	STREAMER_TAG_PICKUP:dPickupId_Ext,
	STREAMER_TAG_3D_TEXT_LABEL:dLabelId_Ext,

	Float:dPos_Int[4],
	dIntId_Int,
	dVwId_Int,
	dModelPickup_Int,
	STREAMER_TAG_PICKUP:dPickupId_Int,
	STREAMER_TAG_3D_TEXT_LABEL:dLabelId_Int,

	dLabelText[DOOR_LABEL_TEXT_SIZE],
	Float:dRangeEnterExit
}
new bool:ChangeCheck;
new DoorInfo[MAX_DOORS][dinfo];
static LoadDoor(){
	mysql_pquery(MYSQL_DEFAULT_HANDLE, "SELECT * FROM `Door`", "OnDoorDataLoaded");
	return 1;
}
static SaveDoor(did){
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dPos_Ext[0]` = %f WHERE `id` = %d",
        DoorInfo[did][dPos_Ext][0],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dPos_Ext[1]` = %f WHERE `id` = %d",
        DoorInfo[did][dPos_Ext][1],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dPos_Ext[2]` = %f WHERE `id` = %d",
        DoorInfo[did][dPos_Ext][2],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dPos_Ext[3]` = %f WHERE `id` = %d",
        DoorInfo[did][dPos_Ext][3],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dIntId_Ext` = %d WHERE `id` = %d",
        DoorInfo[did][dIntId_Ext],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dVwId_Ext` = %d WHERE `id` = %d",
        DoorInfo[did][dVwId_Ext],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dModelPickup_Ext` = %d WHERE `id` = %d",
        DoorInfo[did][dModelPickup_Ext],
        did), false);


	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dPos_Int[0]` = %f WHERE `id` = %d",
        DoorInfo[did][dPos_Int][0],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dPos_Int[1]` = %f WHERE `id` = %d",
        DoorInfo[did][dPos_Int][1],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dPos_Int[2]` = %f WHERE `id` = %d",
        DoorInfo[did][dPos_Int][2],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dPos_Int[3]` = %f WHERE `id` = %d",
        DoorInfo[did][dPos_Int][3],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dIntId_Int` = %d WHERE `id` = %d",
        DoorInfo[did][dIntId_Int],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dVwId_Int` = %d WHERE `id` = %d",
        DoorInfo[did][dVwId_Int],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dModelPickup_Int` = %d WHERE `id` = %d",
        DoorInfo[did][dModelPickup_Int],
        did), false);


	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dLabelText` = %s WHERE `id` = %d",
        DoorInfo[did][dLabelText],
        did), false);
	mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `door` SET `dRangeEnterExit` = %f WHERE `id` = %d",
        DoorInfo[did][dRangeEnterExit],
        did), false);
	return 1;
}
new vDelayUpdate[MAX_DOORS] = {-1,...};
forward DelayUpdate(did);
public DelayUpdate(did){
	vDelayUpdate[did] = -1;
	UpdateDynamicDoor(did, true);
	return 1;
}
static UpdateDynamicDoor(did, bool:update = false){
	if(vDelayUpdate[did] != -1)KillTimer(vDelayUpdate[did]);
	vDelayUpdate[did] = SetTimerEx("DelayUpdate", 500, false, "d", did);
	if(!update)return 1;
	if(DoorInfo[did][dPickupId_Ext] != STREAMER_TAG_PICKUP:-1){
		DestroyDynamicPickup(DoorInfo[did][dPickupId_Ext]);
		DoorInfo[did][dPickupId_Ext] = STREAMER_TAG_PICKUP:-1;
	}
	if(DoorInfo[did][dLabelId_Ext] != STREAMER_TAG_3D_TEXT_LABEL:-1){
		DestroyDynamic3DTextLabel(DoorInfo[did][dLabelId_Ext]);
		DoorInfo[did][dLabelId_Ext] = STREAMER_TAG_3D_TEXT_LABEL:-1;
	}
	if(DoorInfo[did][dPickupId_Int] != STREAMER_TAG_PICKUP:-1){
		DestroyDynamicPickup(DoorInfo[did][dPickupId_Int]);
		DoorInfo[did][dPickupId_Int] = STREAMER_TAG_PICKUP:-1;
	}
	if(DoorInfo[did][dLabelId_Int] != STREAMER_TAG_3D_TEXT_LABEL:-1){
		DestroyDynamic3DTextLabel(DoorInfo[did][dLabelId_Int]);
		DoorInfo[did][dLabelId_Int] = STREAMER_TAG_3D_TEXT_LABEL:-1;
	}
	if(IsDoorExist(did)){
		DoorInfo[did][dPickupId_Ext] = CreateDynamicPickup(DoorInfo[did][dModelPickup_Ext], -1, DoorInfo[did][dPos_Ext][0], DoorInfo[did][dPos_Ext][1], DoorInfo[did][dPos_Ext][2], DoorInfo[did][dVwId_Ext], DoorInfo[did][dIntId_Ext]);
		DoorInfo[did][dLabelId_Ext] = CreateDynamic3DTextLabel(va_return("%s\n{51f542}[ID:%d]", DoorInfo[did][dLabelText], did), -1, DoorInfo[did][dPos_Ext][0], DoorInfo[did][dPos_Ext][1], DoorInfo[did][dPos_Ext][2], 50, DoorInfo[did][dVwId_Ext], DoorInfo[did][dIntId_Ext]);
		DoorInfo[did][dPickupId_Int] = CreateDynamicPickup(DoorInfo[did][dModelPickup_Int], -1, DoorInfo[did][dPos_Int][0], DoorInfo[did][dPos_Int][1], DoorInfo[did][dPos_Int][2], DoorInfo[did][dVwId_Int], DoorInfo[did][dIntId_Int]);
		DoorInfo[did][dLabelId_Int] = CreateDynamic3DTextLabel(va_return("%s\n{f5d442}[ID:%d]", DoorInfo[did][dLabelText], did), -1, DoorInfo[did][dPos_Int][0], DoorInfo[did][dPos_Int][1], DoorInfo[did][dPos_Int][2], 50, DoorInfo[did][dVwId_Int], DoorInfo[did][dIntId_Int]);
	}
	return 1;
}
public OnFilterScriptInit(){
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
    "CREATE TABLE IF NOT EXISTS `Door` (\
        `id` INT AUTO_INCREMENT PRIMARY KEY\
    )", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Ext[0]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Ext[1]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Ext[2]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Ext[3]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dIntId_Ext` Int", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dVwId_Ext` Int", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dModelPickup_Ext` Int", false);

    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Int[0]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Int[1]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Int[2]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Int[3]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dIntId_Int` Int", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dVwId_Int` Int", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dModelPickup_Int` Int", false);

    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("ALTER TABLE `Door` ADD COLUMN `dLabelText` VARCHAR(%d)", DOOR_LABEL_TEXT_SIZE), false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dRangeEnterExit` Float", false);

    LoadDoor();
	return 1;
}
static SaveAllDoor(){
	for(new did; did<MAX_DOORS; did++){
		if(IsDoorExist(did))SaveDoor(did);
	}
	ChangeCheck = false;
	return 1;
}
task TaskSaveDoor[60000](){
	if(ChangeCheck)SaveAllDoor();
}
public OnFilterScriptExit(){
	if(ChangeCheck)SaveAllDoor();
	return 1;
}
forward OnDoorDataLoaded();
public OnDoorDataLoaded(){
	for(new did; did<MAX_DOORS; did++){
		DoorInfo[did][dPickupId_Ext] = STREAMER_TAG_PICKUP:-1;
		DoorInfo[did][dLabelId_Ext] = STREAMER_TAG_3D_TEXT_LABEL:-1;
		DoorInfo[did][dPickupId_Int] = STREAMER_TAG_PICKUP:-1;
		DoorInfo[did][dLabelId_Int] = STREAMER_TAG_3D_TEXT_LABEL:-1;
		cache_get_value_name_float(did, "dPos_Ext[0]", DoorInfo[did][dPos_Ext][0]);
		cache_get_value_name_float(did, "dPos_Ext[1]", DoorInfo[did][dPos_Ext][1]);
		cache_get_value_name_float(did, "dPos_Ext[2]", DoorInfo[did][dPos_Ext][2]);
		cache_get_value_name_float(did, "dPos_Ext[3]", DoorInfo[did][dPos_Ext][3]);
		cache_get_value_name_int(did, "dIntId_Ext", DoorInfo[did][dIntId_Ext]);
		cache_get_value_name_int(did, "dVwId_Ext", DoorInfo[did][dVwId_Ext]);
		cache_get_value_name_int(did, "dModelPickup_Ext", DoorInfo[did][dModelPickup_Ext]);

		cache_get_value_name_float(did, "dPos_Int[0]", DoorInfo[did][dPos_Int][0]);
		cache_get_value_name_float(did, "dPos_Int[1]", DoorInfo[did][dPos_Int][1]);
		cache_get_value_name_float(did, "dPos_Int[2]", DoorInfo[did][dPos_Int][2]);
		cache_get_value_name_float(did, "dPos_Int[3]", DoorInfo[did][dPos_Int][3]);
		cache_get_value_name_int(did, "dIntId_Int", DoorInfo[did][dIntId_Int]);
		cache_get_value_name_int(did, "dVwId_Int", DoorInfo[did][dVwId_Int]);
		cache_get_value_name_int(did, "dModelPickup_Int", DoorInfo[did][dModelPickup_Int]);

		cache_get_value_name(did, "dLabelText", DoorInfo[did][dLabelText]);
		cache_get_value_name_float(did, "dRangeEnterExit", DoorInfo[did][dRangeEnterExit]);
		if(IsDoorExist(did)){
			UpdateDynamicDoor(did);
		}
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys){
	if(newkeys & KEY_YES){
		new pint = GetPlayerInterior(playerid), pvw = GetPlayerVirtualWorld(playerid);
		for(new did; did < MAX_DOORS; did++){
			if(IsDoorExist(did)){
				if(pint == DoorInfo[did][dIntId_Ext] && pvw == DoorInfo[did][dVwId_Ext] && IsPlayerInRangeOfPoint(playerid, DoorInfo[did][dRangeEnterExit], DoorInfo[did][dPos_Ext][0], DoorInfo[did][dPos_Ext][1], DoorInfo[did][dPos_Ext][2])){
					CallRemoteFunction("OnPlayerEnterExitDoor", "dddfffdd", playerid, did, 1, DoorInfo[did][dPos_Int][0], DoorInfo[did][dPos_Int][1], DoorInfo[did][dPos_Int][2], DoorInfo[did][dVwId_Int], DoorInfo[did][dIntId_Int]);
				}
				if(pint == DoorInfo[did][dIntId_Int] && pvw == DoorInfo[did][dVwId_Int] && IsPlayerInRangeOfPoint(playerid, DoorInfo[did][dRangeEnterExit], DoorInfo[did][dPos_Int][0], DoorInfo[did][dPos_Int][1], DoorInfo[did][dPos_Int][2])){
					CallRemoteFunction("OnPlayerEnterExitDoor", "dddfffdd", playerid, did, 0, DoorInfo[did][dPos_Ext][0], DoorInfo[did][dPos_Ext][1], DoorInfo[did][dPos_Ext][2], DoorInfo[did][dVwId_Ext], DoorInfo[did][dIntId_Ext]);
				}
			}
		}
	}
	return 1;
}
forward DeleteDoor(did);
public DeleteDoor(did){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dPos_Ext][0] = DoorInfo[did][dPos_Ext][1] = DoorInfo[did][dPos_Ext][2] = DoorInfo[did][dPos_Int][0] = DoorInfo[did][dPos_Int][1] = DoorInfo[did][dPos_Int][2] = 0;
	UpdateDynamicDoor(did);
	return 1;
}
forward IsDoorExist(did);
public IsDoorExist(did){
	if(did < 0 || did >= MAX_DOORS)return 0;
	if(DoorInfo[did][dPos_Ext][0] + DoorInfo[did][dPos_Ext][1] + DoorInfo[did][dPos_Ext][2] + DoorInfo[did][dPos_Int][0] + DoorInfo[did][dPos_Int][1] + DoorInfo[did][dPos_Int][2] != 0){
		return 1;
	}
	return 0;
}
forward GetFreeDoorid();
public GetFreeDoorid(){
	for(new did; did<MAX_DOORS; did++){
		if(!IsDoorExist(did))return did;
	}
	return -1;
}
forward SetDoorExtPos(did, Float:x, Float:y, Float:z);
public SetDoorExtPos(did, Float:x, Float:y, Float:z){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dPos_Ext][0] = x;
	DoorInfo[did][dPos_Ext][1] = y;
	DoorInfo[did][dPos_Ext][2] = z;
	ChangeCheck = true;
	UpdateDynamicDoor(did);
	return 1;
}
forward SetDoorIntPos(did, Float:x, Float:y, Float:z);
public SetDoorIntPos(did, Float:x, Float:y, Float:z){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dPos_Int][0] = x;
	DoorInfo[did][dPos_Int][1] = y;
	DoorInfo[did][dPos_Int][2] = z;
	ChangeCheck = true;
	UpdateDynamicDoor(did);
	return 1;
}
forward SetDoorExtAngle(did, Float:Angle);
public SetDoorExtAngle(did, Float:Angle){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dPos_Ext][3] = Angle;
	ChangeCheck = true;
	return 1;
}
forward SetDoorIntAngle(did, Float:Angle);
public SetDoorIntAngle(did, Float:Angle){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dPos_Int][3] = Angle;
	ChangeCheck = true;
	return 1;
}
forward SetDoorExtModelPickup(did, modelid);
public SetDoorExtModelPickup(did, modelid){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dModelPickup_Ext] = modelid;
	ChangeCheck = true;
	UpdateDynamicDoor(did);
	return 1;
}
forward SetDoorIntModelPickup(did, modelid);
public SetDoorIntModelPickup(did, modelid){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dModelPickup_Int] = modelid;
	ChangeCheck = true;
	UpdateDynamicDoor(did);
	return 1;
}
forward SetDoorTextLabelContent(did, const text[]);
public SetDoorTextLabelContent(did, const text[]){
	if(did < 0 || did >= MAX_DOORS)return 0;
	format(DoorInfo[did][dLabelText], DOOR_LABEL_TEXT_SIZE, text);
	ChangeCheck = true;
	UpdateDynamicDoor(did);
	return 1;
}
forward SetDoorExtInterior(did, interior);
public SetDoorExtInterior(did, interior){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dIntId_Ext] = interior;
	ChangeCheck = true;
	UpdateDynamicDoor(did);
	return 1;
}
forward SetDoorIntInterior(did, interior);
public SetDoorIntInterior(did, interior){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dIntId_Int] = interior;
	ChangeCheck = true;
	UpdateDynamicDoor(did);
	return 1;
}
forward SetDoorExtVirtualWorld(did, virtualworld);
public SetDoorExtVirtualWorld(did, virtualworld){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dVwId_Ext] = virtualworld;
	ChangeCheck = true;
	UpdateDynamicDoor(did);
	return 1;
}
forward SetDoorIntVirtualWorld(did, virtualworld);
public SetDoorIntVirtualWorld(did, virtualworld){
	if(did < 0 || did >= MAX_DOORS)return 0;
	DoorInfo[did][dVwId_Int] = virtualworld;
	ChangeCheck = true;
	UpdateDynamicDoor(did);
	return 1;
}

forward OnPlayerEnterExitDoor(playerid, doorid, response, Float:x, Float:y, Float:z, virtualworld, interior);