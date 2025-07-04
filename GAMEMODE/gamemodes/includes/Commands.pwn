CMD:sethp(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new giveplayerid, Float:hp;
		if(sscanf(params, "uf", giveplayerid, hp)){
			return SM(playerid, sm_error, "/sethp (playerid/playername) (health)");
		}
		if(!IsPlayerConnected(giveplayerid))return SM(playerid, sm_error, "Nguoi choi khong ton tai");
		SetPlayerHealth(giveplayerid, hp);
		SM(sm_admin, sm_info, "%s da set health cho %s = %.2f", PlayerInfo[playerid][username], PlayerInfo[giveplayerid][username], hp);
		return 1;
	}
	return 0;
}
CMD:setar(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new giveplayerid, Float:ar;
		if(sscanf(params, "uf", giveplayerid, ar)){
			return SM(playerid, sm_error, "/setar (playerid/playername) (armour)");
		}
		if(!IsPlayerConnected(giveplayerid))return SM(playerid, sm_error, "Nguoi choi khong ton tai");
		SetPlayerArmour(giveplayerid, ar);
		SM(sm_admin, sm_info, "%s da set armour cho %s = %.2f", PlayerInfo[playerid][username], PlayerInfo[giveplayerid][username], ar);
		return 1;
	}
	return 0;
}
CMD:setvw(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new giveplayerid, vw;
		if(sscanf(params, "ud", giveplayerid, vw)){
			return SM(playerid, sm_error, "/setvw (playerid/playername) (VirtualWorldID)");
		}
		if(!IsPlayerConnected(giveplayerid))return SM(playerid, sm_error, "Nguoi choi khong ton tai");
		SetPlayerVirtualWorld(giveplayerid, vw);
		SM(sm_admin, sm_info, "%s da set VirtualWorld cho %s = %d", PlayerInfo[playerid][username], PlayerInfo[giveplayerid][username], vw);
		return 1;
	}
	return 0;
}
CMD:setint(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new giveplayerid, int;
		if(sscanf(params, "ud", giveplayerid, int)){
			return SM(playerid, sm_error, "/setint (playerid/playername) (InteriorID)");
		}
		if(!IsPlayerConnected(giveplayerid))return SM(playerid, sm_error, "Nguoi choi khong ton tai");
		SetPlayerInterior(giveplayerid, int);
		SM(sm_admin, sm_info, "%s da set Interior cho %s = %d", PlayerInfo[playerid][username], PlayerInfo[giveplayerid][username], int);
		return 1;
	}
	return 0;
}
CMD:setgod(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new giveplayerid;
		if(sscanf(params, "u", giveplayerid)){
			return SM(playerid, sm_error, "/sethp (playerid/playername)");
		}
		if(!IsPlayerConnected(giveplayerid))return SM(playerid, sm_error, "Nguoi choi khong ton tai");
		if(IsGod(giveplayerid)){
			RemoveTag(giveplayerid, "{34ebeb}Trang thai bat tu");
			SetGod(giveplayerid, false);
			SM(sm_admin, sm_info, "%s da tat god cho %s", PlayerInfo[playerid][username], PlayerInfo[giveplayerid][username]);
		}
		else{
			SetGod(giveplayerid, true);
			AddTag(giveplayerid, "{34ebeb}Trang thai bat tu");
			SM(sm_admin, sm_info, "%s da bat god cho %s", PlayerInfo[playerid][username], PlayerInfo[giveplayerid][username]);
		}
		return 1;
	}
	return 0;
}
CMD:cdoor(playerid){
	if(IsPlayerAdmin(playerid)){
		new did = GetFreeDoorid(), Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		SetDoorExtPos(did, pos[0], pos[1], pos[2]);
		SetDoorIntPos(did, pos[0], pos[1], pos[2]+2);
		GetPlayerFacingAngle(playerid, pos[0]);
		SetDoorExtAngle(did, pos[0]);
		SetDoorIntAngle(did, pos[0]);
		SetDoorExtInterior(did, GetPlayerInterior(playerid));
		SetDoorIntInterior(did, GetPlayerInterior(playerid));
		SetDoorExtVirtualWorld(did, GetPlayerVirtualWorld(playerid));
		SetDoorIntVirtualWorld(did, GetPlayerVirtualWorld(playerid));
		SetDoorRangeEnterExit(did, 3.0);
		SetDoorExtModelPickup(did, 19606);
		SetDoorIntModelPickup(did, 19198);
		return 1;
	}
	return 0;
}
CMD:dedit(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new choice, did, value[256];
		if(sscanf(params, "ddS[256]", did, choice, value)){
			SM(playerid, sm_error, "/dedit (doorid) (choice id) [value]");
			SM(playerid, sm_info, "Choice id: 1.Loi vao | 2.Loi ra | 3.Khoang cach ra vao | 4.model loi vao | 5.model loi ra");
			SM(playerid, sm_info, "Choice id: 6.Van ban tren cua | 7.khoa cua(1 = mo, 0 = dong) | 8.testlos(1 = thuc te, 0 = nhin xuyen tuong)");
			return 1;
		}
		switch(choice){
			case 1:{
				new Float:pos[3];
				GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
				SetDoorExtPos(did, pos[0], pos[1], pos[2]);
				GetPlayerFacingAngle(playerid, pos[0]);
				SetDoorExtAngle(did, pos[0]);
				SetDoorExtInterior(did, GetPlayerInterior(playerid));
				SetDoorExtVirtualWorld(did, GetPlayerVirtualWorld(playerid));
			}
			case 2:{
				new Float:pos[3];
				GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
				SetDoorIntPos(did, pos[0], pos[1], pos[2]);
				GetPlayerFacingAngle(playerid, pos[0]);
				SetDoorIntAngle(did, pos[0]);
				SetDoorIntInterior(did, GetPlayerInterior(playerid));
				SetDoorIntVirtualWorld(did, GetPlayerVirtualWorld(playerid));
			}
			case 3:{
				SetDoorRangeEnterExit(did, floatstr(value));
			}
			case 4:{
				SetDoorExtModelPickup(did, strval(value));
			}
			case 5:{
				SetDoorIntModelPickup(did, strval(value));
			}
			case 6:{
				SetDoorTextLabelContent(did, value);
			}
			case 7:{
				if(strval(value))
					SetDoorOpen(did, true);
				else
					SetDoorOpen(did, false);
			}
			case 8:{
				if(strval(value))
					SetDoorTestLos(did, true);
				else
					SetDoorTestLos(did, false);
			}
		}
		return 1;
	}
	return 0;
}
CMD:csafezone(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new Float:size;
		if(sscanf(params, "f", size)){
			return SM(playerid, sm_error, "/csafezone (size)");
		}
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		new szid = CreateSafeZone(x, y, z, size, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
		if(szid == -1)SM(playerid, sm_error, "So luong SafeZone da dat toi da!");
		else SM(sm_admin, sm_info, "%s da tao mot safezone co id %d", PlayerInfo[playerid][username], szid);
		return 1;
	}
	return 0;
}
CMD:dsafezone(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new szid;
		if(sscanf(params, "d", szid)){
			return SM(playerid, sm_error, "/dsafezone (SafeZone id)");
		}
		if(!DeleteSafeZone(szid))SM(playerid, sm_error, "SafeZone khong ton tai!");
		else SM(sm_admin, sm_info, "%s da xoa mot safezone co id %d", PlayerInfo[playerid][username], szid);
		return 1;
	}
	return 0;
}
CMD:test(playerid){
	SetPlayerCheckpoint(playerid, 2491.5347,-1687.6877,13.5174, 5, "null");
	return 1;
}