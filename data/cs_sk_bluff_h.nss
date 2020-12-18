//::///////////////////////////////////////////////
//:: CS_SK_BLUFF_H.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Attached to the dialogue file.
    Hard check for SKILL_BLUFF
*/
//:://////////////////////////////////////////////
//:: Created By:  Clayton Greene
//:: Created On:  Aug 9, 2003
//:://////////////////////////////////////////////



#include "nw_i0_plot"

int StartingConditional()
{
    return AutoDC(DC_HARD, SKILL_BLUFF, GetPCSpeaker());
}
