/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
              Forsettii's Quest Builder System.   qst_set_var_1
                       Version 1.0
              Created for Layonara Online
              Forsettii  Forsettii@yahoo.com
                      April 7, 2004
            Please see the comments in the Local Version.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */
#include "qst__pqj_inc"
void main()
{

    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();

   AddPersistentJournalQuestEntry(sName, 9, oPC, FALSE, FALSE, FALSE);
}
