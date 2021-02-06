void main()
{
  object oPC = GetEnteringObject();
  int iEntryNum = 1;
  int i;

  if(!GetIsPC(oPC) || GetIsDM(oPC) || oPC == OBJECT_INVALID){
    return;
  }


  //Restore Journals


  if(GetXP(oPC) >= 50 && GetXP(oPC) < 6000){  //level 1 -4 automatically give rat hills journal.
    AddJournalQuestEntry("rathillsjournal", 1, oPC);
    //return;
  }

  iEntryNum = GetCampaignInt("Journals", "sewersgoblinls", oPC);

  if(iEntryNum != 0){
    for(i=1; i <= iEntryNum; i++){
      AddJournalQuestEntry("sewersgoblinls", i, oPC, FALSE, FALSE, FALSE);
    }
  }

  iEntryNum = GetCampaignInt("Journals", "snookeryjourn", oPC);

  if(iEntryNum != 0){
    for(i=1; i <= iEntryNum; i++){
      AddJournalQuestEntry("snookeryjourn", i, oPC, FALSE, FALSE, FALSE);
    }
  }



  iEntryNum = GetCampaignInt("Journals", "thievesguildjourn", oPC);

  if(iEntryNum != 0){
    for(i=1; i <= iEntryNum; i++){
      AddJournalQuestEntry("thievesguildjourn", i, oPC, FALSE, FALSE, FALSE);
    }
  }


  iEntryNum = GetCampaignInt("Journals", "watchfulorderjourn", oPC);

  if(iEntryNum != 0){
    for(i=1; i <= iEntryNum; i++){
      AddJournalQuestEntry("watchfulorderjourn", i, oPC, FALSE, FALSE, FALSE);
    }
  }

  iEntryNum = GetCampaignInt("Journals", "newolamnjourn", oPC);

  if(iEntryNum != 0){
    for(i=1; i <= iEntryNum; i++){
      AddJournalQuestEntry("newolamnjourn", i, oPC, FALSE, FALSE, FALSE);
    }
  }









//Jump To last Location


if(GetCampaignInt("Location", "updated", oPC) != 0){
  SendMessageToPC(oPC, "Last Location found, moving you there...");
  location lLast = GetCampaignLocation("Location", "last", oPC);

  //DelayCommand(2.0, AssignCommand(oPC, ClearAllActions()));
  DelayCommand(2.1, AssignCommand(oPC, ActionJumpToLocation(lLast)));
}
else
  SendMessageToPC(oPC, "No previous location found.");


}
