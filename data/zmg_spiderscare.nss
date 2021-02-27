#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_switches"


#include "x0_i0_anims"
// #include "x0_i0_walkway" - in x0_i0_anims
#include "x0_i0_treasure"

#include "alfa_include"


void main()
{
    int iSaveDC = 13;

    float fDuration = RoundsToSeconds(1);
    int nDamage;
    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect eFear = EffectFrightened();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    location lTarget = GetLocation(GetObjectByTag("boo3"));
    float fDelay;
    //Link the fear and mind effects
    effect eLink = EffectLinkEffects(eFear, eMind);
    eLink = EffectLinkEffects(eLink, eDur);

    object oTarget;
    //Check for metamagic extend
    //Apply Impact
    //Get first target in the spell cone
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            fDelay = GetRandomDelay();
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FEAR));
            //Make SR Check
            //if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            //{
                //Make a will save
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iSaveDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF, fDelay))
                {
                    //Apply the linked effects and the VFX impact
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
                }
            //}
        }
        //Get next target in the spell cone
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation(), TRUE);
    }

    // SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);



    // ***** DEFAULT GENERIC BEHAVIOR (DO NOT TOUCH) ***** //

    // * Goes through and sets up which shouts the NPC will listen to.
    // *
    SetListeningPatterns();

    //***** ALFA MOD: Danmar's PuppetMaster functionality
    //**
    if ( gALFA_USE_PUPPET_MASTER )
    {
      ALFA_InitPuppetMaster( FALSE );
    }
    //**
    //****** end ALFA MOD


    // * Walk among a set of waypoints.
    // * 1. Find waypoints with the tag "WP_" + NPC TAG + "_##" and walk
    // *    among them in order.
    // * 2. If the tag of the Way Point is "POST_" + NPC TAG, stay there
    // *    and return to it after combat.
    //
    // * Optional Parameters:
    // * void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
    //
    // * If "NW_FLAG_DAY_NIGHT_POSTING" is set above, you can also
    // * create waypoints with the tags "WN_" + NPC Tag + "_##"
    // * and those will be walked at night. (The standard waypoints
    // * will be walked during the day.)
    // * The night "posting" waypoint tag is simply "NIGHT_" + NPC tag.
    WalkWayPoints();


    //* Create a small amount of treasure on the creature
    // CTG_GenerateNPCTreasure(TREASURE_TYPE_MONSTER, OBJECT_SELF);


    // ***** ADD ANY SPECIAL ON-SPAWN CODE HERE ***** //

}

