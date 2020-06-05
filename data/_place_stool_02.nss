#include "nw_i0_2q4luskan"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetNearestObjectByTag("UseableStool01", oPC, 1);
    location oItemLoc = GetLocation(oItem);

    DestroyObject(oItem, 0.0);

    AssignCommand(oPC, ActionSpeakString("*Collapses stool.*"));
    CreateObjectVoid(OBJECT_TYPE_ITEM , "portablechair01", oItemLoc, FALSE);
}
