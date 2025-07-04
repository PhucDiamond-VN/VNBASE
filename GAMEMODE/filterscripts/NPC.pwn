#define debug 0
#define FILTERSCRIPT
#include <open.mp>
#include <streamer>
#include <YSI-Includes\YSI_Data\y_iterate>
#include <YSI-Includes\YSI_Coding\y_timers>
#include "../include/CallMessageBox"
#define func%0(%1) forward %0(%1); public %0(%1)
#define MAX_NPC 100
#define MAX_NPC_NAME_LEN 32
static Iterator:NPCExist<MAX_NPC>;
enum enpc{
	actorid,
	STREAMER_TAG_3D_TEXT_LABEL:label,
	Float:npcangle,
	FaceToPlayer,
	npcname[MAX_NPC_NAME_LEN],
	ani_lib[20],
	ani_name[20],
	Float:ani_delta,
	bool:ani_loop,
	bool:ani_lockx,
	bool:ani_locky,
	bool:ani_freeze,
	ani_time,
	bool:IsClearAni,
}
static NPC[MAX_NPC][enpc];

public OnFilterScriptInit(){
	print(" ");
	print("  ------------------------------------------------------");
	print("  |  Copyright 2025 PhucDiamond-VN/VNBASE - NPC System |");
	print("  ------------------------------------------------------");
	print(" ");
	SetCrashDetectLongCallTime(GetConsoleVarAsInt("crashdetect.long_call_time"));
	return 1;
}
public OnFilterScriptExit(){
	print(" ");
	print("  **  Unloading - NPC System **");
	print(" ");
	print(" ");
	print("  **  Unload Success - NPC System **");
	print(" ");
	return 1;
}
static bool:IsNPCExist(npcid){
	if(npcid < 0 || npcid >= MAX_NPC)return false;
	if(Iter_Contains(NPCExist, npcid))return true;
	return false;
}
static GetFreeNPC(){
	for(new npcid; npcid<MAX_NPC;npcid++){
		if(!IsNPCExist(npcid))return npcid;
	}
	return -1;
}
func CreateNPC(const ncpname[], skinid, Float:x, Float:y, Float:z, Float:angle, virtualworld){
	new npcid = GetFreeNPC();
	if(npcid == -1)return -1;
	Iter_Add(NPCExist, npcid);
	NPC[npcid][actorid] = CreateActor(skinid, x, y, z, angle);
	NPC[npcid][npcangle] = angle;
	NPC[npcid][FaceToPlayer] = -1;
	NPC[npcid][IsClearAni] = true;
	format(NPC[npcid][npcname], MAX_NPC_NAME_LEN, ncpname);
	SetActorVirtualWorld(NPC[npcid][actorid], virtualworld);
	SetActorInvulnerable(NPC[npcid][actorid]);
	NPC[npcid][label] = CreateDynamic3DTextLabel(ncpname, -1, x, y, z+1.4, 25, .testlos = true, .worldid = virtualworld);
	UpdateFaceNPC(npcid);
	return npcid;
}
func DestroyNPC(npcid){
	if(IsNPCExist(npcid)){
		DestroyActor(NPC[npcid][actorid]);
		DestroyDynamic3DTextLabel(NPC[npcid][label]);
		NPC[npcid][ani_lib] = 0;
		NPC[npcid][npcname] = 0;
		Iter_Remove(NPCExist, npcid);
	}
	return 1;
}
func SetNPCPos(npcid, Float:x, Float:y, Float:z){
	if(!IsNPCExist(npcid))return 0;
	SetActorPos(NPC[npcid][actorid], x, y, z);
	SetDynamic3DTextLabelPos(NPC[npcid][label], x, y, z);
	return 1;
}
static Float:GetDistanceToPoint2D(Float:x, Float:y, Float:xx, Float:yy)
{
	return VectorSize(x - xx, y - yy, 0);
}
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
func ApplyNPCAnimation(npcid, const animationLibrary[], const animationName[], Float:delta, bool:loop, bool:lockX, bool:lockY, bool:freeze, time){
	if(!IsNPCExist(npcid)) return 0;
	format(NPC[npcid][ani_lib], 20, animationLibrary);
	format(NPC[npcid][ani_name], 20, animationName);
	NPC[npcid][ani_delta] =delta;
	NPC[npcid][ani_loop] = loop;
	NPC[npcid][ani_lockx] = lockX;
	NPC[npcid][ani_locky] = lockY;
	NPC[npcid][ani_freeze] = freeze;
	NPC[npcid][ani_time] = time;
	if(NPC[npcid][FaceToPlayer] == -1){
		ApplyActorAnimation(NPC[npcid][actorid], NPC[npcid][ani_lib], NPC[npcid][ani_name], NPC[npcid][ani_delta], NPC[npcid][ani_loop], NPC[npcid][ani_lockx], NPC[npcid][ani_locky], NPC[npcid][ani_freeze], NPC[npcid][ani_time]);
		NPC[npcid][IsClearAni] = false;
	}
	return 1;
}
static UpdateFaceNPC(npcid){
	new Float:distance = 10;
	foreach(new playerid : Player){
		new Float:ppos[3], Float:apos[3], Float:tmpdistance;
		GetPlayerPos(playerid, ppos[0], ppos[1], ppos[2]);
		GetActorPos(NPC[npcid][actorid], apos[0], apos[1], apos[2]);
		tmpdistance = GetDistanceToPoint2D(ppos[0], ppos[1], apos[0], apos[1]);
		if(tmpdistance < distance){
			distance = tmpdistance;
			NPC[npcid][FaceToPlayer] = playerid;
		}
	}
	if(distance < 10 && IsPlayerConnected(NPC[npcid][FaceToPlayer])){
		new Float:ppos[3], Float:apos[3], Float:tmpangle, Float:angletoplayer;
		GetPlayerPos(NPC[npcid][FaceToPlayer], ppos[0], ppos[1], ppos[2]);
		GetActorPos(NPC[npcid][actorid], apos[0], apos[1], apos[2]);
		GetActorFacingAngle(actorid, tmpangle);
		angletoplayer = GetAngleToPoint(apos[0], apos[1], ppos[0], ppos[1]);
		tmpangle = FloatAbs(tmpangle-angletoplayer);
		if(tmpangle > 20 || (!isnull(NPC[npcid][ani_lib]) && !NPC[npcid][IsClearAni])){
			SetActorFacingAngle(NPC[npcid][actorid], angletoplayer);
			if(!NPC[npcid][IsClearAni]){
				ClearActorAnimations(NPC[npcid][actorid]);
				NPC[npcid][IsClearAni] = true;
			}
		}
	}
	else{
		new Float:oldangle;
		GetActorFacingAngle(NPC[npcid][actorid], oldangle);
		if(oldangle != NPC[npcid][npcangle]){
			SetActorFacingAngle(NPC[npcid][actorid], NPC[npcid][npcangle]);
			if(!isnull(NPC[npcid][ani_lib])){
				if(NPC[npcid][IsClearAni]){
					ApplyActorAnimation(NPC[npcid][actorid], NPC[npcid][ani_lib], NPC[npcid][ani_name], NPC[npcid][ani_delta], NPC[npcid][ani_loop], NPC[npcid][ani_lockx], NPC[npcid][ani_locky], NPC[npcid][ani_freeze], NPC[npcid][ani_time]);
					NPC[npcid][IsClearAni] = false;
				}
			}
			else if(!NPC[npcid][IsClearAni]){
				ClearActorAnimations(NPC[npcid][actorid]);
				NPC[npcid][IsClearAni] = true;
			}
		}
		NPC[npcid][FaceToPlayer] = -1;
	}
}
task NPCUpdate[100](){
	foreach(new npcid : NPCExist)UpdateFaceNPC(npcid);
	return 1;
}
func delaytalking(playerid){
	DeletePVar(playerid, "delaytalking");
}
public OnPlayerDisconnect(playerid, reason){
	if(GetPVarType(playerid, "delaytalking")){
		KillTimer(GetPVarInt(playerid, "delaytalking"));
		DeletePVar(playerid, "delaytalking");
	}
	return 1;
}
public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys){
	if((newkeys & KEY_YES) && !GetPVarType(playerid, "delaytalking")){
		foreach(new npcid : NPCExist){
			if(GetPlayerVirtualWorld(playerid) == GetActorVirtualWorld(NPC[npcid][actorid])){
				new Float:apos[3];
				GetActorPos(NPC[npcid][actorid], apos[0], apos[1], apos[2]);
				if(IsPlayerInRangeOfPoint(playerid, 3, apos[0], apos[1], apos[2])){
					CallRemoteFunction("OnPlayerTalkingToNPC", "dd", playerid, npcid);
					ApplyActorAnimation(NPC[npcid][actorid], "ped", "IDLE_chat", 4.0, false, false, false, false, 3000);
					SetPVarInt(playerid, "delaytalking", SetTimerEx("delaytalking", 3000, false, "d", playerid));
					return 0;
				}
			}
		}
	}
	return 1;
}