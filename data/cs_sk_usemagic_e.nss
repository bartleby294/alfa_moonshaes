//::///////////////////////////////////////////////
//:: CS_SK_USEMAGIC_E.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Attached to the dialogue file.
    Easy check for SKILL_USE_MAGIC_DEVICE
*/
//:://////////////////////////////////////////////
//:: Created By:  Clayton Greene
//:: Created On:  Aug 9, 2003
//:://////////////////////////////////////////////



#include "nw_i0_plot"

int StartingConditional()
{
    return AutoDC(DC_EASY, SKILL_USE_MAGIC_DEVICE, GetPCSpeaker());
}
