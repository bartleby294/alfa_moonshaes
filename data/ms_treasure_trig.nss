#include "ms_treas_declare"
#include "nwnx_visibility"

void main()
{
    object oPC = GetEnteringObject();

    // only run check for pcs not dms.
    if(GetIsPC(oPC) == FALSE || GetIsDM(oPC) == TRUE) {
        //WriteTimestampedLogEntry("Not a PC or is DM.");
        return;
    }



    object treasure = GetNearestObjectByTag(MS_TREASURE_CONTAINER, OBJECT_SELF);
    int spotDiff = GetLocalInt(OBJECT_SELF, MS_TREASURE_TRIGGER_SPOT_DIFF);
    int spotCheck = d20(1) + GetSkillRank(SKILL_SEARCH, oPC, FALSE);

    //WriteTimestampedLogEntry("spotCheck >= spotDiff: "
    //                         + IntToString(spotCheck) + " >= "
    //                         + IntToString(spotDiff));

    // You saw the treasure!
    if(spotCheck >= spotDiff) {
        //WriteTimestampedLogEntry("You know it");
        NWNX_Visibility_SetVisibilityOverride(oPC, treasure,
                                              NWNX_VISIBILITY_VISIBLE);
    }
}
