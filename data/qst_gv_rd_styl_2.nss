/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Rewards for Quest Style 2.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "x0_i0_partywide"
#include "custom_tokens"
#include "NW_I0_PLOT"
#include "ms_xp_util"

void UpdateJournal(object oPC, string sName, string sGve_Item)
{
         SetLocalInt(oPC, sName, 3);
         AddPersistentJournalQuestEntry(sName, 3, oPC, FALSE, FALSE, FALSE);
         if (sGve_Item != "quest_xxxxx_xxxx")
         {
            // Give the speaker the items
            object oGve_Item = GetObjectByTag(sGve_Item);
            SetIdentified(CreateItemOnObject(sGve_Item, oPC, 1), TRUE);
            SetItemCursedFlag(oGve_Item, SET_CURSE_FLAG);
            SetPlotFlag(oGve_Item, SET_PLOT_FLAG);
          }
}

void main()
{
    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    string sQst_Num = sName + "_N";
    int iGold = GetLocalInt(OBJECT_SELF, "gold_2_give");
    int iXp = GetJournalQuestExperience(sName);
    string sGet_Item = GetLocalString(OBJECT_SELF, "item_2_take");
    string sGve_Item = GetLocalString(OBJECT_SELF, "item_2_give");
    int iTotal = GetLocalInt(OBJECT_SELF, "num_item");

    object oPC = GetPCSpeaker();

    // Remove PC from Party since this is an individual Quest
    RemoveFromParty(oPC);
    // Give the speaker some gold
    GiveGoldToCreature(oPC, iGold);

    // Give the speaker some XP (XP to Party)
    GiveAndLogXP(oPC, iXp, "MAIL QST", "for qst_gv_rd_mail_2.");

    // Remove items from the player's inventory
    RemoveItemFromParty(oPC, sGet_Item);
    // Set the variables
    int iNum = GetLocalInt(GetObjectByTag(SAVE_TO_ITEM), sQst_Num);

    iNum += 1;

    SetLocalInt(GetObjectByTag(SAVE_TO_ITEM), sQst_Num, iNum);

    if(iNum >= iTotal)
    {
        UpdateJournal(oPC, sName, sGve_Item);
        DeleteLocalInt(GetObjectByTag(SAVE_TO_ITEM), sQst_Num);
    }

    if (DEBUG_CODE == 1)
    {
        //  ExportSingleCharacter(oPC);
        object oItemSaveTwo = GetObjectByTag(SAVE_TO_ITEM);
        if ( oItemSaveTwo == OBJECT_INVALID)
        {
            SendMessageToPC(oPC, "OBJECT_INVALID");
        }
        else
        {
            string part1 = GetName(oItemSaveTwo);
            string Message1 = "Item requited to save this quest is: " + part1;
            SendMessageToPC(oPC, Message1);
        }
    }
}
