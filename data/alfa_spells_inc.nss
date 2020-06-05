//::///////////////////////////////////////////////
//:: Name ALFA Spellchanges
//:: FileName alfa_spells_inc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This file contains all of the spellchanges
    in ALFA.
*/
//:://////////////////////////////////////////////
//:: Created By: Riotnrrd / Ariak
//:://////////////////////////////////////////////

#include "x2_i0_spells"
#include "x2_inc_toollib"
#include "subraces"
#include "pfp_inc"
#include "nostack_inc"

//::///////////////////////////////////////////////
// Constants
//::///////////////////////////////////////////////

const float F_BEAM = 1.7;

//::///////////////////////////////////////////////
// Function prototypes
//::///////////////////////////////////////////////

//::Spell function prototypes
void SpellAnimateDead();
void SpellBigbysForcefulHand();
void SpellColorSpray();
void SpellCombust();
void SpellContinualFlame();
void SpellCreateGreaterUndead();
void SpellCreateUndead();
void SpellCureCriticalWounds();
void SpellCureLightWounds();
void SpellCureMinorWounds();
void SpellCureModerateWounds();
void SpellCureSeriousWounds();
void SpellDisplacement();
void SpellEnervation();
void SpellEnergyDrain();
void SpellFirebrand();
void SpellFindTraps();
void SpellFlameArrow();
void SpellFlameLash();
void SpellGreaterMagicWeapon();
void SpellGreaterPlanarBinding();
void SpellGreaterRestoration();
void SpellHarm();
void SpellHeal();
void SpellImplosion();
void SpellImprovedInvisibility();
void SpellInferno();
void SpellInfestMaggots();
void SpellInvisibility();
void SpellIsaacsGreaterMissileStorm();
void SpellIsaacsLesserMissileStorm();
void SpellKeenEdge();
void SpellKnock();
void SpellLesserPlanarBinding();
void SpellLesserRestoration();
void SpellLight();
void SpellMagicCircleChaos();
void SpellMagicCircleEvil();
void SpellMagicCircleGood();
void SpellMagicCircleLaw();
void SpellMagicWeapon();
void SpellMassHeal();
void SpellMelfsAcidArrow();
void SpellMindBlank();
void SpellMonsterRegeneration();
void SpellMordenkainensSword();
void SpellNegativeEnergyRay();
void SpellPlanarAlly();
void SpellRaiseDead();
void SpellRayOfEnfeeblement();
void SpellRayOfFrost();
void SpellRestoration();
void SpellSearingLight();
void SpellPersistantBlade();
void SpellStoneskin();
void SpellSummonMonster();
void SpellTimeStop();
void SpellTrueSeeing();

//::Spellabilities function prototypes
void SpellAbilityBoltCold();
void SpellAbilityBoltConfusion();
void SpellAbilityBoltDaze();
void SpellAbilityBoltDeath();
void SpellAbilityBoltFire();
void SpellAbilityBoltKnockd();
void SpellAbilityBoltSlow();
void SpellAbilityConeFire();
void SpellAbilityGazeDeath();
void SpellAbilityGazeFear();
void SpellAbilityHndBreath();
void SpellAbilityHowlFear();

//::Spellhook prototype
void ALFA_Spellhook();

//::Private Function prototypes
void DoBullRush(object oCaster, object oTarget, int nDuration);

void InitiateHand(object oCaster, object oTarget, int nDuration);

//Private function used for Keen Edge spell, returns TRUE if weapon is type piercing
int GetPiercingWeapon(object oItem);

//Private function used for Melf's Acid Arrow damage
void RunImpact(object oTarget, object oCaster, int nMetaMagic);

//Private function used for Shelgarns Persistent Blade
void spellsCreateItemForSummoned(object oCaster, float fDuration);

//Private function used for Greater Magic Weapon
void  AddGreaterEnhancementEffectToWeapon(object oMyWeapon, float fDuration, int nBonus);

//Private function used for Greater Magic Weapon
object GetTargetedOrEquippedWeapon();

//Private function used for Infestation Of Maggots
void RunInfestImpact(object oTarget, object oCaster, int nSaveDC, int nMetaMagic);

//Private function used for Combustion
void RunCombustImpact(object oTarget, object oCaster, int nLevel, int nMetaMagic);

//Private function used for Inferno
void RunInfernoImpact(object oTarget, object oCaster, int nMetaMagic);

//Private function used for Summon Monster
effect SetSummonEffect(int nSpellID);


//::///////////////////////////////////////////////
//:: Function implementations
//::///////////////////////////////////////////////

//void main(){}



void ALFA_Spellhook()
{
    //Get the spell or spellability that was cast or used
    int nSpell = GetSpellId();

    switch (nSpell)
    {
        case SPELL_ANIMATE_DEAD:
            SpellAnimateDead();
            break;
        case SPELL_BIGBYS_FORCEFUL_HAND:
            SpellBigbysForcefulHand();
            break;
        case SPELL_BIGBYS_CLENCHED_FIST:
            break;
        case SPELL_BULLS_STRENGTH:
            DoNoStackingOfAbilityScores();
            break;
        case SPELL_CATS_GRACE:
            DoNoStackingOfAbilityScores();
            break;
        case SPELL_COLOR_SPRAY:
            SpellColorSpray();
            break;
        case SPELL_COMBUST:
            SpellCombust();
            break;
        case SPELL_CONTINUAL_FLAME:
            SpellContinualFlame();
            break;
        case SPELL_CREATE_GREATER_UNDEAD:
            SpellCreateGreaterUndead();
            break;
        case SPELL_CREATE_UNDEAD:
            SpellCreateUndead();
            break;
        case SPELL_CURE_CRITICAL_WOUNDS:
            SpellCureCriticalWounds();
            break;
        case SPELL_CURE_LIGHT_WOUNDS:
            SpellCureLightWounds();
            break;
        case SPELL_CURE_MINOR_WOUNDS:
            SpellCureMinorWounds();
            break;
        case SPELL_CURE_MODERATE_WOUNDS:
            SpellCureModerateWounds();
            break;
        case SPELL_CURE_SERIOUS_WOUNDS:
            SpellCureSeriousWounds();
            break;
        case SPELL_DISPLACEMENT:
            SpellDisplacement();
            break;
        case SPELL_DIVINE_POWER:
            DoNoStackingOfAbilityScores();
            break;
        case SPELL_EAGLE_SPLEDOR:
            DoNoStackingOfAbilityScores();
            break;
        case SPELL_ENDURANCE:
            DoNoStackingOfAbilityScores();
            break;
        case SPELL_ENERVATION:
            SpellEnervation();
            break;
        case SPELL_ENERGY_DRAIN:
            SpellEnergyDrain();
            break;
        case SPELL_FIREBRAND:
            SpellFirebrand();
            break;
        case SPELL_FIND_TRAPS:
            SpellFindTraps();
            break;
        case SPELL_FLAME_ARROW:
            SpellFlameArrow();
            break;
        case SPELL_FLAME_LASH:
            SpellFlameLash();
            break;
        case SPELL_FOXS_CUNNING:
            DoNoStackingOfAbilityScores();
            break;
        case SPELL_GREATER_MAGIC_WEAPON:
            SpellGreaterMagicWeapon();
            break;
        case SPELL_GREATER_PLANAR_BINDING:
            SpellGreaterPlanarBinding();
            break;
        case SPELL_GREATER_RESTORATION:
            SpellGreaterRestoration();
            break;
        case SPELL_HARM:
            SpellHarm();
            break;
        case SPELL_HEAL:
            SpellHeal();
            break;
        case SPELL_IMPLOSION:
            SpellImplosion();
            break;
        case SPELL_IMPROVED_INVISIBILITY:
            SpellImprovedInvisibility();
            break;
        case SPELL_INFERNO:
            SpellInferno();
            break;
        case SPELL_INFESTATION_OF_MAGGOTS:
            SpellInfestMaggots();
            break;
        case SPELL_INVISIBILITY:
            SpellInvisibility();
            break;
        case SPELL_ISAACS_GREATER_MISSILE_STORM:
            SpellIsaacsGreaterMissileStorm();
            break;
        case SPELL_ISAACS_LESSER_MISSILE_STORM:
            SpellIsaacsLesserMissileStorm();
            break;
        case SPELL_KEEN_EDGE:
            SpellKeenEdge();
            break;
        case SPELL_KNOCK:
            SpellKnock();
            break;
        case SPELL_LESSER_PLANAR_BINDING:
            SpellLesserPlanarBinding();
            break;
        case SPELL_LESSER_RESTORATION:
            SpellLesserRestoration();
            break;
        case SPELL_LIGHT:
            SpellLight();
            break;
        case SPELL_MAGIC_CIRCLE_AGAINST_CHAOS:
            SpellMagicCircleChaos();
            break;
        case SPELL_MAGIC_CIRCLE_AGAINST_EVIL:
            SpellMagicCircleEvil();
            break;
        case SPELL_MAGIC_CIRCLE_AGAINST_GOOD:
            SpellMagicCircleGood();
            break;
        case SPELL_MAGIC_CIRCLE_AGAINST_LAW:
            SpellMagicCircleLaw();
            break;
        case SPELL_MAGIC_WEAPON:
            SpellMagicWeapon();
            break;
        case SPELL_MASS_HEAL:
            SpellMassHeal();
            break;
        case SPELL_MELFS_ACID_ARROW:
            SpellMelfsAcidArrow();
            break;
        case SPELL_MIND_BLANK:
            SpellMindBlank();
            break;
        case SPELL_MONSTROUS_REGENERATION:
            SpellMonsterRegeneration();
            break;
        case SPELL_MORDENKAINENS_SWORD:
            SpellMordenkainensSword();
            break;
        case SPELL_OWLS_WISDOM:
            DoNoStackingOfAbilityScores();
            break;
        case SPELL_NEGATIVE_ENERGY_RAY:
            SpellNegativeEnergyRay();
            break;
        case SPELL_PLANAR_ALLY:
            SpellPlanarAlly();
            break;
        case SPELL_PROTECTION__FROM_CHAOS:
            break;
        case SPELL_PROTECTION_FROM_EVIL:
            break;
        case SPELL_PROTECTION_FROM_GOOD:
            break;
        case SPELL_PROTECTION_FROM_LAW:
            break;
        case SPELL_RAY_OF_ENFEEBLEMENT:
            SpellRayOfEnfeeblement();
            break;
        case SPELL_RAY_OF_FROST:
            SpellRayOfFrost();
            break;
        case SPELL_RESTORATION:
            SpellRestoration();
            break;
        case SPELL_SEARING_LIGHT:
            SpellSearingLight();
            break;
        case SPELL_SHELGARNS_PERSISTENT_BLADE:
            SpellPersistantBlade();
            break;
        case SPELL_STONESKIN:
            SpellStoneskin();
            break;
        case SPELL_SUMMON_CREATURE_I:
            SpellSummonMonster();
            break;
        case SPELL_SUMMON_CREATURE_II:
            SpellSummonMonster();
            break;
        case SPELL_SUMMON_CREATURE_III:
            SpellSummonMonster();
            break;
        case SPELL_SUMMON_CREATURE_IV:
            SpellSummonMonster();
            break;
        case SPELL_SUMMON_CREATURE_IX:
            SpellSummonMonster();
            break;
        case SPELL_SUMMON_CREATURE_V:
            SpellSummonMonster();
            break;
        case SPELL_SUMMON_CREATURE_VI:
            SpellSummonMonster();
            break;
        case SPELL_SUMMON_CREATURE_VII:
            SpellSummonMonster();
            break;
        case SPELL_SUMMON_CREATURE_VIII:
            SpellSummonMonster();
            break;
        case SPELL_TIME_STOP:
            SpellTimeStop();
            break;
        case SPELL_TRUE_SEEING:
            SpellTrueSeeing();
            break;

        //Spellabilities
        case SPELLABILITY_BOLT_COLD:
            SpellAbilityBoltCold();
            break;
        case SPELLABILITY_BOLT_CONFUSE:
            SpellAbilityBoltConfusion();
            break;
        case SPELLABILITY_BOLT_DAZE:
            SpellAbilityBoltDaze();
            break;
        case SPELLABILITY_BOLT_DEATH:
            SpellAbilityBoltDeath();
            break;
        case SPELLABILITY_BOLT_FIRE:
            SpellAbilityBoltFire();
            break;
        case SPELLABILITY_BOLT_KNOCKDOWN:
            SpellAbilityBoltKnockd();
            break;
        case SPELLABILITY_BOLT_SLOW:
            SpellAbilityBoltSlow();
            break;
        case SPELLABILITY_CONE_FIRE:
            SpellAbilityConeFire();
            break;
        case SPELLABILITY_GAZE_DEATH:
            SpellAbilityGazeDeath();
            break;
        case SPELLABILITY_GAZE_FEAR:
            SpellAbilityGazeFear();
            break;
        case SPELLABILITY_HELL_HOUND_FIREBREATH:
            SpellAbilityHndBreath();
            break;
        case SPELLABILITY_HOWL_FEAR:
            SpellAbilityHowlFear();
            break;
    }
    return;
}

//::///////////////////////////////////////////////
//:: Function implementations for spells
//::///////////////////////////////////////////////

void SpellAnimateDead()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel+ 10;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    //Metamagic extension if needed
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;  //Duration is +100%
    }
    //Summon the appropriate creature based on the summoner level
    if (nCasterLevel <= 5)
    {
        //Tyrant Fog Zombie
        eSummon = EffectSummonCreature("NW_S_ZOMBTYRANT",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 6) && (nCasterLevel <= 9))
    {
        //Skeleton Warrior
        eSummon = EffectSummonCreature("NW_S_SKELWARR",VFX_FNF_SUMMON_UNDEAD);
    }
    else
    {
        //Skeleton Chieftain
        eSummon = EffectSummonCreature("NW_S_SKELCHIEF",VFX_FNF_SUMMON_UNDEAD);
    }
    //Apply the summon visual and summon the two undead.
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));

    SetModuleOverrideSpellScriptFinished();
}

void SpellBigbysForcefulHand()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    effect eSummon;

    //Check for metamagic extend
    if (GetMetaMagicFeat() == METAMAGIC_EXTEND) //Duration is +100%
    {
         nDuration = nDuration * 2;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 460, TRUE));
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            SetLocalObject(OBJECT_SELF, "oTarget", oTarget);
            if(GetCreatureSize(oTarget) != CREATURE_SIZE_HUGE)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oTarget, RoundsToSeconds(nDuration));
            }
            eSummon = EffectSummonCreature("FORCEFULHAND", VFX_NONE);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));

            DelayCommand(0.5, InitiateHand(OBJECT_SELF, oTarget, nDuration));
        }
    }
    SetModuleOverrideSpellScriptFinished();
}

void InitiateHand(object oCaster, object oTarget, int nDuration)
{
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCaster);

    if(GetIsObjectValid(oSummon))
    {

        effect eVis = EffectVisualEffect(VFX_DUR_BIGBYS_INTERPOSING_HAND);

        int nCasterHP = GetMaxHitPoints(oCaster);
        int nHandHP = GetMaxHitPoints(oSummon);

        if(nCasterHP < nHandHP)
        {
            nHandHP = nHandHP - nCasterHP;

            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nHandHP), oSummon);
        }

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oSummon, RoundsToSeconds(nDuration));
        AssignCommand(oSummon, ActionForceFollowObject(oTarget));
    }
}

void DoBullRush(object oCaster, object oTarget, int nDuration)
{
    if(nDuration > 0)
    {
        SendMessageToPC(oTarget, "Trying Bullsrush");
        // Contested strength roll as per spell
        int nCasterRoll = d20(1) + 14;
        int nTargetRoll = d20(1) + GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetSizeModifier(oTarget);
        // used to calculate distance pushed back
        int nResult = nCasterRoll - nTargetRoll;

        // * bullrush succesful, push back
        if (nCasterRoll >= nTargetRoll)
        {
            // * Bull Rush succesful
            SendMessageToPC(oTarget, "Modified Penalty Applied");
            AssignCommand(oTarget, ClearAllActions());
            AssignCommand(oTarget, ActionMoveAwayFromObject(oCaster, TRUE, 10.0f));
            FloatingTextStrRefOnCreature(8966,OBJECT_SELF, FALSE);
        }
        else
        {
            FloatingTextStrRefOnCreature(8967,OBJECT_SELF, FALSE);
        }
        nDuration--;
        DelayCommand(6.0, DoBullRush(oCaster, oTarget, nDuration));
    }
}

void SpellColorSpray()
{
    //Familiar Spell Tracking
    if(GetIsObjectValid(GetMaster()))
    {
        FamiliarTrackSpell(GetSpellId(),GetMaster());
    }

    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nHD;
    int nDuration;
    float fDelay;
    object oTarget;
    effect eSleep = EffectSleep();
    effect eStun = EffectStunned();
    effect eBlind = EffectBlindness();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    effect eLink1 = EffectLinkEffects(eSleep, eMind);

    effect eLink2 = EffectLinkEffects(eStun, eMind);
    eLink2 = EffectLinkEffects(eLink2, eDur);

    effect eLink3 = EffectLinkEffects(eBlind, eMind);

    effect eVis1 = EffectVisualEffect(VFX_IMP_SLEEP);
    effect eVis2 = EffectVisualEffect(VFX_IMP_STUN);
    effect eVis3 = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);


    //Get first object in the spell cone
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE);
    //Cycle through the target until the current object is invalid
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_COLOR_SPRAY));
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/30;
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && oTarget != OBJECT_SELF)
            {
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
                {
                      nDuration = 3 + d4();
                      //Enter Metamagic conditions
                      if (nMetaMagic == METAMAGIC_MAXIMIZE)
                      {
                         nDuration = 7;//Damage is at max
                      }
                      else if (nMetaMagic == METAMAGIC_EMPOWER)
                      {
                         nDuration = nDuration + (nDuration/2); //Damage/Healing is +50%
                      }
                      else if (nMetaMagic == METAMAGIC_EXTEND)
                      {
                         nDuration = nDuration *2;  //Duration is +100%
                      }

                    nHD = GetHitDice(oTarget);
                    if(nHD <= 2)
                    {
                         //Apply the VFX impact and effects
                         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oTarget));
                         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink1, oTarget, RoundsToSeconds(nDuration)));
                    }
                    else if(nHD > 2 && nHD < 5)
                    {
                         nDuration = nDuration - 1;
                         //Apply the VFX impact and effects
                         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis3, oTarget));
                         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink3, oTarget, RoundsToSeconds(nDuration)));
                    }
                    else
                    {
                         nDuration = nDuration - 2;
                         //Apply the VFX impact and effects
                         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                         DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(nDuration)));
                    }
                }
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE);
    }
    // Spell Completed
    SetModuleOverrideSpellScriptFinished();
}

void SpellCombust()
{

    //--------------------------------------------------------------------------
    // Calculate the save DC
    //--------------------------------------------------------------------------
    int nDC = GetSpellSaveDC();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);


    //--------------------------------------------------------------------------
    // Calculate the damage, 2d6 + casterlevel, capped at +10
    //--------------------------------------------------------------------------
    int nDamage = nCasterLevel;
    if (nDamage > 10)
    {
        nDamage = 10;
    }
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage += 12;//Damage is at max
    }
    else
    {
        nDamage  += d6(2);
        if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nDamage = nDamage + (nDamage/2);//Damage/Healing is +50%
        }
    }

    //--------------------------------------------------------------------------
    // Calculate the duration (we need a duration or bad things would happen
    // if someone is immune to fire but fails his safe all the time)
    //--------------------------------------------------------------------------
    int nDuration = 1 + nCasterLevel/2;

    //--------------------------------------------------------------------------
    // Setup Effects
    //--------------------------------------------------------------------------
    effect eDam      = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
    effect eDur      = EffectVisualEffect(498);

    object oTarget = GetSpellTargetObject();

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

       //-----------------------------------------------------------------------
       // Check SR
       //-----------------------------------------------------------------------
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {

           //-------------------------------------------------------------------
           // Apply VFX
           //-------------------------------------------------------------------
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            TLVFXPillar(VFX_IMP_FLAME_M, GetLocation(oTarget), 5, 0.1f,0.0f, 2.0f);

            //------------------------------------------------------------------
            // This spell no longer stacks. If there is one of that type,
            // that's enough
            //------------------------------------------------------------------
            if (GetHasSpellEffect(GetSpellId(),oTarget) || GetHasSpellEffect(SPELL_INFERNO,oTarget)  )
            {
                FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
                return;
            }

            //------------------------------------------------------------------
            // Apply the VFX that is used to track the spells duration
            //------------------------------------------------------------------
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, RoundsToSeconds(nDuration));

            //------------------------------------------------------------------
            // Save the spell save DC as a variable for later retrieval
            //------------------------------------------------------------------
            SetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_COMBUST), nDC);

            //------------------------------------------------------------------
            // Tick damage after 6 seconds again
            //------------------------------------------------------------------
            DelayCommand(6.0, RunCombustImpact(oTarget, OBJECT_SELF, nCasterLevel, nMetaMagic));
        }
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellContinualFlame()
{
    int nDuration = 24;
    int nMetaMagic;
    object oTarget = GetSpellTargetObject();

    // Handle spell cast on item....
    if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    {
        // Do not allow casting on not equippable items
        if (!IPGetIsItemEquipable(oTarget))
        {
            // Item must be equipable...
            FloatingTextStrRefOnCreature(83326,OBJECT_SELF);
            return;
        }

        itemproperty ip = ItemPropertyLight (IP_CONST_LIGHTBRIGHTNESS_NORMAL, IP_CONST_LIGHTCOLOR_RED);
        if (GetItemHasItemProperty(oTarget, ITEM_PROPERTY_LIGHT))
        {
            IPRemoveMatchingItemProperties(oTarget,ITEM_PROPERTY_LIGHT,DURATION_TYPE_TEMPORARY);
        }

        nMetaMagic = GetMetaMagicFeat();
        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2; //Duration is +100%
        }

        nDuration = nDuration /2;

        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oTarget,HoursToSeconds(nDuration));
    }
    else
    {

        //Declare major variables
        effect eVis = (EffectVisualEffect(VFX_DUR_LIGHT_RED_15));
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = SupernaturalEffect(EffectLinkEffects(eVis, eDur));

        nDuration = GetCasterLevel(OBJECT_SELF);
        nMetaMagic = GetMetaMagicFeat();
        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2; //Duration is +100%
        }

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 419, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    }
    // Spell Completed
    SetModuleOverrideSpellScriptFinished();
}

void SpellCreateGreaterUndead()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel + 10;
    effect eSummon;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    //Make metamagic extend check
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Determine undead to summon based on level
    if (nCasterLevel <= 15)
    {
        eSummon = EffectSummonCreature("NW_S_VAMPIRE",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 16) && (nCasterLevel <= 17))
    {
        eSummon = EffectSummonCreature("NW_S_DOOMKGHT",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 18) && (nCasterLevel <= 19))
    {
        eSummon = EffectSummonCreature("NW_S_LICH",VFX_FNF_SUMMON_UNDEAD);
    }
    else
    {
        eSummon = EffectSummonCreature("NW_S_MUMCLERIC",VFX_FNF_SUMMON_UNDEAD);
    }
    //Apply summon effect and VFX impact.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
    // Spell Completed
    SetModuleOverrideSpellScriptFinished();
}

void SpellCreateUndead()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel + 10;
    effect eSummon;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Set the summoned undead to the appropriate template based on the caster level
    if (nCasterLevel <= 11)
    {
        eSummon = EffectSummonCreature("NW_S_GHOUL",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 12) && (nCasterLevel <= 13))
    {
        eSummon = EffectSummonCreature("NW_S_GHAST",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 14) && (nCasterLevel <= 15))
    {
        eSummon = EffectSummonCreature("NW_S_WIGHT",VFX_FNF_SUMMON_UNDEAD); // change later
    }
    else if ((nCasterLevel >= 16))
    {
        eSummon = EffectSummonCreature("NW_S_SPECTRE",VFX_FNF_SUMMON_UNDEAD);
    }

    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
    // Spell Completed
    SetModuleOverrideSpellScriptFinished();
}

void SpellCureCriticalWounds()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eDam;
    effect eHeal;
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    int nCasterLvl= GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nToHeal;
    //Limit caster level
    if (nCasterLvl > 20)
    {
        nCasterLvl = 20;
    }

    nToHeal = d8(4) + nCasterLvl;

    //Check for metamagic
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nToHeal = 32 + nCasterLvl;
        if(GetIsPC(OBJECT_SELF))
        {
            nToHeal = nToHeal + nCasterLvl;
        }
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER || GetHasFeat(FEAT_HEALING_DOMAIN_POWER))
    {
        nToHeal = nToHeal + (nToHeal/2);
    }
    //Check to see if the target is an undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_CRITICAL_WOUNDS));
            //Make a melee touch attack

            //Make SR Check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Make a Will Save for half damage
                if (MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(),SAVING_THROW_TYPE_POSITIVE))
                {
                    nToHeal = nToHeal/2;
                }
                //Set the damage amount and type
                eDam = EffectDamage(nToHeal,DAMAGE_TYPE_POSITIVE);
                //Apply the effects to the target.
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_CRITICAL_WOUNDS, FALSE));
        //Set the amount to heal
        eHeal = EffectHeal(nToHeal);
        //Apply the VFX impact and heal effect to the target.
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellCureLightWounds()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eDam;
    effect eHeal;
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_S);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nToHeal;
    int nMetaMagic = GetMetaMagicFeat();
    //Limit caster level to 5
    if (nCasterLvl > 5)
    {
        nCasterLvl = 5;
    }
    nToHeal = d8() + nCasterLvl;

    //Make metamagic checks
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nToHeal = 8 + nCasterLvl;
        if(GetIsPC(OBJECT_SELF))
        {
            nToHeal = nToHeal + nCasterLvl;
        }
    }
    if (nMetaMagic == METAMAGIC_EMPOWER || GetHasFeat(FEAT_HEALING_DOMAIN_POWER))
    {
        nToHeal = nToHeal + (nToHeal/2);
    }
    //Check to see if the target is undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_LIGHT_WOUNDS));
            //Make melee touch attack
            //Make SR Check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Make will save for half damage
                if (MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_POSITIVE))
                {
                    nToHeal /= 2;
                }
                //Apply VFX impact and damage
                eDam = EffectDamage(nToHeal,DAMAGE_TYPE_POSITIVE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_LIGHT_WOUNDS, FALSE));
        //Apply VFX impact and heal effect
        eHeal = EffectHeal(nToHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellCureMinorWounds()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eDam;
    effect eHeal;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HEAL);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    int nToHeal = 1;
    //Check to see if the target is undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_MINOR_WOUNDS));
            //Make SR Check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Make Will save to negate damage
                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_POSITIVE))
                {
                    //Set damage effect
                    eDam = EffectDamage(nToHeal,DAMAGE_TYPE_POSITIVE);
                    //Apply VFX Impact and damage effect
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
                }
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_MINOR_WOUNDS, FALSE));
        //Set heal effect
        eHeal = EffectHeal(nToHeal);
        //Apply heal effect and VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellCureModerateWounds()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eHeal;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nToHeal;
    int nMetaMagic = GetMetaMagicFeat();
    //Limit caster level
    if (nCasterLvl > 10)
    {
        nCasterLvl = 10;
    }
    nToHeal = d8(2) + nCasterLvl;
    //Check metamagic
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nToHeal = 16 + nCasterLvl;
        if(GetIsPC(OBJECT_SELF))
        {
            nToHeal = nToHeal + nCasterLvl;
        }
    }
    if (nMetaMagic == METAMAGIC_EMPOWER || GetHasFeat(FEAT_HEALING_DOMAIN_POWER))
    {
        nToHeal = nToHeal + (nToHeal/2);
    }
    //Check for an undead target
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_MODERATE_WOUNDS));
            //Make SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Make Will save for half damage
                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DIVINE))
                {
                    nToHeal /= 2;
                }
                //Set damage effect
                eDam = EffectDamage(nToHeal,DAMAGE_TYPE_POSITIVE);
                //Apply VFX impact and damage effect
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_MODERATE_WOUNDS, FALSE));
        //Set heal effect
        eHeal = EffectHeal(nToHeal);
        //Apply VFX impact and heal effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellCureSeriousWounds()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eDam;
    effect eHeal;
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_L);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    int nCasterLvl= GetCasterLevel(OBJECT_SELF);
    int nToHeal;
    int nMetaMagic = GetMetaMagicFeat();
    //Limit caster level
    if (nCasterLvl > 15)
    {
        nCasterLvl = 15;
    }
    nToHeal = d8(3) + nCasterLvl;
    //Perform metamagic checks
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nToHeal = 24 + nCasterLvl;
        if(GetIsPC(OBJECT_SELF))
        {
            nToHeal = nToHeal + nCasterLvl;
        }
    }
    if (nMetaMagic == METAMAGIC_EMPOWER || GetHasFeat(FEAT_HEALING_DOMAIN_POWER))
    {
        nToHeal = nToHeal + (nToHeal/2);
    }
    //Check if target is an undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_SERIOUS_WOUNDS));
            //Make SR Check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Make will save check for half damage
                if (MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_POSITIVE))
                {
                    nToHeal /= 2;
                }
                //Set the amount of damage
                eDam = EffectDamage(nToHeal,DAMAGE_TYPE_POSITIVE);
                //Apply VFX Impact and damage effect
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_SERIOUS_WOUNDS, FALSE));
        //Set the amount to be healed
        eHeal = EffectHeal(nToHeal);
        //Apply VFX impact and heal effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }

    SetModuleOverrideSpellScriptFinished();
}


void SpellDisplacement()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eDisplace;
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);


    int nMetaMagic = GetMetaMagicFeat();
    int nRaise = GetCasterLevel(OBJECT_SELF) / 2;
    int nDuration = GetCasterLevel(OBJECT_SELF);

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    eDisplace = EffectConcealment(50);
    if (GetEffectType(eDisplace) != EFFECT_TYPE_INVALIDEFFECT)
    {
        effect eImmunity = EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN);
        effect eLink = EffectLinkEffects(eDisplace, eImmunity);
        eLink = EffectLinkEffects(eLink, eDur);

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISPLACEMENT, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellEnergyDrain()
{
    //Declare major variables
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDrain = d4(2);

    float fDuration = HoursToSeconds(nCasterLevel);
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDrain = 8; //Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDrain = nDrain + (nDrain/2); //Damage/Healing is +50%
    }
    else if (nMetaMagic == METAMAGIC_EXTEND)
    {
        fDuration = fDuration *2; //Duration is +100%
    }

    // If Ranged Touch Hits
    if(TouchAttackRanged(oTarget))
    {
        // Ray Hit VFX
        effect eRay = EffectBeam(VFX_BEAM_EVIL, oCaster, BODY_NODE_HAND);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);

        // If Undead, Give 2d4 * 5 Bonus HPs for 1 hour
        if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oTarget, SPELL_ENERGY_DRAIN, FALSE));

            effect eTemporaryHP = EffectTemporaryHitpoints(nDrain * 5);
            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
            effect eLink = EffectLinkEffects(eTemporaryHP, eDur);
            effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

            // Correct duration for flat 1 hour, 2 with metamagic extend
            fDuration = fDuration / nCasterLevel;

            // Apply Effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }

        // Else Drain 2d4 Levels Permanently
        else {
            // Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oTarget, SPELL_ENERGY_DRAIN));

            // Check for Spell Resistance
            if(!MyResistSpell(oCaster, oTarget))
            {
                effect eDrain = EffectNegativeLevel(nDrain);
                effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
                //Make undispellable, remains on rest
                eDrain = SupernaturalEffect(eDrain);

                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDrain, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }
    //Else Ranged Touch Misses
    else
    {
        // Ray Miss VFX
        effect eRay = EffectBeam(VFX_BEAM_EVIL, oCaster, BODY_NODE_HAND, TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellEnervation()
{
    //Declare major variables

    int nMetaMagic = GetMetaMagicFeat();
    int nDrain = d4();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDrain = 4;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDrain = nDrain + (nDrain/2); //Damage/Healing is +50%
    }
    else if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    // If Ranged Touch Attack hits
    if(TouchAttackRanged(oTarget))
    {
        // Ray hits VFX
        effect eRay = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);

        // If Undead, Give 1d4 * 5 Bonus HPs for 1 hour
        if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oTarget, SPELL_ENERVATION, FALSE));

            effect eTemporaryHP = EffectTemporaryHitpoints(nDrain * 5);
            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
            effect eLink = EffectLinkEffects(eTemporaryHP, eDur);
            effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

            // Correct duration for flat 1 hour, 2 with metamagic extend
            nDuration = nDuration / GetCasterLevel(OBJECT_SELF);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }

        // Else Drain 1d4 Levels for 1 hour / level
        else {
            // Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERVATION));

            // Check for Spell Resistance
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
                effect eDrain = EffectNegativeLevel(nDrain);
                effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
                effect eLink = EffectLinkEffects(eDrain, eDur);
                effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);

                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }
    //Else Ranged Touch Misses
    else
    {
        // Ray Miss VFX
        effect eRay = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND, TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellFirebrand()
{
    int nDamage =  GetCasterLevel(OBJECT_SELF);
    if (nDamage > 15)
    {
        nDamage = 15;
    }

    DoMissileStorm(nDamage, 15, SPELL_FIREBRAND, VFX_IMP_MIRV_FLAME, VFX_IMP_FLAME_M, DAMAGE_TYPE_FIRE, TRUE);
    SetModuleOverrideSpellScriptFinished();
}

void SpellFindTraps()
{
    // Search bonus is 1/2 Caster Level, Max +10
    int nSkillBonus = GetCasterLevel(OBJECT_SELF) / 2;
    if (nSkillBonus > 10 ) nSkillBonus = 10;

    // Create Visual and Skill Bonus effects
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eSkill = EffectSkillIncrease(SKILL_SEARCH, nSkillBonus);
    effect eLink = EffectLinkEffects(eVis, eSkill);

    // Duration 1 minute / Caster Level
    float fDuration = 60.0 * GetCasterLevel(OBJECT_SELF);

    //Enter Metamagic conditions
    if (GetMetaMagicFeat() == METAMAGIC_EXTEND) //Duration is +100%
    {
        fDuration = fDuration * 2.0;
    }

    ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);

    // Spell Completed
    SetModuleOverrideSpellScriptFinished();
}

void SpellFlameArrow()
{
    //Declare major variables
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();

    int nCasterLevel = GetCasterLevel(oCaster);
    int nDamage = 0;
    int nDuration;
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt;
    effect eMissile;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    int nMissiles = (nCasterLevel)/4;
    float fDist = GetDistanceBetween(oCaster, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);


    //Limit missiles to five
    if(nMissiles == 0)
    {
        nMissiles = 1;
    }

    if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    {
        if(IPGetIsProjectile(oTarget))
        {
            nDuration = 10 * nCasterLevel;
            itemproperty iProp = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGEBONUS_1d6);
            IPSafeAddItemProperty(oTarget, iProp, TurnsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        }
        else
        {
            FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
        }
    }
    else
    {
     // For each missile
     for (nCnt = 1; nCnt <= nMissiles; nCnt++)
     {
        // If Ranged Touch Attack hits
        if (TouchAttackRanged(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_ARROW));

            // Check for SR
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {

                //Roll damage
                int nDam = d6(4) + 1;
                //Enter Metamagic conditions
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                      nDam = 24;//Damage is at max
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                      nDam = nDam + nDam/2; //Damage/Healing is +50%
                }
                //nDam = GetReflexAdjustedDamage(nDam, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
                //Set damage effect
                effect eDam = EffectDamage(nDam, DAMAGE_TYPE_FIRE);
                //Apply the MIRV and damage effect
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));

            }
        }
        eMissile = EffectVisualEffect(VFX_IMP_MIRV_FLAME);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);

     }
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellFlameLash()
{
    // Familiar spell tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if(nCasterLevel > 3)
    {
        nCasterLevel = (nCasterLevel-3)/2;
    }
    int nDamage = d6(2 + nCasterLevel);

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * (2 + nCasterLevel);//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
    }
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eRay = EffectBeam(VFX_BEAM_FIRE_LASH, OBJECT_SELF, BODY_NODE_HAND);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_LASH));
        if (!MyResistSpell(OBJECT_SELF, oTarget, 1.0))
        {
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            if(nDamage > 0)
            {
                //Apply the VFX impact and effects
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            }
        }
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellGreaterMagicWeapon()
{
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nEnchantment = nDuration / 3;
    int nMetaMagic = GetMetaMagicFeat();

    //Limit nEnchantment to 5, so it max out at +5 enhancement to the weapon.
    if(nEnchantment > 5)
    {
        nEnchantment = 5;
    }

    object oMyWeapon   =  GetTargetedOrEquippedWeapon();

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }

    if(GetIsObjectValid(oMyWeapon))
    {
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        if(nDuration > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, HoursToSeconds(nDuration), nEnchantment);
        }
    }
    else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellGreaterPlanarBinding()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel;

    effect eSummon;
    effect eGate;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);

    effect eLink = EffectLinkEffects(eDur, EffectParalyze());
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eDur3);

    object oTarget = GetSpellTargetObject();
    int nRacial = GetRacialType(oTarget);
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Check to see if a valid target has been chosen
    if (GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_PLANAR_BINDING));
            //Check for racial type
            if(nRacial == RACIAL_TYPE_OUTSIDER)
            {
                //Allow will save to negate hold effect
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()+5))
                {
                    //Apply the hold effect
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration/2));
                }
            }
        }
    }
    else
    {
        //If the ground was clicked on summon an outsider based on alignment
        int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
        float fDelay = 3.0;
        switch (nAlign)
        {
            case ALIGNMENT_EVIL:
                eSummon = EffectSummonCreature("NW_S_VROCK", VFX_FNF_SUMMON_GATE, 3.0);
                //eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
            break;
            case ALIGNMENT_GOOD:
                eSummon = EffectSummonCreature("NW_S_CTRUMPET", VFX_FNF_SUMMON_CELESTIAL, 3.0);
                //eGate = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL);
            break;
            case ALIGNMENT_NEUTRAL:
                eSummon = EffectSummonCreature("NW_S_SLAADDETH", VFX_FNF_SUMMON_MONSTER_3, 1.0);
                //eGate = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
                fDelay = 1.0;
            break;
        }
        //Apply the VFX impact and summon effect

        nDuration = nCasterLevel + 10;
        //Metamagic extension if needed
    if (nMetaMagic == METAMAGIC_EXTEND)
      {
        nDuration = nDuration * 2;  //Duration is +100%
      }
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellGreaterRestoration()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);

    effect eBad = GetFirstEffect(oTarget);
    //Search for negative effects
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
            GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_SLOW ||
            GetEffectType(eBad) == EFFECT_TYPE_STUNNED)
        {
            //Remove effect if it is negative.
            Subraces_SafeRemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_RESTORATION, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);

    SetModuleOverrideSpellScriptFinished();
}

void SpellHarm()
{
    // 3.5 version. Melee touch, heal undead or damage is 10 / level to max of 150, Will save for 1/2

    int nCurrHp;
    int nHarm = 10 * GetCasterLevel(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();

    //Limit damage to maximum 150 hp
    if (nHarm > 150)
    {
        nHarm = 150;
    }

    if(TouchAttackMelee(oTarget))
    {
        // If Undead target, Heal
        if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HARM, FALSE));

            effect eHeal = EffectHeal(nHarm);
            effect eVis = EffectVisualEffect(DURATION_TYPE_INSTANT, VFX_IMP_HEALING_X);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

        }

        // Else do 10 / level, max 150, save for 1/2
        else
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HARM));

            //Check for Spell Resistance
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
                // Check for fort save for 1/2
                if(MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NEGATIVE))
                {
                    nHarm = nHarm / 2;
                }

                nCurrHp = GetCurrentHitPoints(oTarget);

                //Make sure the spell does not reduce the targets hp to less than 1.
                if(nHarm >= nCurrHp)
                {
                    nHarm = nCurrHp - 1;
                }

                effect eDamage = EffectDamage(nHarm, DAMAGE_TYPE_NEGATIVE);
                effect eVis = EffectVisualEffect(DURATION_TYPE_INSTANT, VFX_IMP_HARM);

                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellHeal()
{
    //Declare major variables
    effect eKill, eHeal, eBad;
    effect eSun = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);
    int nCurrHp, nTouch;
    int nMetaMagic = GetMetaMagicFeat();
    int nHeal = 10 * GetCasterLevel(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();

    //Limit spell to maximum 150 hp healed/damaged
    if (nHeal > 150)
    {
        nHeal = 150;
    }

    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
       nHeal = FloatToInt(nHeal * 1.5);
    }

    //Check to see if the target is an undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL));
            //Make a touch attack
            if (TouchAttackMelee(oTarget))
            {
                //Make SR check
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    //Make a will save for half damage
                    if (MySavingThrow(SAVING_THROW_WILL, oTarget,
                        GetSpellSaveDC(), SAVING_THROW_TYPE_POSITIVE))
                    {
                        nHeal = nHeal / 2;
                    }

                    nCurrHp = GetCurrentHitPoints(oTarget);

                    //Make sure the spell does not reduce the targets hp to less than 1.
                    if(nHeal >= nCurrHp)
                    {
                        nHeal = nCurrHp - 1;
                    }

                    //Set damage
                    eKill = EffectDamage(nHeal, DAMAGE_TYPE_POSITIVE);
                    //Apply damage effect and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, oTarget);
                }
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));

        //remove bad effects
        eBad = GetFirstEffect(oTarget);

        while(GetIsEffectValid(eBad))
        {
            if (GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
                GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
                GetEffectType(eBad) == EFFECT_TYPE_POISON ||
                GetEffectType(eBad) == EFFECT_TYPE_STUNNED ||
                GetEffectSpellId(eBad) == SPELL_FEEBLEMIND)
            {
                Subraces_SafeRemoveEffect(oTarget, eBad);
            }
            else if(GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE)
            {
                //Remove ability decreases that are not permanent
                if (GetEffectType(eBad) != SUBTYPE_SUPERNATURAL)
                {
                    Subraces_SafeRemoveEffect(oTarget, eBad);
                }
            }
            eBad = GetNextEffect(oTarget);
        }

        //Set the heal effect
        eHeal = EffectHeal(nHeal);
        //Apply the heal effect and the VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellImplosion()
{
    //Declare major variables
    object oTarget;
    effect eDeath = EffectDeath(TRUE);
    effect eImplode= EffectVisualEffect(VFX_FNF_IMPLOSION);
    float fDelay;
    //Apply the implose effect
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImplode, GetSpellTargetLocation());
    //Get the first target in the shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
           //Fire cast spell at event for the specified target
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_IMPLOSION));
           fDelay = GetRandomDelay(0.4, 1.2);
           //Make SR check
           if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
           {
                //Make Reflex save
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()+3, SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay))
                {
                    //Apply death effect and the VFX impact
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                }
           }
        }
       //Get next target in the shape
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellImprovedInvisibility()
{
    // Familiar spell tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_MIND);

    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);

    effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eCover = EffectConcealment(50);
    effect eSneak = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
    effect eLink = EffectLinkEffects(eDur, eCover);
    eLink = EffectLinkEffects(eLink, eSneak);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eInvis);


    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_IMPROVED_INVISIBILITY, FALSE));
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));

    SetModuleOverrideSpellScriptFinished();
}

void SpellInferno()
{
    object oTarget = GetSpellTargetObject();
    //--------------------------------------------------------------------------
    // This spell no longer stacks. If there is one of that type, thats ok
    //--------------------------------------------------------------------------
    if (GetHasSpellEffect(GetSpellId(),oTarget) || GetHasSpellEffect(SPELL_COMBUST,oTarget))
    {
        FloatingTextStrRefOnCreature(100775, OBJECT_SELF, FALSE);
        return;
    }

    //--------------------------------------------------------------------------
    // Calculate the duration
    //--------------------------------------------------------------------------
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration * 2;
    }

    if (nDuration < 1)
    {
        nDuration = 1;
    }

    //--------------------------------------------------------------------------
    // Flamethrower VFX, thanks to Alex
    //--------------------------------------------------------------------------
    effect eRay      = EffectBeam(444, OBJECT_SELF, BODY_NODE_CHEST);
    effect eDur      = EffectVisualEffect(498);


    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

    float fDelay = GetDistanceBetween(oTarget, OBJECT_SELF)/13;

    if(!MyResistSpell(OBJECT_SELF, oTarget))
    {
        //----------------------------------------------------------------------
        // Engulf the target in flame
        //----------------------------------------------------------------------
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 3.0f);


        //----------------------------------------------------------------------
        // Apply the VFX that is used to track the spells duration
        //----------------------------------------------------------------------
        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oTarget,RoundsToSeconds(nDuration)));
        object oSelf = OBJECT_SELF; // because OBJECT_SELF is a function

        //------------------------------------------------------------------
        // Save the spell save DC as a variable for later retrieval
        //------------------------------------------------------------------
        SetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_INFERNO), nDC);

        DelayCommand(fDelay+0.1f,RunImpact(oTarget, oSelf,nMetaMagic));
    }
    else
    {
        //----------------------------------------------------------------------
        // Indicate Failure
        //----------------------------------------------------------------------
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 2.0f);
        effect eSmoke = EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE);
        DelayCommand(fDelay+0.3f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,oTarget));
    }
    SetModuleOverrideSpellScriptFinished();
}


void SpellInfestMaggots()
{
    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;

    //--------------------------------------------------------------------------
    // This spell no longer stacks. If there is one of that type, thats ok
    //--------------------------------------------------------------------------
    if (GetHasSpellEffect(GetSpellId(),oTarget) )
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }

    //--------------------------------------------------------------------------
    // Calculate the duration
    //--------------------------------------------------------------------------
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration  = GetCasterLevel(oCaster)/2;

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration * 2;
    }

    //--------------------------------------------------------------------------
    // Setup DC, effects and projectile timing
    //--------------------------------------------------------------------------
    float  fDist   = GetDistanceToObject(oTarget);
    float  fDelay  = fDist/25.0;
    int    nDC     = GetSpellSaveDC();
    effect eDur = EffectVisualEffect   ( VFX_DUR_FLIES );

    //--------------------------------------------------------------------------
    // Do Safety check, SR and Saves...
    //--------------------------------------------------------------------------
    if(!GetIsReactionTypeFriendly(oTarget))
    {

        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        if(MyResistSpell(OBJECT_SELF, oTarget, fDelay) == 0)
        {
           //---------------------------------------------------------------
           // Apply Effects, Schedule damage ticks
           //---------------------------------------------------------------
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget,RoundsToSeconds(nDuration)));
            SetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_INFESTATION_OF_MAGGOTS), nDC);
            DelayCommand(fDelay+0.1f, RunInfestImpact(oTarget,oCaster,nDC, nMetaMagic));
        }
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellInvisibility()
{
    // Familiar spell tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    object oTarget = GetSpellTargetObject();

    //effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eInvis, eDur);
    //eLink = EffectLinkEffects(eLink, eVis);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INVISIBILITY, FALSE));
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));

    SetModuleOverrideSpellScriptFinished();
}

void SpellIsaacsLesserMissileStorm()
{
    DoMissileStorm(1, 10, SPELL_ISAACS_LESSER_MISSILE_STORM);
    SetModuleOverrideSpellScriptFinished();
}
void SpellIsaacsGreaterMissileStorm()
{
    DoMissileStorm(2, 20, SPELL_ISAACS_GREATER_MISSILE_STORM);
    SetModuleOverrideSpellScriptFinished();
}

void SpellKeenEdge()
{
    // Modified to check for slashing or piercing weapons

    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);

    // Duration is 10 mins / level
    float fDuration = HoursToSeconds(nCasterLevel) / 6;

    if (GetMetaMagicFeat() == METAMAGIC_EXTEND)
    {
        fDuration = fDuration * 2; //Duration is +100%
    }

    object oMyWeapon = IPGetTargetedOrEquippedMeleeWeapon();

    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, SPELL_KEEN_EDGE, FALSE));

        if (GetSlashingWeapon(oMyWeapon) || GetPiercingWeapon(oMyWeapon))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);
            IPSafeAddItemProperty(oMyWeapon, ItemPropertyKeen(), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING ,TRUE,TRUE);
        }
        else FloatingTextStringOnCreature("* Invalid Target - This spell must be cast on a slashing or piercing weapon *", OBJECT_SELF);
    }
    else FloatingTextStringOnCreature("* Spell Failed - Target must be a melee weapon or creature with a melee weapon equipped *", OBJECT_SELF);

    SetModuleOverrideSpellScriptFinished();
}

void SpellKnock()
{
    int nResist;
    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    object oTarget = GetSpellTargetObject();

    if (GetObjectType(oTarget) == OBJECT_TYPE_DOOR ||
        GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
    {

        SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,GetSpellId()));
        if(!GetPlotFlag(oTarget) && GetLocked(oTarget))
        {
            nResist =  GetDoorFlag(oTarget,DOOR_FLAG_RESIST_KNOCK);
            if (nResist == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                AssignCommand(oTarget, ActionUnlockObject(oTarget));
            }
            else if  (nResist == 1)
            {
                FloatingTextStrRefOnCreature(83887,OBJECT_SELF);   //
            }
        }
    }
    else
    {
        FloatingTextStringOnCreature("* Invalid Target - This spell must be cast on a door or a placeable with a lock *", OBJECT_SELF);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellLesserPlanarBinding()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel;
    effect eSummon;
    effect eGate;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eLink = EffectLinkEffects(eDur, EffectParalyze());
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eDur3);

    object oTarget = GetSpellTargetObject();
    int nRacial = GetRacialType(oTarget);

    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Check to see if the target is valid
    if (GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_PLANAR_BINDING));
            //Check to make sure the target is an outsider
            if(nRacial == RACIAL_TYPE_OUTSIDER)
            {
                //Make a will save
                if(!WillSave(oTarget, GetSpellSaveDC()))
                {
                    //Apply the linked effect
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration/2));
                }
            }
        }
    }
    else
    {
        //Get the alignment of the caster
        int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
        float fDelay = 3.0;
        switch (nAlign)
        {
            //Set the summon effect based on alignment
            case ALIGNMENT_EVIL:
                {
                    eSummon = EffectSummonCreature("NW_S_IMP",VFX_FNF_SUMMON_GATE , fDelay);
                    //eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
                }
            break;
            case ALIGNMENT_GOOD:
                {
                    eSummon = EffectSummonCreature("NW_S_CLANTERN", 219 ,fDelay);
                    //eGate = EffectVisualEffect(219);
                }
            break;
            case ALIGNMENT_NEUTRAL:
                {
                    eSummon = EffectSummonCreature("NW_S_SLAADRED", VFX_FNF_SUMMON_MONSTER_3);
                    //eGate = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3, ,1.0);
                }
            break;
        }
        //Apply the summon effect and the VFX impact
        nDuration = nCasterLevel + 10;
        //Check for metamagic extend
        if (nMetaMagic == METAMAGIC_EXTEND)
          {
            nDuration = nDuration *2;   //Duration is +100%
          }

        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellLesserRestoration()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
    effect eBad = GetFirstEffect(oTarget);
    //Search for negative effects
    while(GetIsEffectValid(eBad))
    {
        //Remove all ability decrease that is not permanent
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE &&
            GetEffectSubType(eBad) != SUBTYPE_SUPERNATURAL)
        {
            Subraces_SafeRemoveEffect(oTarget, eBad);
        }
        else if(GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE)
        {
            //Remove effect
            Subraces_SafeRemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_RESTORATION, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);

    SetModuleOverrideSpellScriptFinished();
}

void SpellLight()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();

    int nDuration;
    int nMetaMagic;

    // Handle spell cast on item....
    if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    {
        // Do not allow casting on not equippable items
        if (!IPGetIsItemEquipable(oTarget))
        {
         // Item must be equipable...
             FloatingTextStrRefOnCreature(83326,OBJECT_SELF);
            return;
        }

        itemproperty ip = ItemPropertyLight (IP_CONST_LIGHTBRIGHTNESS_NORMAL, IP_CONST_LIGHTCOLOR_WHITE);

        if (GetItemHasItemProperty(oTarget, ITEM_PROPERTY_LIGHT))
        {
            IPRemoveMatchingItemProperties(oTarget,ITEM_PROPERTY_LIGHT,DURATION_TYPE_TEMPORARY);
        }

        nDuration = GetCasterLevel(OBJECT_SELF);
        nMetaMagic = GetMetaMagicFeat();
        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2; //Duration is +100%
        }

        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oTarget,HoursToSeconds(nDuration));
    }
    else
    {
        effect eVis = EffectVisualEffect(VFX_DUR_LIGHT_WHITE_10);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eVis, eDur);

        nDuration = GetCasterLevel(OBJECT_SELF);
        nMetaMagic = GetMetaMagicFeat();
        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2; //Duration is +100%
        }

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LIGHT, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellMagicWeapon()
{
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nEnchantment = 1;
    int nMetaMagic = GetMetaMagicFeat();

    object oMyWeapon   =  GetTargetedOrEquippedWeapon();

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }

    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, (HoursToSeconds(nDuration)), nEnchantment);

        }
        return;
    }
        else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellMassHeal()
{
    //Declare major variables
    effect eKill, eHeal, eBad;
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
    effect eStrike = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
    int nCurrHp, nTouch;
    int nHeal = 10 * GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    location lLoc =  GetSpellTargetLocation();


    //Limit spell to maximum 150 hp healed/damaged
    if (nHeal > 150)
    {
        nHeal = 150;
    }

    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
       nHeal = FloatToInt(nHeal * 1.5);
    }

    //Apply VFX area impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, lLoc);
    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
    while(GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();

        //Check to see if the target is an undead
        if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && !GetIsReactionTypeFriendly(oTarget))
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL));
                //Make a touch attack
                if (TouchAttackMelee(oTarget))
                {
                    //Make SR check
                    if (!MyResistSpell(OBJECT_SELF, oTarget))
                    {
                        //Make a will save for half damage
                        if (MySavingThrow(SAVING_THROW_WILL, oTarget,
                            GetSpellSaveDC(), SAVING_THROW_TYPE_POSITIVE))
                        {
                            nHeal = nHeal / 2;
                        }
                        nCurrHp = GetCurrentHitPoints(oTarget);
                        //Make sure the spell does not reduce the targets hp to less than 1.
                        if(nHeal >= nCurrHp)
                        {
                            nHeal = nCurrHp - 1;
                        }
                        //Set damage
                        eKill = EffectDamage(nHeal, DAMAGE_TYPE_POSITIVE);
                        //Apply damage effect and VFX impact
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                }
            }
        }
        else if(GetIsFriend(oTarget) && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));

            //remove bad effects
            eBad = GetFirstEffect(oTarget);

            while(GetIsEffectValid(eBad))
            {
                if (GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                    GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
                    GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
                    GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                    GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_POISON ||
                    GetEffectType(eBad) == EFFECT_TYPE_STUNNED ||
                    GetEffectSpellId(eBad) == SPELL_FEEBLEMIND)
                {
                    Subraces_SafeRemoveEffect(oTarget, eBad);
                }
                else if(GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE)
                {
                    //Remove ability decreases that are not permanent
                    if (GetEffectType(eBad) != SUBTYPE_SUPERNATURAL)
                    {
                        Subraces_SafeRemoveEffect(oTarget, eBad);
                    }
                }
                eBad = GetNextEffect(oTarget);
            }

            //Set the heal effect
            eHeal = EffectHeal(nHeal);
            //Apply the heal effect and the VFX impact
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
        }
        //Get next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellMelfsAcidArrow()
{
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(oCaster);
    //--------------------------------------------------------------------------
    // Calculate the duration
    //--------------------------------------------------------------------------
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = nCasterLevel / 3;

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration * 2;
    }

    if (nDuration < 1)
    {
        nDuration = 1;
    }


    //--------------------------------------------------------------------------
    // Setup VFX
    //--------------------------------------------------------------------------
    effect eVis      = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eDur      = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eArrow = EffectVisualEffect(245);


    //--------------------------------------------------------------------------
    // Set the VFX to be non dispelable, because the acid is not magic
    //--------------------------------------------------------------------------
    eDur = ExtraordinaryEffect(eDur);

    // If Ranged Touch Attack hits
    if (TouchAttackRanged(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));

        float fDist = GetDistanceToObject(oTarget);
        float fDelay = (fDist/25.0);


        if(MyResistSpell(oCaster, oTarget) == FALSE)
        {
            //----------------------------------------------------------------------
            // Do the initial 2d4 points of damage
            //----------------------------------------------------------------------
            int nDamage = MaximizeOrEmpower(4,2,nMetaMagic);
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);

            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

            //----------------------------------------------------------------------
            // Apply the VFX that is used to track the spells duration
            //----------------------------------------------------------------------
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oTarget,RoundsToSeconds(nDuration)));
            DelayCommand(6.0f, RunImpact(oTarget, oCaster,nMetaMagic));
        }
        else
        {
            //----------------------------------------------------------------------
            // Indicate Failure
            //----------------------------------------------------------------------
            effect eSmoke = EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE);
            DelayCommand(fDelay+0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,oTarget));
        }
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eArrow, oTarget);

    SetModuleOverrideSpellScriptFinished();
}

void SpellMindBlank()
{
    //Changed duration from 1 turn / level to 24 hours
    //Changed area of effect from huge sphere to single creature
    //See x0_i0_spells for code changes

    object oTarget = GetSpellTargetObject();

    spellApplyMindBlank(oTarget, GetSpellId());

    SetModuleOverrideSpellScriptFinished();
}

void SpellMonsterRegeneration()
{

    /* Bug fix 21/07/03: Andrew. Lowered regen to 2 HP per round, instead of 10. */
    effect eRegen = EffectRegenerate(2, 6.0);

    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eRegen, eDur);

    int nMeta = GetMetaMagicFeat();
    int nLevel = (GetCasterLevel(OBJECT_SELF)/2)+1;

    object oTarget = GetSpellTargetObject();

    if (nMeta == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }

    // Stacking Spellpass, 2003-07-07, Georg   ... just in case
    RemoveEffectsFromSpell(oTarget, GetSpellId());

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Apply effects and VFX
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nLevel));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    SetModuleOverrideSpellScriptFinished();
}

void SpellMordenkainensSword()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF) +10;
    effect eSummon = EffectSummonCreature("NW_S_HelmHorr");
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));

    SetModuleOverrideSpellScriptFinished();
}

void SpellMagicCircleChaos()
{

}

void SpellMagicCircleEvil()
{

}

void SpellMagicCircleGood()
{

}

void SpellMagicCircleLaw()
{

}

void SpellNegativeEnergyRay()
{
    // From Tome and Blood
    // Fires a bolt of negative energy at the target doing 1d6 damage.  Does an additional 1d6
    // damage for 2 levels after level 1 (3,5,7,9) to a maximum of 5d6 at level 9.
    // Heals undead instead.

    //Declare major variables
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();

    if(nCasterLevel > 9)
    {
        nCasterLevel = 9;
    }
    nCasterLevel = (nCasterLevel + 1) / 2;
    int nDamage = d6(nCasterLevel);

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * nCasterLevel;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
    }

    // If Ranged Touch Attack hits
    if(TouchAttackRanged(oTarget))
    {
        //Ray Hits VFX
        effect eRay = EffectBeam(VFX_BEAM_EVIL, oCaster, BODY_NODE_HAND);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);

        if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_NEGATIVE_ENERGY_RAY, FALSE));

            effect eVis= EffectVisualEffect(VFX_IMP_HEALING_M);
            effect eHeal = EffectHeal(nDamage);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        }
        else
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_NEGATIVE_ENERGY_RAY));

            if (!MyResistSpell(oCaster, oTarget))
            {
                // Will save for half
                if(MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NEGATIVE))
                {
                    nDamage /= 2;
                }

                effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
                effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);

                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
        }
    }
    //Else Ray Misses
    else
    {
        // Ray Miss VFX
        effect eRay = EffectBeam(VFX_BEAM_EVIL, oCaster, BODY_NODE_HAND, TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellPersistantBlade()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = 10 + GetCasterLevel(OBJECT_SELF);

    effect eSummon = EffectSummonCreature("X2_S_FAERIE001");
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));

    object oSelf = OBJECT_SELF;
    DelayCommand(1.0, spellsCreateItemForSummoned(oSelf,TurnsToSeconds(nDuration)));

    SetModuleOverrideSpellScriptFinished();
}

void SpellPlanarAlly()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel;
    effect eSummon;
    effect eGate;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eLink = EffectLinkEffects(eDur, EffectParalyze());
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eDur3);

    int nRacial = GetRacialType(oTarget);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(nDuration == 0)
    {
        nDuration == 1;
    }
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Check to make sure a target was selected
    if (GetIsObjectValid(oTarget))
    {
        //Check the racial type of the target
        if(nRacial == RACIAL_TYPE_OUTSIDER)
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PLANAR_BINDING));
                //Make a Will save
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()+2))
                {
                    //Apply the linked effect
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration/2));
                }
            }
        }
    }
    else
    {
        //Set the summon effect based on the alignment of the caster
        float fDelay = 3.0;
        switch (nAlign)
        {
            case ALIGNMENT_EVIL:
                eSummon = EffectSummonCreature("NW_S_SUCCUBUS",VFX_FNF_SUMMON_GATE, fDelay);
                //eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
            break;
            case ALIGNMENT_GOOD:
                eSummon = EffectSummonCreature("NW_S_CHOUND", VFX_FNF_SUMMON_CELESTIAL, fDelay);
                //eGate = EffectVisualEffect(219);
            break;
            case ALIGNMENT_NEUTRAL:
                eSummon = EffectSummonCreature("NW_S_SLAADGRN",VFX_FNF_SUMMON_MONSTER_3, 1.0);
                //eGate = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
                //fDelay = 1.0;
            break;
        }
        //Apply the summon effect and VFX impact
           nDuration = nCasterLevel + 10;
           //Metamagic extension if needed
       if (nMetaMagic == METAMAGIC_EXTEND)
         {
           nDuration = nDuration * 2;  //Duration is +100%
         }
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellProtectionFromChaos()
{

}
void SpellProtectionFromEvil()
{

}
void SpellProtectionFromGood()
{

}
void SpellProtectionFromLaw()
{

}

void SpellRestoration()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    int bValid;

    effect eBad = GetFirstEffect(oTarget);
    //Search for negative effects
    while(GetIsEffectValid(eBad))
    {
        //Remove all negative levels that not are permanent
        if (GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL &&
            GetEffectSubType(eBad) != SUBTYPE_SUPERNATURAL)
        {
            Subraces_SafeRemoveEffect(oTarget, eBad);
        }
        else if(GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE)
            {
                //Remove effect if it is negative.
                Subraces_SafeRemoveEffect(oTarget, eBad);
            }
        eBad = GetNextEffect(oTarget);
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);

    SetModuleOverrideSpellScriptFinished();
}

void SpellRayOfEnfeeblement()
{
    // 3.5 PHB 269. ranged touch, 1min / level.
    // target takes 1d6 +1 / 2 levels (max +5) str damage

    //Declare major variables
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(oCaster);
    float fDuration = nCasterLevel * 60.0;  // minute / level
    int nBonus = nCasterLevel / 2;
    if (nBonus > 5)
    {
        nBonus = 5;
    }

    int nLoss = d6() + nBonus;
    int nMetaMagic = GetMetaMagicFeat();

    // If ranged touch attack hits
    if(TouchAttackRanged(oTarget))
    {
        // Ray hits VFX
        effect eRay = EffectBeam(VFX_BEAM_EVIL, oCaster, BODY_NODE_HAND);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_RAY_OF_ENFEEBLEMENT));

        //Make SR check
        if (!MyResistSpell(oCaster, oTarget))
        {
            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nLoss = 6 + nBonus;
            }
            if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                 nLoss = nLoss + (nLoss/2);
            }
            if (nMetaMagic == METAMAGIC_EXTEND)
            {
                fDuration = fDuration * 2;
            }
            effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            effect eFeeb = EffectAbilityDecrease(ABILITY_STRENGTH, nLoss);
            effect eLink = EffectLinkEffects(eFeeb, eDur);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget);
        }
    }
    //Else Ranged Touch Attack Misses
    else
    {
        //Ray Misses VFX
        effect eRay = EffectBeam(VFX_BEAM_EVIL, oCaster, BODY_NODE_HAND, TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellRayOfFrost()
{
    // PHB 3.5 pg. 269. Ranged touch, 1d3 of damage

    int nMetaMagic = GetMetaMagicFeat();
    int nDam = d3();
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();

    // If ranged touch attack hits
    if(TouchAttackRanged(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_RAY_OF_FROST));

        // Ray hits VFX
        effect eRay = EffectBeam(VFX_BEAM_COLD, oCaster, BODY_NODE_HAND);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);

        //Make SR Check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDam = 3 ;//Damage is at max
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDam = nDam + nDam/2; //Damage/Healing is +50%
            }
            effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
            effect eDam = EffectDamage(nDam, DAMAGE_TYPE_COLD);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        }
    }
    //Else Ray Misses
    else
    {
        // Ray Miss VFX
        effect eRay = EffectBeam(VFX_BEAM_EVIL, oCaster, BODY_NODE_HAND, TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellSearingLight()
{
    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(oCaster);
    int nDamage, nMax;

    object oTarget = GetSpellTargetObject();

    // If Ranged Touch Attack hits
    if(TouchAttackRanged(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_SEARING_LIGHT));

        effect eRay = EffectBeam(VFX_BEAM_HOLY, oCaster, BODY_NODE_HAND);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);

        //Make an SR Check
        if (!MyResistSpell(oCaster, oTarget))
        {
            //Limit caster level
            if (nCasterLevel > 10)
            {
                nCasterLevel = 10;
            }
            //Check for racial type undead
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {
                nDamage = d6(nCasterLevel);
                nMax = 6;
            }
            //Check for racial type construct
            else if (GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT)
            {
                nCasterLevel /= 2;
                nDamage = d6(nCasterLevel);
                nMax = 6;
            }
            else
            {
                nCasterLevel = nCasterLevel/2;
                nDamage = d8(nCasterLevel);
                nMax = 8;
            }

            //Make metamagic checks
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = nMax * nCasterLevel;
            }
            if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2);
            }
            effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        }
    }
    //Else Ray Misses
    else
    {
        // Ray Miss VFX
        effect eRay = EffectBeam(VFX_BEAM_HOLY, oCaster, BODY_NODE_HAND, TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, F_BEAM);
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellStoneskin()
{
    // Changed from 100 max to 150 max

    //Declare major variables
    effect eStone;
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink;

    object oTarget = GetSpellTargetObject();

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMax = nCasterLevel * 10;
    //Limit the amount protection to 150 points of damage
    if (nMax > 150)
    {
        nMax = 150;
    }

    float fDuration = HoursToSeconds(nCasterLevel);

    //Meta Magic
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
    {
        fDuration *= 2;
    }

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_STONESKIN, FALSE));

    //Define the damage reduction effect
    eStone = EffectDamageReduction(10, DAMAGE_POWER_PLUS_FIVE, nMax);

    //Link the effects
    eLink = EffectLinkEffects(eStone, eVis);
    eLink = EffectLinkEffects(eLink, eDur);

    RemoveEffectsFromSpell(oTarget, SPELL_STONESKIN);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);

    SetModuleOverrideSpellScriptFinished();
}

void SpellSummonMonster()
{
    //Declare major variables
    int nSpellID = GetSpellId();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = nDuration + 10;

    //Metamagic extension if needed
    effect eSummon = SetSummonEffect(nSpellID);

    //Make metamagic check for extend
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));

    SetModuleOverrideSpellScriptFinished();
}

void SpellTimeStop()
{
    //Declare major variables
    location lTarget = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    effect eTime = EffectTimeStop();
    int nRoll = 1 + d4();

    if(GetHasEffect(EFFECT_TYPE_HASTE))
    {
        SendMessageToPC(OBJECT_SELF, "Haste will not stack with Time Stop");
        RemoveSpecificEffect(EFFECT_TYPE_HASTE, OBJECT_SELF);
    }

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

    //Apply the VFX impact and effects
    DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTime, OBJECT_SELF, RoundsToSeconds(nRoll)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);

    SetModuleOverrideSpellScriptFinished();
}

void SpellTrueSeeing()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eSight = EffectSeeInvisible();
    effect eSight2 = EffectUltravision();
    effect eImmune = EffectSpellImmunity(SPELL_PHANTASMAL_KILLER);
    effect eImmune2 = EffectSpellImmunity(SPELL_WEIRD);
    effect eLink = EffectLinkEffects(eVis, eSight);
    eLink = EffectLinkEffects(eLink, eSight2);
    eLink = EffectLinkEffects(eLink, eImmune);
    eLink = EffectLinkEffects(eLink, eImmune2);
    eLink = EffectLinkEffects(eLink, eDur);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_TRUE_SEEING, FALSE));
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));

    SetModuleOverrideSpellScriptFinished();
}

//::///////////////////////////////////////////////
//:: Function implementations for spellabilities
//::///////////////////////////////////////////////

void SpellAbilityBoltCold()
{
    // Familiar spell tracking for Alfa
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eBolt;
    int nDC = 10 + (nHD/2);
    int nCount = nHD /2;
    if (nCount == 0)
    {
        nCount = 1;
    }

    int nDamage = d6(nCount);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_COLD));
    //Make a ranged touch attack
    int nTouch = TouchAttackRanged(oTarget);
    if(nTouch > 0)
    {
        if(nTouch == 2)
        {
            nDamage *= 2;
        }
        //Set damage effect
        eBolt = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
        if(nDamage > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBolt, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityBoltConfusion()
{
    // Familiar spell tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis2 = EffectVisualEffect(VFX_IMP_CONFUSION_S);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eBolt = EffectConfused();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eBolt, eDur);
    eLink = EffectLinkEffects(eLink, eVis);
    int nDC = 10 + (nHD/2);
    int nCount = (nHD + 1) / 2;

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_CONFUSE));
    //Make a saving throw check
    if (TouchAttackRanged(oTarget))
    {
        if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCount));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        }
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityBoltDaze()
{
    // Familiar spell tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eBolt = EffectDazed();
    eBolt = GetScaledEffect(eBolt, oTarget);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eBolt, eDur);
    eLink = EffectLinkEffects(eLink, eVis);

    int nDC = 10 + (nHD/2);
    int nCount = (nHD + 1) / 2;
    nCount = GetScaledDuration(nCount, oTarget);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_DAZE));
    //Make a saving throw check
    if (TouchAttackRanged(oTarget))
    {
       //Apply the VFX impact and effects
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCount));
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityBoltDeath()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eBolt = EffectDeath();
    int nDC = 10 + (nHD/2);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_DEATH));
    //Make a saving throw check
    if(!MyResistSpell(OBJECT_SELF, oTarget))
    {
        if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
        {
            if(TouchAttackRanged(oTarget))
            {
                //Apply the VFX impact and effects
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eBolt, oTarget);
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityBoltFire()
{
    // Familiar spell tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eBolt;
    int nDC = 10 + (nHD/2);
    int nCount = nHD /2;
    if (nCount == 0)
    {
        nCount = 1;
    }

    int nDamage = d6(nCount);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_FIRE));
    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_FIRE);
    //Make a ranged touch attack
    int nTouch = TouchAttackRanged(oTarget);
    if(nTouch > 0)
    {
        if(nTouch == 2)
        {
            nDamage *= 2;
        }
        //Set damage effect
        eBolt = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
        if(nDamage > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBolt, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityBoltKnockd()
{
// Familiar spell tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eBolt = EffectKnockdown();
    int nDC = 10 + (nHD/2);
    effect eDam = EffectDamage(d6(), DAMAGE_TYPE_BLUDGEONING);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_KNOCKDOWN));
    //Make a saving throw check
    if (TouchAttackRanged(oTarget))
    {
       //Apply the VFX impact and effects
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBolt, oTarget, RoundsToSeconds(3));
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityBoltSlow()
{
    // Familiar spell tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    effect eBolt = EffectSlow();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eBolt, eDur);
    int nDC = 10 + (nHD/2);
    int nCount = (nHD + 1) / 2;

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_SLOW));
    //Make a saving throw check
    if (TouchAttackRanged(oTarget))
    {
       //Apply the VFX impact and effects
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCount));
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityConeFire()
{
//Familiar Spell Tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    int nHD = GetHitDice(OBJECT_SELF);
    int nDamage;
    int nLoop = nHD / 3;
    int nDC = 10 + (nHD/2);
    float fDelay;
    if(nLoop == 0)
    {
        nLoop = 1;
    }
    //Calculate the damage
    for (nLoop; nLoop > 0; nLoop--)
    {
        nDamage = nDamage + d6(2);
    }
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    effect eCone;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);

    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    //Get first target in spell area
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_CONE_FIRE));
            //Determine effect delay
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_FIRE);
            //Set damage effect
            eCone = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            if(nDamage > 0)
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCone, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE);
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityGazeDeath()
{
    if( GZCanNotUseGazeAttackCheck(OBJECT_SELF))
    {
        return;
    }

    //Declare major variables
    int nHD = GetHitDice(OBJECT_SELF);
    int nDuration = 1 + (nHD / 3);
    int nDC = 10 + ( nHD / 2 );
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    effect eGaze = EffectDeath();
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget) || oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_GAZE_DEATH));
            //Determine effect delay
            float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay))
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eGaze, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityGazeFear()
{
    if( GZCanNotUseGazeAttackCheck(OBJECT_SELF))
    {
        return;
    }

    // Familiar spell tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    int nHD = GetHitDice(OBJECT_SELF);
    int nDuration = 1 + (nHD / 3);
    int nDC = 10 + (nHD/2);
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    effect eGaze = EffectFrightened();
    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eVisDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);

    effect eLink = EffectLinkEffects(eGaze, eVisDur);
    eLink = EffectLinkEffects(eLink, eDur);
    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        nDuration = GetScaledDuration(nDuration , oTarget);
        if(GetIsEnemy(oTarget) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_GAZE_FEAR));
            //Determine effect delay
            float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF, fDelay))
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityHndBreath()
{
//Familiar Spell Tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());


    //Declare major variables
    int nHD = GetHitDice(OBJECT_SELF);
    int nDamage = d4(1)+1;
    float fDelay;
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    effect eCone;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);

    int nDC = 10 + (nHD/2);

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HELL_HOUND_FIREBREATH));
            //Determine effect delay
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
             //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_FIRE);
            //Set damage effect
            eCone = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            if(nDamage > 0)
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCone, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE);
    }

    SetModuleOverrideSpellScriptFinished();
}

void SpellAbilityHowlFear()
{
// Familiar spell tracking
    if(GetIsObjectValid(GetMaster()))
      FamiliarTrackSpell(GetSpellId(),GetMaster());

    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect eHowl = EffectFrightened();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eImpact = EffectVisualEffect(VFX_FNF_HOWL_MIND);

    effect eLink = EffectLinkEffects(eHowl, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);

    float fDelay;
    int nHD = GetHitDice(OBJECT_SELF);
    int nDC = 10 + (nHD/4);
    int nDuration = 1 + (nHD/4);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget) && oTarget != OBJECT_SELF)
        {
            fDelay = GetDistanceToObject(oTarget)/10;
            nDuration = GetScaledDuration(nDuration , oTarget);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HOWL_FEAR));

            //Make a saving throw check
            if(!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }

    SetModuleOverrideSpellScriptFinished();
}

//::///////////////////////////////////////////////
//:: Private Function implementations
//::///////////////////////////////////////////////

void RunImpact(object oTarget, object oCaster, int nMetaMagic)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(SPELL_MELFS_ACID_ARROW,oTarget,oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
        //----------------------------------------------------------------------
        // Calculate Damage
        //----------------------------------------------------------------------
        int nDamage = MaximizeOrEmpower(4, 2, nMetaMagic);
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
        effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
        eDam = EffectLinkEffects(eVis,eDam);
        ApplyEffectToObject (DURATION_TYPE_INSTANT,eDam,oTarget);
        DelayCommand(6.0f, RunImpact(oTarget, oCaster, nMetaMagic));
    }
}

int GetPiercingWeapon(object oItem)
{
    int nItem = GetBaseItemType(oItem);

    if(( nItem == BASE_ITEM_DAGGER ) ||
        ( nItem == BASE_ITEM_SHORTSPEAR ) ||
        ( nItem == BASE_ITEM_SHORTSWORD ) ||
        ( nItem == BASE_ITEM_RAPIER ))

        return TRUE;
    else return FALSE;
}

void spellsCreateItemForSummoned(object oCaster, float fDuration)
{
    //Declare major variables
    int nStat = GetIsMagicStatBonus(oCaster) / 2;
    // GZ: Just in case...
    if (nStat >20)
    {
        nStat =20;
    }
    else if (nStat <1)
    {
        nStat = 1;
    }
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    object oWeapon;
    if (GetIsObjectValid(oSummon))
    {
        //Create item on the creature, epuip it and add properties.
        oWeapon = CreateItemOnObject("NW_WSWDG001", oSummon);
        // GZ: Fix for weapon being dropped when killed
        SetDroppableFlag(oWeapon,FALSE);
        AssignCommand(oSummon, ActionEquipItem(oWeapon, INVENTORY_SLOT_RIGHTHAND));
        // GZ: Check to prevent invalid item properties from being applies
        if (nStat>0)
        {
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAttackBonus(nStat), oWeapon,fDuration);
        }
        AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1, 2),oWeapon,fDuration);
    }
}

void AddGreaterEnhancementEffectToWeapon(object oMyWeapon, float fDuration, int nBonus)
{
    if(GetWeaponRanged(oMyWeapon))
    {
        IPSafeAddItemProperty(oMyWeapon,ItemPropertyAttackBonus(nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
    }
    else if(IPGetIsProjectile(oMyWeapon))
    {
        if(GetBaseItemType(oMyWeapon) == BASE_ITEM_BULLET)
        {
            int nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
            IPSafeAddItemProperty(oMyWeapon,ItemPropertyDamageBonus(nDamageType, nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        }
        else
        {
            int nDamageType = IP_CONST_DAMAGETYPE_PIERCING;
            IPSafeAddItemProperty(oMyWeapon,ItemPropertyDamageBonus(nDamageType, nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        }
    }
    else
    {
        IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
    }
}

object GetTargetedOrEquippedWeapon()
{
    object oTarget = GetSpellTargetObject();
    if(GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    {
        if (IPGetIsMeleeWeapon(oTarget) || GetWeaponRanged(oTarget) || IPGetIsProjectile(oTarget))
        {
            return oTarget;
        }
        else
        {
            return OBJECT_INVALID;
        }
    }

    object oWeapon1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    if (GetIsObjectValid(oWeapon1) && (IPGetIsMeleeWeapon(oWeapon1) || GetWeaponRanged(oWeapon1)))
    {
        return oWeapon1;
    }

    oWeapon1 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
    if(GetIsObjectValid(oWeapon1) && IPGetIsMeleeWeapon(oWeapon1))
    {
        return oWeapon1;
    }

    oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget);
    if(GetIsObjectValid(oWeapon1))
    {
        return oWeapon1;
    }

    oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget);
    if(GetIsObjectValid(oWeapon1))
    {
        return oWeapon1;
    }

    return OBJECT_INVALID;

}

void RunInfestImpact(object oTarget, object oCaster, int nSaveDC, int nMetaMagic)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(SPELL_INFESTATION_OF_MAGGOTS,oTarget,oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
         int nDC = GetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_INFESTATION_OF_MAGGOTS));

         if (!MySavingThrow(SAVING_THROW_FORT,oTarget,nSaveDC,SAVING_THROW_TYPE_DISEASE,OBJECT_SELF))
         {
            //------------------------------------------------------------------
            // Setup Ability Score Damage
            //------------------------------------------------------------------
            effect eVis    = EffectVisualEffect   ( VFX_IMP_DISEASE_S );
            int    nDamage = d2(1);

            if ( nMetaMagic == METAMAGIC_MAXIMIZE )
            {
                nDamage = 2;
            }
            else if ( nMetaMagic == METAMAGIC_EMPOWER )
            {
                nDamage = nDamage + 1;
            }

            effect eDam = ExtraordinaryEffect( EffectAbilityDecrease( ABILITY_CONSTITUTION, nDamage));

            //------------------------------------------------------------------
            // The trick that allows this spellscript to do stacking ability
            // score damage (which is not possible to do from normal scripts)
            // is that the ability score damage is done from a delaycommanded
            // function which will sever the connection between the effect
            // and the SpellId
            //------------------------------------------------------------------

            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);

            //------------------------------------------------------------------
            // If the target already is down to 0 points of constitution,
            // kill him. For immortal creatures, end the spell
            // This only kicks in in Hardcore+ difficulty
            //------------------------------------------------------------------
            if (GetAbilityScore(oTarget,ABILITY_CONSTITUTION)<=0 && GetGameDifficulty() >= GAME_DIFFICULTY_CORE_RULES)
            {
                  if (!GetImmortal(oTarget))
                 {
                     FloatingTextStrRefOnCreature(100932,oTarget);
                     effect eKill = EffectDamage(GetCurrentHitPoints(oTarget)+1);
                     ApplyEffectToObject(DURATION_TYPE_INSTANT,eKill,oTarget);
                     effect eVfx = EffectVisualEffect(VFX_IMP_DEATH_L);
                     ApplyEffectToObject(DURATION_TYPE_INSTANT,eVfx,oTarget);
                 }
            }
            else
            {
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam, oTarget);
                 DelayCommand(6.0, RunInfestImpact(oTarget,oCaster,nSaveDC, nMetaMagic));
            }

         }
         else
         {
            DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_INFESTATION_OF_MAGGOTS));
            GZRemoveSpellEffects(SPELL_INFESTATION_OF_MAGGOTS, oTarget);
         }

    }
}

void RunCombustImpact(object oTarget, object oCaster, int nLevel, int nMetaMagic)
{
     //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(SPELL_COMBUST,oTarget,oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {

        int nDC = GetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_COMBUST));

        if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_FIRE))
        {
            //------------------------------------------------------------------
            // Calculate the damage, 1d6 + casterlevel, capped at +10
            //------------------------------------------------------------------
            int nDamage = nLevel;
            if (nDamage > 10)
            {
                nDamage = 10;
            }
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage += 6;
            }
            else
            {
                nDamage  += d6();
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
            }

            effect eDmg = EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
            effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_S);

            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);

            //------------------------------------------------------------------
            // After six seconds (1 round), check damage again
            //------------------------------------------------------------------
            DelayCommand(6.0f,RunCombustImpact(oTarget,oCaster, nLevel,nMetaMagic));
        }
        else
        {
            DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_COMBUST));
            GZRemoveSpellEffects(SPELL_COMBUST, oTarget);
        }
   }
}

void RunInfernoImpact(object oTarget, object oCaster, int nMetaMagic)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(446,oTarget,oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
        //----------------------------------------------------------------------
        // Calculate Damage
        //----------------------------------------------------------------------
        int nDamage = MaximizeOrEmpower(6,2,nMetaMagic);

        //apply half damage upon sucessful fortitude save
        if (MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE))
        {
            nDamage = nDamage / 2;
        }

        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
        effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
        eDam = EffectLinkEffects(eVis,eDam); // flare up
        ApplyEffectToObject (DURATION_TYPE_INSTANT,eDam,oTarget);
        DelayCommand(6.0f,RunInfernoImpact(oTarget,oCaster,nMetaMagic));
    }
}

effect SetSummonEffect(int nSpellID)
{
    int nFNF_Effect;
    int nRoll = d3();
    string sSummon;
    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER)) //WITH THE ANIMAL DOMAIN
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_BOARDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_WOLFDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_SPIDDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_diretiger";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRHUGE";
                break;

                case 2:
                    sSummon = "NW_S_WATERHUGE";
                break;

                case 3:
                    sSummon = "NW_S_FIREHUGE";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRGREAT";
                break;

                case 2:
                    sSummon = "NW_S_WATERGREAT";
                break;

                case 3:
                    sSummon = "NW_S_FIREGREAT";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;

                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;

                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;

                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;

                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
        }
    }
    else  //WITOUT THE ANIMAL DOMAIN
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_badgerdire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_BOARDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_WOLFDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_SPIDDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_diretiger";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRHUGE";
                break;

                case 2:
                    sSummon = "NW_S_WATERHUGE";
                break;

                case 3:
                    sSummon = "NW_S_FIREHUGE";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRGREAT";
                break;

                case 2:
                    sSummon = "NW_S_WATERGREAT";
                break;

                case 3:
                    sSummon = "NW_S_FIREGREAT";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;

                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;

                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
        }
    }
    //effect eVis = EffectVisualEffect(nFNF_Effect);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;
}

