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
			SendClientMessage(playerid, MAU_DO1, "/dedit (doorid) (choice id) [value]");
			SendClientMessage(playerid, MAU_CAM, "Choice id: 1.Loi vao | 2.Loi ra | 3.Khoang cach ra vao | 4.model loi vao | 5.model loi ra");
			SendClientMessage(playerid, MAU_CAM, "Choice id: 6.Van ban tren cua | 7.khoa cua(1 = mo, 0 = dong) | 8.testlos(1 = thuc te, 0 = nhin xuyen tuong)");
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
public OnPlayerEnterExitDoor(playerid, doorid, response, Float:x, Float:y, Float:z, virtualworld, interior){
	if(!GetDoorOpen(doorid))return SendClientMessage(playerid, MAU_DO1, "Canh cua nay dang bi khoa!");
	Teleport(playerid, x, y, z, virtualworld, interior);
	return 1;
}