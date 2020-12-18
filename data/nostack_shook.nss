#include "nostack_inc"
#include "alfa_tradescroll"

void main()
{

    object oTarget = GetSpellTargetObject();

    if (DoTradeScrollSpellHook())
        return;
    //This is to pass to Bioware item creation
    if (GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
        return;
    if (DoNoStackingOfAbilityScores())
        return;

}
