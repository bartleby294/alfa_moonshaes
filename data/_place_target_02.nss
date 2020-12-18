#include "nw_i0_2q4luskan"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetNearestObjectByTag("placetarget", oPC, 1);
    location oItemLoc = GetLocation(oItem);

    DestroyObject(oItem, 0.0);

    AssignCommand(oPC, ActionSpeakString("*Puts target away.*"));
    CreateObjectVoid(OBJECT_TYPE_ITEM , "placetargeti", oItemLoc, FALSE);
}
