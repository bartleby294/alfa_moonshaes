#include "_btb_util"

void main()
{
    object oPC = GetEnteringObject();
    int DM_OVERRIDE = GetLocalInt(GetArea(oPC), "AllowMoonwellEnter");

    if(GetIsPC(oPC) == TRUE && DM_OVERRIDE == FALSE) {
        location jumpTo = pickLoc(oPC, 5.0, 180.0);
        AssignCommand(oPC, ActionJumpToLocation(jumpTo));
    }
}
