#include "x2_i0_spells"
#include "_btb_spider_sp1"

void main()
{
    int restorAmt = 0;
    object oPC = GetLastAttacker(OBJECT_SELF);
    object oWeapon = GetLastWeaponUsed(oPC);
    //SendMessageToPC(oPC, "Web Damaged");

    if(GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON) >= 1
       && GetSlashingWeapon(oWeapon) == TRUE) {
       //WriteTimestampedLogEntry("WEB: Slashing Weapon.");
        SendMessageToPC(oPC, "You're able to slash the spider web.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectDamage(10,
                                        DAMAGE_TYPE_DIVINE,
                                        DAMAGE_POWER_NORMAL),
                            OBJECT_SELF);
    } else {
        //WriteTimestampedLogEntry("WEB: Not Slashing Weapon.");
        restorAmt += GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON);
    }

    if (GetDamageDealtByType(DAMAGE_TYPE_COLD) >= 1) {
        //WriteTimestampedLogEntry("WEB: DAMAGE_TYPE_COLD");
        restorAmt += GetDamageDealtByType(DAMAGE_TYPE_COLD);
    }  else if (GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL) >= 1) {
        //WriteTimestampedLogEntry("WEB: DAMAGE_TYPE_ELECTRICAL");
        restorAmt += GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL);
    } else if (GetDamageDealtByType(DAMAGE_TYPE_SONIC) >= 1) {
        //WriteTimestampedLogEntry("WEB: DAMAGE_TYPE_SONIC");
        restorAmt += GetDamageDealtByType(DAMAGE_TYPE_SONIC);
    // If any acid damage was done
    } else if (GetDamageDealtByType(DAMAGE_TYPE_ACID) >= 1) {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectDamage(20,
                                         DAMAGE_TYPE_ACID,
                                         DAMAGE_POWER_NORMAL),
                            OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_COM_HIT_ACID),
                            OBJECT_SELF);
       SendMessageToPC(oPC, "The acid eats through the webs.");
    // If any fire damage was done
    } else if(GetDamageDealtByType(DAMAGE_TYPE_FIRE) >= 1) {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectDamage(20,
                                         DAMAGE_TYPE_FIRE,
                                         DAMAGE_POWER_NORMAL),
                            OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_COM_HIT_FIRE),
                            OBJECT_SELF);
        SendMessageToPC(oPC, "The webs catch fire and it spreads.");
    }

    if(restorAmt > 0) {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(restorAmt),
                            OBJECT_SELF);
        //WriteTimestampedLogEntry("WEB: Damage healed: "
        //                         + IntToString(restorAmt));
        SendMessageToPC(oPC, "That did seem to have much of an effect.");

   }

    if(Random(2) == 1) {
        spawnSpiders(d2(), OBJECT_SELF);
    }
}
