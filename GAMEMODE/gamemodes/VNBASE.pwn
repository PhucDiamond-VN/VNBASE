#include <open.mp>
#include <a_mysql>
#include <easydialog>
#include <YSI-Includes\YSI_Coding\y_hooks>
#include <YSI-Includes\YSI_Coding\y_va>
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

main()
{
	printf(" ");
	printf("  ------------------------------------------");
	printf("  |  Copyright 2025 PhucDiamond-VN/VNBASE  |");
	printf("  ------------------------------------------");
	printf(" ");
}

#include "./includes/database.pwn"
#include "./includes/stock.pwn"
#include "./includes/GamePlay.pwn"

public OnGameModeInit()
{
	
	EnableStuntBonusForAll(false);
	DisableInteriorEnterExits();
	SetGameModeText("Copyright 2025 PhucDiamond-VN/VNBASE");
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

