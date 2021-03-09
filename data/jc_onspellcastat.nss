//::///////////////////////////////////////////////
//:: Name x2_def_spellcast
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spell Cast At script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{

    int iSpell = GetLastSpell();
    effect eHoly;
    effect eDamage;
    effect eVisual;

    if( iSpell ==  SPELLABILITY_TURN_UNDEAD || iSpell ==  SPELL_CURE_LIGHT_WOUNDS || iSpell ==  SPELL_CURE_MINOR_WOUNDS || iSpell ==  SPELL_CURE_MODERATE_WOUNDS || iSpell ==  SPELL_CURE_SERIOUS_WOUNDS || iSpell ==  SPELL_CURE_CRITICAL_WOUNDS || iSpell ==  SPELL_HEALING_CIRCLE){
      SetImmortal( OBJECT_SELF, FALSE );
      eHoly = EffectVisualEffect( VFX_IMP_HOLY_AID );
      eDamage = EffectDamage(d6(), DAMAGE_TYPE_DIVINE);
      eVisual = EffectLinkEffects( eHoly, eDamage );




      ApplyEffectToObject( DURATION_TYPE_INSTANT, eVisual, OBJECT_SELF );




    }



    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_defaultb", OBJECT_SELF);
}
