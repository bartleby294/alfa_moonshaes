/*void dhAddJournalQuestEntry(string strCategoryTag,

      int iEntryId,

      object oCreature,

      int bAllPartyMembers = TRUE,

      int bAllPlayers = FALSE,

      int bAllowOverrideHigher = FALSE,

      int bMarkAsFinished = FALSE)
*/

#include "journal_include"

void main()
{
    dhAddJournalQuestEntry("Template",      //add the TAG of the relevant Journal entry where it says "Template"

      1,

      GetPCSpeaker(),

      TRUE,

      FALSE,

      FALSE,

      FALSE);

}

