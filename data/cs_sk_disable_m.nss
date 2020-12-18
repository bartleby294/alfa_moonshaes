//::///////////////////////////////////////////////
//:: CS_SK_DISABLE_M.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Attached to the dialogue file.
    Medium check for SKILL_DISABLE_TRAP
*/
//:://////////////////////////////////////////////
//:: Created By:  Clayton Greene
//:: Created On:  Aug 9, 2003
//:://////////////////////////////////////////////



#include "nw_i0_plot"

int StartingConditional()
{
    return AutoDC(DC_MEDIUM, SKILL_DISABLE_TRAP, GetPCSpeaker());
}
