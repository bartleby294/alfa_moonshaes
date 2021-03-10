/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Takes Mail for Quests
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "nw_i0_tool"
#include "x0_i0_partywide"
#include "custom_tokens"
#include "ms_xp_util"


void main()
{

    string sGet_Item = GetLocalString(OBJECT_SELF, "mail_2_get");
    string sLastPlace = GetStringRight(sGet_Item, 2);
    int iQst_Pos = StringToInt(sLastPlace);

    string sRem_Quest = GetStringRight(sGet_Item, GetStringLength(sGet_Item)-6);
    string sName = GetStringLeft(sRem_Quest, 6);
    int iXp = GetJournalQuestExperience(sName);
    object oPC = GetPCSpeaker();

    RemoveFromParty(oPC);
    // Give the speaker some gold
    GiveGoldToCreature(oPC, AMOUNT_FOR_MAIL_GOLD);

    // Give the speaker some XP (XP to Party)
    GiveAndLogXP(oPC, iXp, "MAIL QST", "for qst_gv_rd_mail_t.");

    // Take the Mail.
    RemoveItemFromParty(oPC, sGet_Item);

    // Set the variables
    AddPersistentJournalQuestEntry(sName, iQst_Pos, oPC, TRUE, FALSE, FALSE);

}
