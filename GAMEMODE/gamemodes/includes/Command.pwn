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
CMD:setgod(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new giveplayerid;
		if(sscanf(params, "u", giveplayerid)){
			return SM(playerid, sm_error, "/sethp (playerid/playername)");
		}
		if(!IsPlayerConnected(giveplayerid))return SM(playerid, sm_error, "Nguoi choi khong ton tai");
		if(IsGod(giveplayerid)){
			SetGod(giveplayerid, false);
			RemoveTag(giveplayerid, "{34ebeb}Trang thai bat tu");
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