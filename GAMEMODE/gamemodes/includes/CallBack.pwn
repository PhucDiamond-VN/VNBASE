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