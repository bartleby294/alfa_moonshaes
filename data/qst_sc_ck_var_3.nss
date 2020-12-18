/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

       checks for Variable 3
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
int StartingConditional()
{

    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();

    // Inspect local variables
    if(!(PQJ_RetrieveHighestPartyQuestState(oPC, sName) == 3))
        return FALSE;

    return TRUE;

}
