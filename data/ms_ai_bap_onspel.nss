#include "ms_ai_ba_util"

void main()
{
    object oCaster = GetLastSpellCaster();
    int bHarmful = GetLastSpellHarmful();

    // If harmful, we set the spell to a timer, if an AOE one.
    if(bHarmful && GetIsObjectValid(oCaster)) {
        alertCamp(OBJECT_SELF, oCaster);
        ExecuteScript("ms_ai_bah_onspel");
    }
}
