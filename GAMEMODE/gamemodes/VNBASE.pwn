#include <open.mp>
#define function%0(%1) forward %0(%1); public %0(%1)
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
	printf("  -----------------------------------------------");
	printf("  |  Copyright 2025 PhucDiamond-VN/VNBASE  |");
	printf("  -----------------------------------------------");
	printf(" ");
}

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

