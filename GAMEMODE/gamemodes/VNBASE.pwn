#include <open.mp>
#include "./includes/GamePlay.pwn"

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
	printf("  |  Copyright 2025 SAMP Vietnam Gamemode Team  |");
	printf("  -----------------------------------------------");
	printf(" ");
}

public OnGameModeInit()
{
	
	EnableStuntBonusForAll(false);
	DisableInteriorEnterExits();
	SetGameModeText("Copyright 2025 SAMP Vietnam Gamemode Team");
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

