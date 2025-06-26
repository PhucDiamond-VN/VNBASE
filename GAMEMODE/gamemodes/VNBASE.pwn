#define debug 0
#include <open.mp>
#include <a_mysql>
#include <easydialog>
#include <streamer>
#include <Pawn.CMD>
#include <sscanf2>
#include <YSI-Includes\YSI_Coding\y_hooks>
#include <YSI-Includes\YSI_Coding\y_va>
#include <YSI-Includes\YSI_Coding\y_timers>
#include <YSI-Includes\YSI_Data\y_iterate>
#define func%0(%1) forward %0(%1); public %0(%1)
#if !defined setnull
	#define setnull(%1) %1[0]='\1'; %1[1]=0
#endif
/*
	 ___      _
	/ __| ___| |_ _  _ _ __
	\__ \/ -_)  _| || | '_ \
	|___/\___|\__|\_,_| .__/
					  |_|
*/
////////////////////////////////////////////////////////////////////////////////////////
#define ToaDo_Cammera_Dangky 2463.2151,-1655.5500,20.3047 // vị trí của cam khi vào đăng ký
#define GocNhin_Cammera_Dangky 2509.6338,-1687.9923,13.5510 // vị trí mà cam nhìn vào khi đăng ký
#define ToaDo_DangkyXong_X 2495.2061 // đăng ký xong tele qua đây
#define ToaDo_DangkyXong_Y -1690.9382 // đăng ký xong tele qua đây
#define ToaDo_DangkyXong_Z 14.7656 // đăng ký xong tele qua đây
#define ToaDo_DangkyXong_A 1.4737 // đăng ký xong tele qua đây
/////////////////////////////////////////////////////////////////////////////////////////
#define TimeSavePlayerData 60000*3 // 3 phút save một lần
#define MinPassLen 3 // độ dài tối thiểu của pass
#define MaxPassLen 33 // độ dài tối đa của pass
#define LevelNewbie 3 // Từ level này trở xuống sẽ có tag Newbie
/////////////////////////////////////////////////////////////////////////////////////////
main()
{
	print(" ");
	print("  ------------------------------------------------");
	print("  |  Copyright 2025 PhucDiamond-VN/VNBASE - Main |");
	print("  ------------------------------------------------");
	print(" ");
}
hook OnGameModeInit()
{
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

	EnableStuntBonusForAll(false);
	DisableInteriorEnterExits();
	SetGameModeText("Copyright 2025 PhucDiamond-VN/VNBASE");
	return 1;
}


#include "../include/CallDoorSystem"
#include "../include/CallNameTagSystem"
#include "../include/CallTeleportSystem"
#include "../include/CallSplashScreen"
#include "./includes/ProCheckPoint"
#include "./includes/SystemMessage.pwn"
#include "./includes/Color-define.pwn"
#include "./includes/database.pwn"
#include "./includes/stock.pwn"
#include "./includes/Door/DoorCMD.pwn"
#include "./includes/GamePlay.pwn"




#include <YSI-Includes\YSI_Coding\y_hooks>
hook OnGameModeExit()
{
	foreach(new i:Player){
		CallRemoteFunction("OnPlayerDisconnect", "dd", i, 4);
	}
	DestroyAllDynamicObjects();
	DestroyAllDynamicPickups();
	DestroyAllDynamicCPs();
	DestroyAllDynamicAreas();
	DestroyAllDynamicRaceCPs();
	DestroyAllDynamicMapIcons();
	DestroyAllDynamic3DTextLabels();
	mysql_close(MYSQL_DEFAULT_HANDLE);
	return 1;
}
ptask SavePlayerData[TimeSavePlayerData](playerid){
	SavePlayerInfo(playerid);
}
hook OnPlayerDisconnect(playerid, reason){
	SavePlayerInfo(playerid);
    new empty[pInfo];
    PlayerInfo[playerid] = empty;
	return 1;
}