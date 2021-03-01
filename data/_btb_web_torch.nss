void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);

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
        SendMessageToPC(oPC, "Your torch sets the webs aflame.");
    }
}
