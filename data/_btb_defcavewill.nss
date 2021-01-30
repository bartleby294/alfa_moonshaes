#include "_btb_util"
#include "_moonwelldrleave"

void main()
{
    //Create a will o the wisp.
    string wpStr = "cave_wisp_wp_0";
    object curWP = GetObjectByTag(wpStr);
    location sumLoc = GetMidPoint(GetLocation(OBJECT_SELF), GetLocation(curWP));
    CreateObject(OBJECT_TYPE_CREATURE, "moonwellwisp", sumLoc, TRUE);

    moonwellDruidsLeave();
}
