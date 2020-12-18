//::///////////////////////////////////////////////
//:: CS_SK_DISABLE_H.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Attached to the dialogue file.
    Hard check for SKILL_DISABLE_TRAP
*/
//:://////////////////////////////////////////////
//:: Created By:  Clayton Greene
//:: Created On:  Aug 9, 2003
//:://////////////////////////////////////////////



#include "nw_i0_plot"

int StartingConditional()
{
    return AutoDC(DC_HARD, SKILL_DISABLE_TRAP, GetPCSpeaker());
}
