#include "x0_i0_partywide"

void main()
{
    object oPC = GetEnteringObject();
    object Door = GetObjectByTag("ThaneDoor1");
    object VarStore1 = GetObjectByTag("Dwarven_Mines02_var_store1");

    int PCRace = GetRacialType(oPC);

    if(PCRace == RACIAL_TYPE_DWARF)
    {
      AssignCommand(oPC, ActionSpeakString("*You see a door etched into the rock face*", TALKVOLUME_WHISPER));
    }

    if(GetSkillRank(SKILL_SPOT, oPC) > 25)
    {
       AssignCommand(oPC, ActionSpeakString("*You think you notice an odd crack on the rock face*", TALKVOLUME_WHISPER));
    }

    if(GetIsItemPossessedByParty(oPC, "MarkoftheThain") == TRUE)
    {
     AssignCommand(oPC, ActionSpeakString("*You see a door etched into the rock face*", TALKVOLUME_WHISPER));
    }

}
