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
	STREAMER_TAG_PICKUP:dPickupId_Ext,
	STREAMER_TAG_PICKUP:dLabelId_Ext,
	dLabelText_Ext[DOOR_LABEL_TEXT_SIZE],

	Float:dPos_Int[4],
	dIntId_Int,
	dVwId_Int,
	STREAMER_TAG_PICKUP:dPickupId_Int,
	STREAMER_TAG_3D_TEXT_LABEL:dLabelId_Int,
	dLabelText_Int[DOOR_LABEL_TEXT_SIZE],
}
new DoorInfo[MAX_DOORS][dinfo];
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
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("ALTER TABLE `Door` ADD COLUMN `dLabelText_Ext` VARCHAR(%d)", DOOR_LABEL_TEXT_SIZE), false);

    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Int[0]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Int[1]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Int[2]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dPos_Int[3]` Float", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dIntId_Int` Int", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `Door` ADD COLUMN `dVwId_Int` Int", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("ALTER TABLE `Door` ADD COLUMN `dLabelText_Int` VARCHAR(%d)", DOOR_LABEL_TEXT_SIZE), false);

    LoadDoor();
	return 1;
}
forward OnDoorDataLoaded();
public OnDoorDataLoaded(){
	for(new d; d<MAX_DOORS; d++){
		cache_get_value_name_float(d, "dPos_Ext[0]", DoorInfo[d][dPos_Ext][0]);
		cache_get_value_name_float(d, "dPos_Ext[1]", DoorInfo[d][dPos_Ext][1]);
		cache_get_value_name_float(d, "dPos_Ext[2]", DoorInfo[d][dPos_Ext][2]);
		cache_get_value_name_float(d, "dPos_Ext[3]", DoorInfo[d][dPos_Ext][3]);
		cache_get_value_name_int(d, "dIntId_Ext", DoorInfo[d][dIntId_Ext]);
		cache_get_value_name_int(d, "dVwId_Ext", DoorInfo[d][dVwId_Ext]);
		cache_get_value_name(d, "dLabelText_Ext", DoorInfo[d][dLabelText_Ext]);

		cache_get_value_name_float(d, "dPos_Int[0]", DoorInfo[d][dPos_Int][0]);
		cache_get_value_name_float(d, "dPos_Int[1]", DoorInfo[d][dPos_Int][1]);
		cache_get_value_name_float(d, "dPos_Int[2]", DoorInfo[d][dPos_Int][2]);
		cache_get_value_name_float(d, "dPos_Int[3]", DoorInfo[d][dPos_Int][3]);
		cache_get_value_name_int(d, "dIntId_Int", DoorInfo[d][dIntId_Int]);
		cache_get_value_name_int(d, "dVwId_Int", DoorInfo[d][dVwId_Int]);
		cache_get_value_name(d, "dLabelText_Int", DoorInfo[d][dLabelText_Int]);
	}
	return 1;
}
static LoadDoor(){
	mysql_pquery(MYSQL_DEFAULT_HANDLE, "SELECT * FROM `Door`", "OnDoorDataLoaded");
	return 1;
}