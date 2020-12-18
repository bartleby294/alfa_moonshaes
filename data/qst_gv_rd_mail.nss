/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Gives Mail for Quests
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "nw_i0_tool"

void main()
{
    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();

    // Inspect local variables
    int iQst = RetrieveQuestState(sName, oPC);

    iQst++;

    int iValue = iQst + 1;
    string sQst = IntToString(iValue);
    int length = GetStringLength(sQst);
    if (length == 1)
    {
      sQst = "_0" + sQst;
    }
    else if (length == 2)
    {
      sQst = "_" + sQst;
    }

    // Remove PC from Party since this is an individual Quest
    RemoveFromParty(oPC);
    string sMail2Give = "quest_" + sName + sQst;

    // Give the speaker the items
    SetIdentified(CreateItemOnObject(sMail2Give, oPC, 1), 1);

    AddPersistentJournalQuestEntry(sName, iQst, oPC, FALSE, FALSE, FALSE);
}
