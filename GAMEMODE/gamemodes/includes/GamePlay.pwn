#include <YSI-Includes\YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid)
{
	SetSpawnInfo(playerid, NO_TEAM, 0, 2495.3547, -1688.2319, 13.6774, 351.1646);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    new
        szString[64],
        playerName[MAX_PLAYER_NAME];

    GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

    new szDisconnectReason[5][] =
    {
        "Timeout/Crash",
        "Quit",
        "Kick/Ban",
        "Custom",
        "Mode End"
    };

    format(szString, sizeof szString, "%s left the server (%s).", playerName, szDisconnectReason[reason]);

    SendMessageToNearbyPlayers(playerid, 10, 0xC4C4C4FF, szString);
    return 1;
}

hook OnPlayerRequestClass(playerid, classid)
{
	SpawnPlayer(playerid);
	return 1;
}
hook OnPlayerRequestSpawn(playerid)
{
	SpawnPlayer(playerid);
	return 1;
}

hook OnPlayerSpawn(playerid)
{	
	SetPlayerInterior(playerid, 0);
	return 1;
}

hook OnGameModeInit(){
    return 1;
}

Dialog:PlayerRegister(playerid, response, listitem, inputtext[]) {
    if(response){
        if(strlen(inputtext) < MinPassLen || strlen(inputtext) >= MaxPassLen)return Dialog_Show(playerid, PlayerRegister, DIALOG_STYLE_INPUT, "Dang ky tai khoan", va_return("Tai khoan nay hien khong ton tai.\nhay nhap mat khau vao ben duoi de tien hanh dang ky.\n\n     Mat khau khong duoc qua ngan hoac qua dai (%d - %d ky tu)", MinPassLen, MaxPassLen-1), "Xong", "Thoat");
        format(PlayerInfo[playerid][password], MaxPassLen, inputtext);
        InsertPlayer(playerid, PlayerInfo[playerid][password]);
        PlayerInfo[playerid][ppos][0] = ToaDo_DangkyXong_X;
        PlayerInfo[playerid][ppos][1] = ToaDo_DangkyXong_Y;
        PlayerInfo[playerid][ppos][2] = ToaDo_DangkyXong_Z;
        PlayerInfo[playerid][ppos][3] = ToaDo_DangkyXong_A;
        SavePlayerInfo(playerid);
        PlayerInfo[playerid][IsLoging] = true;
        CallLocalFunction("OnPlayerLoging", "d", playerid);
    }
    else return Kick(playerid);
    return 1;
}
func OnPlayerRegister(playerid){
    Teleport(playerid, ToaDo_Cammera_Dangky);
    SetPlayerCameraPos(playerid, ToaDo_Cammera_Dangky);
    SetPlayerCameraLookAt(playerid, GocNhin_Cammera_Dangky);
    SetPlayerVirtualWorld(playerid, 1000+playerid);
    TogglePlayerControllable(playerid, false);
    Dialog_Show(playerid, PlayerRegister, DIALOG_STYLE_INPUT, "Dang ky tai khoan", "Tai khoan nay hien khong ton tai.\nhay nhap mat khau vao ben duoi de tien hanh dang ky.", "Xong", "Thoat");
}
Dialog:PlayerLogin(playerid, response, listitem, inputtext[]) {
    if(response){
        if(strlen(inputtext) < MinPassLen || strlen(inputtext) > MaxPassLen || strcmp(PlayerInfo[playerid][password], inputtext, true) != 0)return Dialog_Show(playerid, PlayerLogin, DIALOG_STYLE_INPUT, "Dang nhap", "Tai khoan nay da ton tai.\nhay nhap mat khau vao ben duoi de tien hanh dang nhap.\n\n     [!] Sai mat khau", "Xong", "Thoat");
        PlayerInfo[playerid][IsLoging] = true;
        CallLocalFunction("OnPlayerLoging", "d", playerid);
    }
    else return Kick(playerid);
    return 1;
}

func OnPlayerLoging(playerid){
    if(!PlayerInfo[playerid][IsLoging]){
        Teleport(playerid, ToaDo_Cammera_Dangky);
        SetPlayerCameraPos(playerid, ToaDo_Cammera_Dangky);
        SetPlayerCameraLookAt(playerid, GocNhin_Cammera_Dangky);
        SetPlayerVirtualWorld(playerid, 1000+playerid);
        TogglePlayerControllable(playerid, false);
        Dialog_Show(playerid, PlayerLogin, DIALOG_STYLE_INPUT, "Dang nhap", "Tai khoan nay da ton tai.\nhay nhap mat khau vao ben duoi de tien hanh dang nhap.", "Xong", "Thoat");
        return 1;
    }
    TogglePlayerControllable(playerid, true);
    ClearAnimations(playerid);
    SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pvw]);
    SetPlayerInterior(playerid, PlayerInfo[playerid][pint]);
    Teleport(playerid, PlayerInfo[playerid][ppos][0], PlayerInfo[playerid][ppos][1], PlayerInfo[playerid][ppos][2]);
    SetPlayerFacingAngle(playerid, PlayerInfo[playerid][ppos][3]);
    SetCameraBehindPlayer(playerid);
    return 1;
}