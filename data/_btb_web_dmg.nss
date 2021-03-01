void main()
{
    int restorAmt = 0;
    object oPC = GetLastAttacker(OBJECT_SELF);
    SendMessageToPC(oPC, "Web Damaged");
    if(GetDamageDealtByType(DAMAGE_TYPE_BLUDGEONING) >= 1) {
        SendMessageToPC(oPC, "DAMAGE_TYPE_BLUDGEONING");
        restorAmt = GetDamageDealtByType(DAMAGE_TYPE_BLUDGEONING);
    } else if (GetDamageDealtByType(DAMAGE_TYPE_COLD) >= 1) {
        SendMessageToPC(oPC, "DAMAGE_TYPE_COLD");
        restorAmt = GetDamageDealtByType(DAMAGE_TYPE_COLD);
    }  else if (GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL) >= 1) {
        SendMessageToPC(oPC, "DAMAGE_TYPE_ELECTRICAL");
        restorAmt = GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL);
    } else if (GetDamageDealtByType(DAMAGE_TYPE_PIERCING) >= 1) {
        SendMessageToPC(oPC, "DAMAGE_TYPE_PIERCING");
        restorAmt = GetDamageDealtByType(DAMAGE_TYPE_PIERCING);
    } else if (GetDamageDealtByType(DAMAGE_TYPE_SONIC) >= 1) {
        SendMessageToPC(oPC, "DAMAGE_TYPE_SONIC");
        restorAmt = GetDamageDealtByType(DAMAGE_TYPE_SONIC);
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
    // Slashing damage works too though less well.
    } else if(GetDamageDealtByType(DAMAGE_TYPE_SLASHING) >= 1) {
         ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectDamage(10,
                                         DAMAGE_TYPE_SLASHING,
                                         DAMAGE_POWER_NORMAL),
                            OBJECT_SELF);
    }

    if(restorAmt > 0) {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(restorAmt),
                            OBJECT_SELF);
        SendMessageToPC(oPC, "That did seem to have much of an effect.");
    }
}
