/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0 Revision #1
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Rewards for Quest Style 1.
        August 25, 2004 - Fixed problem giving Gold and XP to a Group.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "nw_i0_tool"
#include "x0_i0_partywide"
#include "custom_tokens"

void main()
{
    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    int iGold = GetLocalInt(OBJECT_SELF, "gold_2_give");
    int iXp = GetJournalQuestExperience(sName);
    string sGet_Item = GetLocalString(OBJECT_SELF, "item_2_take");
    string sGet_Item1 = GetLocalString(OBJECT_SELF, "item_2_take1");
    string sGve_Item = GetLocalString(OBJECT_SELF, "item_2_give");
    object oPC = GetPCSpeaker();

    if (sGve_Item != "quest_xxxxx_xxxx")
    {
        // Remove PC from Party since this is an individual Quest
        RemoveFromParty(oPC);
        // Give the speaker the items
        object oGve_Item = GetObjectByTag(sGve_Item);
        SetIdentified(CreateItemOnObject(sGve_Item, oPC, 1), TRUE);
        SetItemCursedFlag(oGve_Item, SET_CURSE_FLAG);
        SetPlotFlag(oGve_Item, SET_PLOT_FLAG);
    }

    // Give the speaker some gold
    GiveGoldToAll(oPC, iGold);

    // Give the speaker some XP (XP to Party)
    GiveXPToAll(oPC, iXp);

    // Remove items from the player's inventory
    RemoveItemFromParty(oPC, sGet_Item);
    RemoveItemFromParty(oPC, sGet_Item1);

    // Set the variables*/
    AddPersistentJournalQuestEntry(sName, 3, oPC, TRUE, FALSE, FALSE);

}
