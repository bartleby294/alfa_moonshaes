#include "nwnx_consts"

void main()
{
    // Sitting
    SetLocalInt(OBJECT_SELF, "sleep_style",
        NWNX_Consts_TranslateNWScriptAnimation(ANIMATION_LOOPING_SIT_CROSS));
}
