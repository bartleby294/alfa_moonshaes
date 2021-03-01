void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    if(GetTag(oItem) == "NW_IT_TORCH001" || GetTag(oItem) == "_h_crude_torch"
       || GetTag(oItem) == "hc_torch") {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectDamage(51,
                                         DAMAGE_TYPE_DIVINE,
                                         DAMAGE_POWER_NORMAL),
                            OBJECT_SELF);
        //ApplyEffectToObject(DURATION_TYPE_INSTANT,
        //                    EffectVisualEffect(VFX_DUR_INFERNO),
        //                    OBJECT_SELF);
        //ApplyEffectToObject(DURATION_TYPE_INSTANT,
        //                    EffectVisualEffect(VFX_DUR_INFERNO_CHEST),
        //                    OBJECT_SELF);

        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
                              EffectVisualEffect(VFX_DUR_INFERNO_CHEST),
                              GetLocation(OBJECT_SELF), 2.0);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
                              EffectVisualEffect(VFX_DUR_INFERNO),
                              GetLocation(OBJECT_SELF), 2.0);
        SendMessageToPC(oPC, "Your left hand torch sets the webs aflame.");
    }
}



