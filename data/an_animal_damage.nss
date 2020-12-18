//::///////////////////////////////////////////////
//:: an_animal_damage
//:: This script goes in the OnDamaged spot
//:: By Rhox505 @ stuart_heinrich@hotmail.com
//::
//:: Modified: Rahvin Talemon 5.4
//:: - Morale values are set via local variables on creature by the toolset.
//:: - The following values are set via the variable option in the toolset on a creature.
//:: - These values are ONLY used with the animal ai system.
//::    (Add the following variable to any animal you have attached an_ai scripts to.)
//::    Variable Type:  Integer
//::    Variable Name:  MORALE_TYPE
//::    Variable Value: 1-4
//::
//::            Type        Value       Description
//::    Morale: Fearless    4           This creature will never flee from combat.
//::            Elite       3           This creature will only flee from combat if at 3/4 Strength
//::            Average     2           This creature will only flee from combat at 1/2 Strength
//::            Weak        1           This creature will flee from combat at first blood.
//::
//::
//:://////////////////////////////////////////////

#include "an_animal_ai_inc"

void main()
{
    object oSelf = OBJECT_SELF,
           oAttacker = GetLastDamager();

    ClearAllActions();  //RT.5.4

    if (GetIsScaredOf(oSelf, oAttacker))
    {
        //if scared of attacker, run
        // PrintString("Scared of attacker: " + GetName(oAttacker));
        ActionFleeFrom(oSelf, oAttacker);
    }
    else
    {
        // RT.5.4
        // Combat.
        // - Depending on the creatures Morale it will either continue to fight
        //   an opponent or get the the heck out of dodge. No sense in surrendering
        //   why would an animal surrender?
        int nFlee = FALSE;
        switch(RT_GetMoraleType(oSelf))
        {
            case 1: if (GetCurrentHitPoints(oSelf) <  GetMaxHitPoints(oSelf))       nFlee = TRUE;     break;
            case 2: if (GetCurrentHitPoints(oSelf) <=  GetMaxHitPoints(oSelf)/2)    nFlee = TRUE;     break;
            case 3: if (GetCurrentHitPoints(oSelf) <=  GetMaxHitPoints(oSelf)/4)    nFlee = TRUE;     break;
            default: break;
        }
        // PrintString("Morale Type");
        // PrintString("Current HP" + IntToString(GetCurrentHitPoints(oSelf)));
        // PrintString("Value 1: " + IntToString(GetMaxHitPoints(oSelf) ));
        // PrintString("Value 2: " + IntToString(GetMaxHitPoints(oSelf)/2) );
        // PrintString("Value 3: " + IntToString(GetMaxHitPoints(oSelf)/4) );

        if (nFlee)
            ActionFleeFrom(oSelf, oAttacker);
        else
            ActionAttack(oAttacker, TRUE);
    }
}
