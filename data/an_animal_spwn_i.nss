//::///////////////////////////////////////////////
//:: an_animal_spwn_i
//:: This script goes in the OnSpawn spot for herbivores
//:: that tend to operate with the "pack" mentality.
//::
//:: Modified : Rahvin Talemon April/May 2004 v1.0
//::
//:://////////////////////////////////////////////

#include "an_animal_ai_inc"

void main()
{
    object oSelf = OBJECT_SELF;
    float fOrientation = IntToFloat(Random(360));

    SetHunting(oSelf, FALSE);
    SetEating(oSelf, FALSE);
    SetEatingFood(oSelf, OBJECT_INVALID);
    SetConsumerGroup(oSelf, HERBIVORE);
    SetRememberFood(oSelf, FALSE);
    SetHunger(oSelf, GetMaxPossibleSpawnHunger(oSelf));
    SetIsDestroyable(FALSE, TRUE, FALSE);
    SetFacing(fOrientation);

    RT_SetPackCreature(TRUE, OBJECT_SELF);    //RT.5.4

    ActionRandomExplore(oSelf);
}
