#define debug 0
#define FILTERSCRIPT
#include <open.mp>
#include <Pawn.CMD>
#include <YSI-Includes\YSI_Data\y_iterate>
#include <a_mysql>
#include <easydialog>
#define func%0(%1) forward %0(%1); public %0(%1)

#define MAX_LOCKER 1000
#define MAX_LOCKER_PAGE 20
#define MAX_LOCKER_ITEM_SLOT 16
#define MAX_LOCKER_SLOT MAX_LOCKER_PAGE*MAX_LOCKER_ITEM_SLOT
#define MAX_LOCKER_NAME 50

#define MAX_ITEM 1000
#define MAX_PLAYER_INV_PAGE 20
#define MAX_PLAYER_ITEM_SLOT 12
#define MAX_PLAYER_SLOT MAX_PLAYER_ITEM_SLOT*MAX_PLAYER_INV_PAGE
#define MAX_ITEM_NAME 50
#define MAX_ITEM_CONTENT 256

static Text: Text_Global[10];
static PlayerText: Text_Player[MAX_PLAYERS][15] = {{PlayerText:-1},...};
static PlayerText: SlecTD[MAX_PLAYERS] = {PlayerText:-1,...};
static PlayerText: EquipTD[MAX_PLAYERS][MAX_PLAYER_ITEM_SLOT] = {{PlayerText:-1,...},...};
static PlayerText: AmountTD[MAX_PLAYERS][MAX_PLAYER_ITEM_SLOT] = {{PlayerText:-1,...},...};
static Float:bar_minvalue, Float:bar_maxvalue;
static testitem;
static testitem1;
static testitem2;
enum eitem{
	imodel,
	imax_amount,
	bool:itrade,
	bool:iuse,
	bool:iequip,
	Float:irotx,
	Float:iroty,
	Float:izoom,
	icontent[MAX_ITEM_CONTENT],
	iname[MAX_ITEM_NAME]
}
static Item[MAX_ITEM][eitem] = {{
	-1,
	0,
	false,
	false,
	false,
	0.0,
	0.0,
	0.0
},...};
enum eplayeritem{
	pitemid,
	pamount,
	bool:pequip,
	bool:plock
}
static pSlotEmtype[eplayeritem] = {
	-1,
	0,
	false,
	true
};
static PlayerItem[MAX_PLAYERS][MAX_PLAYER_SLOT][eplayeritem];
enum pInfo{
	bool:ShowInv,
	InPage,
	slec,
	CountClick,
	CountClickSlot,
	CountClickTimer,
	SplitItemSlot,
	SlotDelete
}
static PlayerInfo[MAX_PLAYERS][pInfo] = {{false, 0, -1, 0, -1, -1, 0, -1},...};
enum eLockerInfo{
	lname[MAX_LOCKER_NAME],
	Float:lx,
	Float:ly,
	Float:lz,
	lint,
	lvw
}
static LockerInfo[MAX_LOCKER][eLockerInfo];
enum eLockerItem{
	litemid,
	lamount
}
static LockerItem[MAX_LOCKER][MAX_LOCKER_SLOT][eLockerItem];
static bool:IsValidItem(itemid){
	if(itemid < 0 || itemid >= MAX_ITEM)return false;
	if(Item[itemid][imodel] != -1)return true;
	return false;
}
static GetFreeSlotItem(){
	for(new itemid;itemid<MAX_ITEM;itemid++)if(!IsValidItem(itemid))return itemid;
	return -1;
}
static GetPlayerFreeSlot(playerid){
	for(new slot;slot<MAX_PLAYER_SLOT;slot++){
		if(PlayerItem[playerid][slot][pitemid] == -1 && !PlayerItem[playerid][slot][plock])return slot;
	}
	return -1;
}
static GetPlayerItemFreeAmount(playerid, slot, itemid){
	if(PlayerItem[playerid][slot][plock])return 0;
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
static UpdateItemInfo(playerid, itemid){
	if(IsPlayerShowInv(playerid) && IsValidItem(itemid)){
		PlayerTextDrawSetString(playerid, Text_Player[playerid][14], "~y~[%s]~n~%s~w~%s", Item[itemid][iname], (Item[itemid][itrade]) ? "":"~r~Khong the giao dich~n~", Item[itemid][icontent]);
	}
	else PlayerTextDrawSetString(playerid, Text_Player[playerid][14], "");
	return 1;
}
static UpdatePlayerSlot(playerid, slot){
	if(IsPlayerShowInv(playerid)){
		if(slot >= GetMinSlotInPage(PlayerInfo[playerid][InPage]) && slot <= GetMaxSlotInPage(PlayerInfo[playerid][InPage])){
			new itemslot = GetItemSlotForSlot(slot);
			new Float:x, Float:y;
			PlayerTextDrawGetPos(playerid, Text_Player[playerid][itemslot], x, y);
			if(PlayerInfo[playerid][SlotDelete] == slot)PlayerInfo[playerid][SlotDelete] = -1;
			if(PlayerInfo[playerid][slec] >= GetMinSlotInPage(PlayerInfo[playerid][InPage]) && PlayerInfo[playerid][slec] <= GetMaxSlotInPage(PlayerInfo[playerid][InPage])){
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
					PlayerTextDrawShow(playerid, SlecTD[playerid]);
					UpdateItemInfo(playerid, PlayerItem[playerid][PlayerInfo[playerid][slec]][pitemid]);
				}
				else {
					new Float:slecpos[2], Float:check[2];
					PlayerTextDrawGetPos(playerid, Text_Player[playerid][GetItemSlotForSlot(PlayerInfo[playerid][slec])], slecpos[0], slecpos[1]);
					PlayerTextDrawGetPos(playerid, SlecTD[playerid], check[0], check[1]);
					if(check[0] != slecpos[0]+9 || check[1] != slecpos[1]+9){
						PlayerTextDrawSetPos(playerid, SlecTD[playerid], slecpos[0]+9, slecpos[1]+9);
						PlayerTextDrawShow(playerid, SlecTD[playerid]);
						UpdateItemInfo(playerid, PlayerItem[playerid][PlayerInfo[playerid][slec]][pitemid]);
					}
				}
			}
			else if(SlecTD[playerid] != PlayerText:-1){
				UpdateItemInfo(playerid, -1);
				PlayerTextDrawDestroy(playerid, SlecTD[playerid]);
				SlecTD[playerid] = PlayerText:-1;
			}

			if(!PlayerItem[playerid][slot][plock] && PlayerItem[playerid][slot][pitemid] != -1){
				PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][itemslot], Item[PlayerItem[playerid][slot][pitemid]][imodel]);
				PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][itemslot], Item[PlayerItem[playerid][slot][pitemid]][irotx], Item[PlayerItem[playerid][slot][pitemid]][iroty], 0.000, Item[PlayerItem[playerid][slot][pitemid]][izoom]);

				if(PlayerItem[playerid][slot][pamount] > 1){
					if(AmountTD[playerid][itemslot] == PlayerText:-1){
						AmountTD[playerid][itemslot] = CreatePlayerTextDraw(playerid, x+1, y-1, "%d", PlayerItem[playerid][slot][pamount]);
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
			}
			else{
				new bool:tmplock = PlayerItem[playerid][slot][plock];
				PlayerItem[playerid][slot] = pSlotEmtype;
				PlayerItem[playerid][slot][plock] = tmplock;
				if(tmplock){
					PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][itemslot], 19804);
					PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][itemslot], 0, 0, 0.000, 1.000);
				}
				else{
					PlayerTextDrawSetPreviewModel(playerid, Text_Player[playerid][itemslot], 1122);
					PlayerTextDrawSetPreviewRot(playerid, Text_Player[playerid][itemslot], 0, 0, 0.000, 10.000);
				}
				if(AmountTD[playerid][itemslot] != PlayerText:-1){
					PlayerTextDrawDestroy(playerid, AmountTD[playerid][itemslot]);
					AmountTD[playerid][itemslot] = PlayerText:-1;
				}
				if(EquipTD[playerid][itemslot] != PlayerText:-1){
					PlayerTextDrawDestroy(playerid, EquipTD[playerid][itemslot]);
					EquipTD[playerid][itemslot] = PlayerText:-1;
				}
			}
			PlayerTextDrawShow(playerid, Text_Player[playerid][itemslot]);
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
static UpdatePageBar(playerid){
	if(IsPlayerShowInv(playerid)){
		PlayerTextDrawSetString(playerid, Text_Player[playerid][13], "%d/%d", PlayerInfo[playerid][InPage], MAX_PLAYER_INV_PAGE);
		new Float:value = bar_minvalue + ((bar_maxvalue-bar_minvalue)/MAX_PLAYER_INV_PAGE)*(PlayerInfo[playerid][InPage]-1);
		new Float:barpos[2];
		PlayerTextDrawGetPos(playerid, Text_Player[playerid][12], barpos[0], barpos[1]);
		barpos[0] = value;
		PlayerTextDrawSetPos(playerid, Text_Player[playerid][12], barpos[0], barpos[1]);
		PlayerTextDrawShow(playerid, Text_Player[playerid][12]);
	}
	return 1;
}
static swarpandmerge(playerid, slot1, slot2){
	if(PlayerItem[playerid][slot1][pitemid] != PlayerItem[playerid][slot2][pitemid]){
		new tmppitem[eplayeritem];
		tmppitem = PlayerItem[playerid][slot1];
		PlayerItem[playerid][slot1] = PlayerItem[playerid][slot2];
		PlayerItem[playerid][slot2] = tmppitem;
	}
	else{
		new mergevalue = PlayerItem[playerid][slot1][pamount];
		if(PlayerItem[playerid][slot2][pamount]+mergevalue > Item[PlayerItem[playerid][slot2][pitemid]][imax_amount])
			mergevalue -= PlayerItem[playerid][slot2][pamount] + mergevalue - Item[PlayerItem[playerid][slot2][pitemid]][imax_amount];
		PlayerItem[playerid][slot2][pamount]+=mergevalue;
		PlayerItem[playerid][slot1][pamount]-=mergevalue;
		if(PlayerItem[playerid][slot1][pamount] <= 0){
			PlayerItem[playerid][slot1] = pSlotEmtype;
		}
	}
	UpdatePlayerSlot(playerid, slot1);
	UpdatePlayerSlot(playerid, slot2);
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
func UnlockPlayerSlot(playerid, slot){
	if(slot < 0 || slot >= MAX_PLAYER_SLOT)return 0;
	PlayerItem[playerid][slot][plock] = false;
	return 1;
}
func LockPlayerSlot(playerid, slot){
	if(slot < 0 || slot >= MAX_PLAYER_SLOT)return 0;
	PlayerItem[playerid][slot][plock] = true;
	return 1;
}
func HidePlayerInv(playerid){
	if(IsPlayerShowInv(playerid)){
		DestroyPlayerInvTextDraw(playerid);
		for(new t;t<sizeof Text_Global;t++)TextDrawHideForPlayer(playerid, Text_Global[t]);
		PlayerInfo[playerid][ShowInv] = false;
		CancelSelectTextDraw(playerid);
	}
	if(PlayerInfo[playerid][CountClickTimer] != -1){
		KillTimer(PlayerInfo[playerid][CountClickTimer]);
		PlayerInfo[playerid][CountClickTimer] = -1;
		PlayerInfo[playerid][CountClickSlot] = -1;
		PlayerInfo[playerid][CountClick] = 0;
	}
	PlayerInfo[playerid][SlotDelete] = -1;
	return 1;
}
func IsPlayerItemFull(playerid, itemid, amount){
	if(!IsValidItem(itemid))return 1;
	for(new slot;slot<MAX_PLAYER_SLOT;slot++){
		amount -= GetPlayerItemFreeAmount(playerid, slot, itemid);
		if(amount <= 0)return 0;
	}
	return 1;
}
func InitItem(model, max_amount, Float:rotx, Float:roty, Float:zoom, bool:trade, bool:use, bool:equip){
	new itemid = GetFreeSlotItem();
	if(itemid == -1)return -1;
	Item[itemid][imodel] = model;
	Item[itemid][iuse] = use;
	Item[itemid][itrade] = trade;
	Item[itemid][iequip] = equip;
	Item[itemid][irotx] = rotx;
	Item[itemid][iroty] = roty;
	Item[itemid][izoom] = zoom;
	Item[itemid][imax_amount] = max_amount;
	printf("Inititem %d: model:%d - max amount:%d - rotx:%.1f - roty:%.1f - zoom:%.1f - trade:%d - use:%d - equip:%d", itemid, model, max_amount, rotx, roty, zoom, trade, use, equip);
	return itemid;
}
func SetItemName(itemid, const name[]){
	if(!IsValidItem(itemid))return 0;
	format(Item[itemid][iname], MAX_ITEM_NAME, name);
	return 1;
}
func SetItemContent(itemid, const content[]){
	if(!IsValidItem(itemid))return 0;
	format(Item[itemid][icontent], MAX_ITEM_CONTENT, content);
	return 1;
}
func AddPlayerItem(playerid, itemid, amount){
	if(!IsValidItem(itemid))return 0;
	if(!IsPlayerItemFull(playerid, itemid, amount)){
		for(new slot; slot<MAX_PLAYER_SLOT;slot++){
			if(PlayerItem[playerid][slot][pitemid] == itemid || PlayerItem[playerid][slot][pitemid] == -1){
				new freeamount = GetPlayerItemFreeAmount(playerid, slot, itemid);
				PlayerItem[playerid][slot][pitemid] = itemid;
				PlayerItem[playerid][slot][pamount] += freeamount;
				amount -= freeamount;
				if(amount < 0)PlayerItem[playerid][slot][pamount] += amount;
				if(freeamount > 0)UpdatePlayerSlot(playerid, slot);
			}
			if(amount <= 0)return 1;
		}
	}
	return 0;
}
public OnPlayerConnect(playerid){
	PlayerInfo[playerid][ShowInv] = false;
	for(new slot;slot<MAX_PLAYER_SLOT;slot++)
		PlayerItem[playerid][slot] = pSlotEmtype;
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	HidePlayerInv	(playerid);
	return 1;
}
public OnFilterScriptInit(){
	foreach(new playerid : Player)CallLocalFunction("OnPlayerConnect", "d", playerid);
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

	Text_Global[4] = TextDrawCreate(574.000, 299.000, "LD_BEAT:right");
	TextDrawTextSize(Text_Global[4], 28.000, 26.000);
	TextDrawAlignment(Text_Global[4], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[4], -1);
	TextDrawSetShadow(Text_Global[4], 0);
	TextDrawSetOutline(Text_Global[4], 0);
	TextDrawBackgroundColour(Text_Global[4], 255);
	TextDrawFont(Text_Global[4], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(Text_Global[4], true);
	TextDrawSetSelectable(Text_Global[4], true);

	Text_Global[5] = TextDrawCreate(382.000, 294.000, "LD_SPAC:white");
	TextDrawTextSize(Text_Global[5], 219.000, 3.000);
	TextDrawAlignment(Text_Global[5], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[5], 556608511);
	TextDrawSetShadow(Text_Global[5], 0);
	TextDrawSetOutline(Text_Global[5], 0);
	TextDrawBackgroundColour(Text_Global[5], 255);
	TextDrawFont(Text_Global[5], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(Text_Global[5], true);

	Text_Global[6] = TextDrawCreate(344.000, 372.000, "_");
	TextDrawTextSize(Text_Global[6], 44.000, 46.000);
	TextDrawAlignment(Text_Global[6], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[6], -1);
	TextDrawSetShadow(Text_Global[6], 0);
	TextDrawSetOutline(Text_Global[6], 0);
	TextDrawBackgroundColour(Text_Global[6], 0);
	TextDrawFont(Text_Global[6], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawSetProportional(Text_Global[6], false);
	TextDrawSetPreviewModel(Text_Global[6], 1339);
	TextDrawSetPreviewRot(Text_Global[6], -28.000, 0.000, -203.000, 1.000);
	TextDrawSetPreviewVehicleColours(Text_Global[6], 0, 0);
	TextDrawSetSelectable(Text_Global[6], true);

	Text_Global[7] = TextDrawCreate(340.000, 183.000, "_");
	TextDrawTextSize(Text_Global[7], 44.000, 46.000);
	TextDrawAlignment(Text_Global[7], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[7], -1);
	TextDrawSetShadow(Text_Global[7], 0);
	TextDrawSetOutline(Text_Global[7], 0);
	TextDrawBackgroundColour(Text_Global[7], 0);
	TextDrawFont(Text_Global[7], TEXT_DRAW_FONT_MODEL_PREVIEW);
	TextDrawSetProportional(Text_Global[7], false);
	TextDrawSetPreviewModel(Text_Global[7], 2900);
	TextDrawSetPreviewRot(Text_Global[7], -28.000, 0.000, -203.000, 1.100);
	TextDrawSetPreviewVehicleColours(Text_Global[7], 0, 0);
	TextDrawSetSelectable(Text_Global[7], true);

	Text_Global[8] = TextDrawCreate(379.000, 74.000, "Tui do");
	TextDrawLetterSize(Text_Global[8], 1.139, 6.399);
	TextDrawTextSize(Text_Global[8], 607.000, 370.000);
	TextDrawAlignment(Text_Global[8], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[8], -1);
	TextDrawSetShadow(Text_Global[8], 1);
	TextDrawSetOutline(Text_Global[8], 1);
	TextDrawBackgroundColour(Text_Global[8], 150);
	TextDrawFont(Text_Global[8], TEXT_DRAW_FONT_0);
	TextDrawSetProportional(Text_Global[8], true);

	Text_Global[9] = TextDrawCreate(602.000, 114.000, "X");
	TextDrawLetterSize(Text_Global[9], 0.629, 1.799);
	TextDrawTextSize(Text_Global[9], 18.000, 14.000);
	TextDrawAlignment(Text_Global[9], TEXT_DRAW_ALIGN_CENTER);
	TextDrawColour(Text_Global[9], -16776961);
	TextDrawSetShadow(Text_Global[9], 1);
	TextDrawSetOutline(Text_Global[9], 1);
	TextDrawBackgroundColour(Text_Global[9], 150);
	TextDrawFont(Text_Global[9], TEXT_DRAW_FONT_1);
	TextDrawSetProportional(Text_Global[9], true);
	TextDrawSetSelectable(Text_Global[9], true);

	testitem = InitItem(1, 1, 0, 0, 1, false, true, false);
	SetItemName(testitem, "Skin Ong lao");
	SetItemContent(testitem, "Day la mot skin ong lao danh ca...");

	testitem1= InitItem(0, 1, 0, 0, 1, false, false, true);
	SetItemName(testitem1, "Skin CJ");
	SetItemContent(testitem1, "Day la Skin main...");

	testitem2= InitItem(1080, 10, 0, 0, 1, false, false, false);
	SetItemName(testitem2, "Banh xe rimkit");
	SetItemContent(testitem2, "Mot loai thuc an hoang gia :)");
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


	Text_Player[playerid][12] = CreatePlayerTextDraw(playerid, 408.000, 302.000, "LD_BEAT:chit");
	PlayerTextDrawGetPos(playerid, Text_Player[playerid][12], bar_minvalue, bar_maxvalue);
	bar_maxvalue = bar_minvalue+159;
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][12], 16.000, 19.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][12], 255);
	PlayerTextDrawFont(playerid, Text_Player[playerid][12], TEXT_DRAW_FONT_SPRITE_DRAW);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][12], true);

	Text_Player[playerid][13] = CreatePlayerTextDraw(playerid, 491.000, 303.000, "1/%d", MAX_PLAYER_INV_PAGE);
	PlayerTextDrawLetterSize(playerid, Text_Player[playerid][13], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][13], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, Text_Player[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][13], 1);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][13], 1);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][13], 150);
	PlayerTextDrawFont(playerid, Text_Player[playerid][13], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][13], true);

	Text_Player[playerid][14] = CreatePlayerTextDraw(playerid, 385.000, 323.000, "");
	PlayerTextDrawLetterSize(playerid, Text_Player[playerid][14], 0.239, 1.299);
	PlayerTextDrawTextSize(playerid, Text_Player[playerid][14], 598.000, 59.000);
	PlayerTextDrawAlignment(playerid, Text_Player[playerid][14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, Text_Player[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, Text_Player[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, Text_Player[playerid][14], 1);
	PlayerTextDrawBackgroundColour(playerid, Text_Player[playerid][14], 150);
	PlayerTextDrawFont(playerid, Text_Player[playerid][14], TEXT_DRAW_FONT_1);
	PlayerTextDrawSetProportional(playerid, Text_Player[playerid][14], true);
	return 1;
}

func InitLocker(const LockerName[], Float:x, Float:y, Float:z, interior, virtualworld){

}

Dialog:DeleteDialog(playerid, response, listitem, inputtext[]){
	if(PlayerInfo[playerid][SlotDelete] != -1 && response){
		PlayerItem[playerid][PlayerInfo[playerid][SlotDelete]] = pSlotEmtype;
		PlayerInfo[playerid][slec] = -1;
		UpdatePlayerSlot(playerid, PlayerInfo[playerid][SlotDelete]);
	}
	PlayerInfo[playerid][SlotDelete] = -1;
	return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(IsPlayerShowInv(playerid)){
		if(clickedid == Text_Global[3]){ // left
			if(PlayerInfo[playerid][InPage] > 1){
				PlayerInfo[playerid][InPage]--;
				UpdatePlayerAllSlot(playerid);
				UpdatePageBar(playerid);
			}
			return 1;
		}
		if(clickedid == Text_Global[4]){ // right
			if(PlayerInfo[playerid][InPage] < MAX_PLAYER_INV_PAGE){
				PlayerInfo[playerid][InPage]++;
				UpdatePlayerAllSlot(playerid);
				UpdatePageBar(playerid);
			}
			return 1;
		}
		if(clickedid == Text_Global[6]){ // sot rac
			if(PlayerInfo[playerid][slec] != -1){
				if(PlayerItem[playerid][PlayerInfo[playerid][slec]][pitemid] != -1){
					PlayerInfo[playerid][SlotDelete] = PlayerInfo[playerid][slec];
					Dialog_Show(playerid, DeleteDialog, DIALOG_STYLE_MSGBOX, "Xoa item", va_return("Ban co chac muon xoa item nay [%s x%d]", Item[PlayerItem[playerid][PlayerInfo[playerid][slec]][pitemid]][iname], PlayerItem[playerid][PlayerInfo[playerid][slec]][pamount]), "Xoa", "Huy");
				}
			}
			return 1;
		}
		if(clickedid == Text_Global[7]){ // vut ra dat
			return 1;
		}
		if(clickedid == INVALID_TEXT_DRAW || clickedid == Text_Global[9]){
			HidePlayerInv(playerid);
			return 1;
		}
	}
    return 0;
}
func OnPlayerUseItem(playerid, slot){
	SendClientMessage(playerid, -1, "OnPlayerUseItem(%d, %d)", playerid, slot);
	return 1;
}
func OnPlayerSplitItem(playerid, slot){
	SendClientMessage(playerid, -1, "OnPlayerUseItem(%d, %d)", playerid, slot);
	return 1;
}
func OnPlayerEquipItem(playerid, slot){
	SendClientMessage(playerid, -1, "OnPlayerEquipItem(%d, %d)", playerid, slot);
	return 1;
}
func OnPlayerClickLockSlot(playerid, slot){
	SendClientMessage(playerid, -1, "OnPlayerClickLockSlot(%d, %d)", playerid, slot);
	return 1;
}
Dialog:SplitItem(playerid, response, listitem, inputtext[]){
	if(response && IsValidItem(PlayerItem[playerid][PlayerInfo[playerid][SplitItemSlot]][pitemid]) && PlayerItem[playerid][PlayerInfo[playerid][SplitItemSlot]][pamount] > 1){
		new splitvalue = strval(inputtext);
		if(PlayerItem[playerid][PlayerInfo[playerid][SplitItemSlot]][pamount] > splitvalue > 0){
			new newslot = GetPlayerFreeSlot(playerid);
			if(newslot != -1){
				PlayerItem[playerid][newslot] = PlayerItem[playerid][PlayerInfo[playerid][SplitItemSlot]];
				PlayerItem[playerid][newslot][pamount] = splitvalue;
				PlayerItem[playerid][PlayerInfo[playerid][SplitItemSlot]][pamount] -= splitvalue;
				UpdatePlayerSlot(playerid, newslot);
				UpdatePlayerSlot(playerid, PlayerInfo[playerid][SplitItemSlot]);
			}
		}
	}
	return 1;
}
func fCountClick(playerid){
	if(PlayerInfo[playerid][CountClick] == 1){
		if(IsValidItem(PlayerItem[playerid][PlayerInfo[playerid][CountClickSlot]][pitemid])){
			if(Item[PlayerItem[playerid][PlayerInfo[playerid][CountClickSlot]][pitemid]][iuse]){
				CallRemoteFunction("OnPlayerUseItem", "dd", playerid, PlayerInfo[playerid][CountClickSlot]);
			}
			else if(Item[PlayerItem[playerid][PlayerInfo[playerid][CountClickSlot]][pitemid]][iequip]){
				CallRemoteFunction("OnPlayerEquipItem", "dd", playerid, PlayerInfo[playerid][CountClickSlot]);
			}
		}
	}
	else if(PlayerInfo[playerid][CountClick] > 1){
		if(IsValidItem(PlayerItem[playerid][PlayerInfo[playerid][CountClickSlot]][pitemid]) && PlayerItem[playerid][PlayerInfo[playerid][CountClickSlot]][pamount] > 1 && GetPlayerFreeSlot(playerid) != -1){
			PlayerInfo[playerid][SplitItemSlot] = PlayerInfo[playerid][CountClickSlot];
			Dialog_Show(playerid, SplitItem, DIALOG_STYLE_INPUT, "Tach item", "Nhap vao so luong ban muon tach", "Tach", "Huy");
		}
	}
	PlayerInfo[playerid][CountClickSlot] = -1;
	PlayerInfo[playerid][CountClick] = 0;
	PlayerInfo[playerid][CountClickTimer] = -1;
	return 1;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid){
	if(IsPlayerShowInv(playerid)){
		for(new itemslot;itemslot<MAX_PLAYER_ITEM_SLOT;itemslot++){
			if(playertextid == Text_Player[playerid][itemslot]){
				new slot = GetSlotInPage(itemslot, PlayerInfo[playerid][InPage]);
				if(PlayerItem[playerid][slot][plock]){
					CallRemoteFunction("OnPlayerClickLockSlot", "dd", playerid, slot);
					return 1;
				}
				if(PlayerInfo[playerid][CountClickSlot] != slot){
					if(PlayerInfo[playerid][CountClickTimer] != -1){
						KillTimer(PlayerInfo[playerid][CountClickTimer]);
						PlayerInfo[playerid][CountClick] = 0;
						PlayerInfo[playerid][CountClickTimer] = -1;
						PlayerInfo[playerid][CountClickSlot] = -1;
					}
					PlayerInfo[playerid][CountClickSlot] = slot;
					PlayerInfo[playerid][CountClickTimer] = SetTimerEx("fCountClick", 500, false, "%d", playerid);
				}
				else{
					PlayerInfo[playerid][CountClick]++;
				}

				if(PlayerInfo[playerid][slec] != slot){
					if(PlayerInfo[playerid][slec] != -1 && PlayerItem[playerid][PlayerInfo[playerid][slec]][pitemid] != -1){
						swarpandmerge(playerid, PlayerInfo[playerid][slec], slot);
						PlayerInfo[playerid][slec] = -1;

						if(PlayerInfo[playerid][CountClickTimer] != -1){
							KillTimer(PlayerInfo[playerid][CountClickTimer]);
							PlayerInfo[playerid][CountClick] = 0;
							PlayerInfo[playerid][CountClickTimer] = -1;
							PlayerInfo[playerid][CountClickSlot] = -1;
						}
					}
					else PlayerInfo[playerid][slec] = slot;
				}
				else{
					PlayerInfo[playerid][slec] = -1;
				}
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
CMD:add(playerid){
	printf("%d", AddPlayerItem(playerid, testitem, 2));
	printf("%d", AddPlayerItem(playerid, testitem1, 2));
	printf("%d", AddPlayerItem(playerid, testitem2, 2));
	return 1;
}