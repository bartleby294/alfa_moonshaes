/************************ [Include - Basic AI] *********************************
    Filename: J_INC_BASIC
************************* [Include - Basic AI] *********************************
    A few functions - mostly for animations and AI files.

    This is included in:
    - All Basic AI files
    - Any custom AI files in the packages you import.

    - Includes a few fighting things that help in combat (like Healing functions)
************************* [Workings] *******************************************
    A few settings for animations, as well as some AI combat functions to help
    make custom combat easier.
************************* [Include - Basic AI] ********************************/

// Special: Bioware SoU Waypoints/Animations constants
// - Here so I know where they are :-P
const string sAnimCondVarname                   = "NW_ANIM_CONDITION";
// This is the name of the local variable that holds the spawn-in conditions
string sSpawnCondVarname                        = "NW_GENERIC_MASTER";

// AI for waypoints
const string FILE_WALK_WAYPOINTS                = "j_ai_walkwaypoin";
const string WAYPOINT_RUN                       = "WAYPOINT_RUN";
const string WAYPOINT_PAUSE                     = "WAYPOINT_PAUSE";

// Bioware constants.
const int NW_FLAG_STEALTH                       = 0x00000004;
const int NW_FLAG_SEARCH                        = 0x00000008;
const int NW_FLAG_AMBIENT_ANIMATIONS            = 0x00080000;
const int NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS   = 0x00200000;
const int NW_FLAG_DAY_NIGHT_POSTING             = 0x00400000;
const int NW_FLAG_AMBIENT_ANIMATIONS_AVIAN      = 0x00800000;


// Mark that the given creature has the given condition set for anitmations
// * Bioware SoU animations thing.
void SetAnimationCondition(int nCondition, int bValid = TRUE, object oCreature = OBJECT_SELF);

// Sets the specified spawn-in condition on the caller as directed.
// * Only used for animations
void SetSpawnInCondition(int nCondition, int bValid = TRUE);

// Base for moving round thier waypoints
// - Uses ExectuteScript to run the waypoint walking.
void SpawnWalkWayPoints(int nRun = FALSE, float fPause = 1.0);

// Sets the custom AI file to sString to use.
// - "AI_TEMP_SET_TARGET" is set to anything passed to this script.
void SetAIFileName(string sString);

// Gets the custom AI file set to us.
string GetAIFileName();

// Determines a combat round.
void DetermineCombatRound(object oTarget = OBJECT_INVALID);

// Returns any pre-set target object
object Combat_GetAITargetObject();
// Sets the pre-set target object to attack
void SetAITargetObject(object oTarget);

// Gets the nearest seen or heard enemy.
// * bSeenOnly - If set to TRUE, it will only return a valid seen enemy (if any!)
object Combat_GetNearestSeenOrHeardEnemy(int bSeenOnly = FALSE);
// Gets if the object is valid, and we can see, or hear it.
// * bSeenOnly - If set to TRUE, it must be seen.
// TRUE if oTarget is valid.
int Combat_GetTargetValid(object oTarget, int bSeenOnly = FALSE);

// This will call a random voicechat to be called, if iPercent is met.
void Combat_Taunt(int iPercent = 10);

// This will heal oTarget with the best spell possible.
// - Like the Bioware function.
// - Will force healing if bForce is TRUE, ELSE, it will only heal at 50% HP.
// - TRUE if it heals oTarget
int Combat_HealTarget(object oTarget, int bForce = FALSE);
// This will loop all seen allies. If any of them need healing, it will heal
// them and return TRUE.
// - Uses Combat_HealTarget to check if they need healing.
int Combat_HealAllies();

// Only for use in "Combat_TurnUndead", it checks if there are any non-turned
// undead within 10M, of iRace.
int Combat_TurningAnyOfRaceValid(int iRace);

// This will check if we can turn undead, and check if there are anythings we can
// turn, and turn if so. Uses mainly Bioware stuff.
int Combat_TurnUndead();

// This attempt to use the best potions the creature has.
// * Will return FALSE if they use none, or they already have the effects
// * Uses any Potection First (EG: stoneskin), then Benificial (EG: Bulls strength)
//   then Enhancement (EG: Invisibility)
int Combat_UseAnyPotions();

// Attack oTarget with a melee weapon, and melee feats if we can hit them.
// - VERY basic!
void Combat_AttackMelee(object oTarget);
// Attack oTarget with a ranged weapon (if we have any), and ranged feats if we can hit them.
// - VERY basic!
void Combat_AttackRanged(object oTarget);

// This will check if the caller has nSpell, and casts it at oObject if so.
// - Will not cast if oTarget has the effect of nSpell.
// - Returns TRUE if they cast nSpell.
int Combat_CastAtObject(int nSpell, object oTarget);
// This will check if the caller has nSpell, and casts it at oObject's location if so.
// - Will not cast if oTarget has the effect of nSpell.
// - Returns TRUE if they cast nSpell.
int Combat_CastAtLocation(int nSpell, object oTarget);
// Checks if tUse is TRUE, and uses it against oTarget if not got the effects.
int Combat_TalentAtObject(talent tUse, object oTarget);

// Cheat-Casts nSpell, if under iPercent.
// * Doesn't cast if iPercent fails, or oTarget has nSpell's effects.
// Use this to make sure a caster doesn't run out of spells.
int Combat_CheatRandomSpellAtObject(int nSpell, object oTarget, int iPercent);

// This will loop oTarget's effects, and return TRUE if any are equal to
// iEffect, which is a constant EFFECT_TYPE_*
int Combat_GetHasEffect(int iEffect, object oTarget = OBJECT_SELF);

// This will walk the waypoints of the creature (re-activate them)
// Use this if the creature is not in combat/not attacking/no target to attack/
void Combat_WalkWaypoints();

// Functions start.

// Sets the specified spawn-in condition on the caller as directed.
void SetSpawnInCondition(int nCondition, int bValid = TRUE)
{
    int nSpawnInConditions = GetLocalInt(OBJECT_SELF, sSpawnCondVarname);
    if(bValid == TRUE)
    {
        // Add the given spawn-in condition
        nSpawnInConditions = nSpawnInConditions | nCondition;
        SetLocalInt(OBJECT_SELF, sSpawnCondVarname, nSpawnInConditions);
    }
    else if (bValid == FALSE)
    {
        // Remove the given spawn-in condition
        nSpawnInConditions = nSpawnInConditions & ~nCondition;
        SetLocalInt(OBJECT_SELF, sSpawnCondVarname, nSpawnInConditions);
    }
}

// Mark that the given creature has the given condition set
// * Bioware SoU animations thing.
void SetAnimationCondition(int nCondition, int bValid = TRUE, object oCreature = OBJECT_SELF)
{
    int nCurrentCond = GetLocalInt(oCreature, sAnimCondVarname);
    if (bValid) {
        SetLocalInt(oCreature, sAnimCondVarname, nCurrentCond | nCondition);
    } else {
        SetLocalInt(oCreature, sAnimCondVarname, nCurrentCond & ~nCondition);
    }
}

// Base for moving round thier waypoints
// - Uses ExectuteScript to run the waypoint walking.
void SpawnWalkWayPoints(int nRun = FALSE, float fPause = 1.0)
{
    SetLocalInt(OBJECT_SELF, WAYPOINT_RUN, nRun);
    SetLocalFloat(OBJECT_SELF, WAYPOINT_PAUSE, fPause);
    ExecuteScript(FILE_WALK_WAYPOINTS, OBJECT_SELF);
}

// Sets the custom AI file to sString to use.
// - "AI_TEMP_TARGET_OBJECT" is set to anything passed to this script.
void SetAIFileName(string sString)
{
    SetLocalString(OBJECT_SELF, "AI_FILENAME", sString);
}

// Gets the custom AI file set to us.
string GetAIFileName()
{
    return GetLocalString(OBJECT_SELF, "AI_FILENAME");
}

// Determines a combat round.
void DetermineCombatRound(object oTarget = OBJECT_INVALID)
{
    // Set local object
    SetAITargetObject(oTarget);
    // Execute the AI file set.
    ExecuteScript(GetAIFileName(), OBJECT_SELF);
}

// Returns any pre-set target object
object Combat_GetAITargetObject()
{
    return GetLocalObject(OBJECT_SELF, "AI_TEMP_SET_TARGET");
}

// Sets the pre-set target object to attack
void SetAITargetObject(object oTarget)
{
    SetLocalObject(OBJECT_SELF, "AI_TEMP_SET_TARGET", oTarget);
}

// Gets the nearest seen or heard enemy.
object Combat_GetNearestSeenOrHeardEnemy(int bSeenOnly = FALSE)
{
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    if(!GetIsObjectValid(oTarget) && bSeenOnly == FALSE)
    {
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, CREATURE_TYPE_IS_ALIVE, TRUE);
        if(!GetIsObjectValid(oTarget))
        {
            return OBJECT_INVALID;
        }
    }
    return oTarget;
}
// Gets if the object is valid, and we can see, or hear it.
// * bSeenOnly - If set to TRUE, it must be seen.
// TRUE if oTarget is valid.
int Combat_GetTargetValid(object oTarget, int bSeenOnly = FALSE)
{
    // Check if valid
    if(!GetIsObjectValid(oTarget)) return FALSE;

    // Check if seen
    if(!GetObjectSeen(oTarget) && bSeenOnly == TRUE) return FALSE;

    // Check if heard
    if(!GetObjectHeard(oTarget)) return FALSE;

    // Valid == TRUE
    return TRUE;
}

// This will call a random voicechat to be called, if iPercent is met.
void Combat_Taunt(int iPercent = 10)
{
    if(d100() <= iPercent)
    {
        int iVoice = VOICE_CHAT_BATTLECRY1;
        switch(d6())
        {
            case 1: iVoice = VOICE_CHAT_ATTACK; break;
            case 2: iVoice = VOICE_CHAT_BATTLECRY1; break;
            case 3: iVoice = VOICE_CHAT_BATTLECRY2; break;
            case 4: iVoice = VOICE_CHAT_BATTLECRY3; break;
            case 5: iVoice = VOICE_CHAT_LAUGH; break;
            case 6: iVoice = VOICE_CHAT_TAUNT; break;
        }
        PlayVoiceChat(iVoice);
    }
}

// This will heal oTarget with the best spell possible.
// - Like the Bioware function.
// - Will force healing if bForce is TRUE, ELSE, it will only heal at 50% HP.
// - TRUE if it heals oTarget
int Combat_HealTarget(object oTarget, int bForce = FALSE)
{
    // Taken from Bioware AI and modified.
    talent tUse;
    int nCurrent = GetCurrentHitPoints(OBJECT_SELF) * 2;
    int nBase = GetMaxHitPoints(OBJECT_SELF);

    // Check HP.
    if( (nCurrent < nBase) || (bForce == TRUE) )
    {
        if(oTarget == OBJECT_SELF)
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_POTION, 20);
            if(Combat_TalentAtObject(tUse, oTarget))
            {
                return TRUE;
            }
        }
        tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20);
        if(Combat_TalentAtObject(tUse, oTarget))
        {
            return TRUE;
        }
        else
        {
            tUse = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_AREAEFFECT, 20);
            if(Combat_TalentAtObject(tUse, oTarget))
            {
                return TRUE;
            }
        }
    }
    return FALSE;
}
// This will loop all seen allies. If any of them need healing, it will heal
// them and return TRUE.
// - Uses Combat_HealTarget to check if they need healing.
int Combat_HealAllies()
{
    int iCnt = 1;
    // Loop seen allies who are not dead
    object oAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    while(GetIsObjectValid(oAlly))
    {
        if(Combat_HealTarget(oAlly))
        {
            // Stop - healed someone
            return TRUE;
        }
        iCnt++;
        oAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, iCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    }
    return FALSE;
}

// Only for use in "Combat_TurnUndead", it checks if there are any non-turned
// undead within 10M, of iRace.
int Combat_TurningAnyOfRaceValid(int iRace)
{
    int nCnt = 1;
    int nCount = 0;
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_RACIAL_TYPE, iRace);
    while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 10.0)
    {
        if(!Combat_GetHasEffect(EFFECT_TYPE_TURNED, oTarget) && !GetIsDead(oTarget))
        {
            return TRUE;
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_RACIAL_TYPE, iRace);
    }
    return FALSE;
}

// This will check if we can turn undead, and check if there are anythings we can
// turn, and turn if so. Uses mainly Bioware stuff.
int Combat_TurnUndead()
{
    if(GetHasFeat(FEAT_TURN_UNDEAD))
    {
        object oUndead = Combat_GetNearestSeenOrHeardEnemy();
        if(Combat_GetHasEffect(EFFECT_TYPE_TURNED, oUndead) ||
           GetHitDice(OBJECT_SELF) <= GetHitDice(oUndead))
        {
            return FALSE;
        }
        int nCount;
        int nElemental = GetHasFeat(FEAT_AIR_DOMAIN_POWER)
            + GetHasFeat(FEAT_EARTH_DOMAIN_POWER)
            + GetHasFeat(FEAT_FIRE_DOMAIN_POWER)
            + GetHasFeat(FEAT_FIRE_DOMAIN_POWER);
        int nVermin = GetHasFeat(FEAT_PLANT_DOMAIN_POWER)
            + GetHasFeat(FEAT_ANIMAL_COMPANION);
        int nConstructs = GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER);
        int nOutsider = GetHasFeat(FEAT_GOOD_DOMAIN_POWER)
            + GetHasFeat(FEAT_EVIL_DOMAIN_POWER)
            + GetHasFeat(854);             // planar turning

        if(nElemental == TRUE)
            nCount += Combat_TurningAnyOfRaceValid(RACIAL_TYPE_ELEMENTAL);

        if(nVermin == TRUE)
            nCount += Combat_TurningAnyOfRaceValid(RACIAL_TYPE_VERMIN);

        if(nOutsider == TRUE)
            nCount += Combat_TurningAnyOfRaceValid(RACIAL_TYPE_OUTSIDER);

        if(nConstructs == TRUE)
            nCount += Combat_TurningAnyOfRaceValid(RACIAL_TYPE_CONSTRUCT);

        nCount += Combat_TurningAnyOfRaceValid(RACIAL_TYPE_UNDEAD);

        if(nCount > 0)
        {
            ClearAllActions();
            ActionUseFeat(FEAT_TURN_UNDEAD, OBJECT_SELF);
            return TRUE;
        }
    }
    return FALSE;
}

// This attempt to use the best potions the creature has.
// * Will return FALSE if they use none, or they already have the effects
// * Uses any Potection First (EG: stoneskin), then Enhancement (EG: Bulls strength)
//   then Conditional (EG: Clarity)
int Combat_UseAnyPotions()
{
    talent tPotion = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_POTION, 20);

    // Get if valid, and not got the effects
    if(Combat_TalentAtObject(tPotion, OBJECT_SELF))
    {
        return TRUE;
    }

    // Else get the next one, Enhancement
    tPotion = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_POTION, 20);
    // Get if valid, and not got the effects
    if(Combat_TalentAtObject(tPotion, OBJECT_SELF))
    {
        return TRUE;
    }

    // Else get the next one, Conditional
    tPotion = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_POTION, 20);
    // Get if valid, and not got the effects
    if(Combat_TalentAtObject(tPotion, OBJECT_SELF))
    {
        return TRUE;
    }
    // No potion used/no potion not got effect of.
    return FALSE;
}

// Attack oTarget with a melee weapon, and melee feats if we can hit them.
// - VERY basic!
void Combat_AttackMelee(object oTarget)
{
    // Equip best
    ClearAllActions();
    ActionEquipMostDamagingMelee(oTarget);

    // Attack with feat if we can hit them
    int iRandom = 5 + d10();
    if(GetBaseAttackBonus(OBJECT_SELF) + iRandom >= GetAC(oTarget))
    {
        // Getting the melee talent category for melee feats is useful in a short
        // AI script. Not useful in a longer one.
        // - We can get feats Knockdown (Improved), Disarm (Improved), Sap,
        // Stunning fist, Expertise (Improved), Flurry of Blows, Called Shot,
        // and Power Attack (Improved) from this talent
        talent tMelee = GetCreatureTalentRandom(TALENT_CATEGORY_HARMFUL_MELEE);

        // Can't use ranged feats - and make sure the feat is valid
        if(GetIsTalentValid(tMelee) &&
           GetTypeFromTalent(tMelee) == TALENT_TYPE_FEAT)
        {
            int iTalentID = GetIdFromTalent(tMelee);
            if(iTalentID == FEAT_RAPID_SHOT)
            {
                // Can't use ranged feats in melee, so just normal attack
                ActionAttack(oTarget);
            }
            else
            {
                // Else, use the feat, and attack
                ActionUseTalentOnObject(tMelee, oTarget);
            }
        }
    }
    else
    {
        ActionAttack(oTarget);
    }
}
// Attack oTarget with a ranged weapon (if we have any), and ranged feats if we can hit them.
// - VERY basic!
void Combat_AttackRanged(object oTarget)
{
    // Equip best
    ClearAllActions();
    ActionEquipMostDamagingRanged(oTarget);

    // Check if we did equip a ranged
    if(!GetWeaponRanged(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)))
    {
        ActionAttack(oTarget);
        return;
    }

    // Attack with feat if we can hit them
    int iRandom = 5 + d10();
    if(GetBaseAttackBonus(OBJECT_SELF) >= GetAC(oTarget) - iRandom)
    {
        // Feats for Range
        if(GetHasFeat(FEAT_RAPID_SHOT))
        {
            ActionUseFeat(FEAT_RAPID_SHOT, oTarget);
            return;
        }
        else if(GetHasFeat(FEAT_CALLED_SHOT))
        {
            ActionUseFeat(FEAT_CALLED_SHOT, oTarget);
            return;
        }
        else
        {
            ActionAttack(oTarget);
        }
    }
    else
    {
        ActionAttack(oTarget);
    }
}


// This will check if the caller has nSpell, and casts it at oObject if so.
int Combat_CastAtObject(int nSpell, object oTarget)
{
    if(GetHasSpell(nSpell) && !GetHasSpellEffect(nSpell, oTarget))
    {
        ClearAllActions();
        ActionCastSpellAtObject(nSpell, oTarget);
        return TRUE;
    }
    return FALSE;
}
// This will check if the caller has nSpell, and casts it at oObject's location if so.
int Combat_CastAtLocation(int nSpell, object oTarget)
{
    if(GetHasSpell(nSpell) && !GetHasSpellEffect(nSpell, oTarget))
    {
        ClearAllActions();
        ActionCastSpellAtLocation(nSpell, GetLocation(oTarget));
        return TRUE;
    }
    return FALSE;
}

// Checks if tUse is TRUE, and uses it against oTarget if not got the effects.
int Combat_TalentAtObject(talent tUse, object oTarget)
{
    if(GetIsTalentValid(tUse))
    {
        int iType = GetTypeFromTalent(tUse);
        int iID = GetIdFromTalent(tUse);
        // If it is a feat, check if they have the effect.
        if(iType == TALENT_TYPE_FEAT && GetHasFeatEffect(iID, oTarget))
        {
            return FALSE;
        }
        // If a spell, check if got the spell effect
        else if(iType == TALENT_TYPE_SPELL && GetHasSpellEffect(iID, oTarget))
        {
            return FALSE;
        }
        // Use it.
        ClearAllActions();
        ActionUseTalentOnObject(tUse, oTarget);
        return TRUE;
    }
    return FALSE;
}

// Cheat-Casts nSpell, if under iPercent.
// * Doesn't cast if iPercent fails, or oTarget has nSpell's effects.
// Use this to make sure a caster doesn't run out of spells.
int Combat_CheatRandomSpellAtObject(int nSpell, object oTarget, int iPercent)
{
    // Check %
    if(d100() <= iPercent && !GetHasSpellEffect(nSpell, oTarget))
    {
        // Cheat cast it at oTarget
        ClearAllActions();
        ActionCastSpellAtObject(nSpell, oTarget, METAMAGIC_ANY, TRUE);
        return TRUE;
    }
    return FALSE;
}

// This will loop oTarget's effects, and return TRUE if any are equal to
// iEffect, which is a constant EFFECT_TYPE_*
int Combat_GetHasEffect(int iEffect, object oTarget = OBJECT_SELF)
{
    effect eCheck = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eCheck))
    {
        if(GetEffectType(eCheck) == iEffect)
        {
            return TRUE;
        }
        eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}

// This will walk the waypoints of the creature (re-activate them)
// Use this if the creature is not in combat/not attacking/no target to attack/
void Combat_WalkWaypoints()
{
    ExecuteScript(FILE_WALK_WAYPOINTS, OBJECT_SELF);
}
