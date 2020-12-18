#include "nw_i0_2q4luskan"

void main()
{
    object oPC = GetLastAttacker();
    object spit = OBJECT_SELF;
    location oItemLoc = GetLocation(spit);
    object fire = GetNearestObjectByTag("hc_campfire", oPC, 1);
    float distance = GetDistanceBetween(spit, fire);

    object fire2 = GetNearestObjectByTag("alfa_campfirenoambient", oPC, 1);
    object fire3 = GetNearestObjectByTag("alfa_campfire", oPC, 1);

    float distance2 = GetDistanceBetween(spit, fire2);
    float distance3 = GetDistanceBetween(spit, fire3);

    if(fire == OBJECT_INVALID && fire2 == OBJECT_INVALID && fire3 == OBJECT_INVALID)
    {
        CreateObjectVoid(OBJECT_TYPE_ITEM , "_fishing_item16", oItemLoc, FALSE);
        return;
    }

    if(distance < 4.0 || distance2 < 4.0 || distance3 < 4.0 )
    {

        CreateObjectVoid(OBJECT_TYPE_ITEM , "_fishing_item15", oItemLoc, FALSE);
        CreateObjectVoid(OBJECT_TYPE_ITEM , "_fishing_item15", oItemLoc, FALSE);
    }
    else
    {
         CreateObjectVoid(OBJECT_TYPE_ITEM , "_fishing_item16", oItemLoc, FALSE);
    }
}
