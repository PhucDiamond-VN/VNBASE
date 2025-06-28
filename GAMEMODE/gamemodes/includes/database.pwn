#include <YSI-Includes\YSI_Coding\y_hooks>

//////////////////////////////////////////////////// nếu thêm dữ liệu mới thì cập nhật chỗ này /////////////////////////////////////////////////////////
enum pInfo{
	mysqlid,
    bool:IsLoging,
	username[MAX_PLAYER_NAME],	
	password[MaxPassLen],	
	level,
    Float:ppos[4],
    pint,
    pvw
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
new PlayerInfo[MAX_PLAYERS][pInfo];
stock LoadPlayerInfo(playerid){
	GetPlayerName(playerid, PlayerInfo[playerid][username]);
    mysql_pquery(MYSQL_DEFAULT_HANDLE, va_return("SELECT * FROM `players` WHERE `username` = '%s' LIMIT 1", strtoupper(PlayerInfo[playerid][username])), "OnPlayerDataLoaded", "d", playerid);
	return 1;
}
stock InsertPlayer(playerid, const rpassword[])
{
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("INSERT INTO `players` (`username`, `password`) VALUES ('%s', '%s')",
        strtoupper(PlayerInfo[playerid][username]), rpassword));
    PlayerInfo[playerid][mysqlid] = cache_insert_id();
    return 1;
}
stock GetAllDataPlayer(playerid){ // Lấy các dữ liệu của player về PlayerInfo phục vụ cho save v.v
    GetPlayerPos(playerid, PlayerInfo[playerid][ppos][0], PlayerInfo[playerid][ppos][1], PlayerInfo[playerid][ppos][2]);
    PlayerInfo[playerid][pint] = GetPlayerInterior(playerid);
    PlayerInfo[playerid][pvw] = GetPlayerVirtualWorld(playerid);
    GetPlayerFacingAngle(playerid, PlayerInfo[playerid][ppos][3]);
}
stock DefaultRegisterValue(playerid){
    PlayerInfo[playerid][ppos][0] = ToaDo_DangkyXong_X;
    PlayerInfo[playerid][ppos][1] = ToaDo_DangkyXong_Y;
    PlayerInfo[playerid][ppos][2] = ToaDo_DangkyXong_Z;
    PlayerInfo[playerid][ppos][3] = ToaDo_DangkyXong_A;
    PlayerInfo[playerid][level] = 1;
}
stock SavePlayerInfo(playerid){
	if(!PlayerInfo[playerid][IsLoging])return 0;
	printf("Saveing player data %s", strtoupper(PlayerInfo[playerid][username]));

    GetAllDataPlayer(playerid);
//////////////////////////////////////////////////// nếu thêm dữ liệu mới thì cập nhật chỗ này /////////////////////////////////////////////////////////
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `username` = %s WHERE `id` = %d",
        strtoupper(PlayerInfo[playerid][username]),
        PlayerInfo[playerid][mysqlid]), false);
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `password` = %s WHERE `id` = %d",
        PlayerInfo[playerid][password],
        PlayerInfo[playerid][mysqlid]), false);
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `ppos[0]` = %.1f WHERE `id` = %d",
        PlayerInfo[playerid][ppos][0],
        PlayerInfo[playerid][mysqlid]), false);
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `ppos[1]` = %.1f WHERE `id` = %d",
        PlayerInfo[playerid][ppos][1],
        PlayerInfo[playerid][mysqlid]), false);
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `ppos[2]` = %.1f WHERE `id` = %d",
        PlayerInfo[playerid][ppos][2],
        PlayerInfo[playerid][mysqlid]), false);
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `ppos[3]` = %.1f WHERE `id` = %d",
        PlayerInfo[playerid][ppos][3],
        PlayerInfo[playerid][mysqlid]), false);
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `pint` = %d WHERE `id` = %d",
        PlayerInfo[playerid][pint],
        PlayerInfo[playerid][mysqlid]), false);
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `pvw` = %d WHERE `id` = %d",
        PlayerInfo[playerid][pvw],
        PlayerInfo[playerid][mysqlid]), false);
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `level` = %d WHERE `id` = %d",
        PlayerInfo[playerid][level],
        PlayerInfo[playerid][mysqlid]), false);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	printf("Save player data %s(%d) susscess", strtoupper(PlayerInfo[playerid][username]), PlayerInfo[playerid][mysqlid]);
	return 1;
}


hook OnGameModeInit(){
	mysql_query(MYSQL_DEFAULT_HANDLE,
    "CREATE TABLE IF NOT EXISTS `players` (\
        `id` INT AUTO_INCREMENT PRIMARY KEY,\
        `username` VARCHAR(24) NOT NULL,\
        `password` VARCHAR(100) NOT NULL\
    )", false);


//////////////////////////////////////////////////// nếu thêm dữ liệu mới thì cập nhật chỗ này /////////////////////////////////////////////////////////
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `players` ADD COLUMN `level` INT", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `players` ADD COLUMN `ppos[0]` FLOAT", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `players` ADD COLUMN `ppos[1]` FLOAT", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `players` ADD COLUMN `ppos[2]` FLOAT", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `players` ADD COLUMN `ppos[3]` FLOAT", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `players` ADD COLUMN `pint` INT", false);
    mysql_query(MYSQL_DEFAULT_HANDLE, "ALTER TABLE `players` ADD COLUMN `pvw` INT", false);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
hook OnPlayerConnect(playerid){
    SetPlayerHealth(playerid, 100);
    SetPlayerArmour(playerid, 0);
	return 1;
}
hook OnPlayerSpawn(playerid){
    if(!PlayerInfo[playerid][IsLoging])LoadPlayerInfo(playerid);
    SetCameraBehindPlayer(playerid);
    return 1;
}
func OnPlayerDataLoaded(playerid)
{
    if (cache_num_rows() == 0)
    {
        CallLocalFunction("OnPlayerRegister", "d", playerid);
        return 1;
    }

//////////////////////////////////////////////////// nếu thêm dữ liệu mới thì cập nhật chỗ này /////////////////////////////////////////////////////////
    cache_get_value_name_int(0, "id", PlayerInfo[playerid][mysqlid]);
    cache_get_value_name_int(0, "pint", PlayerInfo[playerid][pint]);
    cache_get_value_name_int(0, "pvw", PlayerInfo[playerid][pvw]);
    cache_get_value_name_int(0, "level", PlayerInfo[playerid][level]);
    cache_get_value_name_float(0, "ppos[0]", PlayerInfo[playerid][ppos][0]);
    cache_get_value_name_float(0, "ppos[1]", PlayerInfo[playerid][ppos][1]);
    cache_get_value_name_float(0, "ppos[2]", PlayerInfo[playerid][ppos][2]);
    cache_get_value_name_float(0, "ppos[3]", PlayerInfo[playerid][ppos][3]);
    cache_get_value_name(0, "password", PlayerInfo[playerid][password]);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CallLocalFunction("OnPlayerLoging", "d", playerid);
    return 1;
}