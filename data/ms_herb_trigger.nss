#include "ms_herb_declare"
#include "nwnx_visibility"

void main()
{
    object oPC = GetEnteringObject();

    // only run check for pcs not dms.
    if(GetIsPC(oPC) == FALSE || GetIsDM(oPC) == TRUE) {
        return;
    }

    // if we know we dont know it stop checking
    if(GetLocalInt(OBJECT_SELF, MS_HERB_DONT_KNOW_IT) == TRUE) {
        return;
    }

    object herb = GetNearestObjectByTag(MS_HERB_CONTAINER, OBJECT_SELF);

    int searchDiff = GetLocalInt(OBJECT_SELF, MS_HERB_TRIGGER_SEARCH_DIFF);
    int loreDiff = GetLocalInt(OBJECT_SELF, MS_HERB_TRIGGER_LORE_DIFF);

    int searchCheck = d20(1) + GetSkillRank(SKILL_SEARCH, oPC, FALSE);
    int loreCheck = GetSkillRank(SKILL_LORE, oPC, FALSE);

    // You saw the herb!
    if(searchCheck >=searchDiff) {
        // Take 10 rules on the lore for now.
        if(loreCheck > loreDiff - 10) {
            // You know what it is and the herb appears!
            NWNX_Visibility_SetVisibilityOverride(oPC, herb,
                                                  NWNX_VISIBILITY_VISIBLE);
        // nope thats not important ill ignore it.
        } else {
            SetLocalInt(OBJECT_SELF, MS_HERB_DONT_KNOW_IT, TRUE);
        }
    }
}
