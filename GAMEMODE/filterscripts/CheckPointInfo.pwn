#define FILTERSCRIPT
#define debug 0
#include <open.mp>
#include <crashdetect>
#include <streamer>
#include <Pawn.Raknet>
#include <PawnPlus>
#include <YSI-Includes\YSI_Data\y_iterate>
#include <textdraw-streamer>
#include <GPS>
#include <map-zones>
#define func%0(%1) forward %0(%1); public %0(%1)
#define MAX_ARROW 30
static PlayerText: Text_Player[MAX_PLAYERS][2] = {{PlayerText:-1,...},...};
static UpdateTimer[MAX_PLAYERS] = {-1,...};
static Float:PlayerOldPos[MAX_PLAYERS][3];
static ObjectArrow[MAX_PLAYERS][MAX_ARROW] = {{-1,...},...};
static Float:Cache[MAX_PLAYERS][MAX_ARROW];
static Float:GetAbsoluteAngle(Float:angle) {
	while(angle < 0.0) {
		angle += 360.0;
	}
	while(angle > 360.0) {
		angle -= 360.0;
	}
	return angle;
}
static Float:GetAngleToPoint(Float:fPointX, Float:fPointY, Float:fDestX, Float:fDestY) {
	return GetAbsoluteAngle(-(
		90.0 - (
			atan2(
				(fDestY - fPointY),
				(fDestX - fPointX)
			)
		)
	));
}
static Float:GetDistanceToPoint2D(Float:x, Float:y, Float:xx, Float:yy)
{
	return VectorSize(x - xx, y - yy, 0);
}
static Float:CalculatorDistance(Path:path) {
    new Float:x, Float:y, Float:z, Float:xx, Float:yy, size, MapNode:node, Float:Distance;
    GetPathSize(path, size);
    for (new i; i < size; i++) {
        GetPathNode(path, i, node);
        GetMapNodePos(node, x, y, z);
        if(i > 0)Distance += GetDistanceToPoint2D(x, y, xx, yy);
        xx = x;
        yy = y;
    }
    return Distance;
}
static UpdateARROW(playerid, Path:path) {
    new size, Float:pos[MAX_ARROW][3], Float:staticcache[MAX_ARROW], Float:objectrot[MAX_ARROW];
    GetPathSize(path, size);
    for (new i, MapNode:node, Float:oldpos[2]; i < size && i < MAX_ARROW; i++) {
        GetPathNode(path, i, node);
        GetMapNodePos(node, pos[i][0], pos[i][1], pos[i][2]);
    	staticcache[i] = pos[i][0]+pos[i][1]+pos[i][2];
    	if(i > 0 && i < MAX_ARROW){
    		objectrot[i-1] = GetAngleToPoint(oldpos[0], oldpos[1], pos[i][0], pos[i][1])-90;
    	}
    	oldpos[0] = pos[i][0];
    	oldpos[1] = pos[i][1];
    }
    new Iterator:oldpoint<MAX_ARROW>;
    for(new i;i<MAX_ARROW;i++){
    	new bool:tmp;
    	if(Cache[playerid][i] != 0){
	    	for(new j;j<MAX_ARROW;j++){
	    		if(Cache[playerid][i] == staticcache[j]){
	    			tmp = true;
	    			break;
	    		}
	    	}
	    }
    	if(!tmp)Iter_Add(oldpoint, i);
    }
    for(new i, j; i<MAX_ARROW; i++, j=0){
    	new bool:tmp;
    	for(;j<MAX_ARROW;j++){
    		if(staticcache[i] == Cache[playerid][j]){
    			tmp = true;
    			break;
    		}
    	}
    	if(tmp){
    		if(ObjectArrow[playerid][j] != -1){
	    		new Float:rotx, Float:roty, Float:rotz;
	    		GetDynamicObjectRot(ObjectArrow[playerid][j], rotx, roty, rotz);
	    		if(floatabs(objectrot[i] - rotz) >= 3){
		    		if(i == size-1)SetDynamicObjectRot(ObjectArrow[playerid][j], 0, 0, 0);
		    		else SetDynamicObjectRot(ObjectArrow[playerid][j], 0, 115, objectrot[i]);
		    	}
		    }
    		continue;
    	}
    	else{
    		new point = Iter_Last(oldpoint);
    		Iter_Remove(oldpoint, point);
    		if(i >= size){
    			if(ObjectArrow[playerid][point] != -1)DestroyDynamicObject(ObjectArrow[playerid][point]);
    			ObjectArrow[playerid][point] = -1;
    			Cache[playerid][point] = 0;
    			continue;
    		}

    		if(ObjectArrow[playerid][point] != -1){
    			SetDynamicObjectPos(ObjectArrow[playerid][point], pos[i][0], pos[i][1], pos[i][2]+1);
    			new Float:rotx, Float:roty, Float:rotz;
	    		GetDynamicObjectRot(ObjectArrow[playerid][point], rotx, roty, rotz);
	    		if(floatabs(objectrot[i] - rotz) >= 3){
			    	if(i == size-1)SetDynamicObjectRot(ObjectArrow[playerid][point], 0, 0, 0);
			    	else SetDynamicObjectRot(ObjectArrow[playerid][point], 0, 115, objectrot[i]);
			    }
    		}
    		else {
    			if(i == size-1)ObjectArrow[playerid][point] = CreateDynamicObject(1318, pos[i][0], pos[i][1], pos[i][2]+1, 0, 0, 0, -1, 0, playerid);
    			else ObjectArrow[playerid][point] = CreateDynamicObject(1318, pos[i][0], pos[i][1], pos[i][2]+1, 0, 115, objectrot[i], -1, 0, playerid);
    		}
    		
    		Cache[playerid][point] = pos[i][0]+pos[i][1]+pos[i][2];
    	}
    }
    foreach(new point :oldpoint){
		if(ObjectArrow[playerid][point] != -1)DestroyDynamicObject(ObjectArrow[playerid][point]);
		ObjectArrow[playerid][point] = -1;
		Cache[playerid][point] = 0;
    }
}

static PlayerCheckPointIndex[MAX_PLAYERS];
func UpdateCheckPointInfo(playerid, Float:x, Float:y, Float:z, index){
	UpdateTimer[playerid] = -1;
	new locationname[MAX_MAP_ZONE_NAME], MapZone:map = GetPlayerMapZone2D(playerid), Float:ppos[3];
	GetPlayerPos(playerid, ppos[0], ppos[1], ppos[2]);
	if(PlayerOldPos[playerid][0] == ppos[0] && PlayerOldPos[playerid][1] == ppos[1] && PlayerOldPos[playerid][2] == ppos[2]){
		if(IsPlayerCheckpointActive(playerid) && PlayerCheckPointIndex[playerid] == index)
			UpdateTimer[playerid] = SetTimerEx("UpdateCheckPointInfo", 300, false, "dfffd", playerid, x, y, z, index);
		return 1;
	}
	PlayerOldPos[playerid][0] = ppos[0];
	PlayerOldPos[playerid][1] = ppos[1];
	PlayerOldPos[playerid][2] = ppos[2];
	if(GetPlayerInterior(playerid)){
		PlayerTextDrawSetString(playerid, Text_Player[playerid][1], "Loading...");
		if(IsPlayerCheckpointActive(playerid) && PlayerCheckPointIndex[playerid] == index)
			UpdateTimer[playerid] = SetTimerEx("UpdateCheckPointInfo", 300, false, "dfffd", playerid, x, y, z, index);
		return 1;
	}
	if(IsValidMapZone(map)){
		GetMapZoneName(map, locationname);
	}
	else strcat(locationname, "Khong xac dinh...");
	new MapNode:start, MapNode:target, Float:distance;
	GetClosestMapNodeToPoint(ppos[0], ppos[1], ppos[2], start);
	GetClosestMapNodeToPoint(x, y, z, target);
	if(start != INVALID_MAP_NODE_ID && target != INVALID_MAP_NODE_ID){
		new Path:Path = Path:task_await(FindPathAsync(start,target));
		distance = CalculatorDistance(Path);
		UpdateARROW(playerid, Path);
    	DestroyPath(Path);
		if(IsPlayerCheckpointActive(playerid) && PlayerCheckPointIndex[playerid] == index)
			UpdateTimer[playerid] = SetTimerEx("UpdateCheckPointInfo", 300, false, "dfffd", playerid, x, y, z, index);
		else return 1;
		if(distance == 0)PlayerTextDrawSetString(playerid, Text_Player[playerid][1], "Khoang cach duong bay: %.1f km~n~Khoang cach mat dat: Khong xac dinh~n~Vi tri cua ban: %s", GetDistanceToPoint2D(ppos[0], ppos[1], x, y), locationname);
		else PlayerTextDrawSetString(playerid, Text_Player[playerid][1], "Khoang cach duong bay: %.1f km~n~Khoang cach mat dat: %.1f km~n~Vi tri cua ban: %s", GetDistanceToPoint2D(ppos[0], ppos[1], x, y), distance, locationname);
	}
	else{
		if(IsPlayerCheckpointActive(playerid) && PlayerCheckPointIndex[playerid] == index)
			UpdateTimer[playerid] = SetTimerEx("UpdateCheckPointInfo", 300, false, "dfffd", playerid, x, y, z, index);
		else return 1;
		PlayerTextDrawSetString(playerid, Text_Player[playerid][1], "Khoang cach duong bay: %.1f km~n~Khoang cach mat dat: Khong xac dinh~n~Vi tri cua ban: %s", GetDistanceToPoint2D(ppos[0], ppos[1], x, y), locationname);
	}
	return 1;
}
static DestroyCheckPointInfo(playerid){
	PlayerCheckPointIndex[playerid] = 0;
	if(UpdateTimer[playerid] != -1){
		KillTimer(UpdateTimer[playerid]);
		UpdateTimer[playerid] = -1;
	}
	if(Text_Player[playerid][0] != PlayerText:-1){
		PlayerTextDrawDestroy(playerid, Text_Player[playerid][0]);
		Text_Player[playerid][0] = PlayerText:-1;
	}
	if(Text_Player[playerid][1] != PlayerText:-1){
		PlayerTextDrawDestroy(playerid, Text_Player[playerid][1]);
		Text_Player[playerid][1] = PlayerText:-1;
	}
	for(new o;o<MAX_ARROW;o++){
		if(ObjectArrow[playerid][o] != -1){
			DestroyDynamicObject(ObjectArrow[playerid][o]);
			ObjectArrow[playerid][o] = -1;
			Cache[playerid][o] = 0;
		}
	}
	return 1;
}
static InitCheckPointInfo(playerid, Float:x, Float:y, Float:z){
	new locationname[MAX_MAP_ZONE_NAME];
	new MapZone:map = GetMapZoneAtPoint2D(x, y);
	if(IsValidMapZone(map)){
		GetMapZoneName(map, locationname);
	}
	else strcat(locationname, "Khong xac dinh...");
	if(Text_Player[playerid][0] == PlayerText:-1)Text_Player[playerid][0] = CreatePlayerTextDraw(playerid, 153.000, 325.000, locationname);
	else PlayerTextDrawSetString(playerid, Text_Player[playerid][0], locationname);
	PlayerTextDrawLetterSize(playerid, Text_Player[playerid][0], 0.379, 1.900);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][0], 1);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][0], 1);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][0], 150);
	PlayerTextDrawFont(playerid, Text_Player[playerid][0], TEXT_DRAW_FONT_2);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][0], true);

	if(Text_Player[playerid][1] == PlayerText:-1)Text_Player[playerid][1] = CreatePlayerTextDraw(playerid, 153.000, 359.000, "Loading...");
	else PlayerTextDrawSetString(playerid, Text_Player[playerid][1], "Loading...");
	PlayerTextDrawLetterSize(playerid, Text_Player[playerid][1], 0.230, 1.500);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][1], 1);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][1], 150);
	PlayerTextDrawFont(playerid, Text_Player[playerid][1], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][1], true);

	PlayerTextDrawShow(playerid, Text_Player[playerid][0]);
	PlayerTextDrawShow(playerid, Text_Player[playerid][1]);

	if(UpdateTimer[playerid] != -1)KillTimer(UpdateTimer[playerid]);
	PlayerCheckPointIndex[playerid]++;
	UpdateTimer[playerid] = SetTimerEx("UpdateCheckPointInfo", 300, false, "dfffd", playerid, x, y, z, PlayerCheckPointIndex[playerid]);
	return 1;
}
public OnOutgoingRPC(playerid, rpcid, BitStream:bs){
	if(rpcid == 107){//SetCheckpoint 
		new Float:x, Float:y, Float:z;
		BS_ReadFloat(bs, x);
		BS_ReadFloat(bs, y);
		BS_ReadFloat(bs, z);
		InitCheckPointInfo(playerid, x, y, z);
	}
	if(rpcid == 37){//DisableCheckpoint
		DestroyCheckPointInfo(playerid);
	} 
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	DestroyCheckPointInfo(playerid);
	return 1;
}

public OnFilterScriptInit(){
	print(" ");
	print("  -----------------------------------------------------------------");
	print("  |  Copyright 2025 PhucDiamond-VN/VNBASE - CheckPointInfo System |");
	print("  -----------------------------------------------------------------");
	print(" ");
	SetCrashDetectLongCallTime(GetConsoleVarAsInt("crashdetect.long_call_time"));
	new Float:x, Float:y, Float:z, Float:radius;
	foreach(new i:Player){
		if(IsPlayerCheckpointActive(i)){
			GetPlayerCheckpoint(i, x, y, z, radius);
			InitCheckPointInfo(i, x, y, z);
		}
	}
	return 1;
}
public OnFilterScriptExit(){
	print(" ");
	print("  **  Unloading - CheckPointInfo System **");
	print(" ");
	foreach(new i:Player){
		DestroyCheckPointInfo(i);
	}
	print(" ");
	print("  **  Unload Success - CheckPointInfo System **");
	print(" ");
	return 1;
}