void main()
{
  object oPC = GetPCSpeaker();

  if(d4(1) == 4)
  {
    CreateItemOnObject("_walking_stick", oPC, 1);
    AssignCommand(oPC, ActionSpeakString("*Snaps a branck off of tree.*"));
  }

  else
  {
    AssignCommand(oPC, ActionSpeakString("*There doesnt seem to be a good one.*"));
  }
}
