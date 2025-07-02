public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
  if (!PlayerInfo[playerid][IsLoging])
  {
    SendClientMessage(playerid, -1, "Ban phai dang nhap de co the su dung lenh");
    return 0;
  }

  return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
  if (result == -1)
  {
    SendClientMessage(playerid, 0xFFFFFFFF, "server khong co lenh nay.");

    return 0;
  }

  return 1;
}
public OnPlayerText(playerid, text[]){
    ApplyAnimation(playerid, "ped", "IDLE_chat", 4.0, false, false, false, false, 1000, SYNC_ALL);
    return 1;
}
public OnPlayerDisableCheckPoint(playerid){
    return 1;
}
public OnPlayerNewCheckPoint(playerid, Float:x, Float:y, Float:z, Float:size){
    return 1;
}
public OnCancelDynamicTextDraw(playerid)
{
    return 0;
}

public OnClickDynamicTextDraw(playerid, Text:textid)
{
    return 0;
}

public OnClickDynamicPlayerTextDraw(playerid, PlayerText:textid)
{
    return 0;
}
public OnPlayerEnterExitDoor(playerid, doorid, response, Float:x, Float:y, Float:z, virtualworld, interior){
    if(!GetDoorOpen(doorid))return SendClientMessage(playerid, MAU_DO1, "Canh cua nay dang bi khoa!");
    SetPlayerInterior(playerid, interior);
    SetPlayerVirtualWorld(playerid, virtualworld);
    Teleport(playerid, x, y, z);
    return 1;
}

forward OnPlayerEnterSafeZone(playerid, szid);
public OnPlayerEnterSafeZone(playerid, szid){
    SM(playerid, sm_info, "Ban dang duoc bao ve boi safezone!");
    return 1;
}
forward OnPlayerExitSafeZone(playerid, szid);
public OnPlayerExitSafeZone(playerid, szid){
    SM(playerid, sm_info, "Ban da roi khoi khu vuc safezone hay can than!");
    return 1;
}
public OnPlayerExitGodMode(playerid){
    if(TagExist(playerid, "{34ebeb}Trang thai bat tu"))SetGod(playerid, true);
}