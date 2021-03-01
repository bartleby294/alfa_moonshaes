void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);

    SendMessageToPC(oPC, "Web Used");

    if(GetTag(oItem) == "NW_IT_TORCH001" || GetTag(oItem) == "_h_crude_torch"
       || GetTag(oItem) == "hc_torch") {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectDamage(51,
                                         DAMAGE_TYPE_FIRE,
                                         DAMAGE_POWER_NORMAL),
                            OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_COM_HIT_FIRE),
                            OBJECT_SELF);
        SendMessageToPC(oPC, "Your left hand torch sets the webs aflame.");
    } else if (GetTag(oItem2) == "NW_IT_TORCH001"
                || GetTag(oItem2) == "_h_crude_torch"
                || GetTag(oItem2) == "hc_torch") {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectDamage(51,
                                         DAMAGE_TYPE_FIRE,
                                         DAMAGE_POWER_NORMAL),
                            OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_COM_HIT_FIRE),
                            OBJECT_SELF);
        SendMessageToPC(oPC, "Your right hand torch sets the webs aflame.");
    }
}



