#include "ms_ai_ba_util"

void main()
{
    object oPerceived = GetLastPerceived();
    if(GetIsEnemy(oPerceived) && !GetFactionEqual(oPerceived)) {
        alertCamp(OBJECT_SELF, oPerceived);
        ExecuteScript("ms_ai_bah_onperc");
    }
}
