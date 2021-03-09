#include "nwnx_consts"

void main()
{
    SetLocalInt(GetPCSpeaker(), "sleep_style",
        NWNX_Consts_TranslateNWScriptAnimation(ANIMATION_LOOPING_DEAD_FRONT));
}
