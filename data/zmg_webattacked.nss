#include "x2_inc_itemprop"

void main()
{
    object oPC = GetLastAttacker();
    object oWeapon = GetLastWeaponUsed(oPC);

    // Character has a torch
    //if(

    // DAMAGE_TYPE_SLASHING or Pericing.
    if(IPGetIsBludgeoningWeapon(oWeapon) == FALSE
        && IPGetIsMeleeWeapon(oWeapon) == TRUE) {

    }

}
