//::///////////////////////////////////////////////
//:: FileName chk_intimidat_18
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////

int StartingConditional()
{
  object pc    = GetPCSpeaker();
  int skill    = SKILL_INTIMIDATE; // this is a constant integer for the skill
  int skill_dc = 18;
  return GetIsSkillSuccessful( pc, skill, skill_dc);
}

