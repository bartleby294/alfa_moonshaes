//::///////////////////////////////////////////////
//:: FileName chk_bluff_18
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
  object pc    = GetPCSpeaker();
  int skill    = SKILL_BLUFF; // this is a constant integer for the skill
  int skill_dc = 11;
  return GetIsSkillSuccessful( pc, skill, skill_dc);
}

