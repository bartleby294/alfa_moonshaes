#include "_btb_util"
#include "_btb_moonwellcon"
#include "_btb_moonwelluti"

void main()
{
    //Create a will o the wisp.
    string wpStr = "cave_wisp_wp_0";
    object curWP = GetObjectByTag(wpStr);
    location sumLoc = GetMidPoint(GetLocation(OBJECT_SELF), GetLocation(curWP));
    CreateObject(OBJECT_TYPE_CREATURE, "moonwellwisp", sumLoc, TRUE);

    object oPC = GetPCSpeaker();
    object highDruid = GetNearestObjectByTag("moonwelldruid", oPC);
    AssignCommand(highDruid,
                    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 2.0));
}
