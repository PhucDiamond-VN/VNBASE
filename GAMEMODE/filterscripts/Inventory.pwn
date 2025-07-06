#define debug 0
#define FILTERSCRIPT
#include <open.mp>
#include <Pawn.CMD>
#include <YSI-Includes\YSI_Data\y_iterate>
#include <a_mysql>
#include <easydialog>
#define MAX_ITEM 1000
#define func%0(%1) forward %0(%1); public %0(%1)
// min 408 max 556
#define MAX_PLAYER_INV_PAGE 20
#define MAX_PLAYER_ITEM_SLOT 12
#define MAX_PLAYER_SLOT MAX_PLAYER_ITEM_SLOT*MAX_PLAYER_INV_PAGE
static Text: Text_Global[9];
static PlayerText: Text_Player[MAX_PLAYERS][16] = {{PlayerText:-1},...};
static PlayerText: SlecTD[MAX_PLAYERS] = {PlayerText:-1,...};
static PlayerText: EquipTD[MAX_PLAYERS][MAX_PLAYER_ITEM_SLOT] = {{PlayerText:-1,...},...};
static PlayerText: AmountTD[MAX_PLAYERS][MAX_PLAYER_ITEM_SLOT] = {{PlayerText:-1,...},...};
enum eitem{
	imodel,
	imax_amount,
	bool:itrade,
	bool:iuse,
	bool:iequip,
	Float:irotx,
	Float:iroty
}
enum eplayeritem{
	pitemid,
	pamount,
	bool:pequip,
	bool:plock
}
enum pInfo{
	bool:ShowInv,
	InPage,
	slec
}
static PlayerInfo[MAX_PLAYERS][pInfo] = {{false, 0, -1},...};
static pInvEmtype[MAX_PLAYER_SLOT][eplayeritem] = {
	{
		-1,
		0,
		false,
		false
	},...
};
static Item[MAX_ITEM][eitem];
static PlayerItem[MAX_PLAYERS][MAX_PLAYER_SLOT][eplayeritem];
static bool:IsValidItem(itemid){
	if(Item[itemid][imodel] != -1)return true;
	return false;
}
static GetFreeSlotItem(){
	for(new itemid;itemid<MAX_ITEM;itemid++)if(!IsValidItem(itemid))return itemid;
	return -1;
}
static GetPlayerFreeSlot(playerid){
	for(new slot;slot<MAX_PLAYER_SLOT;slot++){
		if(PlayerItem[playerid][slot][pitemid] == -1)return slot;
	}
	return -1;
}
static GetPlayerItemFreeAmount(playerid, slot, itemid){
	return Item[itemid][imax_amount] - PlayerItem[playerid][slot][pamount];
}
static GetSlotInPage(itemslot, page){
	return MAX_PLAYER_ITEM_SLOT*(page-1)+itemslot;
}
static GetMinSlotInPage(page){
	return MAX_PLAYER_ITEM_SLOT*(page-1);
}
static GetMaxSlotInPage(page){
	return (MAX_PLAYER_ITEM_SLOT*page)-1;
}
static GetItemSlotForSlot(slot){
	while(slot >= MAX_PLAYER_ITEM_SLOT){
		slot -= MAX_PLAYER_ITEM_SLOT;
	}
	return slot;
}
static UpdatePlayerSlot(playerid, slot){
	if(IsPlayerShowInv(playerid)){
		if(slot >= GetMinSlotInPage(PlayerInfo[playerid][InPage]) && slot <= GetMaxSlotInPage(PlayerInfo[playerid][InPage])){
			new itemslot = GetItemSlotForSlot(slot);
			new Float:x, Float:y;
			PlayerTextDrawGetPos(playerid, Text_Player[playerid][itemslot], x, y);

			if(PlayerInfo[playerid][slec] == slot){
				if(SlecTD[playerid] == PlayerText:-1){
					SlecTD[playerid] = CreatePlayerTextDraw(playerid, x+9, y+9, "PARTICLE:target256");
					PlayerTextDrawTextSize(playerid, SlecTD[playerid], 32.000, 35.000);
					PlayerTextDrawAlignment(playerid, SlecTD[playerid], TEXT_DRAW_ALIGN_LEFT);
					PlayerTextDrawColour(playerid, SlecTD[playerid], 16711935);
					PlayerTextDrawSetShadow(playerid, SlecTD[playerid], 0);
					PlayerTextDrawSetOutline(playerid, SlecTD[playerid], 0);
					PlayerTextDrawBackgroundColour(playerid, SlecTD[playerid], 255);
					PlayerTextDrawFont(playerid, SlecTD[playerid], TEXT_DRAW_FONT_SPRITE_DRAW);
					PlayerTextDrawSetProportional(playerid, SlecTD[playerid], true);
				}
				else PlayerTextDrawSetPos(playerid, SlecTD[playerid], x+9, y+9);
				PlayerTextDrawShow(playerid, SlecTD[playerid]);
			}
			else if(SlecTD[playerid] != PlayerText:-1){
				PlayerTextDrawDestroy(playerid, SlecTD[playerid]);
				SlecTD[playerid] = PlayerText:-1;
			}

			if(PlayerItem[playerid][slot][pequip]){
				if(EquipTD[playerid][itemslot] == PlayerText:-1){
					EquipTD[playerid][itemslot] = CreatePlayerTextDraw(playerid, x+38, y+37, "PARTICLE:lockon");
					PlayerTextDrawTextSize(playerid, EquipTD[playerid][itemslot], 12.000, 13.000);
					PlayerTextDrawAlignment(playerid, EquipTD[playerid][itemslot], TEXT_DRAW_ALIGN_LEFT);
					PlayerTextDrawColour(playerid, EquipTD[playerid][itemslot], -1);
					PlayerTextDrawSetShadow(playerid, EquipTD[playerid][itemslot], 0);
					PlayerTextDrawSetOutline(playerid, EquipTD[playerid][itemslot], 0);
					PlayerTextDrawBackgroundColour(playerid, EquipTD[playerid][itemslot], 255);
					PlayerTextDrawFont(playerid, EquipTD[playerid][itemslot], TEXT_DRAW_FONT_SPRITE_DRAW);
					PlayerTextDrawSetProportional(playerid, EquipTD[playerid][itemslot], true);
				}
				PlayerTextDrawShow(playerid, EquipTD[playerid][itemslot]);
			}
			else if(EquipTD[playerid][itemslot] != PlayerText:-1){
				PlayerTextDrawDestroy(playerid, EquipTD[playerid][itemslot]);
				EquipTD[playerid][itemslot] = PlayerText:-1;
			}

			if(PlayerItem[playerid][slot][pamount] > 1){
				if(AmountTD[playerid][itemslot] == PlayerText:-1){
					AmountTD[playerid][itemslot] = CreatePlayerTextDraw(playerid, x, y, "%d", PlayerItem[playerid][slot][pamount]);
					PlayerTextDrawLetterSize(playerid, AmountTD[playerid][itemslot], 0.200, 1.399);
					PlayerTextDrawAlignment(playerid, AmountTD[playerid][itemslot], TEXT_DRAW_ALIGN_LEFT);
					PlayerTextDrawColour(playerid, AmountTD[playerid][itemslot], -1);
					PlayerTextDrawSetShadow(playerid, AmountTD[playerid][itemslot], 1);
					PlayerTextDrawSetOutline(playerid, AmountTD[playerid][itemslot], 1);
					PlayerTextDrawBackgroundColour(playerid, AmountTD[playerid][itemslot], 150);
					PlayerTextDrawFont(playerid, AmountTD[playerid][itemslot], TEXT_DRAW_FONT_1);
					PlayerTextDrawSetProportional(playerid, AmountTD[playerid][itemslot], true);
				}
				else PlayerTextDrawSetString(playerid, AmountTD[playerid][itemslot], "%d", PlayerItem[playerid][slot][pamount]);
				PlayerTextDrawShow(playerid, AmountTD[playerid][itemslot]);
			}
			else if(AmountTD[playerid][itemslot] != PlayerText:-1){
				PlayerTextDrawDestroy(playerid, AmountTD[playerid][itemslot]);
				AmountTD[playerid][itemslot] = PlayerText:-1;
			}
		}
	}
	return 1;
}
static UpdatePlayerAllSlot(playerid){
	if(IsPlayerShowInv(playerid)){
		for(new itemslot;itemslot<MAX_PLAYER_ITEM_SLOT;itemslot++){
			UpdatePlayerSlot(playerid, GetSlotInPage(itemslot, PlayerInfo[playerid][InPage]));
		}
	}
	return 1;
}
func IsPlayerShowInv(playerid){
	return PlayerInfo[playerid][ShowInv];
}
func ShowPlayerInv(playerid){
	if(!IsPlayerShowInv(playerid)){
		PlayerInfo[playerid][slec] = -1;
		PlayerInfo[playerid][InPage] = 1;
		InitPlayerTextDraw(playerid);
		for(new t;t<sizeof Text_Global;t++)TextDrawShowForPlayer(playerid, Text_Global[t]);
		for(new t;t<sizeof Text_Player[];t++)PlayerTextDrawShow(playerid, Text_Player[playerid][t]);
		PlayerInfo[playerid][ShowInv] = true;
		UpdatePlayerAllSlot(playerid);
		SelectTextDraw(playerid, 0xf2ed5cff);
	}
	return 1;
}
func HidePlayerInv(playerid){
	if(IsPlayerShowInv(playerid)){
		DestroyPlayerInvTextDraw(playerid);
		for(new t;t<sizeof Text_Global;t++)TextDrawHideForPlayer(playerid, Text_Global[t]);
		PlayerInfo[playerid][ShowInv] = false;
		CancelSelectTextDraw(playerid);
	}
	return 1;
}
func IsPlayerItemFull(playerid, itemid, amount){
	for(new slot;slot<MAX_PLAYER_SLOT;slot++){
		amount -= GetPlayerItemFreeAmount(playerid, slot, itemid);
		if(amount <= 0)return 0;
	}
	return 1;
}
func InitItem(model, max_amount, Float:rotx, Float:roty, bool:trade, bool:use, bool:equip){
	new itemid = GetFreeSlotItem();
	if(itemid == -1)return -1;
	Item[itemid][imodel] = model;
	Item[itemid][iuse] = use;
	Item[itemid][itrade] = trade;
	Item[itemid][iequip] = equip;
	Item[itemid][irotx] = rotx;
	Item[itemid][iroty] = roty;
	Item[itemid][imax_amount] = max_amount;
	return itemid;
}
func AddPlayerItem(playerid, itemid, amount){
	if(!IsPlayerItemFull(playerid, itemid, amount)){
		for(new slot; slot<MAX_PLAYER_SLOT;slot++){
			if(PlayerItem[playerid][slot][pitemid] == itemid || PlayerItem[playerid][slot][pitemid] == -1){
				new freeamount = GetPlayerItemFreeAmount(playerid, slot, itemid);
				PlayerItem[playerid][slot][pamount] += freeamount;
				amount -= freeamount;
			}
			if(amount <= 0)return 1;
		}
	}
	return 0;
}
public OnPlayerConnect(playerid){
	PlayerInfo[playerid][ShowInv] = false;
	PlayerItem[playerid] = pInvEmtype;
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	HidePlayerInv	(playerid);
	return 1;
}
public OnFilterScriptInit(){
	Text_Global[0] = TextDrawCreate(382.000, 125.000, "LD_SPAC:white");
	TextDrawTextSize(Text_Global[0], 219.000, 291.000);
	TextDrawAlignment(Text_Global[0], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[0], 1044332799);
	TextDrawSetShadow(Text_Global[0], 0);
	TextDrawSetOutline(Text_Global[0], 0);
	TextDrawBackgroundColour(Text_Global[0], 255);
	TextDrawFont(Text_Global[0], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(Text_Global[0], true);

	Text_Global[1] = TextDrawCreate(382.000, 294.000, "LD_SPAC:white");
	TextDrawTextSize(Text_Global[1], 219.000, 3.000);
	TextDrawAlignment(Text_Global[1], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[1], 556608511);
	TextDrawSetShadow(Text_Global[1], 0);
	TextDrawSetOutline(Text_Global[1], 0);
	TextDrawBackgroundColour(Text_Global[1], 255);
	TextDrawFont(Text_Global[1], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(Text_Global[1], true);

	Text_Global[2] = TextDrawCreate(382.000, 300.000, "LD_SPAC:white");
	TextDrawTextSize(Text_Global[2], 219.000, 22.000);
	TextDrawAlignment(Text_Global[2], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[2], 556608511);
	TextDrawSetShadow(Text_Global[2], 0);
	TextDrawSetOutline(Text_Global[2], 0);
	TextDrawBackgroundColour(Text_Global[2], 255);
	TextDrawFont(Text_Global[2], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(Text_Global[2], true);

	Text_Global[3] = TextDrawCreate(382.000, 299.000, "LD_BEAT:left");
	TextDrawTextSize(Text_Global[3], 28.000, 25.000);
	TextDrawAlignment(Text_Global[3], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[3], -1);
	TextDrawSetShadow(Text_Global[3], 0);
	TextDrawSetOutline(Text_Global[3], 0);
	TextDrawBackgroundColour(Text_Global[3], 255);
	TextDrawFont(Text_Global[3], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(Text_Global[3], true);
	TextDrawSetSelectable(Text_Global[3], true);

	Text_Global[4] = TextDrawCreate(382.000, 294.000, "LD_SPAC:white");
	TextDrawTextSize(Text_Global[4], 219.000, 3.000);
	TextDrawAlignment(Text_Global[4], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[4], 556608511);
	TextDrawSetShadow(Text_Global[4], 0);
	TextDrawSetOutline(Text_Global[4], 0);
	TextDrawBackgroundColour(Text_Global[4], 255);
	TextDrawFont(Text_Global[4], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(Text_Global[4], true);

	Text_Global[5] = TextDrawCreate(344.000, 372.000, "_");
	TextDrawTextSize(Text_Global[5], 44.000, 46.000);
	TextDrawAlignment(Text_Global[5], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[5], -1);
	TextDrawSetShadow(Text_Global[5], 0);
	TextDrawSetOutline(Text_Global[5], 0);
	TextDrawBackgroundColour(Text_Global[5], 0);
	TextDrawFont(Text_Global[5], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawSetProportional(Text_Global[5], false);
	TextDrawSetPreviewModel(Text_Global[5], 1339);
	TextDrawSetPreviewRot(Text_Global[5], -28.000, 0.000, -203.000, 1.000);
	TextDrawSetPreviewVehicleColours(Text_Global[5], 0, 0);
	TextDrawSetSelectable(Text_Global[5], true);

	Text_Global[6] = TextDrawCreate(340.000, 183.000, "_");
	TextDrawTextSize(Text_Global[6], 44.000, 46.000);
	TextDrawAlignment(Text_Global[6], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[6], -1);
	TextDrawSetShadow(Text_Global[6], 0);
	TextDrawSetOutline(Text_Global[6], 0);
	TextDrawBackgroundColour(Text_Global[6], 0);
	TextDrawFont(Text_Global[6], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawSetProportional(Text_Global[6], false);
	TextDrawSetPreviewModel(Text_Global[6], 2900);
	TextDrawSetPreviewRot(Text_Global[6], -28.000, 0.000, -203.000, 1.100);
	TextDrawSetPreviewVehicleColours(Text_Global[6], 0, 0);
	TextDrawSetSelectable(Text_Global[6], true);

	Text_Global[7] = TextDrawCreate(379.000, 74.000, "Tui do");
	TextDrawLetterSize(Text_Global[7], 1.139, 6.399);
	TextDrawTextSize(Text_Global[7], 607.000, 370.000);
	TextDrawAlignment(Text_Global[7], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[7], -1);
	TextDrawSetShadow(Text_Global[7], 1);
	TextDrawSetOutline(Text_Global[7], 1);
	TextDrawBackgroundColour(Text_Global[7], 150);
	TextDrawFont(Text_Global[7], TEXT_DRAW_FONT_0);
	TextDrawSetProportional(Text_Global[7], true);

	Text_Global[8] = TextDrawCreate(602.000, 114.000, "X");
	TextDrawLetterSize(Text_Global[8], 0.629, 1.799);
	TextDrawTextSize(Text_Global[8], 18.000, 14.000);
	TextDrawAlignment(Text_Global[8], TEXT_DRAW_ALIGN_CENTER);
	TextDrawColour(Text_Global[8], -16776961);
	TextDrawSetShadow(Text_Global[8], 1);
	TextDrawSetOutline(Text_Global[8], 1);
	TextDrawBackgroundColour(Text_Global[8], 150);
	TextDrawFont(Text_Global[8], TEXT_DRAW_FONT_1);
	TextDrawSetProportional(Text_Global[8], true);
	TextDrawSetSelectable(Text_Global[8], true);
	return 1;
}
public OnFilterScriptExit(){
	foreach(new playerid:Player){
		HidePlayerInv(playerid);
	}
	for(new t;t<sizeof Text_Global;t++)TextDrawDestroy(Text_Global[t]);
	return 1;
}
static InitPlayerTextDraw(playerid){
	Text_Player[playerid][0] = CreatePlayerTextDraw(playerid, 387.000, 132.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][0], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][0], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][0], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][0], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][0], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][0], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][0], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][0], true);

	Text_Player[playerid][1] = CreatePlayerTextDraw(playerid, 440.000, 132.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][1], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][1], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][1], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][1], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][1], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][1], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][1], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][1], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][1], true);

	Text_Player[playerid][2] = CreatePlayerTextDraw(playerid, 493.000, 132.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][2], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][2], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][2], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][2], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][2], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][2], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][2], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][2], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][2], true);

	Text_Player[playerid][3] = CreatePlayerTextDraw(playerid, 546.000, 132.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][3], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][3], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][3], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][3], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][3], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][3], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][3], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][3], true);

	Text_Player[playerid][4] = CreatePlayerTextDraw(playerid, 387.000, 186.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][4], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][4], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][4], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][4], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][4], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][4], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][4], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][4], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][4], true);

	Text_Player[playerid][5] = CreatePlayerTextDraw(playerid, 440.000, 186.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][5], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][5], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][5], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][5], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][5], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][5], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][5], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][5], true);

	Text_Player[playerid][6] = CreatePlayerTextDraw(playerid, 493.000, 186.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][6], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][6], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][6], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][6], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][6], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][6], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][6], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][6], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][6], true);

	Text_Player[playerid][7] = CreatePlayerTextDraw(playerid, 546.000, 186.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][7], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][7], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][7], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][7], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][7], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][7], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][7], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][7], true);

	Text_Player[playerid][8] = CreatePlayerTextDraw(playerid, 387.000, 241.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][8], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][8], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][8], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][8], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][8], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][8], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][8], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][8], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][8], true);

	Text_Player[playerid][9] = CreatePlayerTextDraw(playerid, 440.000, 241.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][9], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][9], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][9], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][9], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][9], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][9], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][9], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][9], true);

	Text_Player[playerid][10] = CreatePlayerTextDraw(playerid, 493.000, 241.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][10], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][10], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][10], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][10], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][10], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][10], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][10], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][10], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][10], true);

	Text_Player[playerid][11] = CreatePlayerTextDraw(playerid, 546.000, 241.000, "_");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][11], 50.000, 50.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][11], 85);
	PlayerTextDrawFont(playerid, Text_Player[playerid][11], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][11], false);
	PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][11], 1122);
	PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][11], 0.000, 0.000, 0.000, 10.000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, Text_Player[playerid][11], 0, 0);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][11], true);

	Text_Player[playerid][12] = CreatePlayerTextDraw(playerid, 574.000, 299.000, "LD_BEAT:right");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][12], 28.000, 26.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][12], 255);
	PlayerTextDrawFont(playerid, Text_Player[playerid][12], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][12], true);
	PlayerTextDrawSetSelectable(playerid, Text_Player[playerid][12], true);

	Text_Player[playerid][13] = CreatePlayerTextDraw(playerid, 408.000, 301.000, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][13], 16.000, 19.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][13], 255);
	PlayerTextDrawFont(playerid, Text_Player[playerid][13], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][13], true);

	Text_Player[playerid][14] = CreatePlayerTextDraw(playerid, 491.000, 303.000, "1/10");
	PlayerTextDrawLetterSize(playerid, Text_Player[playerid][14], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][14], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, Text_Player[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][14], 1);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][14], 1);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][14], 150);
	PlayerTextDrawFont(playerid, Text_Player[playerid][14], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][14], true);

	Text_Player[playerid][15] = CreatePlayerTextDraw(playerid, 385.000, 323.000, "~y~[Item Name]~n~~r~Khong the giao dich~n~~w~Content");
	PlayerTextDrawLetterSize(playerid, Text_Player[playerid][15], 0.239, 1.299);
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][15], 598.000, 59.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][15], 1);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][15], 150);
	PlayerTextDrawFont(playerid, Text_Player[playerid][15], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][15], true);
	return 1;
}
static DestroyPlayerInvTextDraw(playerid){
	for(new i;i<sizeof Text_Player[];i++){
		if(Text_Player[playerid][i] != PlayerText:-1){
			PlayerTextDrawDestroy(playerid, Text_Player[playerid][i]);
			Text_Player[playerid][i] = PlayerText:-1;
		}
	}
	if(SlecTD[playerid] != PlayerText:-1){
		PlayerTextDrawDestroy(playerid, SlecTD[playerid]);
		SlecTD[playerid] = PlayerText:-1;
	}
	for(new itemslot;itemslot<MAX_PLAYER_ITEM_SLOT;itemslot++){
		if(EquipTD[playerid][itemslot] != PlayerText:-1){
			PlayerTextDrawDestroy(playerid, EquipTD[playerid][itemslot]);
			EquipTD[playerid][itemslot] = PlayerText:-1;
		}
		if(AmountTD[playerid][itemslot] != PlayerText:-1){
			PlayerTextDrawDestroy(playerid, AmountTD[playerid][itemslot]);
			AmountTD[playerid][itemslot] = PlayerText:-1;
		}
	}
	return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(IsPlayerShowInv(playerid)){
		if(clickedid == INVALID_TEXT_DRAW || clickedid == Text_Global[8]){
			HidePlayerInv(playerid);
			return 1;
		}
	}
    return 0;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid){
	if(IsPlayerShowInv(playerid)){
		for(new itemslot;itemslot<MAX_PLAYER_ITEM_SLOT;itemslot++){
			if(playertextid == Text_Player[playerid][itemslot]){
				new slot = GetSlotInPage(itemslot, PlayerInfo[playerid][InPage]);
				if(PlayerInfo[playerid][slec] != slot)
					PlayerInfo[playerid][slec] = slot;
				else
					PlayerInfo[playerid][slec] = -1;
				UpdatePlayerSlot(playerid, slot);
				return 1;
			}
		}
	}
	return 0;
}
CMD:inv(playerid){
	if(!IsPlayerShowInv(playerid))
		ShowPlayerInv(playerid);
	else
		HidePlayerInv(playerid);
	return 1;
}