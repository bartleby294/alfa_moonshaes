void main()
{
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    string sItem = GetTag(oItem);
    string sName = GetName(oItem);
    location lLoc = GetItemActivatedTargetLocation();
    string sRef = GetResRef(oItem);
    object oOwner = GetItemPossessor(oItem);


    if (sItem == "004_thebox")
    {
        switch( Random( 8 ))
                {
                    case 0: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DESTRUCTION), oOwner); break;
                    case 1: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_BIGBYS_CLENCHED_FIST), oOwner); break;
                    case 2:  ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_GHOST_SMOKE), oOwner); break;
                    case 3: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_PIXIEDUST), oOwner); break;
                    case 4: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_PROT_PREMONITION), oOwner); break;
                    case 5: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oOwner); break;
                    case 6: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SPELL_MANTLE_USE), oOwner); break;
                    case 7: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_HIT_ELECTRICAL), oOwner); break;
                }
    }
}
