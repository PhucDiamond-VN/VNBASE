#include <YSI-Includes\YSI_Coding\y_hooks>

//////////////////////////////////////////////////// nếu thêm dữ liệu mới thì cập nhật chỗ này /////////////////////////////////////////////////////////
enum pInfo{
	mysqlid,
	username[MAX_PLAYER_NAME],	
	password[100],	
	level	
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
new PlayerInfo[MAX_PLAYERS][pInfo];
stock LoadPlayerInfo(playerid){
	GetPlayerName(playerid, PlayerInfo[playerid][username]);
    mysql_pquery(MYSQL_DEFAULT_HANDLE, va_return("SELECT * FROM `players` WHERE `username` = '%s' LIMIT 1", strtoupper(PlayerInfo[playerid][username])), "OnPlayerDataLoaded", "d", playerid);
	return 1;
}
stock InsertPlayer(playerid, const rusername[], const rpassword[])
{
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("INSERT INTO `players` (`username`, `password`) VALUES ('%s', '%s')",
        rusername, rpassword));
    PlayerInfo[playerid][mysqlid] = cache_insert_id();
    return 1;
}
stock SavePlayerInfo(playerid){
	if(PlayerInfo[playerid][mysqlid] == 0)return 0;
	printf("Saveing player data %s", strtoupper(PlayerInfo[playerid][username]));

//////////////////////////////////////////////////// nếu thêm dữ liệu mới thì cập nhật chỗ này /////////////////////////////////////////////////////////
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `username` = %s WHERE `id` = %d",
        PlayerInfo[playerid][username],
        PlayerInfo[playerid][mysqlid]), false);
    mysql_query(MYSQL_DEFAULT_HANDLE, va_return("UPDATE `players` SET `password` = %s WHERE `id` = %d",
        PlayerInfo[playerid][password],
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
hook function SetPlayerName(playerid, const name[]){
	format(PlayerInfo[playerid][username], 32, name);
	return SetPlayerName(playerid, name);
}
hook OnPlayerConnect(playerid){
	LoadPlayerInfo(playerid);
	return 1;	
}
hook OnPlayerDisconnect(playerid, reason){
	SavePlayerInfo(playerid);
}

func OnPlayerDataLoaded(playerid)
{
    if (cache_num_rows() == 0)
    {
        return 1;
    }

//////////////////////////////////////////////////// nếu thêm dữ liệu mới thì cập nhật chỗ này /////////////////////////////////////////////////////////
    cache_get_value_int(0, "id", PlayerInfo[playerid][mysqlid]);
    cache_get_value_name(0, "password", PlayerInfo[playerid][password]);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    return 1;
}