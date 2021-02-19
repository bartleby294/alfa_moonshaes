#include "_btb_util"
#include "x0_i0_position"

void main()
{
    object oPC = GetItemActivator();
    object oArea = GetArea(oPC);
    object oItem = GetItemActivated();
    location oItemLoc = GetItemActivatedTargetLocation();
    CreateObject(OBJECT_TYPE_CREATURE, "rabidbat", oItemLoc, TRUE);

}
