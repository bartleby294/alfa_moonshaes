//::///////////////////////////////////////////////
//:: CS_AB_INTELL_M.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Attached to the dialogue file.
    Medium check for ABILITY_INTELLIGENCE
*/
//:://////////////////////////////////////////////
//:: Created By:  Clayton Greene
//:: Created On:  Aug 9, 2003
//:://////////////////////////////////////////////
#include "cs_fn_tools"

int StartingConditional()
{
    return AbilityCheck(DC_MEDIUM, ABILITY_INTELLIGENCE, GetPCSpeaker());
}
