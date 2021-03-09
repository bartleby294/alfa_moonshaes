#include "nwnx_consts"

void main()
{
    SetLocalInt(OBJECT_SELF, "sleep_style",
        NWNX_Consts_TranslateNWScriptAnimation(ANIMATION_LOOPING_DEAD_FRONT));
}
