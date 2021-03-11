/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Rewards for Quest Style 8.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "nw_i0_tool"
#include "x0_i0_partywide"
#include "custom_tokens"
#include "ms_xp_util"

void main()
{

    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    int iGold = GetLocalInt(OBJECT_SELF, "gold_2_give");
    int iXp = GetJournalQuestExperience(sName);
    int fGold = iGold * 5;
    int fXp = iXp * 5;
    //string sTke_Item = GetLocalString(OBJECT_SELF, "item_2_take");
    string sItem2Start = GetLocalString(OBJECT_SELF, "item_2_begin");
    string sGve_Item = GetLocalString(OBJECT_SELF, "item_2_give");
    object oGve_Item = GetObjectByTag(sGve_Item);
    object oPC = GetPCSpeaker();
    object oItemToTake;
    string sGet_Item1 = GetLocalString(OBJECT_SELF, "item_col_1");
    string sGet_Item2 = GetLocalString(OBJECT_SELF, "item_col_2");
    string sGet_Item3 = GetLocalString(OBJECT_SELF, "item_col_3");
    string sGet_Item4 = GetLocalString(OBJECT_SELF, "item_col_4");
    string sGet_Item5 = GetLocalString(OBJECT_SELF, "item_col_5");
    string sGet_Item6 = GetLocalString(OBJECT_SELF, "item_col_6");
    string sGet_Item7 = GetLocalString(OBJECT_SELF, "item_col_7");
    string sGet_Item8 = GetLocalString(OBJECT_SELF, "item_col_8");

    // Remove PC from Party since this is an individual Quest
    RemoveFromParty(oPC);
    // Give the speaker some xp
    GiveAndLogXP(oPC, iXp, "MAIL QST", "for qst_gv_rd_mail_8.");

    // Give the speaker some gold
    GiveGoldToCreature(oPC, iGold);

    int nVar = RetrieveQuestState(sName, oPC);

    switch (nVar)
    {
        case 1:
            // Set the variables
            AddPersistentJournalQuestEntry(sName, 2, oPC, TRUE, FALSE, FALSE);

            // Remove items from the player's inventory
            RemoveItemFromParty(oPC, sGet_Item1);
           break;
        case 2:
            // Set the variables
            AddPersistentJournalQuestEntry(sName, 3, oPC, TRUE, FALSE, FALSE);

            // Remove items from the player's inventory
            RemoveItemFromParty(oPC, sGet_Item2);
            break;
       case 3:
            // Set the variables
            AddPersistentJournalQuestEntry(sName, 4, oPC, TRUE, FALSE, FALSE);

            // Remove items from the player's inventory
            RemoveItemFromParty(oPC, sGet_Item3);
            break;
       case 4:
             // Set the variables
            AddPersistentJournalQuestEntry(sName, 5, oPC, TRUE, FALSE, FALSE);

            // Remove items from the player's inventory
            RemoveItemFromParty(oPC, sGet_Item4);
            break;
        case 5:
             // Set the variables
            AddPersistentJournalQuestEntry(sName, 6, oPC, TRUE, FALSE, FALSE);

            // Remove items from the player's inventory
            RemoveItemFromParty(oPC, sGet_Item5);
            break;
       case 6:
             // Set the variables
            AddPersistentJournalQuestEntry(sName, 7, oPC, TRUE, FALSE, FALSE);

            // Remove items from the player's inventory
            RemoveItemFromParty(oPC, sGet_Item6);
            break;
        case 7:
             // Set the variables
            AddPersistentJournalQuestEntry(sName, 8, oPC, TRUE, FALSE, FALSE);

            // Remove items from the player's inventory
            RemoveItemFromParty(oPC, sGet_Item7);
            break;
        case 8:
            GiveGoldToCreature(oPC, fGold);
            // Give the party some XP
            GiveAndLogXP(oPC, fXp, "MAIL QST", "for qst_gv_rd_mail_8.");
            // Give the speaker the items
            SetIdentified(CreateItemOnObject(sGve_Item, oPC, 1), TRUE);
            SetItemCursedFlag(oGve_Item, SET_CURSE_FLAG);
            SetPlotFlag(oGve_Item, SET_PLOT_FLAG);
            // Set the variables

            AddPersistentJournalQuestEntry(sName, 9, oPC, TRUE, FALSE, FALSE);

            // Remove items from the player's inventory
            RemoveItemFromParty(oPC, sGet_Item8);
            RemoveItemFromParty(oPC, sItem2Start);
            break;
       case 9:
            break;
    }
}

