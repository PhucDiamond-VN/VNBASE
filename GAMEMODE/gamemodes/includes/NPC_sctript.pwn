#include <YSI-Includes\YSI_Coding\y_hooks>
new NPC_CJ;
hook OnPlayerTalkingToNPC(playerid, npcid){
    MessageBox(playerid, "CJ", "Nay ban dang lam gi o day ?, khu nay la cua Grove Street va ban co 1p de tra loi cau hoi cua toi hoac roi khoi noi nay", 0, true);
    return 1;
}
hook OnGameModeInit(){
    NPC_CJ = CreateNPC("CJ", 0, 2491.5347,-1687.6877,13.5174,0.5137, 0);
    ApplyNPCAnimation(NPC_CJ, "SMOKING", "M_smklean_loop", 4.0, true, false, false, false, 0);
    return 1;
}