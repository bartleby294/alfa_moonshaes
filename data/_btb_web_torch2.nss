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
        object invis = CreateObject(OBJECT_TYPE_PLACEABLE, "alfa_invisibleob",
                                    GetLocation(OBJECT_SELF));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectVisualEffect(VFX_DUR_INFERNO_CHEST),
                            invis, 3.0);
        DestroyObject(invis, 3.1);
        SendMessageToPC(oPC, "Your torch sets the webs aflame.");
    }
}



