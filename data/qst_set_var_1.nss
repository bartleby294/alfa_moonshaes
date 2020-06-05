/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0 Revision #1
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        set Variable 1
        August 25, 2004 - Fixed problem removing from Group when no item given.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
void main()
{

    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();

    string sBegin_Item = GetLocalString(OBJECT_SELF, "item_2_give_s");
    string sGve_Item = GetLocalString(OBJECT_SELF, "item_2_give");

    // Set the variables

    // Give the speaker the items
    if (sBegin_Item != "quest_xxxxx_xxxx" || sGve_Item != "quest_xxxxx_xxxx" || sBegin_Item != "" || sGve_Item != "")
    {
        RemoveFromParty(oPC);
        SetIdentified(CreateItemOnObject(sBegin_Item, oPC, 1), 1);
        AddPersistentJournalQuestEntry(sName, 1, oPC, FALSE, FALSE, FALSE);
     }
    else
    {
        AddPersistentJournalQuestEntry(sName, 1, oPC, FALSE, FALSE, FALSE);
    }
}
