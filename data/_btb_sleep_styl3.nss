#include "nwnx_consts"

void main()
{
    // Sitting
    SetLocalInt(GetPCSpeaker(), "sleep_style",
        NWNX_Consts_TranslateNWScriptAnimation(ANIMATION_LOOPING_SIT_CROSS));
}
