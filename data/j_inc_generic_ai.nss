// j_int_generic_ai/nw_i0_generic. Revamped and restarted!
// The format of this file is:

// 1. Defining everything (just below this)
// 2. Fuctions used in other scripts, not the CombatRound call. (line 456)
// 3. All the Geting info functions (500 - )
/*
 - Info For Allies/Us
 - Info For Enemies
 - Everything Else
*/
// 4. All the functions that will perform the actions
/*
 - Using a script on self.
 - Spell Casting Functions
 - Feat Useage against X
 - All spell casting functions that have lead off from the one below.
*/
// 5. Actually checking then seeing if they can perform said action functions.
/*
 - Special Checks
 - Healing Self, Cure Condition, Heal Allies, Return To Starting Posistion
 - Spell Triggers, Teleport
 - Summon Familiar/Companion
 - Flee
 - LeaderActions
 - AttemptShoutToAllies
 - GoForTheKill
 - AbilityAura
 - ArcherRetreat
 - UseTurning
 - jTalentBardSong
 - jTalentDragonCombat
 - ConcentrationCheck
 - ImportAllSpells, ImportCantripSpells
 - UseSpecialSkills
 - CastCombatHostileSpells, PolyMorph
 - TalentMeleeAttack
*/
// 6. Respond to shouts
// 7. DetermineCombatRound (right at the end, easier for me).


//Master Constants- Default ones still used.

// This will make the creature never fight against impossible odds.

int NEVER_FIGHT_IMPOSSIBLE_ODDS             = 0x00000010;

// This reflects the boss' power. All allies in 6 tiles will come.

int BOSS_MONSTER_SHOUT                      = 0x00000020;

// This will make the creature a "leader" to command the help, and genrally command others.

// Also, any creature that can see the leader will not flee except on command, although the

// leader may flee, and order others to.

int GROUP_LEADER                            = 0x00000040;

// This will make the creature defined as an Archer only. They will either:

//  a. Use a missile weapon with pointblankshot.

//  b. Move back, best they can, if allies are there to help, then carry on shooting.

int ARCHER_ATTACKING                        = 0x00000080;

// This will make the creature never flee at all.

int FEARLESS                                = 0x00000100;

// If they are damaged a lot, they may spawn a critical wounds potion and use it.

int CHEAT_MORE_POTIONS                      = 0x00080000;

// This will make the creature summon thier respective familiars/animal companions.

int SUMMON_FAMILIAR                         = 0x00200000;

// This will make the creature cheat by using some instant death spells on low save enemies

// Its not that powerful at all, really, but might as well be toggelable.

int IMPROVED_INSTANT_DEATH_SPELLS           = 0x00800000;

// This will let the cleric use the raising spells in battle.

int WILL_RAISE_ALLIES_IN_BATTLE             = 0x01000000;

// This will make the creature use ranged spells, before moving in bit by bit.

// Ranges of spells are 40, then 20, 8, 2.5 and then 0 (or self! hehe)

int ATTACK_FROM_AFAR_FIRST                  = 0x02000000;

// There will be a chance each round to try and pickpocket the enemy. This toggles it.

// It will only use it if it's skills are at least 1 every 4 levels.

int USE_PICKPOCKETING                       = 0x08000000;

// This will store thier starting location, and then move back there after combat

// Will turn off if there are waypoints.

int RETURN_TO_SPAWN_LOCATION                = 0x10000000;

// Tracks day/night.

int TRACK_DAY_NIGHT                         = 0x20000000;

// This will affect conversations - will they clear all actions before hand?

int NO_CLEAR_ACTIONS_BEFORE_CONVERSATION    = 0x40000000;

// Last one! This stops all polymorphing by spells/feats

int NO_POLYMORPHING                         = 0x80000000;

// Randomwalk normally, or move to nearest ally.
int AMBIENT_ANIMATIONS                      = 1;
// These will face nearest ally, and talk or laugh. If no ally then look right/left.
int IMMOBILE_AMBIENT_ANIMATIONS             = 2;
// This is the bird animations.
int AMBIENT_ANIMATIONS_AVIAN                = 3;
// This will make the creatures "group" and sit, and normally talk.
int AMBIENT_GROUP_ANIMATIONS                = 4;
// This will make the creature talk with nearby allies, as to not look dead.
// Also, if alone, it will take drinks, and things like that.
int IMMOBILE_ANIMATIONS_AND_SOLO            = 5;
// This is a consitution for just random walking, nothing else.
int AMBIENT_ANIMAL_WALKING                  = 6;

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@ SETUP OF THINGS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// This is a group of local variables that are set to 0 each time here, and
// used each round. This is better than local ints to use.

// This is set to TRUE if we are affected with silence - meaning no proper spells!
int OnlyUseItems;
// This is used a LOT to see if we are in time stop
int iInTimeStop;
// Master varible set for any of these 3 types of talents.
// The master, CanCastSpells, is determined by talents and darkness etc. Normally spells.
int WandsAvalible, PotionsAvalible, KitsAvalible, CanCastSpells;

// These are if we have talents of the respective number.
// Instead of GetIsTalentValid a lot...set once, with the talent.
int ItemValid1, ItemValid2, ItemValid3, ItemValid4, ItemValid5,
    ItemValid6, ItemValid7, ItemValid8, ItemValid9, ItemValid10,
    ItemValid11, ItemValid12, ItemValid13, ItemValid14, ItemValid15,
    // Respective potions
    ItemValid17, ItemValid18, ItemValid20, ItemValid21;
// This is the set values of spells that the talent actually is.
int ItemSpell1, ItemSpell2, ItemSpell3, ItemSpell4, ItemSpell5, ItemSpell6, ItemSpell7,
    ItemSpell8, ItemSpell9, ItemSpell10, ItemSpell11, ItemSpell12, ItemSpell13, ItemSpell14,
    ItemSpell15,/*Potions*/ ItemSpell17, ItemSpell18, ItemSpell20, ItemSpell21;

// How it works (for the above). We set if we have items, or potions.
// Then, we check the respective talent category. If the spell stored matches, it is true.
// then, we go into a special silence check - we get the talent again. It *should* be the
// same, and if so, use it!

// These are set for the right talents. No potions - handled as items, above.
int /*Special - Darkness, light and silence.*/ SpellValid0,
    SpellValid1, SpellValid2, SpellValid3, SpellValid4, SpellValid5,
    SpellValid6, SpellValid7, SpellValid8, SpellValid9, SpellValid10,
    SpellValid11, SpellValid12, SpellValid13, SpellValid14, SpellValid15;

// Global immunities to items, used against oSpellTarget.
int ImmuneFear, ImmuneNecromancy, ImmuneMind, ImmuneNegativeLevel, ImmuneEntangle,
    ImmuneSleep, ImmunePoison, ImmuneDisease, ImmuneDomination, ImmuneStun, ImmuneCurse,
    ImmuneConfusion, ImmuneBlind, ImmuneDeath, ImmuneNegativeEnergy;

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@ CORE AI FUNCTIONS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

// Main call. It goes though many lines of code to decide what to do in combat
// To lengthy to explain here. Basically, input an object, it will check if it
// is valid and if not try and find an enemy (not dead, same area).
// Calling bascially initiates combat! CHHARRRGGEEE
void jDetermineCombatRound(object oIntruder = OBJECT_INVALID);
// Equip the weapon appropriate to enemy and position
// This will return TRUE if any action is taken, except the basic one.
// ActionUseFeat stops the use of ActionEquipItem.
void jEquipAppropriateWeapons(object oTarget, int iInt);
// Responds to it (like makinging the callers attacker thier target)
void RespondToShout(object oShouter, int nShoutIndex, object oIntruder = OBJECT_INVALID);
//  Checks if the passed object has an Attempted
//  Attack or Spell Target
int jGetIsFighting(int iIncludeInCombat = TRUE);
// Returns the local int. "MAX_ELEMENTAL_DAMAGE" on self.
int GetMaxDamageDone();
// Shouts, or really brings all people in 60.0 M to the "shouter"
void ShoutBossShout(object oEnemy);
// Speaks and stamps a debug string.
void DebugActionSpeak(string sString);

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@ ACTION FUNCTIONS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

// Get all spells, and cast if valid. See end functions
int ImportAllSpells(int iInt, int nClass, object oTarget, object oAlly, int iHasAlly, float fAllyDistance, int iMeleeEnemy, int iRangedEnemy, int iMyHD, int iPartyHD, int iPCHP, int iBAB);
// This is used to cast all cantrips.
// They are always castable, so no class. Will only cast some on enemy posisiton
// or on bad BAB.
int ImportCantripSpells(object oSpellTarget, object oAlly, int iHasAlly, float fAllyDistance, float fEnemyDistance, int iMeleeEnemy, int iRangedEnemy, int iMyHD, int iPartyHD, int iPCHP, int iBAB);
// Used to attack. Called in determine conbat round.
// 1 - Gets the target, if invalid, returns false
// 2 - Checks AC and attack for disarm, and if so, disarm
// 3 - Else normal attack the target.
int jTalentMeleeAttack(object oIntruder, int iInt);
// Talents like breath weopens...woohoo!
int jTalentDragonCombat(object oIntruder = OBJECT_INVALID);
// This will activate some spell protections on self, depending on wiz/sorc levels
int SpellTriggersActivate();
// If we can turn any of the enemy, try it!
int UseTurning();
// Uses the bard song, if they have it.
int jTalentBardSong();
// Runs though several basic checks. True, if any are performed
// 1 - Darkness. If so, dispel (inc. Ultravision) or move out
// 2 - AOE spells. Move away from enemy if got effects (more so if no one near)
// 3 - If invisible, need to move away from any combations.
int SpecialChecks(int nClass);
// Include for AI. Activates best aura. Checks for alignment, then best.
int AbilityAura();
// Dragon ability - Wing buffet.
int AbilityWingBuffet(object oTarget);
// Runs through summoning a familiar - uses the feat if it has it.
int TalantSummonFamiliar();
// This may make the archer retreat - if they are set to, and have a ranged weapon
// and don't have point blank shot, and has a nearby ally.
int ArcherRetreat(int iHasAlly, float fAllyRange, object oEnemy, float fEnemyRange);
// This will use empathy, taunt, and if set, pickpocketing. Most are random, and
// checks are made.
int UseSpecialSkills(object oEnemy, int iInt, float fEnemyRange, int iMyHD);

// This is a good check against the enemies (highest AC one) Damage against concentration
// Also, based on allies, enemies, and things, may move back (random chance, bigger with
// more bad things, like no stoneskins, no invisibility etc.)
int ConcentrationCheck(object oTarget, int iInt, int nClass, object oAlly, int iHasAlly, float fAllyDistance, float fEnemyDistance, int iMeleeEnemy, int iRangedEnemy, int iMyHD, int iEnemyHD, int iPCHP, int iMyBAB);
// This will attempt to get a very near target with low HP, and knock them out.
int GoForTheKill(object oTarget, int iInt, int iPCHP = 0, float fEnemyDistance = 100.0, int iMeleeEnemy = 0, int iMyBAB = 0);
// Checks enemy condition, and if they can cast invis and protections they
// do not have...then casts spells if appropriate.
int GoodTimeToInvisSelf(int iAttackers, int iMyHD, int iRangedAttackers, int iAverageHD);
// Will cast any protection spells it can, while invis, and no enemy can hear or see it
// Uses GetCanAnyoneSeeOrHearMe(object oTarget = OBJECT_SELF);
int AmInvisibleCasting(int iMod, object NearestEnemy = OBJECT_INVALID);
// If very overwhelmed, and with low allies, the creature may run
// Makes a fear save, against the enemy average HD number, so immune to fear creatures will never run
// Need average or just below INT as well.
// Will run, if they can, to the best concentration of allies in the area...
// Still needs serious testing, as with all things.
int Flee(object oEnemy, int iInt, int iEnemyAverageHD, int iMyCR, int iLeaderBonus);
// Flees from oTarget or last hostile actor, to fDistace, for 4 seconds.
int FleeFrom(object oTarget = OBJECT_INVALID, float fDistance = 10.0);
// Returns the intelligence set on spawn. Default to 10.
int jGetIntelligence();
// Returns the nearest set leader.
object GetNearestLeaderInSight();

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@ HEALING FUNCTIONS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

// If our current HP is under the percent given, it will check things to heal itself, and use them.
// Used for animals ETC as well. They just don't use potions.
// This will also check levels, for appropriate healing. Set iMyHD to higher to use lower level spells.
int jTalentHealingSelf(int iPercent, int iMyHD = 20, int iThierHD = 1, object oEnemy = OBJECT_INVALID, int iMeleeAttackers = 0, int iRubbishAsWell = FALSE);
// Uses spells only on others and self, no potions because they are usable on self only
int jTalentHeal(int iHasAlly, object oLeader, int iMyHD, int iMeleeAttackers, int iRubbishAsWell = FALSE);
// Uses spells to cure conditions. Needs to be checked fully
int jTalentCureCondition(int iAlly, int iInt);
// This returns the highest value healing kit they have in thier inventory. Else OBJECT_INVALID
object GetBestHealingKit();
// This will check the possibility of spontaneously casting a healing spell.
// Returns TRUE if it casts one.
int TalentHealingCleric();
// This will do 1 of two things, with the spell ID
// 1. If iHealAmount is FALSE, it will return what number (rank) in order, which is also used for level checking
// 2. If TRUE, it will return the average damage it will heal.
int ReturnHealingInfo(int iSpellID, int iHealAmount = FALSE);
// This will check talents ETC, and heal if so. Used in jTalentHeal
int RunHealingOnObject(object oTarget, int iMyHD, int iRubbishAsWell, int iPercent, int iMeleeAttackers);
// Returns if the talent of iTalentNum has a repective item that casts a spell
// from that category.
int ReturnIfTalentEqualsSpell(int iSpellID, int iTalentNum);
// Sorts inventory - if there are potions or scrolls, it will set talents to use them.
void CheckInventory();

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@ TARGETING & ACTUAL ACTION FUNCTIONS @@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

// This will cast the respective spell, if they have it memorised.
int CastSpellNormalAtObject(int nSpellID, int iNoAttackAfter = FALSE, object oTarget = OBJECT_SELF, int iModifier = 20, int iRequirement = 1, int iChance = 100);
// We will attempt to use the spell, or find the relivant talent to cast it by an item.
// This does not use potions. Target only.
int CastNoPotionSpellAtObject(int iSpellID, int nTalent, object oTarget = OBJECT_SELF, int iModifier = 20, int iRequirement = 1, int iChance = 100, int DoubleTimeStop = TRUE);
// Will cast iSpellID at location, but if a valid target, will use the targets location.
int CastNoPotionSpellAtLocation(int iSpellID, int nTalent, location lLocation, int iModifier = 20, int iRequirement = 1, int AndAttack = FALSE, int DoubleTimeStop = TRUE, int iChance = 100);
// This will cast the spell of ID in this order [Note: Always adds to time stop, as it will be on self, and benifical):
// 1. If they have the spell normally
// 2. If they have an item with the spell.
// 3. If they have a potion of the right type.
int CastPotionSpellAtObject(int iSpellID, int nTalent, object oTarget = OBJECT_SELF, int iModifier = 20, int iRequirement = 1, int iChance = 100);
// If the talent, and target, are valid, cast the talent and return TRUE.
int CastSpellTalentAtObject(talent tTalent, object oTarget = OBJECT_SELF);
// This is a special case. It tries to match a spell, using talents. Things like shades,
// and protection from XXX seem not to work with normal means.
int CastAttemptedTalentAtObject(int iSpellID, int nTalent, object oTarget = OBJECT_SELF, int iModifier = 20, int iRequirement = 1, int iChance = 100, int iDoubleTimeStop = TRUE);
// This will get the item talent again, silence if appropriate, so check we have it already.
// TRUE if we use an item.
int CastItemEqualTo(object oTarget, int iSpellID, int nTalent, object oEnemy = OBJECT_INVALID);
// Location varient of CastItemEqualTo.
int CastItemLocationEqualTo(location lLocation, int iSpellID, int nTalent, object oEnemy = OBJECT_INVALID);

// This will cast the right stat-boosting spell, for better spell saves.
int CastRightSpellHelp(int nClass, int iMod = 20);
// Stoneskin protections, if none already. Will return TRUE if it casts best on self.
int CastPhysicalProtections(int iMod = 20);
// Casts Best Mantal on self, if none already. Will return TRUE if it casts best on self.
int CastMantalProtections(int iMod = 20);
// Casts the best globe on self, if not got it already. Will return TRUE if it casts best on self.
int CastGlobeProtections(int iMod = 20);
// Will cast best possible elemental protection, if not already. Will return TRUE if it casts best on self.
int CastElementalProtections(int iMod = 20);
// Shadow shield, etc. Casts Best, if not already. Will return TRUE if it casts best on self.
int CastVisageProtections(int iMod = 20);
// Will polymorph Self if not already so. Will return TRUE if it casts best on self.
int PolyMorph();
// Plays talks like "ATTACK!" and "Group Near Me" etc.
// The numbers are 1-10. For a narrower choice, use lower numbers.
// The default is "attack", so making it 20 randomness means a 11/20 chance to play it.
void PlayRandomAttackTaunt(int iRandomness = 7, object oSpeaker = OBJECT_SELF);
// Returns -1 on error.
// Reports a feat to use - if any at all. Runs thorugh list, comparing BAB, and the modifications etc.
// Accuratly uses sizes, and so forth, in things like knockdown. Replaces TALENT_HARMFUL_MELEE
int GetBestFightingFeat(object oTarget, int iBAB, int iAC);
// If they have the feat, they will use it on the target, and return TRUE
int UseFeatOnObject(int iFeat, object oObject = OBJECT_SELF, int iClearAllActions = TRUE);
// This uses the best combat feat or spell it can, such as barbarian rage, divine power,
// bulls strength and so on. Spells may depend on melee enemy, or HD, or both, or range of enemy.
// Target is used for race's ect.
int CastCombatHostileSpells(int nClass, object oTarget, float fEnemyRange, int iMeleeAttackers, object oAlly, int iHasAlly, float fAllyRange, int iMyHD, int iEnemyHD, int iMyBAB);
// This will summon a familiar, or animal companion, as appropriate (IE they can)
int DoSummonFamiliar();
// This may teleport the person, if set to.
int Teleport(int iHitDice, int iMeleeEnemy);
// This will make us return to our starting place, if we are set to.
int ReturnToStartingPlace();
// This will shout, maybe, some commands to allies. Or just command them!
void LeaderActions(object oEnemy, int iEnemyHD, int iMyHD, int iHasAlly, object oAlly, int iBAB);
// This sets up the creatures in LOS in an array (to be used with ObjectIsInLOS)
// and also checks enemies for invisbility (if they are only heard AND in LOS)
void CountCreatures();
// This will return TRUE if creature is in the stored creature array, so within LOS
int ObjectIsInLOS(object oCreature = OBJECT_INVALID);

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@ ALL INFO FUNCTIONS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

/* INFO ON SELF */
// Checks the 3 classes, and returns the int value of the highest.
// Not sure of each class int Though.
int DetermineClassToUse();
// This sets, in a genral INT, what cirtain talents are valid. Speeds things up, and sets
// if we can use spells as well.
void SetMySpells();
// This is TRUE if the talent of that number has got a spell (checked at start).
int GetTalentIsCastable(int nTalent);
// Returns TRUE if you can cast any sort of spell. Defaults to only hostile ones.
// Types:
//  1 - Includes protection spells
//  2 - Includes potions
//  3 - Includes summoning spells
int CanCastAnything(object oTarget = OBJECT_SELF, int Type = 0);
// Returns TRUE if oTarget has any spell protections from any of the 4 elemental spells
int HasElementalProtections(object oTarget = OBJECT_SELF);
// Returns TRUE if oTarget has any spell protections from any of the 3 stoneskin spells
int HasStoneskinProtections(object oTarget = OBJECT_SELF);
// Returns TRUE if oTarget has any spell protections from any of the 3 visage spells
int HasVisageProtections(object oTarget = OBJECT_SELF);
// Returns TRUE if oTarget has any spell protections from any of the 3 mantal spells
int HasMantalProtections(object oTarget = OBJECT_SELF);
// Returns TRUE if oTarget has any spell protections from any of the 2 globe spells
int HasGlobeProtections(object oTarget = OBJECT_SELF);
// Returns the Attack Bonus - what thier primary attack *probably* hits at.
int BaseAttackBonus(object oTarget = OBJECT_SELF);
// Returns TRUE if we are affected by something that would comprimise our actions.
int GetIsUnCommandable();
// This will return the damage of an AOO around ourselves.
// Takes into account melee attackers, in 2.0M
int GetAnAooDamageTotal();
/*MISC*/
// If any enemy in 50m are targeting oTarget (default = self)
int GetIsAnyoneAttackingTarget(object oTarget = OBJECT_SELF);
// Area info. Used for the spell light. If any source or tiles are black, true.
int GetIsAreaDark();

/*GETTING ENEMY INFO*/

// Calculate the number of enemies within melee range of self. Uses 2.0M for now.
int jGetNumberOfMeleeAttackers();
// Calculate the number of people attacking self from beyond 2.0m
int jGetNumberOfRangedAttackers();
// Determine the number of targets within 20m that are of the specified racial-type
// Used in turning, and some spells.
int jGetRacialTypeCount(int nRacial_Type);
// Returns the nearest object that can be seen, then checks for the nearest heard target.
// Now used in combat round end, and also here in melee attack (inc dragon combat) and turning
object jGetNearestSeenOrHeardEnemy();
// Gets the target with the lowest AC that they can hear or see.
// Set the range - thus 2.0M for melee, more for ranged.
object GetLowestEnemyAC(float fRange = 2.0, object oSelf = OBJECT_SELF);
// This returns the lowest Melee AC, of targets not attacks it
// Else it returns the lowest AC creature.
object GetBestSneakTarget(float fRange = 2.0, object oSelf = OBJECT_SELF);
// Returns the appropriate Challenge rating if higher then the Hit Dice. Toughness basically.
int GetChallengeOf(object oTarget);
// Returns the average hit dice (or CR) of all creatures of iRep, in a 50' radius (seen range) around oTarget
// Use Value one, nd Valaue1Para, to be things like is dead, perception etc. Default to perception seen.
int GetAverageHD(int iRep = REPUTATION_TYPE_ENEMY, float fRange = 50.0, object oTarget = OBJECT_SELF, int iValue1 = CREATURE_TYPE_PERCEPTION, int Value1Para = PERCEPTION_SEEN);
// Main call for melee attacks. Normally, the AI goes for the lowest AC that attacked
// it, else the one it percieved first. This will get the lowest AC, if in melee,
// Else it will check for the nearest creature it can reach with the lowest AC (for now)
object GetBestTarget();
// Returns true if Target is a humanoid, orc, goblin or lizardfolk, or a PC race.
// Use GetIsPlayableRacialType for just humaniod. Animal is for dominate/hold animal.
int GetIsHumanoid(object oTarget, int Animal = FALSE);
// Returns 1-4 for tiny-huge weapons. Used for disarm etc.
int GetWeaponSize(object oItem);
// This returns TRUE if the target will always resist the spell given the parameters.
int SpellResistanceImmune(object oTarget, int nClass);
// If the target will always save against iSaveType, and will take no damage, returns TRUE
int SaveImmune(object oTarget, int iSaveType, int iSave, int iSaveDC, int iSpellLevel);

/*GETTING ALLIED INFO*/

// Returns the greatest group of allies, same area.
object GetBestGroupOfAllies();
// Return nearest ALIVE, SEEN ally, used for spells, like healing and helping them.
object GetNearestAlly();

/*GETTING SPELL TARGETS*/

// Checks the target for a specific EFFECT_TYPE constant value
// Returns TRUE or FALSE
int jGetHasEffect(int nEffectType, object oTarget = OBJECT_SELF);
// TRUE if any effect is scared or turned.
int GetIsFrightened(object oTarget);
// Return TRUE if target is enhanced with any spell that will disrupt some spellcasting
// for example - all mantals, FALSE otherwise.
int GetHasGreatEnhancement(object oTarget);
// Return TRUE if target is enhanced with a beneficial
// spell that can be dispelled (= from a spell script), FALSE otherwise.
int GetHasBeneficialEnhancement(object oTarget);
// Returns TRUE if the target has any spell effect that can be targeted with
// any Spell breach. Breachs are pretty good.
int GetHasBeneficialBreach(object oTarget);
// This returns a number, 1-4. This number is the levels
// of spell they will be totally immune to.
int GetSpellLevelEffect(object oTarget);
// Returns the object to the specifications:
// Within fRange
// The most targets around the creature in fRange, in fSpread.
// nFriendlyFire - If it affects allies, this is used.
// It will subtract allies in that area, in a cirtain CR of caster.
// Also, will never hurt ourselves (anything that would hit us are not used)
// Spell ranges: (normally 0-4). Need to use spells.2da to find these.
//           Label              PrimaryRange   SecondaryRange   Name
//0          SpellRngPers       0              ****             ****
//1          SpellRngTouch      2.25           ****             ****
//2          SpellRngShrt       8              ****             ****
//3          SpellRngMed        20             ****             ****
//4          SpellRngLng        40             ****             ****
// Spell Spreads, Check the spell file for that info.
// float RADIUS_SIZE_SMALL           = 1.67f;
// float RADIUS_SIZE_MEDIUM          = 3.33f;
// float RADIUS_SIZE_LARGE           = 5.0f;
// float RADIUS_SIZE_HUGE            = 6.67f;
// float RADIUS_SIZE_GARGANTUAN      = 8.33f;
// float RADIUS_SIZE_COLOSSAL        = 10.0f;
// nShape is the type of shape, Check the spell file for that info as well.
//int    SHAPE_SPELLCYLINDER      = 0;
//int    SHAPE_CONE               = 1;
//int    SHAPE_CUBE               = 2;
//int    SHAPE_SPELLCONE          = 3;
//int    SHAPE_SPHERE             = 4;
// And nLevel is the level of spell. Only applicable for level 1-4 spells
// Only uses targets that do not have protections like MinorGlobe that absorb it
object GetBestAreaSpellTarget(float fRange, float fSpread, int nLevel, int nClassLevel, int iSaveType = FALSE, int iSaveDC = FALSE, int nShape = SHAPE_SPHERE, int nFriendlyFire = FALSE, int iDeathImmune = FALSE, int iNecromanticSpell = FALSE);
// Returns the object to the specifications:
// Within nRange (float)
// The most targets around the creature in nRange, in nSpread.
// Can be the caster, of course
object GetBestFriendyAreaSpellTarget(float fRange, float fSpread, int nShape = SHAPE_SPHERE);
// This basically gets any summoned creatures in range (8.0)
// The range of the spell is 8.0. It has a sphere of 10.0.
object GetDismissalTarget();
// True if the target is immune to instant death.
// Got a spell which grants it, or got an effect that grants it.
int GetIsDeathImmune(object oTarget = OBJECT_SELF);
// Returns a value of TRUE if the target is immune to necromancy spells
// Also should check the level of spell...seperatly.
int GetIsNecromancyImmune(object oTarget = OBJECT_SELF);
// Returns TRUE if they are immune to fear.
int GetIsFearImmune(object oTarget = OBJECT_SELF);
// TRUE if the spell is one recorded as being cast before in time stop.
int CompareTimeStopStored(int nSpell);
// Sets the spell to be stored in our time stop array.
void SetTimeStopStored(int nSpell);
// Deletes all time stopped stored numbers.
void DeleteTimeStopStored();
// If the spell is there, or they have the respective talent version.
int GetIsSpellValid(int iSpellID, int nTalent);

#include "x0_i0_spawncond"

//::///////////////////////////////////////////////

//:: Master Local Set

//:: FileName

//:: Copyright (c) 2001 Bioware Corp.

//:://////////////////////////////////////////////

/*

    All On Spawn in conditions in the game are now

    being stored within one local.  The get and set

    changed or checks the condition of this one

    Hex local.  The NW_FLAG_XXX variables above

    allow for the user of these functions throughout

    the generic scripts.

*/

//:://////////////////////////////////////////////

//:: Created By: Preston Watamaniuk

//:: Created On: Nov 14, 2001

//:://////////////////////////////////////////////



void SetSpawnInValue(string sNameOfValue, int iValue, int iAddOne=FALSE)

{

    if(iAddOne)

    {

        int iValueNew = iValue + 1;

        SetLocalInt(OBJECT_SELF, sNameOfValue, iValueNew);

    }

    else

    {

        SetLocalInt(OBJECT_SELF, sNameOfValue, iValue);

    }

}



void SetSpawnInStringValue(string sNameOfValue, string sValue)

{

    SetLocalString(OBJECT_SELF, sNameOfValue, sValue);

}



void SetSpawnInStringRandomValue(string sNameOfValue, int iRandomness, string sValue0, string sValue1, string sValue2 = "", string sValue3 = "", string sValue4 = "", string sValue5 = "", string sValue6 = "")

{

    // Need a value amount of values!

    if(iRandomness > 0)

    {

        int iRandomNum = Random(iRandomness) -1; // take one, as it is 0 - X, not 1 - X

        string sValueToUse;

        switch(iRandomNum)

        {

            case(0):{sValueToUse = sValue0;}break;

            case(1):{sValueToUse = sValue1;}break;

            case(2):{sValueToUse = sValue2;}break;

            case(3):{sValueToUse = sValue3;}break;

            case(4):{sValueToUse = sValue4;}break;

            case(5):{sValueToUse = sValue5;}break;

            case(6):{sValueToUse = sValue6;}break;

        }

        SetLocalString(OBJECT_SELF, sNameOfValue, sValueToUse);

    }

}

void jSetSpawnInCondition(int nCondition, int bValid=TRUE, string sName="JAI_GENERIC_MASTER", object target=OBJECT_SELF)
{

    int nPlot = GetLocalInt(target, sName);

    if(bValid == TRUE)

    {

        nPlot = nPlot | nCondition;

        SetLocalInt(target, sName, nPlot);

    }

    else if (bValid == FALSE)

    {

        nPlot = nPlot & ~nCondition;

        SetLocalInt(target, sName, nPlot);

    }

}

int jGetSpawnInCondition(int nCondition,  object target=OBJECT_SELF, string sName = "JAI_GENERIC_MASTER")

{

    int nPlot = GetLocalInt(target, sName);

    if(nPlot & nCondition)

    {

        return TRUE;

    }

    return FALSE;

}



////////////////////////////////////////////////////////////////////////////////



// This applies an increase, decrease or no change to the intended stat.

void ApplyStatChange(int iStat, int iAmount)

{

    if(iAmount != 0)

    {

        effect eChange;

        if(iAmount < 0)

        {

            int iNewAmount = abs(iAmount);

            eChange = ExtraordinaryEffect(EffectAbilityDecrease(iStat, iNewAmount));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

        else

        {

            eChange = ExtraordinaryEffect(EffectAbilityIncrease(iStat, iAmount));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

    }

}

// This will, eventually, choose X number of stats, and change them within the

// range given.

void CreateRandomStats(int iLowest, int iHighest, int iAmount)

{

    if(iAmount > 0 && !(iLowest == 0 && iHighest == 0) && iHighest >= iLowest)

    {

        int iRange = iHighest - iLowest;

        int iNumSlots = iAmount;

        if(iNumSlots > 6) iNumSlots = 6;

        int iNumLeft = 6;

        // Walk through each stat and figure out what it's chance of being

        // modified is.  As an example, suppose we wanted to have 4 randomized

        // abilities.  We'd look at the first ability and it would have a 4 in 6

        // chance of being picked.  Let's suppose it was, the next ability would

        // have a 3 in 5 chance of being picked.  If this next ability wasn't

        // picked to be changed, the 3rd ability woud have a 3 in 4 chance of

        // being picked and so on.

        int iCnt;

        int iChange;

        for(iCnt = 0; (iNumSlots > 0) && (iCnt < 6); iCnt++)

        {

           if((iNumSlots == iNumLeft) || (Random(iNumLeft) < iNumSlots))

           {

              iChange = Random(iRange) + iLowest;

              ApplyStatChange(iCnt, iChange);

              iNumSlots--;

           }

           iNumLeft--;

        }

    }

}



void CreateRandomOther(int iHPMin, int iHPMax, int iReflexSaveMin = 0, int iReflexSaveMax = 0, int iWillSaveMin = 0, int iWillSaveMax = 0, int iFortSaveMin = 0, int iFortSaveMax = 0, int iACMin = 0, int iACMax = 0, int iACType = AC_DODGE_BONUS)

{

    int iRange, iChange, iNewChange;

    effect eChange;

    if(!(iHPMin == 0 && iHPMax == 0) && iHPMax >= iHPMin)

    {

        iRange = iHPMax - iHPMin;

        iChange = Random(iRange) + iHPMin;

        if(iChange > 0)

        {

            eChange = ExtraordinaryEffect(EffectTemporaryHitpoints(iChange));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

        else if(iChange < 0 && GetMaxHitPoints() > 1)

        {

            eChange = EffectDamage(iChange, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_PLUS_FIVE);

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

    }

    if(!(iReflexSaveMin == 0 && iReflexSaveMax == 0) && iReflexSaveMax >= iReflexSaveMin)

    {

        iRange = iReflexSaveMax - iReflexSaveMin;

        iChange = Random(iRange) + iReflexSaveMin;

        if(iChange > 0)

        {

            eChange = ExtraordinaryEffect(EffectSavingThrowIncrease(SAVING_THROW_REFLEX, iChange));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

        else if(iChange < 0 && GetReflexSavingThrow(OBJECT_SELF) > 1)

        {

            iNewChange = abs(iChange);

            eChange = ExtraordinaryEffect(EffectSavingThrowDecrease(SAVING_THROW_REFLEX, iNewChange));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

    }

    if(!(iWillSaveMin == 0 && iWillSaveMax == 0) && iWillSaveMax >= iWillSaveMin)

    {

        iRange = iWillSaveMax - iWillSaveMin;

        iChange = Random(iRange) + iWillSaveMin;

        if(iChange > 0)

        {

            eChange = ExtraordinaryEffect(EffectSavingThrowIncrease(SAVING_THROW_WILL, iChange));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

        else if(iChange < 0 && GetWillSavingThrow(OBJECT_SELF) > 1)

        {

            iNewChange = abs(iChange);

            eChange = ExtraordinaryEffect(EffectSavingThrowDecrease(SAVING_THROW_WILL, iNewChange));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

    }

    if(!(iFortSaveMin == 0 && iFortSaveMax == 0) && iFortSaveMax >= iFortSaveMin)

    {

        iRange = iFortSaveMax - iFortSaveMin;

        iChange = Random(iRange) + iFortSaveMin;

        if(iChange > 0)

        {

            eChange = ExtraordinaryEffect(EffectSavingThrowIncrease(SAVING_THROW_FORT, iChange));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

        else if(iChange < 0 && GetFortitudeSavingThrow(OBJECT_SELF) > 1)

        {

            iNewChange = abs(iChange);

            eChange = ExtraordinaryEffect(EffectSavingThrowDecrease(SAVING_THROW_FORT, iNewChange));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

    }

    if(!(iACMin == 0 && iACMax == 0) && iACMax >= iACMin)

    {

        iRange = iACMax - iACMin;

        iChange = Random(iRange) + iACMin;

        if(iChange > 0)

        {

            eChange = ExtraordinaryEffect(EffectACIncrease(iChange, iACType));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

        else if(iChange < 0)

        {

            iNewChange = abs(iChange);

            eChange = ExtraordinaryEffect(EffectACDecrease(iNewChange, iACType));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

        }

    }

}



/*::///////////////////////////////////////////////

//:: SetListeningPatterns

//:://////////////////////////////////////////////



    Changed a lot. Sets up death destroyable corpse thing,

    and added in "**" (all) listening, for hearing enemies.



//::////////////////////////////////////////////*/



void jSetListeningPatterns()

{

    SetIsDestroyable(FALSE,TRUE,TRUE);  // Just handling corpse raising/resurrection/removal

    SetListening(OBJECT_SELF, TRUE);

//  Anyone that can hear it, and is not fighting, comes and helps

    SetListenPattern(OBJECT_SELF, "I_WAS_ATTACKED", 1);

    //Set a custom listening pattern for the creature so that placables with

    //"NW_BLOCKER" + Blocker NPC Tag will correctly call to their blockers.

    string sBlocker = "NW_BLOCKER_BLK_" + GetTag(OBJECT_SELF);

    SetListenPattern(OBJECT_SELF, sBlocker, 2);

//  Determines combat round, if not fighting

    SetListenPattern(OBJECT_SELF, "CALL_TO_ARMS", 3);

    // These call to allies, to move them to a battle.

    SetListenPattern(OBJECT_SELF, "HELP_MY_FRIEND", 4);

    SetListenPattern(OBJECT_SELF, "LEADER_FLEE_NOW", 5);

// This will make the listener hear anything, used to react to enemy talking.

    SetListenPattern(OBJECT_SELF, "**", 0);

}



//***************************

//***************************

//

//WAY POINT WALK FUNCTIONS

//

//***************************

//***************************



// Returns the string to use - depending on day or night.

string GetStringPrefix(string sPrefix, object oWalker=OBJECT_SELF)

{

    if(GetIsDay() || GetIsDawn())

    {

        return GetLocalString(oWalker, sPrefix + "_DAY");

    }

    else

    {

        return GetLocalString(oWalker, sPrefix + "_NIGHT");

    }

}



//::///////////////////////////////////////////////

//:: Run Circuit

//:: Copyright (c) 2001 Bioware Corp.

//:://////////////////////////////////////////////

/*

    Calculates the proper path to follow along a

    predetermined set of way points

*/

//:://////////////////////////////////////////////

//:: Created By: Aidan Scanlan

//:: Created On: July 10, 2001

//:://////////////////////////////////////////////

// Added things from Two's verion - Jasperre



void RunCircuit(int nTens, int nNum, int nRun, float fPause)

{

    // starting at a given way point, move sequentialy through incrementally

    // increasing points until there are no more valid ones.

    // We will check for day/night in these instead of heartbeats.

    string sWay = GetStringPrefix("NW_GENERIC_WALKWAYS");

    string sNewString;

    object oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) + IntToString(nNum));



    while(GetIsObjectValid(oTargetPoint))

    {

        ActionWait(fPause);

        ActionMoveToObject(oTargetPoint, nRun);

        nNum++;

        if (nNum > 9)

        {

            nTens++;

            nNum = 0;

        }

        // Maybe change string prefix to use.

        sNewString = GetStringPrefix("NW_GENERIC_WALKWAYS");

        if(sNewString != sWay)

        {

            sWay == sNewString;

        }

        oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) + IntToString(nNum));

    }

    // changes by two.

    // once there are no more waypoints available, check if we are at our post

    object oCurrentWP = oTargetPoint;

    string sWayTag = GetStringPrefix("NW_GENERIC_POSTING") + GetTag(OBJECT_SELF);

    oTargetPoint = GetNearestObjectByTag(sWayTag);

    if(!GetIsObjectValid(oTargetPoint))

    {

        oTargetPoint = GetObjectByTag(sWayTag);

    }

    if(GetIsObjectValid(oTargetPoint) && GetDistanceToObject(oTargetPoint) > 0.0)

    {

        ActionForceMoveToObject(oTargetPoint, nRun, 1.0, 60.0);

        float fFacing = GetFacing(oTargetPoint);

        ActionDoCommand(SetFacing(fFacing));

        return;

    }

    // no post, lets check if I shall walk in circles or walk back

    else

    {

        sNewString = GetStringPrefix("NW_GENERIC_WALKWAYS");

        if(sNewString != sWay)

        {

            sWay == sNewString;

        }

        sWayTag = sWay + GetTag(OBJECT_SELF) + "_01";

        oTargetPoint = GetNearestObjectByTag(sWayTag);

        if(!GetIsObjectValid(oTargetPoint))

        {

            oTargetPoint = GetObjectByTag(sWayTag);

        }

        if(GetIsObjectValid(oTargetPoint))

        {

            // If the first waypoint is actually nearby...return true to walk it again!

            if(GetDistanceBetween(oTargetPoint, oCurrentWP) < 3.0 && GetDistanceBetween(oTargetPoint, oCurrentWP) >= 0.0)

            {

                return;// Stop and don't walk backwards.

            }

            else

            {

                nNum--;

                if(nNum < 0)

                {

                    nTens--;

                    nNum = 9;

                }

                // start the cycle again going back to point 01

                oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));

                while(GetIsObjectValid(oTargetPoint))

                {

                    ActionWait(fPause);

                    ActionMoveToObject(oTargetPoint, nRun);

                    nNum--;

                    if (nNum < 0)

                    {

                        nTens--;

                        nNum = 9;

                    }

                    oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));

                }

            }

        }

    }

}



// This just carries on walking around and around...

void RunNextCircuit(int nRun, float fPause)

{

    RunCircuit(0, 1, nRun, fPause);

    ActionWait(fPause);

    ActionDoCommand(RunNextCircuit(nRun, fPause));

}

// Activate all auras.

int ActivateIfHas(int nAuraNumber)

{

    if(GetHasSpell(nAuraNumber) && !GetHasSpellEffect(nAuraNumber))

    {

        ClearAllActions();

        ActionCastSpellAtObject(nAuraNumber, OBJECT_SELF, METAMAGIC_ANY, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);

        return TRUE;

    }

    return FALSE;

}



void AdvancedAuras()

{

    if(GetIsTalentValid(GetCreatureTalentBest(TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 20)))

    {

        if(ActivateIfHas(SPELLABILITY_DRAGON_FEAR)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_UNEARTHLY_VISAGE)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_BLINDING)) return;;

        if(ActivateIfHas(SPELLABILITY_AURA_OF_COURAGE)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_PROTECTION)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_STUN)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_FIRE)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_COLD)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_ELECTRICITY)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_UNNATURAL)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_FEAR)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_UNNATURAL)) return;

        if(ActivateIfHas(SPELLABILITY_AURA_MENACE)) return;

    }

}


//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

/*::///////////////////////////////////////////////
//:: Name: ShoutBossShout
//::///////////////////////////////////////////////
 This is used in the OnPercieve, and if we are set to,
 we will "shout" and bring lots of allies a running
//:://///////////////////////////////////////////*/
void ShoutBossShout(object oEnemy)
{
    int Cnt = 1;
    object oAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, Cnt, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_NOT_SEEN_AND_NOT_HEARD);
    object oThierTarget = GetLocalObject(oAlly, "AI_TO_ATTACK");
    while(GetIsObjectValid(oAlly) && GetDistanceToObject(oAlly) <= 60.0)
    {
        if(oThierTarget != oEnemy)
        {
            SetLocalObject(oAlly, "AI_TO_ATTACK", oEnemy);
            if(!GetIsInCombat(oAlly))
            {
                AssignCommand(oAlly, jDetermineCombatRound(oEnemy));
            }
        }
        Cnt++;
        oAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, Cnt, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_NOT_SEEN_AND_NOT_HEARD);
        oThierTarget = GetLocalObject(oAlly, "AI_TO_ATTACK");
    }
}


//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
/*
 - Info For Allies/Us
 - Info For Enemies
 - Everything Else
*/
// Returns the intelligence set on spawn. Default to 10.
int jGetIntelligence()
{
    int iIntelligence = GetLocalInt(OBJECT_SELF, "AI_INTELLIGENCE");
    if(iIntelligence <= 0 || iIntelligence >= 11)
    {
        iIntelligence = 10;
    }
    return iIntelligence;
}
// Returns the local int. "MAX_ELEMENTAL_DAMAGE" on self.
int GetMaxDamageDone()
{
    int iReturn = GetLocalInt(OBJECT_SELF, "MAX_ELEMENTAL_DAMAGE");
    return iReturn;
}
// Checks the 3 classes, and returns the int value of the highest.
// Not sure of each class int Though.
int jDetermineClassToUse()
{
    int nClass;
    int nTotal = GetHitDice(OBJECT_SELF);
    float fTotal = IntToFloat(nTotal);

    int nState1 = FloatToInt((IntToFloat(GetLevelByClass(GetClassByPosition(1))) / fTotal) * 100);
    int nState2 = FloatToInt((IntToFloat(GetLevelByClass(GetClassByPosition(2))) / fTotal) * 100) + nState1;
    int nState3 = FloatToInt((IntToFloat(GetLevelByClass(GetClassByPosition(3))) / fTotal) * 100) + nState2;

    int nUseClass = d100();

    if(nUseClass <= nState1)
    {
        nClass = GetClassByPosition(1);
    }
    else if(nUseClass > nState1 && nUseClass <= nState2)
    {
        nClass = GetClassByPosition(2);
    }
    else
    {
        nClass = GetClassByPosition(3);
    }
    return nClass;
}
// This will check the inventory, for potions, items and talents associated with them
void CheckInventory()
{
    // NO INVALID RACES!!!
    int iRace = GetRacialType(OBJECT_SELF);
    if(iRace != RACIAL_TYPE_ABERRATION && iRace != RACIAL_TYPE_ANIMAL && iRace != RACIAL_TYPE_BEAST &&
       iRace != RACIAL_TYPE_CONSTRUCT && iRace != RACIAL_TYPE_DRAGON && iRace != RACIAL_TYPE_ELEMENTAL &&
       iRace != RACIAL_TYPE_MAGICAL_BEAST && iRace != RACIAL_TYPE_OUTSIDER && iRace != RACIAL_TYPE_SHAPECHANGER &&
       iRace != RACIAL_TYPE_VERMIN)
    {
    // Item's type.
    int iItemType;
    // Check the amulet slot, and the rings - the only equippable items NPCs can use.
    object oItem = GetItemInSlot(INVENTORY_SLOT_NECK);
    if(GetIsObjectValid(oItem))
        if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_CAST_SPELL))
            WandsAvalible = TRUE;
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING);
        if(GetIsObjectValid(oItem))
            if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_CAST_SPELL))
                WandsAvalible = TRUE;
    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING);
        if(GetIsObjectValid(oItem))
            if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_CAST_SPELL))
                WandsAvalible = TRUE;
    // Inventory sweep. Clean as possible.
    oItem = GetFirstItemInInventory();
    while(GetIsObjectValid(oItem) && (!WandsAvalible || !PotionsAvalible || !KitsAvalible))
    {
        iItemType = GetBaseItemType(oItem);
        // If it is a healing kit, we will set we have at least 1.
        if(iItemType == BASE_ITEM_HEALERSKIT)
        {
            if(!KitsAvalible) KitsAvalible = TRUE;
        }
        // If a potion, we will set it so we have some.
        else if(iItemType == BASE_ITEM_POTIONS && !PotionsAvalible)
        {
            if(!PotionsAvalible)
                if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_CAST_SPELL))
                    PotionsAvalible = TRUE;
        }
        // This sets if the item is a special, possibally spellcasting item, then
        // if it is, we may use it to cast spells.
        else if(iItemType == BASE_ITEM_SCROLL || iItemType == BASE_ITEM_MAGICROD ||
                iItemType == BASE_ITEM_MAGICWAND || iItemType == BASE_ITEM_MISCLARGE ||
                iItemType == BASE_ITEM_MISCMEDIUM || iItemType == BASE_ITEM_MISCSMALL ||
                iItemType == BASE_ITEM_MISCTALL || iItemType == BASE_ITEM_MISCTHIN ||
                iItemType == BASE_ITEM_MISCWIDE || iItemType == BASE_ITEM_RING ||
                iItemType == BASE_ITEM_SPELLSCROLL || iItemType == BASE_ITEM_AMULET ||
                iItemType == BASE_ITEM_BOOK)
        {
            if(!WandsAvalible)
                if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_CAST_SPELL))
                    WandsAvalible = TRUE;
        }
        // Carry on.
        oItem = GetNextItemInInventory();
    }
    // Set them all to -1  - no spell is value -1
    ItemSpell1 = -1; ItemSpell2 = -1; ItemSpell3 = -1; ItemSpell4 = -1; ItemSpell5 = -1;
    ItemSpell6 = -1; ItemSpell7 = -1; ItemSpell8 = -1; ItemSpell9 = -1; ItemSpell10 = -1;
    ItemSpell11 = -1; ItemSpell12 = -1; ItemSpell13 = -1; ItemSpell14 = -1;
    ItemSpell15 = -1;/*Potions*/ ItemSpell17 = -1; ItemSpell18 = -1; ItemSpell20 = -1;
    ItemSpell21 = -1;
    // The talent we just change for each...
    talent tBest;
    if(PotionsAvalible)
    {
//        // If we have a valid healing potion one, set it.
//        tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_POTION, 20);
//        if(GetIsTalentValid(tBest) && GetTypeFromTalent(tBest) == TALENT_TYPE_SPELL)
//        {   ItemValid17 = TRUE;
//            ItemSpell17 = GetIdFromTalent(tBest);   }
        // If we have a valid condidtional one, set it.
        tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_POTION, 20);
        if(GetIsTalentValid(tBest) && GetTypeFromTalent(tBest) == TALENT_TYPE_SPELL)
        {   ItemValid18 = TRUE;
            ItemSpell18 = GetIdFromTalent(tBest);   }
        // If we have a valid protection one, set it.
        tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_POTION, 20);
        if(GetIsTalentValid(tBest) && GetTypeFromTalent(tBest) == TALENT_TYPE_SPELL)
        {   ItemValid20 = TRUE;
            ItemSpell20 = GetIdFromTalent(tBest);   }
        // If we have a valid enhancement one, set it.
        tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_POTION, 20);
        if(GetIsTalentValid(tBest) && GetTypeFromTalent(tBest) == TALENT_TYPE_SPELL)
        {   ItemValid21 = TRUE;
            ItemSpell21 = GetIdFromTalent(tBest);   }
        // If there are no valid potions set...don't set potions avalible.
        if(!(ItemValid17 || ItemValid18 || ItemValid20 || ItemValid21))
        {
            PotionsAvalible = FALSE;
        }
    }
    // Set items that cast spell, if we have any.
    if(WandsAvalible)
    {
        int nAlreadySilenced = jGetHasEffect(EFFECT_TYPE_SILENCE);
        if(!nAlreadySilenced)
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSilence(), OBJECT_SELF);
        }
        else
        {
            OnlyUseItems = TRUE;
        }
        // All the same - we will just go through each category,
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid1 = TRUE;
                ItemSpell1 = GetIdFromTalent(tBest);
                SpeakString("Got a areaeffect discriminant, id:" + IntToString(ItemSpell1)); }

            tBest = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_RANGED, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid2 = TRUE;
                ItemSpell2 = GetIdFromTalent(tBest);    }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_TOUCH, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid3 = TRUE;
                ItemSpell3 = GetIdFromTalent(tBest);    }
//            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_AREAEFFECT, 20);
//            if(GetIsTalentValid(tBest))
//            {   ItemValid4 = TRUE;
//                ItemSpell4 = GetIdFromTalent(tBest);    }
//            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20);
//            if(GetIsTalentValid(tBest))
//            {   ItemValid5 = TRUE;
//                ItemSpell5 = GetIdFromTalent(tBest);    }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_AREAEFFECT, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid6 = TRUE;
                ItemSpell6 = GetIdFromTalent(tBest);    }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_SINGLE, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid7 = TRUE;
                ItemSpell7 = GetIdFromTalent(tBest);    }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_AREAEFFECT, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid8 = TRUE;
                ItemSpell8 = GetIdFromTalent(tBest);    }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SINGLE, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid9 = TRUE;
                ItemSpell9 = GetIdFromTalent(tBest);    }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SELF, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid10 = TRUE;
                ItemSpell10 = GetIdFromTalent(tBest);    }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_INDISCRIMINANT, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid11 = TRUE;
                ItemSpell11 = GetIdFromTalent(tBest);    }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SELF, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid12 = TRUE;
                ItemSpell12 = GetIdFromTalent(tBest);
                SpeakString("Got a protection, self, id:" + IntToString(ItemSpell12));
                }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SINGLE, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid13 = TRUE;
                ItemSpell13 = GetIdFromTalent(tBest);
                SpeakString("Got a protection, single id:" + IntToString(ItemSpell13));
                }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_AREAEFFECT, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid14 = TRUE;
                ItemSpell14 = GetIdFromTalent(tBest);    }
            tBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_OBTAIN_ALLIES, 20);
            if(GetIsTalentValid(tBest))
            {   ItemValid15 = TRUE;
                ItemSpell15 = GetIdFromTalent(tBest);    }
        // If we had silence already, we won't remove it, else it was just
        // set by us, so remove it so we can cast again.
        if(!nAlreadySilenced)
        {
            effect eSilence = GetFirstEffect(OBJECT_SELF);
            while(GetIsEffectValid(eSilence))
            {
                if(GetEffectType(eSilence) == EFFECT_TYPE_SILENCE)
                {
                    RemoveEffect(OBJECT_SELF, eSilence);
                    break;
                }
                eSilence = GetNextEffect(OBJECT_SELF);
            }
        }
        // End wands.
    }
    }//End race checks
    // End all.
}
// Checks effects, and commandable check, for determine combat round.
// Returns TRUE if we are affected by something that would comprimise our actions.
int GetIsUnCommandable()
{
    if(!GetCommandable())
        return TRUE;
    if(GetIsDead(OBJECT_SELF))
        return TRUE;
    effect eCheck = GetFirstEffect(OBJECT_SELF);
    int iEffect;
    // Own loop for the uncommandable effect that may be on us.
    while(GetIsEffectValid(eCheck))
    {
        iEffect = GetEffectType(eCheck);
        if(iEffect == EFFECT_TYPE_PARALYZE || iEffect == EFFECT_TYPE_STUNNED ||
           iEffect == EFFECT_TYPE_FRIGHTENED || iEffect == EFFECT_TYPE_SLEEP ||
           iEffect == EFFECT_TYPE_DAZED)
        {
             return TRUE;
             break;
        }
        eCheck = GetNextEffect(OBJECT_SELF);
    }
    return FALSE;
}
// Variation of CanCastAnything. This sets integers on the entire script if we have
// talents of that type, and one grand one for any spells.
void SetMySpells()
{
    talent tTalant;
    // Sets each one to TRUE if we have any of that category (and a spell)
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid1 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_RANGED, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid2 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_TOUCH, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid3 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_AREAEFFECT, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid4 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid5 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_AREAEFFECT, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid6 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_SINGLE, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid7 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_AREAEFFECT, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid8 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SINGLE, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid9 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SELF, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid10 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_INDISCRIMINANT, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid11 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SELF, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid12 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SINGLE, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid13 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_AREAEFFECT, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid14 = TRUE;
    tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_OBTAIN_ALLIES, 20);
    if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
        SpellValid15 = TRUE;
    // Special spells not in any talent at all.
    if(GetHasSpell(SPELL_DARKNESS) || GetHasSpell(SPELL_LIGHT) || GetHasSpell(SPELL_SILENCE))
        SpellValid0 = TRUE;
    if(!CanCastSpells)
    {
        if(SpellValid1 || SpellValid2 || SpellValid3 || SpellValid4 || SpellValid5 || SpellValid6
            || SpellValid7 || SpellValid8 || SpellValid9 || SpellValid10 || SpellValid11 || SpellValid12
            || SpellValid13  || SpellValid14  || SpellValid15)
            {   CanCastSpells = TRUE;    }
    }
}

// Returns TRUE if you can cast any sort of spell. Defaults to only hostile ones.
// Types:
//  1 - Includes protection spells
//  2 - Includes potions
//  3 - Includes summoning spells
int CanCastAnything(object oTarget, int Type)
{
    talent tTalant;
    if(GetIsObjectValid(oTarget))
    {
        tTalant = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, 20, oTarget);
        if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
            return TRUE;
        tTalant = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_AREAEFFECT_INDISCRIMINANT, 20, oTarget);
        if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
            return TRUE;
        tTalant = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_RANGED, 20, oTarget);
        if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
            return TRUE;
        tTalant = GetCreatureTalentBest(TALENT_CATEGORY_HARMFUL_TOUCH, 20, oTarget);
        if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
            return TRUE;
        if(Type >= 1)
        {
            tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_AREAEFFECT, 20, oTarget);
            if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
                return TRUE;
            tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_CONDITIONAL_SINGLE, 20, oTarget);
            if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
                return TRUE;
            tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_AREAEFFECT, 20, oTarget);
            if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
                return TRUE;
            tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SELF, 20, oTarget);
            if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
                return TRUE;
            tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_SINGLE, 20, oTarget);
            if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
                return TRUE;
            tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_AREAEFFECT, 20, oTarget);
            if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
                return TRUE;
            tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SELF, 20, oTarget);
            if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
                return TRUE;
            tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_SINGLE, 20, oTarget);
            if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
                return TRUE;
        }
        if(Type >= 2 && oTarget == OBJECT_SELF)// Potions
        {
            if(PotionsAvalible) return TRUE;
        }
        if(Type >= 3)// Summoning.
        {
            tTalant = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_OBTAIN_ALLIES, 20, oTarget);
            if(GetIsTalentValid(tTalant) && GetTypeFromTalent(tTalant) == TALENT_TYPE_SPELL)
                return TRUE;
        }
        // Special spells not in any talent at all.
        if(GetHasSpell(SPELL_DARKNESS, oTarget) || GetHasSpell(SPELL_LIGHT, oTarget) || GetHasSpell(SPELL_SILENCE, oTarget))
            return TRUE;
    }
    return FALSE;
}
// Returns TRUE if oTarget has any spell protections from any of the 4 elemental spells
int HasElementalProtections(object oTarget)
{
    if(GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, oTarget) ||
       GetHasSpellEffect(SPELL_ENERGY_BUFFER, oTarget) ||
       GetHasSpellEffect(SPELL_RESIST_ELEMENTS, oTarget) ||
       GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS, oTarget))
        return TRUE;
    return FALSE;
}
// Returns TRUE if oTarget has any spell protections from any of the 3 stoneskin spells
int HasStoneskinProtections(object oTarget)
{
    if(GetHasSpellEffect(SPELL_STONESKIN, oTarget) ||
       GetHasSpellEffect(SPELL_GREATER_STONESKIN, oTarget) ||
       GetHasSpellEffect(SPELL_PREMONITION, oTarget) ||
       GetHasSpellEffect(342, oTarget))
        return TRUE;
    return FALSE;
}
// Returns TRUE if oTarget has any spell protections from any of the 3 (+shad) visage spells
int HasVisageProtections(object oTarget)
{
    if(GetHasSpellEffect(SPELL_GHOSTLY_VISAGE, oTarget) ||
       GetHasSpellEffect(SPELL_SHADOW_SHIELD, oTarget) ||
       GetHasSpellEffect(SPELL_ETHEREAL_VISAGE, oTarget) ||
       GetHasSpellEffect(351, oTarget))
        return TRUE;
    return FALSE;
}
// Returns TRUE if oTarget has any spell protections from any of the 3 mantal spells
int HasMantalProtections(object oTarget)
{
    if(GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE, oTarget) ||
       GetHasSpellEffect(SPELL_SPELL_MANTLE, oTarget) ||
       GetHasSpellEffect(SPELL_LESSER_SPELL_MANTLE, oTarget))
        return TRUE;
    return FALSE;
}
// Returns TRUE if oTarget has any spell protections from any of the 3 globe spells
int HasGlobeProtections(object oTarget)
{
    if(GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oTarget) ||
       GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY, oTarget) ||
       GetHasSpellEffect(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE, oTarget))
        return TRUE;
    return FALSE;
}
// If any enemy in 50m are targeting me.
int GetIsAnyoneAttackingTarget(object oTarget)
{
    int iCnt = 1;
    // Gets the first enemy
    object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oTarget, iCnt);
    while(GetIsObjectValid(oEnemy) && GetDistanceBetween(oTarget, oEnemy) < 60.0)// 60.0 range
    {
        // If they can hear me, or see me, then return that they can...
        if(GetAttackTarget(oEnemy) == oTarget)
            return TRUE;
            break;
        // Else carry on...next one futhest away...
        iCnt++;
        oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oTarget, iCnt);
    }
    return FALSE;
}
// Returns an EXTIMATED, TOP BAB - IE, what thier primary attack will hit at.
// Returns the Attack Bonus - what thier primary attack *probably* hits at.
int BaseAttackBonus(object oTarget)
{
    int nBAB1 = GetLevelByClass(CLASS_TYPE_RANGER, oTarget)
        + GetLevelByClass(CLASS_TYPE_FIGHTER, oTarget)
        + GetLevelByClass(CLASS_TYPE_PALADIN, oTarget)
        + GetLevelByClass(CLASS_TYPE_BARBARIAN, oTarget)
        + GetLevelByClass(CLASS_TYPE_DRAGON, oTarget)
        + GetLevelByClass(CLASS_TYPE_OUTSIDER, oTarget)
        + GetLevelByClass(CLASS_TYPE_MONSTROUS, oTarget);
    int nBAB2 = GetLevelByClass(CLASS_TYPE_ABERRATION, oTarget)
        + GetLevelByClass(CLASS_TYPE_ANIMAL, oTarget)
        + GetLevelByClass(CLASS_TYPE_BARD, oTarget)
        + GetLevelByClass(CLASS_TYPE_BEAST, oTarget)
        + GetLevelByClass(CLASS_TYPE_CLERIC, oTarget)
        + GetLevelByClass(CLASS_TYPE_CONSTRUCT, oTarget)
        + GetLevelByClass(CLASS_TYPE_DRUID, oTarget)
        + GetLevelByClass(CLASS_TYPE_ELEMENTAL, oTarget)
        + GetLevelByClass(CLASS_TYPE_GIANT, oTarget)
        + GetLevelByClass(CLASS_TYPE_HUMANOID, oTarget)
        + GetLevelByClass(CLASS_TYPE_MAGICAL_BEAST, oTarget)
        + GetLevelByClass(CLASS_TYPE_MONK, oTarget)
        + GetLevelByClass(CLASS_TYPE_ROGUE, oTarget)
        + GetLevelByClass(CLASS_TYPE_SHAPECHANGER, oTarget)
        + GetLevelByClass(CLASS_TYPE_VERMIN, oTarget);
    int nBAB3 = GetLevelByClass(CLASS_TYPE_COMMONER, oTarget)
        + GetLevelByClass(CLASS_TYPE_FEY, oTarget)
        + GetLevelByClass(CLASS_TYPE_UNDEAD, oTarget)
        + GetLevelByClass(CLASS_TYPE_SORCERER, oTarget)
        + GetLevelByClass(CLASS_TYPE_WIZARD, oTarget);
    int nOldBAB = nBAB1 + (nBAB2 * 3 / 4) + (nBAB3 / 2);
    int nStr = GetAbilityScore(oTarget, ABILITY_STRENGTH);
    int nDex = GetAbilityScore(oTarget, ABILITY_DEXTERITY);
    int nAddOn;
    // Primary weapon...if enchanted, add a few on.
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND , oTarget);
        if(GetItemHasItemProperty(oWeapon, ITEM_PROPERTY_ENHANCEMENT_BONUS)) nAddOn++;
        if(GetItemHasItemProperty(oWeapon, ITEM_PROPERTY_ATTACK_BONUS)) nAddOn++;
    // Finess only if we are using a proper weapon (ie no monster attacks)
    if(GetHasFeat(FEAT_WEAPON_FINESSE) && (nDex > nStr) && GetIsObjectValid(oWeapon))
    { nAddOn += GetAbilityModifier(ABILITY_DEXTERITY, oTarget); } else
    { nAddOn += GetAbilityModifier(ABILITY_STRENGTH, oTarget); }
    int nReturn = nOldBAB + nAddOn;
    return nReturn;
}
// This will return the damage of an AOO around ourselves.
// Takes into account melee attackers, in 2.0M
int GetAnAooDamageTotal()
{
    int iReturnDamage = 0;
    int nCnt = 1;
    int iBAB;
    int iAC = GetAC(OBJECT_SELF);
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 2.0)// 5 feet, as D&D, is 1.5M aprox. Changed to 2.0
    {
        if(!GetWeaponRanged(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget)))
        {
            iBAB = BaseAttackBonus(oTarget);
            // Take thier roll as 15, about average top level hit.
            if(iBAB + 15 >= iAC)
            {
                // Damage will be strength, some HD and 1.
                // much faster than something like getting the weapon damage.
                iReturnDamage = iReturnDamage + GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetHitDice(oTarget)/3 + d6() + 1;
            }
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt);
    }
    return iReturnDamage;
}
// Returns -1 on error.
// Reports a feat to use - if any at all. Runs thorugh list, comparing BAB, and the modifications etc.
// Accuratly uses sizes, and so forth, in things like knockdown. Replaces TALENT_HARMFUL_MELEE
int GetBestFightingFeat(object oTarget, int iBAB, int iAC)
{
    // No dead or plot targets to use.
    if(GetIsDead(oTarget) || GetPlotFlag(oTarget)) return FALSE;
    // NOTE: we take 5 + (0 to 10) as our 1d20 roll, then subtract approprate modifiers.
    int iMod, iOurSize, iThierSize, iDifference;
    int iRace = GetRacialType(oTarget);
    // We state that our 1d20 roll is 5 + (0 to 10)
    int iNewBAB = iBAB + 5 + Random(10);
    // Sets weapons. Used for disarm, monk feats ETC. We use Us, they are Them
    object oUsLeft = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    object oThemLeft = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
    // These are Valid, sizes and ranged weapon check numbers.
    int iUsLeft, iThemLeft, iRangedUs, iRangedThem, iSizeUs, iSizeThem;
    if(GetWeaponRanged(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)) || iRangedUs)
    {
        // Less Get's. We need -2 for all ranged feats.
        if((iNewBAB -2) >= iAC)
        {
            // This provides another attack, at -2 to hit.
            if(GetHasFeat(FEAT_RAPID_SHOT))
            {
                return FEAT_RAPID_SHOT;
            }
            // At a -2 to hit, this can disarm the arms or legs...speed or attack bonus
            if(GetHasFeat(FEAT_CALLED_SHOT) && !GetHasFeatEffect(FEAT_CALLED_SHOT, oTarget))
            {
                return FEAT_CALLED_SHOT;
            }
        }
    }
    else
    {
        // For use against them evil pests! Top - one use only anyway.
        if(GetHasFeat(FEAT_SMITE_EVIL) && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_EVIL)
        {
            return FEAT_SMITE_EVIL;
        }
        if(!GetHasFeatEffect(FEAT_KNOCKDOWN, oTarget) && !GetHasFeatEffect(FEAT_IMPROVED_KNOCKDOWN, oTarget))
        {
            // These return 1-5, based on size.
            iOurSize = GetCreatureSize(OBJECT_SELF);
            iThierSize = GetCreatureSize(oTarget);
            // By far the BEST feat to use - knocking them down lets you freely attack them!
            if(GetHasFeat(FEAT_IMPROVED_KNOCKDOWN))
            {
                // Base it at same sizes
                iMod = 0;
                // Imporved affects like if we were 1 size larger - thus we can affect 2 sizes bigger targets
                if((iOurSize + 2) >= iThierSize)
                {
                    iDifference = iThierSize - iOurSize;
                    if(iDifference != 0)
                        iMod += 4 * iDifference;
                    // We are 1 size bigger, so its evens (we add 4 onto -4)
                    iMod += iNewBAB;
                    if(iMod >= iAC)
                        return FEAT_IMPROVED_KNOCKDOWN;
                }
            }
            // By far the BEST feat to use - knocking them down lets you freely attack them!
            // Else - we do not want them to use this inplace of the above
            else if(GetHasFeat(FEAT_KNOCKDOWN))
            {
                // Base it at same sizes
                iMod = 0;
                // Only works on our size, above 1, or smaller.
                if((iOurSize + 1) >= iThierSize)
                {
                    iDifference = iThierSize - iOurSize;
                    if(iDifference != 0)
                        iMod += 4 * iDifference;
                    // Add BAB, at a -4 penalty.
                    iMod += iNewBAB -4;
                    if(iMod >= iAC)
                        return FEAT_KNOCKDOWN;
                }
            }
        }
        // Define let weapons (IE promary melee weapon)
        iUsLeft = GetIsObjectValid(oUsLeft);
            iRangedUs = GetWeaponRanged(oUsLeft);
                iSizeUs = GetWeaponSize(oUsLeft);
        iThemLeft = GetIsObjectValid(oThemLeft);
            iRangedThem = GetWeaponRanged(oThemLeft);
                iSizeThem = GetWeaponSize(oThemLeft);
        // No AOO, and only a -4 penalty to hit.
        if(GetHasFeat(FEAT_IMPROVED_DISARM))
        {
            // These two state if we can disarm, IE no missile, and they have a weapon!
            // Only left (primary non-shield hand) will be used. Otherwise it is probably a
            // shield, or a ranged weapon, if there is only an item in that slot.
            if((iUsLeft && !iRangedUs) && (iThemLeft && !iRangedThem))
            {
                // Apply weapon size penalites/bonuses to check - Use left weapons.
                iMod = (iSizeThem - iSizeUs);
                if(iMod != 0) iMod += (iMod * 4);
                if((iNewBAB -4 + iMod) >= iAC)
                {
                    return FEAT_IMPROVED_DISARM;
                }
            }
        }
        // Provokes an AOO. Improved does not, but this is -6, and bonuses depend on weapons used (sizes)
        if(GetHasFeat(FEAT_DISARM) && !GetHasFeat(FEAT_IMPROVED_DISARM))
        {
            // See above for why only left weapon.
            if((iUsLeft && !iRangedUs) && (iThemLeft && !iRangedThem))
            {
                // Apply weapon size penalites/bonuses to check - Use left weapons.
                iMod = (iSizeThem - iSizeUs);
                if(iMod != 0) iMod += (iMod * 4);
                if((iNewBAB - 4 + iMod) >= iAC)
                {
                    return FEAT_DISARM;
                }
            }
        }
        int iBaseType = GetBaseItemType(oUsLeft);
        // These are 3 monk feats. Not to be used against some races, with cirtain weapons.
        if(!iUsLeft || iBaseType == BASE_ITEM_KAMA && iRace != RACIAL_TYPE_CONSTRUCT && iRace != RACIAL_TYPE_UNDEAD)
        {
            // Can inflict cirtain death. Roll is DC10 + 0.5 * monks level + wis modifier. Fort save
            if(GetHasFeat(FEAT_QUIVERING_PALM) && iNewBAB >= iAC)
            {
                // Ok, not too random. Thier roll is not d20 + fort save, it is random(15) + 5.
                if((10 + (GetLevelByClass(CLASS_TYPE_MONK)/2) + GetAbilityModifier(ABILITY_WISDOM)) >= (GetFortitudeSavingThrow(oTarget) + 5 + Random(15)))
                {
                    return FEAT_QUIVERING_PALM;
                }
            }
            // These two don't want to conflict
            if(!GetHasFeatEffect(FEAT_STUNNING_FIST, oTarget) && !GetHasFeatEffect(FEAT_SAP, oTarget))
            {
                // Stuns the target, making them unable to move. -4 attack. DC (fort) of 10 + HD/2 + wis mod.
                if(GetHasFeat(FEAT_STUNNING_FIST))
                {
                    iMod = 6;
                    if(GetLevelByClass(CLASS_TYPE_MONK) >= 1) iMod = 10;
                    if((iBAB + iMod >= iAC) && ((10 + (GetHitDice(OBJECT_SELF)/2) + GetAbilityModifier(ABILITY_WISDOM)) >=  GetFortitudeSavingThrow(oTarget) + 5 + Random(15)))
                    {
                        return FEAT_STUNNING_FIST;
                    }
                }
                // OK, not for PCs, but may be on an NPC. -4 Attack. Above the one below.
                if(GetHasFeat(FEAT_SAP))
                {
                    if((iNewBAB - 4) >= iAC)
                    {
                        return FEAT_SAP;
                    }
                }
            }
            // This activates an extra attack, at -2 to hit. Of course, only unarmed and kama
            if(GetHasFeat(FEAT_FLURRY_OF_BLOWS))
            {
                if((iNewBAB - 2) >= iAC)
                {
                    return FEAT_FLURRY_OF_BLOWS;
                }
            }
        }
        // At a -2 to hit, this can disarm the arms or legs...speed or attack bonus
        if(GetHasFeat(FEAT_CALLED_SHOT) && !GetHasFeatEffect(FEAT_CALLED_SHOT, oTarget) && (iNewBAB -2) >= iAC)
        {
            return FEAT_CALLED_SHOT;
        }
        // -10 to hit, for +10 damage. Good, I guess, in some circumstances.
        if(GetHasFeat(FEAT_IMPROVED_POWER_ATTACK) && (iBAB >= iAC))
        {
            return FEAT_IMPROVED_POWER_ATTACK;
        }
        // is a -5 to hit. Uses random 5, to randomise a bit, I guess. Still means a massive BAB will use it.
        if(GetHasFeat(FEAT_POWER_ATTACK) && ((iBAB + Random(5)) >= iAC))
        {
            return FEAT_POWER_ATTACK;
        }
    }
    // We will not use any feats defined as 0, or false.
    return FALSE;
}
// Calculate the number of enemies within melee range of self. Uses 2.0M for now.
int jGetNumberOfMeleeAttackers()
{
    int nCnt = 1;
    int nReturn = 0;
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_IS_ALIVE, TRUE);
    while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 2.0)// 5 feet, as D&D, is 1.5M aprox. Changed to 2.0
    {
        if(!GetWeaponRanged(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget)))
        {
            nReturn++;
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_IS_ALIVE, TRUE);
    }
    return nReturn;
}
// jGetNumberOfRangedAttackers
//    Check how many enemies are attacking the
//    target from as distance
int jGetNumberOfRangedAttackers()
{
    int nCnt = 1;
    int nReturn;
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_IS_ALIVE, TRUE);
    float fRange = GetDistanceToObject(oTarget);
    while(GetIsObjectValid(oTarget) && fRange <= 40.0)
    {
        if(GetAttackTarget(oTarget) == OBJECT_SELF && GetWeaponRanged(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget)) && fRange > 2.0)
        {
            nReturn++;
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_IS_ALIVE, TRUE);
        fRange = GetDistanceToObject(oTarget);
    }
    return nReturn;
}
// Returns the nearest object that can be seen, then checks for the nearest heard target.
// Now used in combat round end, and also here in melee attack (inc dragon combat) and turning
object jGetNearestSeenOrHeardEnemy()
{
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
        if(!GetIsObjectValid(oTarget))
        {
            oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, CREATURE_TYPE_IS_ALIVE, TRUE);
            if(!GetIsObjectValid(oTarget))
            {
                return OBJECT_INVALID;
            }
        }
    }
    return oTarget;
}
// Determine the number of targets within 20m that are of the specified racial-type
// Used in turning, and some spells.
int jGetRacialTypeCount(int nRacial_Type)
{
    int nCnt = 1;
    int nCount = 0;
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_RACIAL_TYPE, nRacial_Type);
    while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 20.0)
    {
        if(!GetIsFrightened(oTarget) && !GetIsDead(oTarget) && !GetPlotFlag(oTarget))
        {
            nCount++;
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_RACIAL_TYPE, nRacial_Type);
    }
    return nCount;
}
// This returns the lowest Melee AC, of targets not attacks it
// Else it returns the lowest AC creature.
object GetBestSneakTarget(float fRange, object oSelf)
{
    int iEnemyAC, iAC = 100;
    int nCnt = 1;
    object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    object oBest = OBJECT_INVALID;
    while(GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) <= fRange)
    {
        if(!GetPlotFlag(oEnemy) && !GetIsDead(oEnemy))
        {
            if(GetAttackTarget(oEnemy) != OBJECT_SELF)
            {
                iEnemyAC = GetAC(oEnemy);
                if(iAC > iEnemyAC)
                {
                    iAC = iEnemyAC;
                    oBest = oEnemy;
                }
            }
        }
        nCnt++;
        oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    }
    if(!GetIsObjectValid(oBest))
    {
        oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, CREATURE_TYPE_IS_ALIVE, TRUE);
        oBest = OBJECT_INVALID;
        while(GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) <= fRange)
        {
            if(!GetPlotFlag(oEnemy) && !GetIsDead(oEnemy))
            {
                if(GetAttackTarget(oEnemy) != OBJECT_SELF)
                {
                    iEnemyAC = GetAC(oEnemy);
                    if(iAC > iEnemyAC)
                    {
                        iAC = iEnemyAC;
                        oBest = oEnemy;
                    }
                }
            }
            nCnt++;
            oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, CREATURE_TYPE_IS_ALIVE, TRUE);
        }
    }
    if(!GetIsObjectValid(oBest))
        oBest = GetLowestEnemyAC(fRange);
    return oBest;
}
// Gets the target with the lowest AC that they can hear or see.
// Set the range - thus 2.0M for melee, more for ranged.
object GetLowestEnemyAC(float fRange, object oSelf = OBJECT_SELF)
{
    int iEnemyAC, iAC = 100;
    int nCnt = 1;
    object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    object oLowest = OBJECT_INVALID;
    //First, seen enemies only.
    while(GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) <= fRange)
    {
        if(!GetPlotFlag(oEnemy) && !GetIsDead(oEnemy))
        {
            iEnemyAC = GetAC(oEnemy);
            if(iAC > iEnemyAC)
            {
                iAC = iEnemyAC;
                oLowest = oEnemy;
            }
        }
        nCnt++;
        oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    }
    // Then check the heard enemies.
    if(!GetIsObjectValid(oLowest))
    {
        oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, CREATURE_TYPE_IS_ALIVE, TRUE);
        oLowest = OBJECT_INVALID;
        iAC = 100;
        while(GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) <= fRange)
        {
            if(!GetPlotFlag(oEnemy) && !GetIsDead(oEnemy))
            {
                iEnemyAC = GetAC(oEnemy);
                if(iAC > iEnemyAC)
                {
                    iAC = iEnemyAC;
                    oLowest = oEnemy;
                }
            }
            nCnt++;
            oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, CREATURE_TYPE_IS_ALIVE, TRUE);
        }
    }
    return oLowest;
}
// Returns the appropriate Challenge rating if higher then the Hit Dice. Toughness basically.
int GetChallengeOf(object oTarget)
{
    int iHD = GetHitDice(oTarget);
    int iCR = FloatToInt(GetChallengeRating(oTarget));
    // Returns HD is equal or higher.
    if(iCR > iHD)
        return iCR;
    // Always will return iHD otherwise
    return iHD;
}
// Main call for melee attacks. Normally, the AI goes for the lowest AC that attacked
// it, else the one it percieved first. This will get the lowest AC, if in melee,
// Else it will check for the nearest creature it can reach with the lowest AC (for now)
object GetBestTarget()
{
    object oTarget = OBJECT_INVALID;
    object oRangedWeapon = GetLocalObject(OBJECT_SELF, "DW_RANGED");
    // If we are in melee...
    if(jGetNumberOfMeleeAttackers() > 0)
    {
        if(GetHasFeat(FEAT_SNEAK_ATTACK))
        {
            oTarget = GetBestSneakTarget();
        }
        else
        {
            oTarget = GetLowestEnemyAC();
        }
    }
    // Else we get the lowest AC ranged...
    else if(GetIsObjectValid(oRangedWeapon))
    {
        if(GetHasFeat(FEAT_SNEAK_ATTACK))
        {
            oTarget = GetBestSneakTarget(50.0);
        }
        else
        {
            oTarget = GetLowestEnemyAC(50.0);
        }
    }
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = jGetNearestSeenOrHeardEnemy();
    }
    return oTarget;
}
// Returns if the talent of iTalentNum has a repective item that casts a spell
// from that category.
int ReturnIfTalentEqualsSpell(int iSpellID, int iTalentNum)
{
    // Value to return.
    int iReturn = FALSE;
    switch(iTalentNum)
    {
        case 1: {if(ItemValid1){ if(iSpellID == ItemSpell1){ iReturn = TRUE;}}} break;
        case 2: {if(ItemValid2){ if(iSpellID == ItemSpell2){ iReturn = TRUE;}}} break;
        case 3: {if(ItemValid3){ if(iSpellID == ItemSpell3){ iReturn = TRUE;}}} break;
        case 4: {if(ItemValid4){ if(iSpellID == ItemSpell4){ iReturn = TRUE;}}} break;
        case 5: {if(ItemValid5){ if(iSpellID == ItemSpell5){ iReturn = TRUE;}}} break;
        case 6: {if(ItemValid6){ if(iSpellID == ItemSpell6){ iReturn = TRUE;}}} break;
        case 7:
        {
            if(ItemValid7){ if(iSpellID == ItemSpell7){ iReturn = TRUE;}}
            if(ItemValid20){ if(iSpellID == ItemSpell20){ iReturn = TRUE;}}
        }
        break;
        case 8: {if(ItemValid8){ if(iSpellID == ItemSpell8){ iReturn = TRUE;}}} break;
        case 9:
        {
            if(ItemValid9){ if(iSpellID == ItemSpell9){ iReturn = TRUE;}}
            if(ItemValid21){ if(iSpellID == ItemSpell21){ iReturn = TRUE;}}
        }
        break;
        case 10:
        {
            if(ItemValid10){ if(iSpellID == ItemSpell10){ iReturn = TRUE;}}
            if(ItemValid21){ if(iSpellID == ItemSpell21){ iReturn = TRUE;}}
        }
        break;
        case 11: {if(ItemValid11){ if(iSpellID == ItemSpell11){ iReturn = TRUE;}}} break;
        case 12:
        {
            if(ItemValid12){ if(iSpellID == ItemSpell12){ iReturn = TRUE;}}
            if(ItemValid20){ if(iSpellID == ItemSpell20){ iReturn = TRUE;}}
        }
        break;
        case 13:
        {
            if(ItemValid13){ if(iSpellID == ItemSpell13){ iReturn = TRUE;}}
            if(ItemValid20){ if(iSpellID == ItemSpell20){ iReturn = TRUE;}}
        }
        break;
        case 14: {if(ItemValid14){ if(iSpellID == ItemSpell14){ iReturn = TRUE;}}} break;
        case 15: {if(ItemValid15){ if(iSpellID == ItemSpell15){ iReturn = TRUE;}}} break;
        // 17 - 21 are potions, handled above also.
    }
    return iReturn;
}
// Get Is Spell Valid
// If the spell is there, or they have the respective talent version.
int GetIsSpellValid(int iSpellID, int nTalent)
{
    if(GetHasSpell(iSpellID)) return TRUE;
    if(PotionsAvalible || WandsAvalible)
    {
        // Potion spell setting correctly. SELF and SINLGE checked in potions (not AOE's).
        int iPotionSpell = 0;
        if(nTalent == 7){ iPotionSpell = 20; }
        else if(nTalent == 9 || nTalent == 10){ iPotionSpell = 21; }
        else if(nTalent == 12 || nTalent == 13){ iPotionSpell = 20; }
        // Will not check for talents if we don't have items.
        if((WandsAvalible && nTalent < 16) || (PotionsAvalible && iPotionSpell > 0))
        {
            if(ReturnIfTalentEqualsSpell(iSpellID, nTalent)) return TRUE;
        }
    }
    return FALSE;
}
int GetTalentIsCastable(int nTalent)
{
    // Returns TRUE if the talent of that number has a valid GetCreatureTalentBest in it.
    int iReturn = FALSE;
    switch(nTalent)
    {
        case 1: { if(SpellValid1) iReturn = TRUE; } break;
        case 2: { if(SpellValid2) iReturn = TRUE; } break;
        case 3: { if(SpellValid3) iReturn = TRUE; } break;
        case 4: { if(SpellValid4) iReturn = TRUE; } break;
        case 5: { if(SpellValid5) iReturn = TRUE; } break;
        case 6: { if(SpellValid6) iReturn = TRUE; } break;
        case 7: { if(SpellValid7) iReturn = TRUE; } break;
        case 8: { if(SpellValid8) iReturn = TRUE; } break;
        case 9: { if(SpellValid9) iReturn = TRUE; } break;
        case 10: { if(SpellValid10) iReturn = TRUE; } break;
        case 11: { if(SpellValid11) iReturn = TRUE; } break;
        case 12: { if(SpellValid12) iReturn = TRUE; } break;
        case 13: { if(SpellValid13) iReturn = TRUE; } break;
        case 14: { if(SpellValid14) iReturn = TRUE; } break;
        case 15: { if(SpellValid15) iReturn = TRUE; } break;
        // After here are potions - not normal spell categories in most senses.
    }
    return iReturn;
}
// Return nearest ALIVE, SEEN ally, used for spells, like healing and helping them.
object GetNearestAlly()
{
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION,
        REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION,
        PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);

    if (GetIsObjectValid(oTarget))
    {
        return oTarget;
    }
    return OBJECT_INVALID;
}
// TRUE if the spell is one recorded as being cast before in time stop.
int CompareTimeStopStored(int nSpell)
{
    int iCnt = 1;
    int iLast = GetLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt));
    // 0 is acid fog - so can be cast twice, and is hostile.
    while(iLast != 0)
    {
        if(nSpell == iLast)
        {
            return TRUE;
        }
        iCnt++;
        iLast = GetLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt));
    }
    return FALSE;
}
// Sets the spell to be stored in our time stop array.
void SetTimeStopStored(int nSpell)
{
    int iCnt = 1;
    int iLast = GetLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt));
//  Limit the loop to 20 spells. Should be enough space if all other functions are correct.
    while(iCnt < 20)
    {
        if(iLast == 0)
        {
            SetLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt), nSpell);
            iCnt = 30;
            return;
        }
        iCnt++;
        iLast = GetLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt));
    }
    return;
}
// Deletes all time stopped stored numbers.
void DeleteTimeStopStored()
{
    int iCnt = 1;
    int iLast = GetLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt));
    // Acid Fog (spell 0) can be cast multiple times. This stops 25 loops if a limited selection are valid INTs
    while(iCnt < 25 && iLast != 0)
    {
        DeleteLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt));
        iCnt++;
        iLast = GetLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt));
    }
    return;
}
// Returns the object to the specifications:
// Within nRange (float)
// The most targets around the creature in nRange, in nSpread.
// Can be the caster, of course
object GetBestFriendyAreaSpellTarget(float fRange, float fSpread, int nShape)
{
    object oGroupies;
    int iCountOnPerson, iMostOnPerson = 0;
    // Will always at least return ourselves.
    object oSpellTarget = OBJECT_SELF;
    int nCnt = 1;
    // Gets the nearest friend...the loops takes care of range.
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    location lTarget = GetLocation(oTarget);
    while (GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= fRange)
    {
        // Reset/Start counting the spread on oTarget.
        oGroupies = GetFirstObjectInShape(nShape, fSpread, lTarget);
        // Starts the count at 0, as first object in shape will also include the target.
        iCountOnPerson = 0;
        // If oGroupies is invalid, nothing.
        while(GetIsObjectValid(oGroupies))
        {
            // Only add one if the person is an friend
            if(GetIsFriend(oGroupies))
            {
                iCountOnPerson++;
            }
            oGroupies = GetNextObjectInShape(nShape, fSpread, lTarget);
        }
        if(iCountOnPerson > iMostOnPerson)
        {
            iMostOnPerson = iCountOnPerson;
            oSpellTarget = oTarget;
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
        lTarget = GetLocation(oTarget);
    }
    // Will always return self if anything
    return oSpellTarget;
}
// Returns the nearest set leader.
object GetNearestLeaderInSight()
{
    if(jGetSpawnInCondition(GROUP_LEADER))
        return OBJECT_SELF;
    object oLeader = OBJECT_INVALID;
    int nCnt = 1;
    // Breaks, when need be.
    int iBreak = 3;
    object oPerson = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nCnt, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    while(GetIsObjectValid(oPerson) && iBreak < 10)
    {
        if(jGetSpawnInCondition(GROUP_LEADER, oPerson))
        {
            // If they are the leader, return them!
            oLeader = oPerson;
            iBreak = 30;
        }
        nCnt++;
        oPerson = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nCnt, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }
    return oLeader;
}

// Returns the biggest group of people.
object GetBestGroupOfAllies()
{
    object oAlly = OBJECT_INVALID;
    // Sets counters.
    int nCountTotal, nCountOn, nCnt;
    nCountTotal = 0;
    nCnt = 1;
    // Nearest ally is got...
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTarget))
    {
        if(!GetObjectSeen(oTarget) && !GetObjectHeard(oTarget))
        {
            // Gets the average HD of everything around target, including the targets HD.
            // This is the best indication of power, and makes bosses not run off.
            int nCountOn = GetAverageHD(REPUTATION_TYPE_FRIEND, 20.0, oTarget, CREATURE_TYPE_IS_ALIVE, TRUE);
            // Sets the ally, if got lots of allies.
            if(nCountOn > nCountTotal)
            {
                oAlly = oTarget;
            }
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nCnt);
    }
    return oAlly;
}
// Area info. Used for the spell light. If any source or tiles are black, true.
int GetIsAreaDark()
{
    location lSelf = GetLocation(OBJECT_SELF);
    int iLight = GetTileMainLight1Color(lSelf);
    if(iLight == TILE_MAIN_LIGHT_COLOR_BLACK)
        return TRUE;
    iLight = GetTileMainLight2Color(lSelf);
    if(iLight == TILE_MAIN_LIGHT_COLOR_BLACK)
        return TRUE;
    iLight = GetTileSourceLight1Color(lSelf);
    if(iLight == TILE_MAIN_LIGHT_COLOR_BLACK)
        return TRUE;
    iLight = GetTileSourceLight2Color(lSelf);
    if(iLight == TILE_MAIN_LIGHT_COLOR_BLACK)
        return TRUE;
    return FALSE;
}
// Returns 1-4 for tiny-huge weapons. Used for disarm etc.
int GetWeaponSize(object oItem)
{
    int nBase = GetBaseItemType(oItem);
    if(nBase == 22 || nBase == 42 || nBase == 59)
        return 1;
    if(nBase == 0 || nBase == 7 || nBase == 9 || nBase == 14 || nBase == 31 ||
       nBase == 37 || nBase == 38 || nBase == 40 || nBase == 60 || nBase == 61 || nBase ==63)
        return 2;
    if(nBase == 1 || nBase == 2 || nBase == 3 || nBase == 4 || nBase == 5 ||
       nBase == 6 || nBase == 11 || nBase == 28 || nBase == 41 || nBase == 47 ||
        nBase == 51 || nBase == 53 || nBase == 56)
        return 3;
    if(nBase == 8 || nBase == 10 || nBase == 12 || nBase == 13 || nBase == 18 ||
       nBase == 32 || nBase == 33 || nBase == 35 || nBase == 50 || nBase == 55 ||
       nBase == 57 || nBase == 58 || nBase == 45)
        return 4;
    return 0;
}
// GetAverageHD - Basic 50.0 range. Can be allies as well.
int GetAverageHD(int iRep, float fRange, object oTarget, int iValue1, int Value1Para)
{
    int nCnt = 1;
    int TotalHD = 0;
    int TotalPeople = 0;
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, iRep, OBJECT_SELF, nCnt, iValue1, Value1Para);
    while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= fRange)
    {
        TotalHD += GetChallengeOf(oTarget);
        TotalPeople++;
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, iRep, OBJECT_SELF, nCnt, iValue1, Value1Para);
    }
    if(TotalHD == 0) TotalHD = 1;
    if(TotalPeople == 0) TotalPeople  = 1;
    int iAverageHD = TotalHD / TotalPeople;
    return iAverageHD;
}
// * Returns true if Target is a humanoid
int GetIsHumanoid(object oTarget, int Animal)
{
   int nRacial = GetRacialType(oTarget);
   if((GetIsPlayableRacialType(oTarget)) ||
      (nRacial == RACIAL_TYPE_HUMANOID_GOBLINOID) ||
      (nRacial == RACIAL_TYPE_HUMANOID_MONSTROUS) ||
      (nRacial == RACIAL_TYPE_HUMANOID_ORC) ||
      (nRacial == RACIAL_TYPE_HUMANOID_REPTILIAN) ||
      (Animal && nRacial == RACIAL_TYPE_ANIMAL))
   {    return TRUE;   }
   return FALSE;
}
// Get Has Effect
//  Checks to see if the target has a given
//  effect, usually from a spell. Really useful this is.
int jGetHasEffect(int nEffectType, object oTarget = OBJECT_SELF)
{
    effect eCheck = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eCheck))
    {
        if(GetEffectType(eCheck) == nEffectType)
        {
             return TRUE;
             break;
        }
        eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}
// TRUE if any effect is scared or turned.
int GetIsFrightened(object oTarget)
{
    effect eCheck = GetFirstEffect(oTarget);
    int iID;
    while(GetIsEffectValid(eCheck))
    {
        iID = GetEffectType(eCheck);
        if(iID == EFFECT_TYPE_TURNED || iID == EFFECT_TYPE_FRIGHTENED)
        {
             return TRUE;
             break;
        }
        eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}
// Return TRUE if target is enhanced with any spell that will disrupt some spellcasting
// for example - all mantals, FALSE otherwise.
int GetHasGreatEnhancement(object oTarget)
{
    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while (GetIsEffectValid(eCheck))
    {
        if (GetEffectSpellId(eCheck) != -1)
        {
        // Spells A-Z, good only.
        // Missed out cantrips, Also some others...need to check. Greaters are not in.
        // None of the shadow conjurations (I think they just use the normal spell sctrips)
            iSpellID = GetEffectSpellId(eCheck);
            if(iSpellID ==  SPELL_DEATH_WARD || iSpellID ==  SPELL_ENERGY_BUFFER ||
               iSpellID ==  SPELL_ETHEREAL_VISAGE || iSpellID ==  SPELL_GHOSTLY_VISAGE ||
               iSpellID ==  SPELL_GLOBE_OF_INVULNERABILITY || iSpellID ==  SPELL_SPELL_MANTLE ||
               iSpellID ==  SPELL_GREATER_SPELL_MANTLE || iSpellID ==  SPELL_LESSER_SPELL_MANTLE ||
               iSpellID ==  SPELL_MASS_HASTE || iSpellID ==  SPELL_MINOR_GLOBE_OF_INVULNERABILITY ||
               iSpellID ==  SPELL_NEGATIVE_ENERGY_PROTECTION || iSpellID ==  SPELL_PROTECTION_FROM_ELEMENTS ||
               iSpellID ==  SPELL_PROTECTION_FROM_SPELLS || iSpellID ==  SPELL_REGENERATE ||
               iSpellID ==  SPELL_RESIST_ELEMENTS || iSpellID == SPELL_SHADOW_SHIELD ||
               iSpellID ==  SPELL_SPELL_RESISTANCE)
                    return TRUE;
        }
        eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}
// Return TRUE if target is enhanced with a beneficial
// spell that can be dispelled (= from a spell script), FALSE otherwise.
int GetHasBeneficialEnhancement(object oTarget)
{
    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while(GetIsEffectValid(eCheck))
    {
        if (GetEffectSpellId(eCheck) != -1)
        {
        // Spells A-Z, good only.
        // Missed out cantrips, Also some others...need to check. Greaters are not in.
        // None of the shadow conjurations (I think they just use the normal spell sctrips)
            iSpellID = GetEffectSpellId(eCheck);
            if(iSpellID ==  SPELL_AID || iSpellID ==  SPELL_AURA_OF_VITALITY || // No awakan - thats for summons
               iSpellID ==  SPELL_BARKSKIN || iSpellID ==  SPELL_BLESS ||
               iSpellID ==  SPELL_BULLS_STRENGTH ||iSpellID ==  SPELL_CATS_GRACE ||
               iSpellID ==  SPELL_CLARITY || iSpellID ==  SPELL_DEATH_WARD ||
               iSpellID ==  SPELL_DIVINE_POWER || iSpellID ==  SPELL_EAGLE_SPLEDOR ||
               iSpellID ==  SPELL_ELEMENTAL_SHIELD || iSpellID ==  SPELL_ENDURE_ELEMENTS ||
               iSpellID ==  SPELL_ENERGY_BUFFER || iSpellID ==  SPELL_ETHEREAL_VISAGE ||
               iSpellID ==  SPELL_FREEDOM_OF_MOVEMENT ||
               iSpellID ==  SPELL_GHOSTLY_VISAGE || iSpellID ==  SPELL_GLOBE_OF_INVULNERABILITY ||
               iSpellID ==  SPELL_GREATER_SPELL_MANTLE || iSpellID ==  SPELL_GREATER_STONESKIN ||
               iSpellID ==  SPELL_HOLY_AURA || iSpellID ==  SPELL_LESSER_SPELL_MANTLE ||
               iSpellID ==  SPELL_MAGE_ARMOR || iSpellID ==  SPELL_MAGIC_CIRCLE_AGAINST_CHAOS ||
               iSpellID ==  SPELL_MAGIC_CIRCLE_AGAINST_EVIL || iSpellID ==  SPELL_MAGIC_CIRCLE_AGAINST_GOOD ||
               iSpellID ==  SPELL_MASS_HASTE || iSpellID ==  SPELL_MINOR_GLOBE_OF_INVULNERABILITY ||
               iSpellID ==  SPELL_NEGATIVE_ENERGY_PROTECTION || iSpellID ==  SPELL_PREMONITION ||
               iSpellID ==  SPELL_PROTECTION_FROM_ELEMENTS || iSpellID ==  SPELL_PROTECTION_FROM_EVIL ||
               iSpellID ==  SPELL_PROTECTION_FROM_GOOD || iSpellID ==  SPELL_PROTECTION_FROM_SPELLS ||
               iSpellID ==  SPELL_REGENERATE || iSpellID ==  SPELL_RESIST_ELEMENTS ||
               iSpellID ==  SPELL_SANCTUARY || iSpellID ==  SPELL_SEE_INVISIBILITY ||
               iSpellID ==  SPELL_SHADOW_SHIELD || iSpellID ==  SPELL_SHAPECHANGE ||
               iSpellID ==  SPELL_SPELL_MANTLE || iSpellID ==  SPELL_SPELL_RESISTANCE ||
               iSpellID ==  SPELL_STONESKIN || iSpellID ==  SPELL_TENSERS_TRANSFORMATION ||
               iSpellID ==  SPELL_TRUE_SEEING || iSpellID ==  SPELL_WAR_CRY)
            return TRUE;
        }
        eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}
// Returns TRUE if the target has any spell effect that can be targeted with
// any Spell breach. Breachs are pretty good.
int GetHasBeneficialBreach(object oTarget)
{
    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while (GetIsEffectValid(eCheck))
    {
        if (GetEffectSpellId(eCheck) != -1)
        {
        // Spells A-Z, ONLY ONES THAT ARE AFFECTED BY MIGHTY BREACH
        // Missed out cantrips and the lesser improved stats.
            iSpellID = GetEffectSpellId(eCheck);
            if(iSpellID ==  SPELL_ELEMENTAL_SHIELD ||  iSpellID ==  SPELL_ENDURE_ELEMENTS ||
               iSpellID ==  SPELL_ENERGY_BUFFER || iSpellID ==  SPELL_ETHEREAL_VISAGE ||
               iSpellID ==  SPELL_GHOSTLY_VISAGE ||iSpellID ==  SPELL_GLOBE_OF_INVULNERABILITY ||
               iSpellID ==  SPELL_GREATER_SPELL_MANTLE ||iSpellID ==  SPELL_GREATER_STONESKIN ||
               iSpellID ==  SPELL_LESSER_SPELL_MANTLE || iSpellID ==  SPELL_MAGE_ARMOR ||
               iSpellID ==  SPELL_MINOR_GLOBE_OF_INVULNERABILITY || iSpellID ==  SPELL_PREMONITION ||
               iSpellID ==  SPELL_PROTECTION_FROM_ELEMENTS || iSpellID ==  SPELL_RESIST_ELEMENTS ||
               iSpellID ==  SPELL_SPELL_MANTLE || iSpellID ==  SPELL_STONESKIN)
            return TRUE;
        }
        eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}
// This returns a number, 1-4. This number is the levels
// of spell they will be totally immune to.
int GetSpellLevelEffect(object oTarget)
{
    // Big globe affects 4 or lower spells
    if(GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY, oTarget))
        return 4;
    // Minor globe is 3 or under
    if(GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oTarget) ||
       GetHasSpellEffect(353, oTarget))// Shadow con version
        return 3;
    // 2 and under is ethereal visage.
    if(GetHasSpellEffect(SPELL_ETHEREAL_VISAGE, oTarget))
        return 2;
    // Ghostly Visarge affects 1 or 0 level spells, and any spell immunity.
    if(GetHasSpellEffect(SPELL_GHOSTLY_VISAGE, oTarget) ||
       GetHasSpellEffect(351, oTarget) || // Or shadow con version.
       jGetHasEffect(EFFECT_TYPE_SPELLLEVELABSORPTION, oTarget))
        return 1;
    return FALSE;
}
// Is the target always going to save against iSaveType
int SaveImmune(object oTarget, int iSaveType, int iSave, int iSaveDC, int iSpellLevel)
{
    if(iSaveType != 0)
    {
        switch(iSaveType)
        {
            case(SAVING_THROW_FORT):
            {
                // Basic one here. Some addition and comparison.
                if((iSave + 1) >= (iSaveDC + iSpellLevel)) return TRUE;
            }
            break;
            case(SAVING_THROW_REFLEX):
            {
                // Evasion - full damaged saved if the save is sucessful.
                if(GetHasFeat(FEAT_EVASION, oTarget) || GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
                {
                    if((iSave + 1) >= (iSaveDC + iSpellLevel)) return TRUE;
                }
            }
            break;
            case(SAVING_THROW_WILL):
            {
                if((iSave + 1) >= (iSaveDC + iSpellLevel))
                {
                    return TRUE;
                }
                // Slippery mind has a re-roll. We will take thier roll as 3, not 1.
                else if(GetHasFeat(FEAT_SLIPPERY_MIND, oTarget) && (iSave + 3) >= (iSaveDC + iSpellLevel))
                {
                    return TRUE;
                }
            }
            break;
        }
    }
    return FALSE;
}
// This checks targets spell resistance. If our level + 20 is below thier
// resistance, the spell won't affect them.
int SpellResistanceImmune(object oTarget, int nClassLevel)
{
    int iMyRoll = nClassLevel + 20;
    if(GetHasFeat(FEAT_DIAMOND_SOUL, oTarget))
    {       // Monk feat. 10 + level of monk.
        if(GetLevelByClass(CLASS_TYPE_MONK, oTarget) + 10 >= iMyRoll)
        {
            return TRUE;
        }
    }
    if(GetHasSpellEffect(SPELL_SPELL_RESISTANCE, oTarget))
    {       // 12 + cleric or druid levels (normally)
        if(GetLevelByClass(CLASS_TYPE_CLERIC, oTarget) + GetLevelByClass(CLASS_TYPE_DRUID, oTarget) + 12 >= iMyRoll)
        {
            return TRUE;
        }
    }
    int iMyAlignment = GetAlignmentGoodEvil(OBJECT_SELF);
    if(iMyAlignment != ALIGNMENT_NEUTRAL)
    {   // Alinment protection (highest) is a SR 25
        if(iMyAlignment == ALIGNMENT_GOOD)
        {
            if(GetHasSpellEffect(SPELL_UNHOLY_AURA))
            {
                if(25 >= iMyRoll) return TRUE;
            }
        }
        else if(iMyAlignment == ALIGNMENT_GOOD)
        {
            if(GetHasSpellEffect(SPELL_HOLY_AURA))
            {
                if(25 >= iMyRoll) return TRUE;
            }
        }
    }
    return FALSE;
}
// This returns any object to be the target of our spell.
object GetBestAreaSpellTarget(float fRange, float fSpread, int nLevel, int nClassLevel, int iSaveType, int iSaveDC, int nShape, int nFriendlyFire, int iDeathImmune, int iNecromanticSpell)
{
    object oGroupies;
    int iSave, iCountOnPerson, iMostOnPerson = 0;
    int nCnt = 1;
    // We will subtract all non-enemies within 5 challenge, upwards.
    int iMyToughness = GetChallengeOf(OBJECT_SELF);
    iMyToughness = iMyToughness - 5;
    // The target to return - set to invalid to start
    object oSpellTarget = OBJECT_INVALID;
    // We will use anything as a target!
    object oTarget = GetNearestObject(OBJECT_TYPE_ALL, OBJECT_SELF, nCnt);
    float fDistance = GetDistanceToObject(oTarget);
    location lTarget = GetLocation(oTarget);
    // Need to see the target, within nRange around self.
    while(GetIsObjectValid(oTarget) && fDistance <= fRange)
    {
        if((GetObjectSeen(oTarget) || GetObjectHeard(oTarget)) && fDistance >= 0.0)//Error = -1.0
        {
            // Will not fire on self, if it is too near.
            if(!(nFriendlyFire && fDistance < fSpread) || !nFriendlyFire)
            {
                lTarget = GetLocation(oTarget);
                // Must sue this - needs to use the correct shape
                // This only gets creatures in shape to check.
                oGroupies = GetFirstObjectInShape(nShape, fSpread, lTarget);
                // The person starts the spread at 0, because the object in shape will return the target as well.
                iCountOnPerson = 0;
                // If oGroupies is invalid, nothing. Should not - as target will be returned at least.
                while(GetIsObjectValid(oGroupies))
                {
                    if(!GetIsDead(oGroupies) && !GetPlotFlag(oGroupies))
                    {
                        if(iSaveType != FALSE)
                        {
                            // We will check the saves of the target. If immune, don't count add or substract.
                            if(iSaveType == SAVING_THROW_FORT){ iSave = GetFortitudeSavingThrow(oGroupies); }
                            else if(iSaveType == SAVING_THROW_REFLEX){ iSave = GetReflexSavingThrow(oGroupies); }
                            else if(iSaveType == SAVING_THROW_WILL){ iSave = GetWillSavingThrow(oGroupies); }
                        }
                        // Necromacy checks, death checks.
                        if((!GetIsNecromancyImmune(oGroupies) || !iNecromanticSpell) && (!GetIsDeathImmune(oGroupies) || !iDeathImmune))
                        {
                            if(!SpellResistanceImmune(oGroupies, nClassLevel) && !SaveImmune(oGroupies, iSaveType, iSave, iSaveDC, nLevel))
                            {
                                if(GetIsEnemy(oGroupies) && GetSpellLevelEffect(oGroupies) < nLevel)
                                {
                                    // Only add one if the person is an enemy, and the spell will affect them
                                    iCountOnPerson++;
                                }
                                // But else if friendly fire, we will subract similar non-allies.
                                else if(nFriendlyFire && (GetIsFriend(oGroupies) || GetFactionEqual(oGroupies)) && GetChallengeOf(oGroupies) >= iMyToughness && GetSpellLevelEffect(oGroupies) < nLevel)
                                {
                                    iCountOnPerson--;
                                }
                            }
                        }
                    }
                    oGroupies = GetNextObjectInShape(nShape, fSpread, lTarget);
                }
                // Make the spell target oTarget if so.
                if(iCountOnPerson > iMostOnPerson)
                {
                    iMostOnPerson = iCountOnPerson;
                    oSpellTarget = oTarget;
                }
            }
        }
        // Gets the next nearest.
        nCnt++;
        oTarget = GetNearestObject(OBJECT_TYPE_ALL, OBJECT_SELF, nCnt);
        fDistance = GetDistanceToObject(oTarget);
    }
    // Will OBJECT_INVALID, or the best target in range.
    return oSpellTarget;
}
// if any target within 8.0m and is a summoned, OR has a summon within  10.0 of the target.
object GetDismissalTarget()
{
    object oGroupies, oSpellTarget, oMaster;
    int iCountOnPerson, iMostOnPerson;
    int nCnt = 1;
    location lSelf = GetLocation(OBJECT_SELF);
    location lGroupie;
    // Need to see the target, within nRange around self.
    object oTarget = GetNearestObject(OBJECT_TYPE_ALL, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 8.0)
    {
        oMaster = GetMaster(oTarget);
        // If the target IS a summoned creature...
        if(GetIsEnemy(oTarget) && GetIsObjectValid(oMaster))
        {
            // Here is the summoned check
            if((GetAssociate(ASSOCIATE_TYPE_SUMMONED, oMaster) == oTarget ||
                GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster) == oTarget ||
                GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oMaster) == oTarget ))
                {  return oTarget;  }
        }
        lGroupie = GetLocation(oTarget);
        // Reset/Start counting the spread on oTarget (the spread of dismissal is 10.0)
        oGroupies = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, lGroupie);
        // If oGroupies is invalid, nothing.
        while(GetIsObjectValid(oGroupies))
        {
            // Only add one if the person is an enemy
            oMaster = GetMaster(oGroupies);
            if(GetIsEnemy(oGroupies) && GetIsObjectValid(oMaster))
            {
                if(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oMaster) == oGroupies ||
                   GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster) == oGroupies ||
                   GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oMaster) == oGroupies )
                   {  return oTarget;  }
            }
            oGroupies = GetNextObjectInShape(SHAPE_SPHERE, 10.0, lGroupie);
        }
        nCnt++;
        oTarget = GetNearestObject(OBJECT_TYPE_ALL, OBJECT_SELF, nCnt);
    }
    return OBJECT_INVALID;
}
/*::///////////////////////////////////////////////
//:: Name: Immune Checks
//::///////////////////////////////////////////////
    These return TRUE if the target will be immune,
    normally by a spell of effect.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/

// True if the target is immune to instant death.
// Got a spell which grants it, or got an effect that grants it.
int GetIsDeathImmune(object oTarget)
{
    // If the target has death ward, they are immune.
    if(GetHasSpellEffect(SPELL_DEATH_WARD, oTarget) ||
       GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH))
        return TRUE;
    return FALSE;
}
// Returns a value of TRUE if the target is immune to necromancy spells
// Also should check the level of spell...seperatly.
int GetIsNecromancyImmune(object oTarget)
{
    if(GetHasSpellEffect(160, oTarget))
        return TRUE;
    return FALSE;
}

void SortSpellImmunities(object oTarget)
{
    effect eCheck = GetFirstEffect(oTarget);
    int iType;
    while(GetIsEffectValid(eCheck))
    {
        iType = GetEffectType(eCheck);
        if(iType == EFFECT_TYPE_TURNED || iType == EFFECT_TYPE_FRIGHTENED)
        {
            ImmuneFear = TRUE;
        }
        else if(iType == EFFECT_TYPE_STUNNED)
        {
            ImmuneStun = TRUE;
        }
        else if(iType == EFFECT_TYPE_SLEEP)
        {
            ImmuneSleep = TRUE;
        }
        else if(iType == EFFECT_TYPE_POISON)
        {
            ImmunePoison = TRUE;
        }
        else if(iType == EFFECT_TYPE_PARALYZE)
        {
            ImmuneStun = TRUE;
        }
        else if(iType == EFFECT_TYPE_NEGATIVELEVEL)
        {
            ImmuneNegativeLevel = TRUE;
        }
        else if(iType == EFFECT_TYPE_ENTANGLE)
        {
            ImmuneEntangle = TRUE;
        }
        else if(iType == EFFECT_TYPE_DOMINATED || iType == EFFECT_TYPE_CHARMED)
        {
            ImmuneMind = TRUE;
        }
        else if(iType == EFFECT_TYPE_CONFUSED)
        {
            ImmuneConfusion = TRUE;
        }
        else if(iType == EFFECT_TYPE_DISEASE)
        {
            ImmuneDisease = TRUE;
        }
        else if(iType == EFFECT_TYPE_CURSE)
        {
            ImmuneCurse = TRUE;
        }
        else if(iType == EFFECT_TYPE_BLINDNESS)
        {
            ImmuneBlind = TRUE;
        }
        eCheck = GetNextEffect(oTarget);
    }
    if(!ImmuneDeath)
    {
        // If the target has death ward, they are immune.
        if(GetHasSpellEffect(SPELL_DEATH_WARD, oTarget)
        || GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH))
            ImmuneDeath = TRUE;
    }
    if(!ImmuneConfusion && GetIsImmune(oTarget, IMMUNITY_TYPE_CONFUSED))
        ImmuneConfusion = TRUE;
    if(!ImmuneNegativeLevel && GetIsImmune(oTarget, IMMUNITY_TYPE_NEGATIVE_LEVEL))
        ImmuneNegativeLevel = TRUE;
    // Spells that stop negative energy spells:
    // Shadow Shield - Negative energy
    // Negative energy protection
    if(!ImmuneNegativeEnergy && (GetHasSpellEffect(SPELL_SHADOW_SHIELD, oTarget) ||
       GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget)))
        ImmuneNegativeEnergy = TRUE;
    // Spells that stop necromanctic spells:
    // Shadow Shield - All necromancy
    // not sure what else
    if(!ImmuneNecromancy && GetHasSpellEffect(160, oTarget))
        ImmuneNecromancy = TRUE;
    // MIND IMMUNITIES
    int iRace = GetRacialType(oTarget);
    if(!ImmuneMind && (GetHasFeat(FEAT_EMPTY_BODY, oTarget) || iRace == RACIAL_TYPE_UNDEAD ||
       iRace == RACIAL_TYPE_DRAGON || iRace == RACIAL_TYPE_CONSTRUCT ||
        // Protections from other, Clarity, Mind Blank...
       GetHasSpellEffect(SPELL_CLARITY, oTarget) ||
       GetHasSpellEffect(SPELL_MIND_BLANK, oTarget) ||
       GetHasSpellEffect(SPELL_LESSER_MIND_BLANK, oTarget)))
        ImmuneMind = TRUE;
    if(!ImmuneMind)
    {
        int nAlignSelf = GetAlignmentGoodEvil(OBJECT_SELF);
        // Protections from Good...
        if(nAlignSelf = ALIGNMENT_GOOD)
        {
           if(GetHasSpellEffect(SPELL_UNHOLY_AURA, oTarget) ||
              GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_GOOD, oTarget) ||
              GetHasSpellEffect(SPELL_PROTECTION_FROM_GOOD, oTarget))
                ImmuneMind = TRUE;
        }
        // Protections from Evil...
        else if(nAlignSelf = ALIGNMENT_EVIL)
        {
           if(GetHasSpellEffect(SPELL_HOLY_AURA, oTarget) ||
              GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL, oTarget) ||
              GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, oTarget))
                ImmuneMind = TRUE;
        }
    }
    // They are immune (even ourselves) if we are already frightened!
    if(!ImmuneFear && (
        // Will be immune if a cirtain race, or got those 2 feats.
        iRace == RACIAL_TYPE_CONSTRUCT || iRace == RACIAL_TYPE_DRAGON ||
        iRace == RACIAL_TYPE_UNDEAD || iRace == RACIAL_TYPE_OUTSIDER ||
        GetHasFeat(FEAT_AURA_OF_COURAGE, oTarget) ||
        GetHasFeat(FEAT_RESIST_NATURES_LURE, oTarget) ||
        GetIsImmune(oTarget, IMMUNITY_TYPE_FEAR)))
        ImmuneFear = TRUE;
    // This stops curses.
    if(!ImmuneCurse && GetIsImmune(oTarget, IMMUNITY_TYPE_CURSED))
        ImmuneCurse = TRUE;
    // This stops poison.
    if(!ImmunePoison && GetIsImmune(oTarget, IMMUNITY_TYPE_POISON))
        ImmunePoison = TRUE;
    // Stun
    if(!ImmuneStun && GetIsImmune(oTarget, IMMUNITY_TYPE_STUN) ||
        GetIsImmune(oTarget, IMMUNITY_TYPE_PARALYSIS ))
        ImmuneStun = TRUE;
    // This stops entanglement.
    if(!ImmuneEntangle && (GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) ||
       GetIsImmune(oTarget, IMMUNITY_TYPE_ENTANGLE)))
        ImmuneEntangle = TRUE;
    if(!ImmuneSleep && (GetHasFeat(FEAT_IMMUNITY_TO_SLEEP, oTarget) ||
       GetIsImmune(oTarget, IMMUNITY_TYPE_SLEEP)))
        ImmuneSleep = TRUE;
    if((!ImmunePoison || !ImmuneDisease) && (GetHasFeat(FEAT_VENOM_IMMUNITY, oTarget) ||
         GetHasFeat(FEAT_DIAMOND_BODY, oTarget)))
    {
        ImmunePoison = TRUE;
        ImmuneDisease = TRUE;
    }
    if(!ImmuneDomination)
    {
        if(GetIsObjectValid(GetMaster(oTarget)) ||
           GetIsImmune(oTarget, IMMUNITY_TYPE_DOMINATE) ||
           GetIsImmune(oTarget, IMMUNITY_TYPE_CHARM))
            ImmuneDomination = TRUE;
    }
}
int GetIsFearImmune(object oTarget)
{
    // If us, are we fearless? (used in morale checks).
    if(oTarget == OBJECT_SELF)
    {
        if(jGetSpawnInCondition(FEARLESS))
            return TRUE;
    }
    int iRace = GetRacialType(oTarget);
    if( // Will be immune if a cirtain race, or got those 2 feats.
        iRace == RACIAL_TYPE_CONSTRUCT || iRace == RACIAL_TYPE_DRAGON ||
        iRace == RACIAL_TYPE_UNDEAD || iRace == RACIAL_TYPE_OUTSIDER ||
        GetHasFeat(FEAT_AURA_OF_COURAGE, oTarget) ||
        GetHasFeat(FEAT_RESIST_NATURES_LURE, oTarget) ||
        GetIsImmune(oTarget, IMMUNITY_TYPE_FEAR))
    {
        return TRUE;
    }
    return FALSE;
}
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// ACTIONS ///////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
/*

 - Special Checks
 - Healing Self, Cure Condition, Heal Allies, Return To Starting Posistion
 - Spell Triggers, Teleport
 - Summon Familiar/Companion
 - Flee
 - LeaderActions
 - AttemptShoutToAllies
 - GoForTheKill
 - AbilityAura
 - ArcherRetreat
 - UseTurning
 - jTalentBardSong
 - jTalentDragonCombat
 - ConcentrationCheck
 - ImportAllSpells, ImportCantripSpells
 - UseSpecialSkills
 - CastCombatHostileSpells, PolyMorph
 - jTalentMeleeAttack

*/
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// ACTIONS ///////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
/*::///////////////////////////////////////////////
//:: Name: Special Checks
//::///////////////////////////////////////////////
    This will check for darkness, AOE spells,
    time stop stored, and a few other things.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int SpecialChecks(int nClass)
{
    // Delete stored ints if not in time stop.
    if(!iInTimeStop) DeleteTimeStopStored();
    // If we are fleeing, we will not stop!
    object oMoveTo = GetLocalObject(OBJECT_SELF, "AI_TO_FLEE");
    if(GetIsObjectValid(oMoveTo) && !GetIsDead(oMoveTo) && !GetIsInCombat(oMoveTo))
    {
        if(GetDistanceToObject(oMoveTo) > 9.0)
        {
            ClearAllActions();
            DebugActionSpeak("Moving to the 'Flee' [Ally] " + GetName(oMoveTo));
            ActionMoveToObject(oMoveTo, TRUE);
            return TRUE;
        }
    }
    if(GetHasSpellEffect(SPELL_DARKNESS) && !GetHasSpellEffect(SPELL_DARKVISION))
    {
        int iValidHeard = GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, CREATURE_TYPE_IS_ALIVE, TRUE));
        // Ultravision
        if(CastPotionSpellAtObject(SPELL_DARKVISION, 10)) return TRUE;
        // If we are a rubbish fightingclass OR we cannot hear any enemy to attack...move or something.
        if(nClass == CLASS_TYPE_WIZARD || nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_FEY || !iValidHeard)
        {
            // Dispell it - trying nearest creature, if has darkness as well
            object oCreature = GetNearestCreature(CREATURE_TYPE_HAS_SPELL_EFFECT, SPELL_DARKNESS);
            location lSelf;
            if(GetIsObjectValid(oCreature))
            {
                vector vTarget = GetPosition(oCreature);
                vector vSource = GetPosition(OBJECT_SELF);
                vector vDirection = vTarget - vSource;
                float fDistance = VectorMagnitude(vDirection) / 10.0f;// Nearer self
                vector vPoint = VectorNormalize(vDirection) * fDistance + vSource;
                lSelf = Location(GetArea(OBJECT_SELF), vPoint, GetFacing(OBJECT_SELF));
            }
            else
            {
                lSelf = GetLocation(OBJECT_SELF);
            }
            if(CastNoPotionSpellAtLocation(SPELL_MORDENKAINENS_DISJUNCTION, 11, lSelf)) return TRUE;
            if(CastNoPotionSpellAtLocation(SPELL_GREATER_DISPELLING, 2, lSelf)) return TRUE;
            if(CastNoPotionSpellAtLocation(SPELL_DISPEL_MAGIC, 2, lSelf)) return TRUE;
            if(CastNoPotionSpellAtLocation(SPELL_LESSER_DISPEL, 11, lSelf)) return TRUE;
            ClearAllActions();
            DebugActionSpeak("Moving out of the darkness effect");
            ActionMoveAwayFromLocation(lSelf, TRUE, 5.0);
            return TRUE;
        }
    }
    object oDarkness = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_HAS_SPELL_EFFECT, SPELL_DARKNESS);
    if(GetIsObjectValid(oDarkness) && ((GetDistanceToObject(oDarkness) < 20.0 && GetDistanceToObject(oDarkness) >= 0.0) || !GetIsObjectValid(jGetNearestSeenOrHeardEnemy())))
    {
        if(CastPotionSpellAtObject(SPELL_DARKVISION, 10)) return TRUE;
    }

    // If we have a previously set invisible enemy
    if(GetLocalInt(OBJECT_SELF, "AI_ENEMY_INVIS"))
    {
        if(CastPotionSpellAtObject(SPELL_TRUE_SEEING, 6)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_INVISIBILITY_PURGE, 6)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_SEE_INVISIBILITY, 7)) return TRUE;
    }
    // AOE spells
    // Top ones are dangerous for anyone...
    // Now got elemental prot. checks. Runs if else...
    object oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT);
    int iEnemy = GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN));
    int iElemental = HasElementalProtections();
    int iHD = GetHitDice(OBJECT_SELF);
    int iCurrentHP = GetCurrentHitPoints();
    if(GetIsObjectValid(oAOE))
    {
        // I am guessing that the AOE is the size it is intended. 6.5 M though - so it will help allies, and us moving around.
        float fDistance = GetDistanceToObject(oAOE);
        if((jGetNumberOfMeleeAttackers() < (iHD / 4) || GetAverageHD(REPUTATION_TYPE_ENEMY, 2.0) < iHD || !iEnemy)
            && fDistance < 8.5 && fDistance >= 0.0)
        {
            location lAOE = GetLocation(oAOE);
            if((GetHasSpellEffect(SPELL_ACID_FOG) && (!iElemental || !iEnemy))||
               (GetHasSpellEffect(SPELL_INCENDIARY_CLOUD) && (!iElemental || !iEnemy)) ||
               (GetHasSpellEffect(SPELL_CREEPING_DOOM) && !iEnemy) ||
               (GetHasSpellEffect(SPELL_MIND_FOG) && (iHD < 17 || !iEnemy)) ||
               (GetHasSpellEffect(SPELL_WALL_OF_FIRE) && (!iElemental || !iEnemy)) ||
               (GetHasSpellEffect(SPELL_CLOUDKILL) && (!iElemental || !iEnemy)) ||
               (GetHasSpellEffect(SPELL_STINKING_CLOUD) && (!iElemental || !iEnemy)) ||
               (GetHasSpellEffect(SPELL_WEB) && (iHD < 6 || !iEnemy)) ||
               (GetHasSpellEffect(SPELL_GREASE) && (iHD < 6 || !iEnemy)))
            {
                // Dispell it - trying nearest creature, if has darkness as well
                if(GetIsEnemy(GetAreaOfEffectCreator(oAOE)))
                {
                    if(CastNoPotionSpellAtLocation(SPELL_MORDENKAINENS_DISJUNCTION, 11, lAOE)) return TRUE;
                    if(CastNoPotionSpellAtLocation(SPELL_GREATER_DISPELLING, 2, lAOE)) return TRUE;
                    if(CastNoPotionSpellAtLocation(SPELL_DISPEL_MAGIC, 2, lAOE)) return TRUE;
                    if(CastNoPotionSpellAtLocation(SPELL_LESSER_DISPEL, 11, lAOE)) return TRUE;
                }
                // RUN!!!! If too close.
                ClearAllActions();
                DebugActionSpeak("Moving away from an AOE spell [AOE (probably)] " + GetName(oAOE));
                ActionMoveAwayFromLocation(lAOE, TRUE, 6.0);
                return TRUE;
            }
        }
    }
    return FALSE;
}

/*::///////////////////////////////////////////////
//:: Name: jTalentHealingSelf
//::///////////////////////////////////////////////
    Uses the best it can.
    1. If it is heal, they need to be under half HP and under 40 HP
    2. If not, it has to be under half HP and not be heal/mass heal
    3. Testing to see if harm will be cast by undead
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//:://///////////////////////////////////////////*/
int jTalentHealingSelf(int iPercent, int iMyHD, int iThierHD, object oEnemy, int iMeleeAttackers, int iRubbishAsWell)
{
    int iCurrent = GetCurrentHitPoints(OBJECT_SELF);
    int iBase = GetMaxHitPoints(OBJECT_SELF);
    int iBeBelow =  (iBase / 100) * iPercent;
    // If current is under the multiplyer * max.
    if(iCurrent < iBeBelow)
    {
        int iRace = GetRacialType(OBJECT_SELF);

        if(iRace != RACIAL_TYPE_UNDEAD && iRace != RACIAL_TYPE_CONSTRUCT)
        {
            // If we can heal self with feats...use them! No AOO
            if(GetHasFeat(FEAT_WHOLENESS_OF_BODY) && iBeBelow < iMyHD * 2)
            {
                if(UseFeatOnObject(FEAT_WHOLENESS_OF_BODY)) return TRUE;
            }
            if(GetHasFeat(FEAT_LAY_ON_HANDS))
            {
                // This does the actual formula...note, putting ones to stop DIVIDE BY ZERO errors
                int nChr = GetAbilityModifier(ABILITY_CHARISMA);
                    if(nChr < 1) nChr = 1;
                int nLevel = GetLevelByClass(CLASS_TYPE_PALADIN);
                    if(nLevel < 1) nLevel = 1;
                //Caluclate the amount needed to be at, to use.
                int nHeal = nLevel * nChr;
                if(nHeal <= 0) nHeal = 1;
                if(iCurrent < nHeal)
                {
                    if(UseFeatOnObject(FEAT_LAY_ON_HANDS)) return TRUE;
                }
            }
            // Note: Feat Lesser Bodily Adjustment uses cure light wounds spell script.
            // Odd classes mean no potions.
            int iPotions = TRUE;
            if(iRace == RACIAL_TYPE_ABERRATION ||
            iRace == RACIAL_TYPE_BEAST || iRace == RACIAL_TYPE_ELEMENTAL ||
            iRace == RACIAL_TYPE_VERMIN || iRace == RACIAL_TYPE_MAGICAL_BEAST ||
            iRace == RACIAL_TYPE_DRAGON || iRace == RACIAL_TYPE_ANIMAL)
                iPotions = FALSE;

            // Lets see if we can use a healing kit! Only a valid race (as potions)
            if(iPotions && KitsAvalible)
            {
                object oHealingKit = GetBestHealingKit();
                if(GetIsObjectValid(oHealingKit) && GetSkillRank(SKILL_HEAL) >= (iMyHD/3))
                {
                    ClearAllActions();
                    DebugActionSpeak("Healing self with healing kit, [Kit] " + GetName(oHealingKit) + " [Enemy] " + GetName(oEnemy));
                    ActionUseSkill(SKILL_HEAL, OBJECT_SELF, 0, oHealingKit);
                    if(GetDistanceToObject(oEnemy) < 4.0 && GetDistanceToObject(oEnemy) >= 0.0)
                    {
                        ActionAttack(oEnemy);
                    }
                    return TRUE;
                }
            }
            // Define the talents, if not undead (normal healing)
            int iTouchSpell, iPotionSpell, iAreaSpell, iValidPotion, iValidSpell, iValidArea;
            int iTouchRank, iPotionRank, iAreaRank, iTouchHealing, iPotionHealing, iAreaHealing;
            talent tTouchUseBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20);
                iValidSpell = GetIsTalentValid(tTouchUseBest);
                if(iValidSpell)
                {
                    iTouchSpell = GetIdFromTalent(tTouchUseBest);
                    iTouchRank = ReturnHealingInfo(iTouchSpell);
                }
            talent tPotionUseBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_POTION, 20);
                iValidPotion = GetIsTalentValid(tPotionUseBest);
                if(iValidPotion)
                {
                    iPotionSpell = GetIdFromTalent(tPotionUseBest);
                    iPotionRank = ReturnHealingInfo(iPotionSpell);
                }
            talent tAreaUseBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_AREAEFFECT, 20);
                iValidArea = GetIsTalentValid(tAreaUseBest);
                if(iValidArea)
                {
                    iAreaSpell = GetIdFromTalent(tAreaUseBest);
                    iAreaRank = ReturnHealingInfo(iAreaSpell);
                }
            if(iValidPotion || iValidArea || iValidSpell)
            {
                // If we are under 40 HP OR under 35 percent of our base HP...use HEAL
                if(iCurrent < 40 || iCurrent < ((iBase / 100) * 35))
                {
                    if(iValidPotion && iPotions && iPotionSpell == SPELL_HEAL)
                    {
                        if(CastSpellTalentAtObject(tPotionUseBest)) return TRUE;
                    }
                    if(iValidSpell && iTouchSpell == SPELL_HEAL)
                    {
                        if(CastSpellTalentAtObject(tTouchUseBest)) return TRUE;
                    }
                    if(iValidArea && iAreaSpell == SPELL_MASS_HEAL)
                    {
                        if(CastSpellTalentAtObject(tAreaUseBest)) return TRUE;
                    }
                }
                // Else, another talent - IE critical wounds and under.
                talent tTalentToUse;
                int iDamageNeededToBeDone, iRank = 0;
                // Determine what to use...
                // First - if we have the best potion, use it, as it needs no concentration. (thus >= not >)
                if(iPotionRank >= iAreaRank && iPotionRank >= iTouchSpell)
                {
                    tTalentToUse = tPotionUseBest;
                    iRank = iPotionRank;
                    iDamageNeededToBeDone = ReturnHealingInfo(iPotionSpell, TRUE);
                }
                // Only area one is healing circle anyway...
                else if(iAreaRank > iPotionRank && iAreaRank > iTouchRank)
                {
                    tTalentToUse = tAreaUseBest;
                    iRank = iAreaRank;
                    iDamageNeededToBeDone = ReturnHealingInfo(iAreaSpell, TRUE);
                }
                // Else, this is best, or should be.
                else if(iTouchRank > iPotionRank && iTouchRank > iAreaRank)
                {
                    tTalentToUse = tTouchUseBest;
                    iRank = iTouchRank;
                    iDamageNeededToBeDone = ReturnHealingInfo(iTouchSpell, TRUE);
                }
                if(GetIsTalentValid(tTalentToUse))
                {
                    // If the current HP is under the damage that is healed.
                    if(iCurrent <= iBase - iDamageNeededToBeDone)
                    {
                        // Level check. Our HD must be a suitble amount, or no melee attackers.
                        if(iRank - iMyHD >= -5 || iRank >= 16 || iRubbishAsWell || (iMeleeAttackers < 1 && iRank - iMyHD >= -10))
                        {
                            if(CastSpellTalentAtObject(tTalentToUse)) return TRUE;
                        }
                    }
                }
                // Create a potion if we are cheating, 1/4 chance.
                if(iCurrent * 3 < iBase)
                {
                    if(iPotions && jGetSpawnInCondition(CHEAT_MORE_POTIONS) && d4() == 1 && iRank < 16)
                    {
                        if(!GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF, "nw_it_mpotion003")))
                        {
                            CreateItemOnObject("nw_it_mpotion003");
                            if(jTalentHealingSelf(99, iMyHD, iThierHD, oEnemy, iMeleeAttackers, iRubbishAsWell)) return TRUE;
                        }
                    }
                }
            }
        }
        else if(iRace == RACIAL_TYPE_UNDEAD)
        {
            // Undead can cast harm on themselves, of course...
            if(GetHasSpell(SPELL_HARM) && (iCurrent < 40 || iCurrent < ((iBase / 100) * 35)))
                if(CastSpellNormalAtObject(SPELL_HARM)) return TRUE;
            // Negative energy burst can be cast at a location
            if(GetHasSpell(SPELL_NEGATIVE_ENERGY_BURST) && iCurrent < ((iBase / 100) * 50))
                if(CastNoPotionSpellAtLocation(SPELL_NEGATIVE_ENERGY_BURST, 1, GetLocation(OBJECT_SELF))) return TRUE;
        }
    }
    return FALSE;
}

/*::///////////////////////////////////////////////
//:: Name: TalentHealingCleric
//::///////////////////////////////////////////////
    RUNS THROUGH POSSIBLE CLERICAL SPONTANEOUS CASTING
  Will use a healing spell (cheating) while decrementing another.
  that is, when it is added.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int TalentHealingCleric()
{
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name: jTalentCureCondition
//::///////////////////////////////////////////////
    This checks the status (and if we can cast curing spells)
    and cure conditons of allies, in range, or out of battle.
//::///////////////////////////////////////////////
//:: Created By: Bioware Modified (a lot) by: Jasperre
//::////////////////////////////////////////////*/
int jTalentCureCondition(int iAlly, int iInt)
{
    // Are we clever enough to even cast helpful spells?
    if(iAlly && iInt >= 2)
    {
        // We will check if we can use anything first!
        int iGRestoreSpell = GetIsSpellValid(SPELL_GREATER_RESTORATION, 7);
            // Removes: nAbility, nCurse, nFear, nSlow, nClarity, nParalsis, nDrained, nPoison, nDisease, nBlindDeaf,
        int iRestoreSpell = GetIsSpellValid(SPELL_RESTORATION, 7);
            // Removes: nAbility, nDrained, nParalsis, nBlindDeaf
        int iLRestoreSpell = GetIsSpellValid(SPELL_LESSER_RESTORATION, 7);
            // Removes: nAbility
        int iFreedomSpell = GetIsSpellValid(SPELL_FREEDOM_OF_MOVEMENT, 9);
            // Removes: nFreedom, nParalsis, nSlow
        int iNeutPoisonSpell = GetIsSpellValid(SPELL_NEUTRALIZE_POISON, 7);
            // Removes: nPoison
        int iDiseaseSpell = GetIsSpellValid(SPELL_REMOVE_DISEASE, 7);
            // Removes: nDisease
        int iCurseSpell = GetIsSpellValid(SPELL_REMOVE_CURSE, 7);
            // Removes: nCurse
        int iFearSpell = GetIsSpellValid(SPELL_REMOVE_FEAR, 6);
            // Removes: nFear
        int iParalsisSpell = GetIsSpellValid(SPELL_REMOVE_PARALYSIS, 7);
            // Removes: nParalsis
        int iBlindDeathSpell = GetIsSpellValid(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, 6);
            // Removes: nBlindDeaf
        int iClaritySpell = GetIsSpellValid(SPELL_CLARITY, 7);
            // Removes: nClarity, nSleep
        int iMindBlankSpell = GetIsSpellValid(SPELL_MIND_BLANK, 9);
            // Removes: nClarity, nSleep, nSlow
        if(iGRestoreSpell || iRestoreSpell || iLRestoreSpell || iFreedomSpell || iNeutPoisonSpell ||
           iDiseaseSpell || iCurseSpell || iFearSpell || iParalsisSpell || iBlindDeathSpell || iClaritySpell || iMindBlankSpell)
        {
            // Setup all constants. Only if we can actually cast anything! (check above)
            int nCurse, nPoison, nDisease, nAbility, nParalsis, nSlow, nDrained, nBlindDeaf, nFreedom, nFear, nClarity, nDominated, nSleep;
            int nType; // Constant for effect type
            int nTotalGRestore, nTotalRestore, nTotalFreedom; // Counts for restore and greater and freedom, which have multiple.
            effect eEffect;
            location lSelf = GetLocation(OBJECT_SELF);
            // Using this, until I can make it work on myself then nearest creatures, which should be better.
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lSelf, TRUE);
            while(GetIsObjectValid(oTarget))
            {
                if(GetIsFriend(oTarget) && GetObjectSeen(oTarget))
                {
                    eEffect = GetFirstEffect(oTarget);
                    while(GetIsEffectValid(eEffect))
                    {
                        // We will only get magically applied effects. Important also because I
                        // have implimented "random stats", so creatures may have decreased (extraodiary)
                        // effects.
                        if(GetEffectSubType(eEffect) == SUBTYPE_MAGICAL)
                        {
                            nType = GetEffectType(eEffect);

                            if(nType == EFFECT_TYPE_DISEASE)
                            {
                                nDisease = 1;
                            }
                            else if(nType == EFFECT_TYPE_FRIGHTENED)
                            {
                                nFear = 1;
                            }
                            else if(nType == EFFECT_TYPE_POISON)
                            {
                                nPoison = 1;
                            }
                            else if(nType == EFFECT_TYPE_CURSE)
                            {
                                nCurse = 1;
                            }
                            else if(nType == EFFECT_TYPE_NEGATIVELEVEL)
                            {
                                nDrained = 1;
                            }
                            else if(nType == EFFECT_TYPE_ABILITY_DECREASE ||
                                    nType == EFFECT_TYPE_AC_DECREASE ||
                                    nType == EFFECT_TYPE_ATTACK_DECREASE ||
                                    nType == EFFECT_TYPE_DAMAGE_DECREASE ||
                                    nType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                                    nType == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                                    nType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                                    nType == EFFECT_TYPE_SKILL_DECREASE)
                            {
                                nAbility = 1;
                            }
                            else if(nType == EFFECT_TYPE_PARALYZE)
                            {
                                nParalsis = 1;
                            }
                            else if(nType == EFFECT_TYPE_SLOW)
                            {
                                nSlow = 1;
                            }
                            else if(nType == EFFECT_TYPE_BLINDNESS || nType == EFFECT_TYPE_DEAF)
                            {
                                nBlindDeaf = 1;
                            }
                            else if(nType == EFFECT_TYPE_ENTANGLE ||
                                    nType == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
                            {
                                nFreedom = 1;
                            }
                            else if(nType == EFFECT_TYPE_DAZED ||
                                    nType == EFFECT_TYPE_CHARMED ||
                                    nType == EFFECT_TYPE_CONFUSED ||
                                    nType == EFFECT_TYPE_STUNNED)
                            {
                                nClarity = 1;
                            }
                            else if(nType == EFFECT_TYPE_SLEEP)
                            {
                                nSleep = 1;
                            }
                            else if(nType == EFFECT_TYPE_DOMINATED)
                            {
                                nDominated = 1;
                            }
                        }
                        eEffect = GetNextEffect(oTarget);
                    }
                }
                // If we have some bad effects on the target... (any are not 0)
                if(nDisease || nFear  || nPoison || nCurse || nDrained || nDisease || nAbility ||
                   nParalsis || nSlow || nBlindDeaf || nFreedom || nClarity || nSleep || nDominated)
                {
                    // Removes: nFear (remove fear)
                    if(nFear && iFearSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_REMOVE_FEAR, 6, oTarget)) return TRUE;
                    }
                    // Removes: nAbility, nCurse, nFear, nSlow, nClarity, nParalsis, nDrained, nPoison, nDisease, nBlindDeaf, nDominated
                    // If total is high, we will use it! 5+ (greater restoration)
                    nTotalGRestore = nAbility + nCurse + nFear + nSlow + nClarity + nParalsis + nDrained + nPoison + nDisease + nBlindDeaf + nDominated;
                    if((nTotalGRestore >= 5 || nDominated) && iGRestoreSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_GREATER_RESTORATION, 7, oTarget)) return TRUE;
                    }
                    // Removes: nAbility, nDrained, nParalsis, nBlindDeaf (normal restoration)
                    // Total needs to be 2+
                    nTotalRestore = nAbility + nParalsis + nDrained + nBlindDeaf;
                    if(nTotalRestore >= 2 && iRestoreSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_RESTORATION, 7, oTarget)) return TRUE;
                    }
                    // Removes: nFreedom, nParalsis, nSlow
                    nTotalFreedom = nSlow + nFreedom + nParalsis;
                    if((nTotalFreedom >= 2 || nFreedom) && iFreedomSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_FREEDOM_OF_MOVEMENT, 9, oTarget)) return TRUE;
                    }
                    // Removes: nParalsis (remove paralysis)
                    if(nParalsis && iParalsisSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_REMOVE_PARALYSIS, 7, oTarget)) return TRUE;
                    }
                    // Removes: nClarity, nSleep, nSlow (mind blank)
                    // Removes: nAbility (lesser restoration)
                    if(nAbility && iLRestoreSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_LESSER_RESTORATION, 7, oTarget)) return TRUE;
                    }
                    // Removes: nClarity, nSleep (clarity)
                    if(((nClarity || nSleep) && !((nClarity || nSleep) && nSlow && iMindBlankSpell)) && iClaritySpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_CLARITY, 7, oTarget)) return TRUE;
                    }
                    // Removes: nClarity, nSleep, nSlow (mind blank)
                    if((nClarity || nSleep || nSlow) && iMindBlankSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_MIND_BLANK, 9, oTarget)) return TRUE;
                    }
                    // Freedom again - slow (mind blank) paralsis (remove paralsis) have not been cured
                    if(nTotalFreedom >= 1 + iFreedomSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_FREEDOM_OF_MOVEMENT, 9, oTarget)) return TRUE;
                    }
                    // Removes: nBlindDeaf (remove blindness/deafness)
                    if(nBlindDeaf && iBlindDeathSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, 6, oTarget)) return TRUE;
                    }
                    // Total needs to be 2+ (greater restoration)
                    if(nTotalGRestore >= 2 && iGRestoreSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_GREATER_RESTORATION, 7, oTarget)) return TRUE;
                    }
                    // Total needs to be 1+
                    nTotalRestore = nAbility + nParalsis + nDrained + nBlindDeaf;
                    if(nTotalRestore >= 1 && iRestoreSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_RESTORATION, 7, oTarget)) return TRUE;
                    }
                    // Removes: nDisease (remove diease)
                    if(nDisease && iDiseaseSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_REMOVE_DISEASE, 7, oTarget)) return TRUE;
                    }
                    // Removes: nPoison (and also nDisease!) (neutrlise poison)
                    if(nPoison || nDisease && iNeutPoisonSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_NEUTRALIZE_POISON, 7, oTarget)) return TRUE;
                    }
                    // Removes: nCurse (remove curse)
                    if(nCurse && iCurseSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_REMOVE_CURSE, 7, oTarget)) return TRUE;
                    }
                    // Total needs to be 1+ (greater restoration) Final one.
                    if(nTotalGRestore >= 1 && iGRestoreSpell)
                    {
                        if(CastPotionSpellAtObject(SPELL_GREATER_RESTORATION, 7, oTarget)) return TRUE;
                    }
                }
                // Reset everything...
                nCurse = 0; nPoison = 0; nDisease = 0; nAbility = 0; nParalsis = 0; nSlow = 0;
                nDrained = 0; nBlindDeaf = 0; nFreedom = 0; nFear = 0; nDominated = 0; nSleep = 0;
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lSelf);
            }
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name: RunHealingOnObject
//::///////////////////////////////////////////////
    This will heal the target, if they are under the percent
    and we can, of course. Used in TalentHeal
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//:://///////////////////////////////////////////*/
int RunHealingOnObject(object oTarget, int iMyHD, int iRubbishAsWell, int iPercent, int iMeleeAttackers)
{
    int iCurrent = GetCurrentHitPoints(oTarget);
    int iBase = GetMaxHitPoints(oTarget);
    // Default to 60%, if invalid percent.
    if(iPercent <= 0 || iPercent >= 100){ iPercent == 60; }
    // Under 60% (or stated value) is minimum damage needed to be done.
    if(iCurrent < (iBase / 100) * iPercent)
    {
        if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {                                   // Set time stop to ON just in case...
            if(CastNoPotionSpellAtObject(SPELL_HARM, 3, oTarget)) return TRUE;
            if(CastNoPotionSpellAtLocation(SPELL_NEGATIVE_ENERGY_BURST, 1, GetLocation(oTarget))) return TRUE;
            if(CastNoPotionSpellAtObject(SPELL_NEGATIVE_ENERGY_RAY, 2, oTarget)) return TRUE;
        }
        else
        {
            // Define the talents, if not undead (normal healing).
            // Cannot use items defined above - we have to look for spells as well.
            int iTouchSpell, iAreaSpell, iValidSpell, iValidArea;
            int iTouchRank, iAreaRank, iTouchHealing, iAreaHealing;
            talent tTouchUseBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20);
            iValidSpell = GetIsTalentValid(tTouchUseBest);
            if(iValidSpell)
            {
                iTouchSpell = GetIdFromTalent(tTouchUseBest);
                iTouchRank = ReturnHealingInfo(iTouchSpell);
            }
            talent tAreaUseBest = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_AREAEFFECT, 20);
            iValidArea = GetIsTalentValid(tAreaUseBest);
            if(iValidArea)
            {
                iAreaSpell = GetIdFromTalent(tAreaUseBest);
                iAreaRank = ReturnHealingInfo(iAreaSpell);
            }
            // We will use heals first, if under 35% or 40 HP
            if(iCurrent < 40 || iCurrent < ((iBase / 100) * 35))
            {
                if(iValidSpell && iTouchSpell == SPELL_HEAL)
                {
                    if(CastSpellTalentAtObject(tTouchUseBest, oTarget)) return TRUE;
                }
                if(iValidArea && iAreaSpell == SPELL_MASS_HEAL)
                {
                    if(CastSpellTalentAtObject(tAreaUseBest, oTarget)) return TRUE;
                }
            }
            // Else, another talent - IE critical wounds and under.
            talent tTalentToUse;
            int iDamageNeededToBeDone, iRank = 0;
            // Determine what to use...
            // Only area one is healing circle anyway...
            if(iAreaRank > iTouchRank)
            {
                tTalentToUse = tAreaUseBest;
                iDamageNeededToBeDone = ReturnHealingInfo(iAreaSpell, TRUE);
            }
            // Else, this is best, or should be.
            else if(iTouchRank > iAreaRank)
            {
                tTalentToUse = tTouchUseBest;
                iRank = iAreaRank;
                iDamageNeededToBeDone = ReturnHealingInfo(iTouchSpell, TRUE);
            }
            if(GetIsTalentValid(tTalentToUse))
            {
                // If the current HP is under the damage that is healed.
                if(iCurrent <= iBase - iDamageNeededToBeDone)
                {
                    // Level check. Our HD must be a suitble amount, or no melee attackers.
                    if(iRank - iMyHD >= -5 || iRubbishAsWell || iRank >= 16 || iMeleeAttackers < 1 || GetCurrentHitPoints() >= 100)
                    {
                        if(CastSpellTalentAtObject(tTalentToUse, oTarget)) return TRUE;
                    }
                }
            }
        }
    }
    return FALSE;
}


/*::///////////////////////////////////////////////
//:: Name: TalentHeal
//::///////////////////////////////////////////////
  HEAL ALL ALLIES
    Only if they are in sight, and are under a percent%. Always nearest...
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int jTalentHeal(int iHasAlly, object oLeader, int iMyHD, int iMeleeAttackers, int iRubbishAsWell)
{
    if(jGetSpawnInCondition(WILL_RAISE_ALLIES_IN_BATTLE))
    {
        if(GetIsDead(oLeader) && oLeader != OBJECT_SELF)
        {
            if(CastNoPotionSpellAtObject(SPELL_RESURRECTION, 7, oLeader)) return TRUE;
            if(CastNoPotionSpellAtObject(SPELL_RAISE_DEAD, 7, oLeader)) return TRUE;
        }
        object oDeath = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, FALSE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        if(GetIsObjectValid(oDeath))
        {
            if(GetIsDead(oDeath))
            {
                if(CastNoPotionSpellAtObject(SPELL_RESURRECTION, 7, oDeath)) return TRUE;
                if(CastNoPotionSpellAtObject(SPELL_RAISE_DEAD, 7, oDeath)) return TRUE;
            }
        }
    }
    if(iHasAlly)
    {
        int iAllyRace = GetRacialType(oLeader);
        if(GetIsObjectValid(oLeader) && oLeader != OBJECT_SELF && iAllyRace != RACIAL_TYPE_CONSTRUCT)
        {
            if(GetDistanceToObject(oLeader) >= 0.0 && (GetDistanceToObject(oLeader) < 30.0 || (iRubbishAsWell && GetDistanceToObject(oLeader) < 50.0)))
            {
                if(GetCurrentHitPoints(oLeader) * 2 < GetMaxHitPoints(oLeader))
                {
                    if(RunHealingOnObject(oLeader, iMyHD, iRubbishAsWell, 100, iMeleeAttackers)) return TRUE;
                }
            }
        }
        // We need a seen ally,  within 20.0 M.
        object oTarget = GetFactionMostDamagedMember(OBJECT_SELF, TRUE);
        if(GetIsObjectValid(oTarget) && oTarget != OBJECT_SELF && GetDistanceToObject(oTarget) >= 0.0 && (GetDistanceToObject(oTarget) < 20.0 || (iRubbishAsWell && GetDistanceToObject(oTarget) < 40.0)))
        {
            iAllyRace = GetRacialType(oTarget);
            // Will not cast on constructs.
            if(iAllyRace != RACIAL_TYPE_CONSTRUCT && !GetIsDead(oTarget))
            {
                int iPercent = GetLocalInt(OBJECT_SELF, "AI_HEALING_ALLIES_PERCENT");
                if(RunHealingOnObject(oTarget, iMyHD, iRubbishAsWell, iPercent, iMeleeAttackers)) return TRUE;
            }
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name: ReturnToStartingPlace
//::///////////////////////////////////////////////
    This will make us return to our starting place, if we are set to.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int ReturnToStartingPlace()
{
    if(jGetSpawnInCondition(RETURN_TO_SPAWN_LOCATION))
    {
        location lMoveTo = GetLocalLocation(OBJECT_SELF, "AI_RETURN_TO_POINT");
        float fDistance = GetDistanceBetweenLocations(lMoveTo, GetLocation(OBJECT_SELF));
        if(fDistance > 5.0 && fDistance >= 0.0)
        {
            ClearAllActions();
            DebugActionSpeak("Returning to spawn location");
            ActionMoveToLocation(lMoveTo);
            return TRUE;
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name: SpellTriggersActivate
//::///////////////////////////////////////////////
    If the spawn is set up to, this releases some spells,
    which are based on wizard OR sorceror levels.

    Can be set to happen more than once, of course.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int SpellTriggersActivate()
{
    int iSpellTriggers = GetLocalInt(OBJECT_SELF, "AI_SPELL_TRIGGERS");
    if(iSpellTriggers > 0)// We need at least one in the local integer to continue.
    {
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD);
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER);
        if(iWizard > 0 || iSorcerer > 0)
        {
            int iUse;
            // This is a special stored number, for the first we release.
            int iUsedFirst = GetLocalInt(OBJECT_SELF, "AI_FIRST_SPELL_TRIGGER_USED");
            // Set our highest spellcaster.
            if(iWizard >= iSorcerer)
            { iUse = iWizard; } else { iUse = iSorcerer; }
            int iSpellTriggerUseCount = GetLocalInt(OBJECT_SELF, "ROUNDS_UNTIL_SPELL_TRIGGER_RELEASE");
            // Set the next use to up one.
            iSpellTriggerUseCount = (iSpellTriggerUseCount - 1);
            SetLocalInt(OBJECT_SELF, "ROUNDS_UNTIL_SPELL_TRIGGER_RELEASE", iSpellTriggerUseCount);
            int iPhysicalProtections = HasStoneskinProtections();
            int iMantals = HasMantalProtections();
            if(!iUsedFirst || ((iSpellTriggerUseCount <= 0 && (!iPhysicalProtections || !iMantals)) || ((GetCurrentHitPoints() * 2 < GetMaxHitPoints()) && (!iPhysicalProtections || !iMantals))))
            {
                SpeakString("--Spell Trigger Released--");
                // Set so we have used at least 1.
                SetLocalInt(OBJECT_SELF, "AI_FIRST_SPELL_TRIGGER_USED", TRUE);
                ClearAllActions();
                // Set so we don't get killed when doing this - as it is meant to happen whenever.
                int iAlreadyPlot = GetPlotFlag();
                if(!iAlreadyPlot)
                    SetPlotFlag(OBJECT_SELF, TRUE);
                // Sets the lowest spells.
                int iGlobe, iHaste, iMantal;
                int iPhysical = SPELL_MAGE_ARMOR;
                int iElemental = SPELL_ENDURE_ELEMENTS;
                if(iUse >= 3)// Level 2 spells.
                {
                    iElemental = SPELL_RESIST_ELEMENTS;
                    if(iUse >= 5)// Level 3
                    {
                        iHaste = SPELL_HASTE;
                        iElemental = SPELL_PROTECTION_FROM_ELEMENTS;
                        if(iUse >= 7)// Level 4
                        {
                            iGlobe = SPELL_MINOR_GLOBE_OF_INVULNERABILITY;
                            iPhysical = SPELL_STONESKIN;
                            if(iUse >= 9)// Level 5
                            {
                                iElemental = SPELL_ENERGY_BUFFER;
                                iMantal = SPELL_LESSER_SPELL_MANTLE;
                                ActionCastSpellAtObject(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                                if(iUse >= 11)// Level 6
                                {
                                    iHaste = SPELL_MASS_HASTE;
                                    iGlobe = SPELL_GLOBE_OF_INVULNERABILITY;
                                    iPhysical = SPELL_GREATER_STONESKIN;
                                    if(iUse >= 13)// Level 7
                                    {
                                        iMantal = SPELL_SPELL_MANTLE;
                                        if(iUse >= 15)// Level 8
                                        {
                                            iPhysical = SPELL_PREMONITION;
                                            if(iUse >= 17)// Level 9
                                            {
                                                iMantal = SPELL_GREATER_SPELL_MANTLE;
                                            }
                                        }
                                    }
                                }
                                ActionCastSpellAtObject(iMantal, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                            }
                            ActionCastSpellAtObject(iGlobe, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                        }
                        ActionCastSpellAtObject(iHaste, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                    }
                }
                ActionCastSpellAtObject(iPhysical, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                ActionCastSpellAtObject(iElemental, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                // We have used up one of the triggers.
                iSpellTriggers = iSpellTriggers - 1;
                SetLocalInt(OBJECT_SELF, "AI_SPELL_TRIGGERS", iSpellTriggers);

                // Set the next use to 6 (7 - 1) rounds for a check.
                iSpellTriggerUseCount = 7;
                SetLocalInt(OBJECT_SELF, "ROUNDS_UNTIL_SPELL_TRIGGER_RELEASE", iSpellTriggerUseCount);
                DebugActionSpeak("Spell Tiggers released");
                // This SHOULD make us stop for 2 seconds, then carry on attacking.
                SetCommandable(FALSE);
                DelayCommand(2.0, SetCommandable(TRUE));
                // Reset plot flag, then lower the times we can do it.
                if(!iAlreadyPlot)
                    DelayCommand(2.4, SetPlotFlag(OBJECT_SELF, FALSE));
                DelayCommand(2.6, ExecuteScript("nw_c2_default3", OBJECT_SELF));
                return TRUE;
            }
        }
    }
    return FALSE;
}

/*::///////////////////////////////////////////////
//:: Name: Teleport
//::///////////////////////////////////////////////
    If the spawn is set up to, this will teleport the
    person, either to a waypoint with no enemies in 15M or
    an ally of the same status.

    As I am not sure about vectors, I am not putting in locations
    other than the above.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int Teleport(int iHitDice, int iMeleeEnemy)
{
    int iTeleport = GetLocalInt(OBJECT_SELF, "AI_ABILITY_TO_TELEPORT");
    if(iTeleport > 0 && ((iMeleeEnemy > 1 && iTeleport > 3) || iMeleeEnemy > 2))
    {
        int iAlreadyPlot = GetPlotFlag();
        if(!iAlreadyPlot)
            SetPlotFlag(OBJECT_SELF, TRUE);
        object oEnemy, oUse;
        int nCnt = 1;
        string sFirstPart = "TELEPORT_" + GetTag(OBJECT_SELF) + "_";
        object oWaypoint = GetWaypointByTag(sFirstPart + IntToString(nCnt));
        // A little loop though the waypoints, if any.
        while (GetIsObjectValid(oWaypoint))
        {
            oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oWaypoint, 1, CREATURE_TYPE_IS_ALIVE, TRUE);
            if(GetDistanceBetween(oEnemy, oWaypoint) > 15.0)
            {
                oUse = oWaypoint;
                break;
            }
            nCnt++;
            oWaypoint = GetWaypointByTag(sFirstPart + IntToString(nCnt));
        }
        location lNewPlace;
        effect eTeleport = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
        // If we have a valid waypoint, gets it location
        if(GetIsObjectValid(oUse))
        {
            lNewPlace = GetLocation(oUse);
        }
        else // Else now check ally
        {
            object oAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE);
            nCnt = 1;
            while(GetIsObjectValid(oAlly))
            {
                // Checks by enemy around the ally.
                oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oAlly, 1, CREATURE_TYPE_IS_ALIVE, TRUE);
                if(GetDistanceBetween(oEnemy, oAlly) > 15.0)
                {
                    oUse = oAlly;
                    break;
                }
            }
            // If we now have a valid ally (the nearest, by the way, because of the break) use it
            if(GetIsObjectValid(oAlly))
            {
                lNewPlace = GetLocation(oAlly);
            }
            else
            // Else stop, and return false.
            {
                return FALSE;
            }
        }
        DebugActionSpeak("Teleporting to a new place");
        // If not returned false, then teleport!
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eTeleport, GetLocation(OBJECT_SELF));
        ActionCastFakeSpellAtObject(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, OBJECT_SELF);
        SetCommandable(FALSE);
        DelayCommand(1.5, ActionJumpToLocation(lNewPlace));
        DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eTeleport, lNewPlace));
        DelayCommand(2.0, SetCommandable(TRUE));
        DelayCommand(2.5, ExecuteScript("nw_c2_default3", OBJECT_SELF));
        // Reset plot flag, then lower the times we can do it.
        if(!iAlreadyPlot)
            DelayCommand(3.0, SetPlotFlag(OBJECT_SELF, FALSE));
        iTeleport--;
        SetLocalInt(OBJECT_SELF, "AI_ABILITY_TO_TELEPORT", iTeleport);
        return TRUE;
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name: DoSummonFamiliar
//::///////////////////////////////////////////////
    This will, if it can, summon a familiar, or
    animal companion, and if set to want to.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int DoSummonFamiliar()
{
    if(jGetSpawnInCondition(SUMMON_FAMILIAR))
    {
        if(GetHasFeat(FEAT_SUMMON_FAMILIAR) && !GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR)))
        {
            ClearAllActions();
            DebugActionSpeak("Summoning my familiar");
            ActionUseFeat(FEAT_SUMMON_FAMILIAR, OBJECT_SELF);
            DelayCommand(1.5, ExecuteScript("nw_c2_default3", OBJECT_SELF));
            return TRUE;
        }
        else if(GetHasFeat(FEAT_ANIMAL_COMPANION) && !GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION)))
        {
            ClearAllActions();
            DebugActionSpeak("Summoning my animal companion");
            ActionUseFeat(FEAT_ANIMAL_COMPANION, OBJECT_SELF);
            DelayCommand(1.5, ExecuteScript("nw_c2_default3", OBJECT_SELF));
            return TRUE;
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name Flee
//::///////////////////////////////////////////////
    Makes checks, and may flee.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//:: Created On: 21/01/03
//::////////////////////////////////////////////*/
int Flee(object oEnemy, int iInt, int iEnemyAverageHD, int iMyCR, int iLeaderBonus)
{
    // Will never flee if the enemy is not that strong
    int iFleeDelay = GetLocalInt(OBJECT_SELF, "AI_FLEE_DELAY");
    int iMorale = GetLocalInt(OBJECT_SELF, "AI_MORALE");
    // Note: if morale is under 0, we always flee (unless immune)
    if((iMyCR < (iEnemyAverageHD - 2) || iMorale < 0) && !GetIsFearImmune())
    {
        if(jGetSpawnInCondition(NEVER_FIGHT_IMPOSSIBLE_ODDS) || jGetSpawnInCondition(GROUP_LEADER))
        {
            if(iMyCR < iEnemyAverageHD - 8)
            {
                object oBestGroupedAllies = GetBestGroupOfAllies();
                if(GetIsObjectValid(oBestGroupedAllies) && GetDistanceToObject(oBestGroupedAllies) > 10.0)
                {
                    ClearAllActions();
                    PlayVoiceChat(VOICE_CHAT_FLEE);
                    string sFleeImpossible = GetLocalString(OBJECT_SELF, "AI_TALK_ON_MORALE_BREAK");
                    if(sFleeImpossible != ""){ SpeakString(sFleeImpossible); }
                    else if(GetIsHumanoid(OBJECT_SELF)){ SpeakString("I must flee!"); }
                    // Set it so we will not return for a bit.
                    SetLocalObject(OBJECT_SELF, "AI_TO_FLEE", oBestGroupedAllies);
                    // If we are a leader, we will make everyone run!
                    if(jGetSpawnInCondition(GROUP_LEADER)) SpeakString("LEADER_FLEE_NOW", TALKVOLUME_SILENT_TALK);
                    DebugActionSpeak("Moving to my best group of allies - overwhelming odds. [Ally]" + GetName(oBestGroupedAllies));
                    ActionMoveToObject(oBestGroupedAllies, TRUE, 2.0);
                    return TRUE;
                }
            }
        }
        if(iMorale < 0)// If we are set to always flee.
        {
            string sFleeNoMorale = GetLocalString(OBJECT_SELF, "AI_TALK_ON_STUPID_RUN");
            if(sFleeNoMorale != ""){ SpeakString(sFleeNoMorale); }
            else if(GetIsHumanoid(OBJECT_SELF)){ SpeakString("Flee! Flee!"); }
            ClearAllActions();
            DebugActionSpeak("No Morale So Fleeing [Enemy] " + GetName(oEnemy));
            ActionMoveAwayFromObject(oEnemy, TRUE);
            SetCommandable(FALSE);
            DelayCommand(10.0, SetCommandable(TRUE));
            return TRUE;
        }
        else if(iFleeDelay >= 3) // Else, only a chance of fleeing (on a timer...toimprove performance)
        {
            // Quite a big save - 10 + Thier toughness - my toughness. Depends though.
            int nSave = 20 + (iEnemyAverageHD - iMyCR);
            // Apply leader and morale bonuses.
            nSave -= (iMorale + iLeaderBonus);
            if(nSave > 0)
            {
                if(!WillSave(OBJECT_SELF, nSave, SAVING_THROW_TYPE_FEAR, oEnemy))
                {   // If we fail the will save, VS fear...
                    object oBestGroupedAllies = GetBestGroupOfAllies();
                    if(GetIsObjectValid(oBestGroupedAllies) && GetDistanceToObject(oBestGroupedAllies) > 10.0)
                    {
                        ClearAllActions();
                        PlayVoiceChat(VOICE_CHAT_FLEE);
                        string sFleeBreak = GetLocalString(OBJECT_SELF, "AI_TALK_ON_MORALE_BREAK");
                        if(sFleeBreak != ""){ SpeakString(sFleeBreak); }
                        else if(GetIsHumanoid(OBJECT_SELF)){ SpeakString("I must flee!"); }
                        // Set it so we will not return for a bit.
                        SetLocalObject(OBJECT_SELF, "AI_TO_FLEE", oBestGroupedAllies);
                        DebugActionSpeak("Moving to best allies group - failed save. [Ally] " + GetName(oBestGroupedAllies) + " [Enemy] " + GetName(oEnemy));
                        ActionMoveToObject(oBestGroupedAllies, TRUE, 2.0);
                        SetLocalInt(OBJECT_SELF, "AI_FLEE_DELAY", 0);
                        return TRUE;
                    }
                    else
                    {
                        // If we have enough intelligence, we will fight because there is no where to run!
                        if(iInt >= 4)
                        {
                            string sFleeCannotRun = GetLocalString(OBJECT_SELF, "AI_TALK_ON_CANNOT_RUN");
                            if(sFleeCannotRun != ""){ SpeakString(sFleeCannotRun); }
                            else if(GetIsHumanoid(OBJECT_SELF)){ SpeakString("Stand and Fight! I am not going to flee!"); }
                            SetLocalInt(OBJECT_SELF, "AI_FLEE_DELAY", 0);
                            return FALSE;
                        }
                        // Else we are dumb, and run off...
                        else
                        {
                            ClearAllActions();
                            PlayVoiceChat(VOICE_CHAT_FLEE);
                            string sFleeStupid = GetLocalString(OBJECT_SELF, "AI_TALK_ON_STUPID_RUN");
                            if(sFleeStupid != ""){ SpeakString(sFleeStupid); }
                            else if(GetIsHumanoid(OBJECT_SELF)){ SpeakString("Help! Flee!"); }
                            DebugActionSpeak("Stupid moving from enemies - Failed save against fear. [Enemy] " + GetName(oEnemy));
                            ActionMoveAwayFromObject(oEnemy, TRUE);
                            SetCommandable(FALSE);
                            DelayCommand(10.0, SetCommandable(TRUE));
                            SetLocalInt(OBJECT_SELF, "AI_FLEE_DELAY", 0);
                            return TRUE;
                        }
                    }
                }
            }
        }
    }
    // Add one to the flee delay to set.
    iFleeDelay++;
    SetLocalInt(OBJECT_SELF, "AI_FLEE_DELAY", iFleeDelay);
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name TalentFlee
//::///////////////////////////////////////////////
    Makes the person move away from the nearest enemy, or the defined target.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//:: Created On: 13/01/03
//:://///////////////////////////////////////////*/
int FleeFrom(object oIntruder, float fDistance)
{
    object oTarget = oIntruder;
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = GetLastHostileActor();
        if(!GetIsObjectValid(oTarget) || GetIsDead(oTarget))
        {
            oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
            if(!GetIsObjectValid(oTarget))
            {
                return FALSE;
            }
        }
    }
    if(d4() == 1) PlayVoiceChat(VOICE_CHAT_FLEE);
    ClearAllActions();
    DebugActionSpeak("Stupid moving from enemies - We are a commoner. [Enemy] " + GetName(oTarget));
    ActionMoveAwayFromObject(oTarget, TRUE, fDistance);
    return TRUE;
}
/*::///////////////////////////////////////////////
//:: Name: GoForTheKill
//::///////////////////////////////////////////////
    Very basic at the moment. This will, if thier inteligence is
    high and they can be hit relitivly easily, and at low HP
    will attack in combat. May add some spells, if I can be bothered.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int GoForTheKill(object oTarget, int iInt, int iPCHP, float fEnemyDistance, int iMeleeEnemy, int iMyBAB)
{
    if(iInt >= 8)
    {
        // Finnish off a dead PC, or dying one, out of combat.
        if(!GetIsObjectValid(oTarget))
        {
            object oDeadPC = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, FALSE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
            if(GetIsObjectValid(oDeadPC) && GetIsDead(oDeadPC))
            {
                if(GetCurrentHitPoints(oDeadPC) > -10)
                {
                    ClearAllActions();
                    DebugActionSpeak("Attacking a PC who is dying [Enemy]" + GetName(oTarget));
                    jEquipAppropriateWeapons(oTarget, iInt);
                    ActionAttack(oTarget);
                    return TRUE;
                }
            }
        }
        // If the target enemy is of low HP...
        else if(iPCHP < (2 + Random(4) + GetAbilityModifier(ABILITY_STRENGTH)) && ((iPCHP * 2) < GetMaxHitPoints(oTarget)) && GetMaxHitPoints(oTarget) > 20)
        {
            // Melee spells and attacking.
            if(fEnemyDistance < 2.0 && fEnemyDistance >= 0.0)
            {
                // We will equip and attack for the kill
                if(GetAC(oTarget) < iMyBAB + Random(5) + 5)
                {
                    ClearAllActions();
                    DebugActionSpeak("Attacking Low HP enemy [Enemy]" + GetName(oTarget));
                    jEquipAppropriateWeapons(oTarget, iInt);
                    ActionAttack(oTarget);
                    return TRUE;
                }
            }
            else
            {
                // If there are any melee enemy, althoug they are at range...attack
                if(GetAC(oTarget) < iMyBAB + 10)
                {
                    ClearAllActions();
                    DebugActionSpeak("A ranged attack at the enemy, on low HP [Enemy]" + GetName(oTarget));
                    jEquipAppropriateWeapons(oTarget, iInt);
                    ActionAttack(oTarget);
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name: AbilityAura
//::///////////////////////////////////////////////
    Should cast them all. All instantly applied.
    This talent category returns the Rage's as well...pretty odd, but oh well.
    Also, wholeness of body.

    This replaces persistant talant usage - as that included rage's
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int AbilityAura()
{
    if(GetIsTalentValid(GetCreatureTalentBest(TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 20)))
    {
        if(CastSpellNormalAtObject(SPELLABILITY_MUMMY_BOLSTER_UNDEAD)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_WHOLENESS_OF_BODY)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_DRAGON_FEAR)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_UNEARTHLY_VISAGE)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_OF_COURAGE)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_PROTECTION)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_FEAR)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_UNNATURAL)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_BLINDING)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_STUN)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_FIRE)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_COLD)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_ELECTRICITY)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_UNNATURAL)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_AURA_FEAR)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_TYRANT_FOG_MIST)) return TRUE;
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name LeaderActions
//::///////////////////////////////////////////////
    This will make the leader "command" allies. Moving
    one to get others, orshout attack my target.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
void LeaderActions(object oEnemy, int iEnemyHD, int iMyHD, int iHasAlly, object oAlly, int iBAB)
{
    if(jGetSpawnInCondition(GROUP_LEADER))
    {
        int iAlliedHD = GetAverageHD(REPUTATION_TYPE_FRIEND);
        if(iEnemyHD > iAlliedHD + 5)
        {
            if(iHasAlly && !GetLocalInt(OBJECT_SELF, "AI_SENT_RUNNER"))
            {
                object oBestAllies = GetBestGroupOfAllies();
                if(GetIsObjectValid(oBestAllies)) // Send a runner...
                {
                    string sRunner = GetLocalString(OBJECT_SELF, "AI_TALK_ON_LEADER_SEND_RUNNER");
                    if(sRunner != "") SpeakString(sRunner);
                    AssignCommand(oAlly, ClearAllActions());
                    AssignCommand(oAlly, ActionMoveToObject(oBestAllies, TRUE));
                    SetCommandable(FALSE, oAlly);
                    SetLocalObject(oAlly, "AI_TO_ATTACK", oEnemy);
                    SetLocalObject(oAlly, "AI_TO_FLEE", oBestAllies);
                    AssignCommand(oAlly, SetCommandable(TRUE));
                    AssignCommand(oAlly, ActionSpeakString("HELP_MY_FRIEND", TALKVOLUME_SILENT_TALK));
                    SetLocalInt(OBJECT_SELF, "AI_SENT_RUNNER", TRUE);
                }
            }
        }
        int iLeaderCountForShout = GetLocalInt(OBJECT_SELF, "AI_LEADER_SHOUT_COUNT");
        iLeaderCountForShout++;
        SetLocalInt(OBJECT_SELF, "AI_LEADER_SHOUT_COUNT", iLeaderCountForShout);
        if(iLeaderCountForShout > 4)
        {
            if(GetHitDice(oEnemy) - 5 > iEnemyHD)
            {
                string sAttackTarget = GetLocalString(OBJECT_SELF, "AI_TALK_ON_LEADER_ATTACK_TARGET");
                if(sAttackTarget != "") SpeakString(sAttackTarget);
                PlayVoiceChat(VOICE_CHAT_ATTACK);
            }
        }
    }
}
/*::///////////////////////////////////////////////
//:: Name CountCreatures
//::///////////////////////////////////////////////
    Counts creatures, and checks for invisible enemies.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
void CountCreatures()
{
    int iAlliesCount, iEnemiesCount, iTotalCount;
    location lSelf = GetLocation(OBJECT_SELF);
    object oCreature = GetFirstObjectInShape(SHAPE_SPHERE, 50.0, lSelf, TRUE);
    while(GetIsObjectValid(oCreature))
    {
        // Add one to running total - to set in array.
        iTotalCount++;
        SetLocalObject(OBJECT_SELF, "AI_CREATURES_IN_SIGHT_" + IntToString(iTotalCount), oCreature);
        // If it is a friend, add one.
        if(GetIsFriend(oCreature))
        {
            iAlliesCount++;
        }
        else if(GetIsEnemy(oCreature))
        {
            iEnemiesCount++;
        }
        oCreature = GetNextObjectInShape(SHAPE_SPHERE, 50.0, lSelf, TRUE);
    }
    // Set things to use later...
    SetLocalInt(OBJECT_SELF, "AI_CREATURES_IN_SIGHT_TOTAL", iTotalCount);
    SetLocalInt(OBJECT_SELF, "AI_ALLIES_COUNT", iAlliesCount);
    SetLocalInt(OBJECT_SELF, "AI_ENEMY_COUNT", iEnemiesCount);
    // We will check if we need to use "See invisibility" type spells.
    int iCount = 1;
    int iBreakInvis;
    // Enemy check - invisibility.
    oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCount, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN);
    while(GetIsObjectValid(oCreature) && iBreakInvis != TRUE)
    {
        // This time, if they ARE in LOS, it is a not seen but heard enemy that must be invis.
        if(ObjectIsInLOS(oCreature))
        {
            iBreakInvis = TRUE;
        }
        iCount++;
        oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCount, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN);
    }
    SetLocalInt(OBJECT_SELF, "AI_ENEMY_INVIS", iBreakInvis);
}
// This is used in conjunction with:
int ObjectIsInLOS(object oCreature)
{
    int iReturn = FALSE;
    if(GetIsObjectValid(oCreature))
    {
        int iAmount = 1;
        int iMax = GetLocalInt(OBJECT_SELF, "AI_CREATURES_IN_SIGHT_TOTAL");
        object oCheck = GetLocalObject(OBJECT_SELF, "AI_CREATURES_IN_SIGHT_" + IntToString(iAmount));
        while(iAmount <= iMax && iReturn != TRUE)
        {
            if(GetIsObjectValid(oCreature))
            {
                // If it is the one we are looking for, break out of loop and return TRUE not false
                if(oCreature == oCheck)
                {
                    iReturn = TRUE;
                }
            }
            iAmount++;
            oCheck = GetLocalObject(OBJECT_SELF, "AI_CREATURES_IN_SIGHT_" + IntToString(iAmount));
        }
    }
    return iReturn;
}

/*::///////////////////////////////////////////////
//:: Name ArcherRetreat
//::///////////////////////////////////////////////
    If we are defined as an archer, and don't have
    point blank shot, we will back up if allies are near
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int ArcherRetreat(int iHasAlly, float fAllyRange, object oEnemy, float fEnemyRange)
{
    // Many conditions - IE valid ranged, no point blank shot, range, ally range, ETC.
    if(jGetSpawnInCondition(ARCHER_ATTACKING) && fEnemyRange < 5.0 && iHasAlly
            && GetIsObjectValid(GetLocalObject(OBJECT_SELF, "DW_RANGED")))
    {
        if(fAllyRange < 5.0 && !GetHasFeat(FEAT_POINT_BLANK_SHOT))
        {
            if(GetIsObjectValid(GetLocalObject(OBJECT_SELF, "DW_RANGED")))
            {
                ClearAllActions();
                DebugActionSpeak("Archer Retreating back from the enemy [Enemy]" + GetName(oEnemy));
                ActionMoveAwayFromObject(oEnemy, TRUE, 15.0);
                SetCommandable(FALSE);
                DelayCommand(5.0, SetCommandable(TRUE));
                return TRUE;
            }
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name UseTurning
//::///////////////////////////////////////////////
    This, if we have the feat, will turn things it can.
    Need to really make sure it works well, and maybe
    make an interval between one and another.
//::///////////////////////////////////////////////
//:: Created By: Bioware. Edited by Jasperre.
//::////////////////////////////////////////////*/
int UseTurning()
{
    if(GetHasFeat(FEAT_TURN_UNDEAD))
    {
        int nCount;
        object oUndead = jGetNearestSeenOrHeardEnemy();
        int nHD = GetHitDice(oUndead);
        if(jGetHasEffect(EFFECT_TYPE_TURNED, oUndead) || GetHitDice(OBJECT_SELF) <= nHD)
        {
            return FALSE;
        }
        int nElemental = GetHasFeat(FEAT_AIR_DOMAIN_POWER) + GetHasFeat(FEAT_EARTH_DOMAIN_POWER) + GetHasFeat(FEAT_FIRE_DOMAIN_POWER) + GetHasFeat(FEAT_FIRE_DOMAIN_POWER);
        int nVermin = GetHasFeat(FEAT_PLANT_DOMAIN_POWER) + GetHasFeat(FEAT_ANIMAL_COMPANION);
        int nConstructs = GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER);
        int nOutsider = GetHasFeat(FEAT_GOOD_DOMAIN_POWER) + GetHasFeat(FEAT_EVIL_DOMAIN_POWER);

        if(nElemental == TRUE)
        {
            nCount += jGetRacialTypeCount(RACIAL_TYPE_ELEMENTAL);
        }
        if(nVermin == TRUE)
        {
            nCount += jGetRacialTypeCount(RACIAL_TYPE_VERMIN);
        }
        if(nOutsider == TRUE)
        {
            nCount += jGetRacialTypeCount(RACIAL_TYPE_OUTSIDER);
        }
        if(nConstructs == TRUE)
        {
            nCount += jGetRacialTypeCount(RACIAL_TYPE_CONSTRUCT);
        }
        nCount += jGetRacialTypeCount(RACIAL_TYPE_UNDEAD);
        // If we have any targets, do it!
        if(nCount > 0)
        {
            if(UseFeatOnObject(FEAT_TURN_UNDEAD)) return TRUE;
        }
    }
    // Else nothing to do it against or no feat.
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name jTalentBardSong
//::///////////////////////////////////////////////
    This, if we have the feat, and not the effects,
    will use it on ourselves.
//::///////////////////////////////////////////////
//:: Created By: Bioware
//::////////////////////////////////////////////*/
int jTalentBardSong()
{
    if(GetHasFeat(FEAT_BARD_SONGS))
    {
        // the spell script used is 411
        if(!GetHasSpellEffect(411))
        {
            if(UseFeatOnObject(FEAT_BARD_SONGS)) return TRUE;
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name jTalentDragonCombat
//::///////////////////////////////////////////////
    Main call for dragons. This will cast major spells,
    use feats, wing buffet and breath weapons.
//::///////////////////////////////////////////////
//:: Created By: Bioware. Heavily Modified: Jasperre
//::////////////////////////////////////////////*/
int jTalentDragonCombat(object oIntruder)
{
    object oTarget = GetBestTarget();
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = oIntruder;
        if(!GetIsObjectValid(oTarget))
        {
            return FALSE;
        }
    }
    // Adds one to all things, by default, every call. This will randomise when to use things.
    int nBreath = GetLocalInt(OBJECT_SELF, "AI_DRAGONS_BREATH");
    int nWing = GetLocalInt(OBJECT_SELF, "AI_WING_BUFFET");
    nWing++;
    nBreath++;
    SetLocalInt(OBJECT_SELF, "AI_DRAGONS_BREATH", nBreath);
    SetLocalInt(OBJECT_SELF, "AI_WING_BUFFET", nWing);
    // Chance each round to use best spells possible.
    if(d2() == 1)
    {
        if(!HasMantalProtections())
            if(CastNoPotionSpellAtObject(SPELL_GREATER_SPELL_MANTLE, 12)) return TRUE;
        if(!HasStoneskinProtections())
        {
            if(CastNoPotionSpellAtObject(SPELL_PREMONITION, 12)) return TRUE;
            if(CastNoPotionSpellAtObject(SPELL_GREATER_STONESKIN, 12)) return TRUE;
        }
        if(!HasElementalProtections())
            if(CastNoPotionSpellAtObject(SPELL_ENERGY_BUFFER, 12)) return TRUE;
        int iRace = GetRacialType(oTarget);
        // Harm
        // CONDITION: 6+ hit dice and NOT undead! :) Also checks HP
        if(GetHitDice(oTarget) > GetHitDice(OBJECT_SELF) - 5 && GetCurrentHitPoints(oTarget) > 25)
        {
            if(iRace != RACIAL_TYPE_UNDEAD && iRace != RACIAL_TYPE_CONSTRUCT)
            {
                if(CastNoPotionSpellAtObject(SPELL_HARM, 3, oTarget)) return TRUE;
            }
            // CONDITION: Undead at 4+ hd. Never casts twice in time stop, and not over 20 HP.
            else
            {
                if(CastNoPotionSpellAtLocation(SPELL_MASS_HEAL, 6, GetLocation(oTarget))) return TRUE;
                // Will never use thier last heal on the enemy.
                if(GetHasSpell(SPELL_HEAL) > 1)
                    if(CastNoPotionSpellAtObject(SPELL_HEAL, 6, oTarget)) return TRUE;
            }
        }
    }
    talent tUse = GetCreatureTalentBest(TALENT_CATEGORY_DRAGONS_BREATH, 20);
    if(GetIsTalentValid(tUse) && !GetHasSpellEffect(GetIdFromTalent(tUse), oTarget) && nBreath >= 3)
    {
        ClearAllActions();
        DebugActionSpeak("Dragon breath being used [Breath] " + IntToString(GetIdFromTalent(tUse)) + " [Enemy] " + GetName(oTarget));
        ActionUseTalentOnObject(tUse, oTarget);
        // We will attack the target just after the breath. No standing around.
        ActionAttack(oTarget);
        // Resets breath counter to 0
        SetLocalInt(OBJECT_SELF, "AI_DRAGONS_BREATH", 0);
        return TRUE;
    }
    else if(nWing >= (3 + Random(2)))
    {
        if(AbilityWingBuffet(oTarget))
        {
            // Resets wing counter to 0
            SetLocalInt(OBJECT_SELF, "AI_WING_BUFFET", 0);
            return TRUE;
        }
    }
    ClearAllActions();
    int iFeat = GetBestFightingFeat(oTarget, BaseAttackBonus(), GetAC(oTarget));
    if(iFeat > 0 && !jGetHasEffect(EFFECT_TYPE_POLYMORPH))
    {
        UseFeatOnObject(iFeat, oTarget, FALSE);
        return TRUE;
    }
    else
    {
        DebugActionSpeak("Dragon: Normal (no feat) attacking. [Enemy] " + GetName(oTarget));
        ActionAttack(oTarget);
        return TRUE;
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name AbilityWingBuffet
//::///////////////////////////////////////////////
    If we can, we will use wing buffet, which is really
    just a script, but works well!
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int AbilityWingBuffet(object oTarget)
{
    if(GetIsUnCommandable())
    {
        return FALSE;
    }
    else
    {
        if(GetCreatureSize(oTarget) != CREATURE_SIZE_HUGE && GetDistanceToObject(oTarget) < 3.0 && GetDistanceToObject(oTarget) >= 0.0)
        {
            ClearAllActions();
            DebugActionSpeak("Dragon wing buffect being used [Enemy]" + GetName(oTarget));
            DelayCommand(0.2, ExecuteScript("j_ai_wingbuffet", OBJECT_SELF));
            return TRUE;
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name ConcentrationCheck
//::///////////////////////////////////////////////
    If we are intelligent, have an ally nearby, of a mage class
    and damage from an AOO is a lot, we will move back
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int ConcentrationCheck(object oTarget, int iInt, int nClass, object oAlly, int iHasAlly, float fAllyDistance, float fEnemyDistance, int iMeleeEnemy, int iRangedEnemy, int iMyHD, int iEnemyHD, int iPCHP, int iMyBAB)
{
    // We will never do anything if no melee attackers, or no ally that can help repel them
    if(iMeleeEnemy > 0 && iHasAlly && iInt >= 4 && GetIsObjectValid(oTarget))
    {
        if(nClass == CLASS_TYPE_WIZARD || nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_FEY)
        {
            // First - checks concentration...
            int iConcentration = GetSkillRank(SKILL_CONCENTRATION);
            // Wil not do anything with invalid concentration, else they will probably always run from anything.
            if(iConcentration && fAllyDistance < 3.0 && fAllyDistance >= 0.0)
            {
                // When we check melee enemies...we need whats the biggest reduction in thier damage will be.
                int iDamageReduction = 0;
                if(GetHasSpellEffect(SPELL_PREMONITION)){ iDamageReduction = 30; }
                else if(GetHasSpellEffect(SPELL_GREATER_STONESKIN)){ iDamageReduction = 20; }
                else if(GetHasSpellEffect(SPELL_ETHEREAL_VISAGE)){ iDamageReduction = 20; }
                else if(GetHasSpellEffect(SPELL_STONESKIN)){ iDamageReduction = 10; }
                else if(GetHasSpellEffect(SPELL_SHADOW_SHIELD)){ iDamageReduction = 10; }
                else if(GetHasSpellEffect(SPELL_GHOSTLY_VISAGE)){ iDamageReduction = 5; }

                int iTotalDamage = GetAnAooDamageTotal();
                iTotalDamage = iTotalDamage - iDamageReduction;
                // This is counted up and up, our percent of moving back.
                int iPercent = 0;
                // We will take our roll as a Random(15) + 5;
                iConcentration == iConcentration + (Random(15) + 5);
                // Now, if our concentration is < Number of attackers * possible damage...
                // We take damage as random (7) + 4, for now.
                if(iConcentration < iTotalDamage)
                {
                    iPercent = iMeleeEnemy * 20;
                }
                // Final check - does a d100() roll against the added percentage.
                // If under it, it moves back then clears actions after 5.
                if(d100() < iPercent)
                {
                    ClearAllActions();
                    DebugActionSpeak("Moving away, because of low concentration [Enemy] " + GetName(oTarget));
                    ActionMoveAwayFromLocation(GetLocation(oTarget), TRUE, 8.0);
                    SetCommandable(FALSE);
                    DelayCommand(5.0, SetCommandable(TRUE));
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name ImportAllSpells
//::///////////////////////////////////////////////
    Taken from Jugulators improved spell AI, this is a
    very heavily changed version. If they can cast spells
    or abilities, this will run though them and choose which
    to cast. It will cast location spells at location, meaning heard
    enemies may still be targeted.

    Incudes, nearer the bottom, if we are not a spellcaster, and
    our BAB is high compared to thier AC, we will HTH attack
    rather than carry on casting low level spells.
//::///////////////////////////////////////////////
//:: Created By: Jugulator, Modified (very) Heavily: Jasperre
//::////////////////////////////////////////////*/
int ImportAllSpells(int iInt, int nClass, object oTarget, object oAlly, int iHasAlly, float fAllyDistance, int iMeleeEnemy, int iRangedEnemy, int iMyHD, int iPartyHD, int iPCHP, int iBAB)
{
    // Our spell target will be dependant on seen enemies...non seen, no spells.
    object oSpellTarget = OBJECT_INVALID;
    if(GetIsObjectValid(oTarget) && oTarget != OBJECT_SELF && !GetFactionEqual(oTarget))
    {
        oSpellTarget = oTarget;
    }
    object oNearestSeen = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    if((!GetObjectSeen(oSpellTarget) || GetIsDead(oSpellTarget)) && GetIsObjectValid(oNearestSeen))
    {
        oSpellTarget = oNearestSeen;
    }
    // If the imputted target AND the seen target is invlid, return FALSE (stop)
    if(!GetIsObjectValid(oSpellTarget))
    {
        return FALSE;
    }
    // Set if we can see the enemy - will cast protection spells, or location spells.
    // Always we use oSpellTarget to target, except AOE spells, which will get locations.
    int iSeenEnemy = FALSE;
    if(GetIsObjectValid(oSpellTarget) && GetObjectSeen(oSpellTarget))
    {
        iSeenEnemy = TRUE;
    }
    float fEnemyDistance = GetDistanceToObject(oSpellTarget);
    int iAllySeen = FALSE;
    if(iHasAlly)
    {
        iAllySeen = GetObjectSeen(oAlly);
    }
    // Get primary modifier for class
    int iMod = 20;
    int nClassLevel = GetLevelByClass(nClass);
    int iSaveDC = 10;// Starts at 10 - the normal 10 + spell level 10.
    // NO RANGERS OR PALADINS!!! Buggy as hell, STILL!
    if(nClass == CLASS_TYPE_RANGER || nClass == CLASS_TYPE_PALADIN)    {
        return FALSE;    }
    // Wizards are intelligence based for spells.
    else if(nClass == CLASS_TYPE_WIZARD)    {
        iMod = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE);
        iSaveDC = iSaveDC + GetAbilityModifier(ABILITY_INTELLIGENCE);    }
    // These can cast spell X, Y and Z up to A times, and are charisma based for spells.
    else if(nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_BARD)    {
        iMod = GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA);
        iSaveDC = iSaveDC + GetAbilityModifier(ABILITY_CHARISMA);    }
    // These are the divine casters - wisdom is thier ethos.
    else if(nClass == CLASS_TYPE_DRUID || nClass == CLASS_TYPE_CLERIC)    {
        iMod = GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM);
        iSaveDC = iSaveDC + GetAbilityModifier(ABILITY_WISDOM);    }
    // monster class, or something (like a cleric with invisibility ability
    // or a Drow with darkness)
    else    {
    // Mod is 20 - the max ever needed is 19. They can always cast thier spells.
        iMod = 20;
        // Charima is the other - if positive, we add it on.
        if(GetAbilityModifier(ABILITY_CHARISMA) > 0)
            iSaveDC += GetAbilityModifier(ABILITY_CHARISMA);    }

    DebugActionSpeak("SpellCastingFunction. [Modifier] " + IntToString(iMod)  + " [Target] " + GetName(oSpellTarget) + " [Ally, may not be valid] " + GetName(oAlly));
    // Testing Save to check spell effectiveness.
    // Will never cast if no decent effects are achived, because of high saves.
    int iWill = GetWillSavingThrow(oSpellTarget);
    int iFortitude = GetFortitudeSavingThrow(oSpellTarget);
    int iReflex = GetReflexSavingThrow(oSpellTarget);

    int isDruid = (nClass == CLASS_TYPE_DRUID); // TRUE if Druid
    // Cure spell adjustment value
    // Cure Wounds spells has +1 Wis requirement for Druids (equivalent spell is 1 level higher)
    // TO DO: Make sure all spells like this (EG, harm, create undead) use this system!
    int iCureAdj = isDruid ? 1 : 0;

    // Will we use our most ranged spells first?
    int iRangedFirst = jGetSpawnInCondition(ATTACK_FROM_AFAR_FIRST);

    // Set if we can use spells at cirtain ranges.
    int iRangeLong = TRUE;
    int iRangeMed = TRUE;
    int iRangeShort = TRUE;
    int iRangeTouch = TRUE;
    if(iRangedFirst)
    {
        if(fEnemyDistance > 3.0)
        {
            iRangeTouch = FALSE;
            if(fEnemyDistance > 8.5)
            {
                iRangeShort = FALSE;
                if(fEnemyDistance > 20.5)
                {
                    iRangeMed = FALSE;
                    if(fEnemyDistance > 40.5)
                    {
                        iRangeLong = FALSE;
                    }
                }
            }
        }
    }

    // Used for summoned creatures. Location is self, for now. Will change to max
    // range of them spells.
    int iSummon = GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED));
    location lSummonLocation = GetLocation(OBJECT_SELF);
    // Set location of the seen, or heard, enemy.
    location lSpellLocation = GetLocation(oSpellTarget);

    if(GetIsSpellValid(SPELL_DISMISSAL, 11))
    {
        object oSummonInRange = GetDismissalTarget();
        // Cast Dismissal on summons
        // Dismissal - Range Small (8.0). No immunities. Hostiles Only.
        if(GetIsObjectValid(oSummonInRange))
        {
            if(CastNoPotionSpellAtObject(SPELL_DISMISSAL, 11, oSummonInRange, iMod, 15)) return TRUE;
        }
    }
    //Time Stop - Never casts again in a timestop
    // This will cast it very first if we have 2 or more.
    if(GetHasSpell(SPELL_TIME_STOP) >= 2)
        if(CastNoPotionSpellAtObject(SPELL_TIME_STOP, 1, OBJECT_SELF, iMod, 19)) return TRUE;
    // Haste - First. Good one, I suppose. Should check for close (non-hasted)
    // allies, to choose between them.
    if(!(GetHasSpellEffect(SPELL_MASS_HASTE) || GetHasSpellEffect(SPELL_HASTE) || jGetHasEffect(EFFECT_TYPE_HASTE)))
    {
        if((iHasAlly && fAllyDistance < 8.0) || !GetHasSpell(SPELL_HASTE))
            if(iInTimeStop && !CompareTimeStopStored(SPELL_HASTE) || !iInTimeStop)
                if(CastNoPotionSpellAtObject(SPELL_MASS_HASTE, 8, OBJECT_SELF, iMod, 16)) return TRUE;
        if(iInTimeStop && !CompareTimeStopStored(SPELL_MASS_HASTE) || !iInTimeStop)
            if(CastPotionSpellAtObject(SPELL_HASTE, 9, OBJECT_SELF, iMod, 13)) return TRUE;
    }

    // Now the normal time stop. Power to the lords of time! (sorry, a bit over the top!)
    if(CastNoPotionSpellAtObject(SPELL_TIME_STOP, 1, OBJECT_SELF, iMod, 19)) return TRUE;

    // Used for fireball checks, and for shields against it.
    int iElementalProtection = HasElementalProtections();
    // Special case - if lots of damage has been done elemetally wise, we will cast elemental prots.
    if(!iElementalProtection)
    {
        int iDamageDone = GetMaxDamageDone();
        if(iDamageDone > 20 || (iDamageDone > 15 && iMyHD < 25) || (iDamageDone > 10 && iMyHD < 20)
             || (iDamageDone > 5 && iMyHD < 15))
        {
            if(CastElementalProtections(iMod))
            {
                // Reset and return, if we cast something!
                DeleteLocalInt(OBJECT_SELF, "MAX_ELEMENTAL_DAMAGE");
                return TRUE;
            }
        }
    }

    // If we are in time stop, or no enemy in 3 m, we will buff our appropriate stat.
    if(iInTimeStop || fEnemyDistance > 3.0)
    {
        if(CastRightSpellHelp(nClass, iMod)) return TRUE;
    }

    //Visibility Protections
    if(!iInTimeStop)
    {
        if(GoodTimeToInvisSelf(iMeleeEnemy, iMyHD, iRangedEnemy, iPartyHD)) return TRUE;
        // And will protect themselves (or run a bit) if they are invisible...
        // Things like stoneskin, and so on
        if(AmInvisibleCasting(iMod, oSpellTarget)) return TRUE;
    }
    // We are determining ALL immunities here. Used for future checks.
    SortSpellImmunities(oSpellTarget);
    // Are we allowed to use our better judement?
    int iImprovedDeathSpells = jGetSpawnInCondition(IMPROVED_INSTANT_DEATH_SPELLS);
    // If our intelligence is low, we will not check SR or Saves.
    if(iInt <= 3)
    {
        iSaveDC = 100;
        nClassLevel = 100;
    }
    // This is used with AOE spells. some PvP or levels will make spells
    // affect allies.
    int iFriendlyFireHostile = FALSE;
    int iFriendlyFireFriendly = FALSE;
    if(iHasAlly)
    {
        // If the spell uses GetIsReactionTypeHostile, use this.
        if(GetIsReactionTypeHostile(oAlly))
            iFriendlyFireHostile = TRUE;
        // If the spell uses !GetIsReactionTypeFriendly, use this.
        if(!GetIsReactionTypeFriendly(oAlly))
            iFriendlyFireFriendly = TRUE;
    }

    int iEnemyHasMantals = HasMantalProtections(oSpellTarget);
    // Try a finger/destruction spell, if their fortitude save is really, really low.
    // Will not use these 2 twice in time stop, as they *should* die instantly
    if(iImprovedDeathSpells && iSeenEnemy && iRangeShort)
    {
        if((iFortitude + 20) <= (iSaveDC + 7) && !ImmuneDeath && !ImmuneNecromancy && !iEnemyHasMantals)
        {
            if(CastNoPotionSpellAtObject(SPELL_DESTRUCTION, 2, oSpellTarget, iMod, 17)) return TRUE;
            if(CastNoPotionSpellAtObject(SPELL_FINGER_OF_DEATH, 2, oSpellTarget, iMod, 17)) return TRUE;
        }
    }

    // Now will cast mantal if not got one and nearest enemy is a spellcaster...
    if(CanCastAnything(oSpellTarget) && iMeleeEnemy < 1)
        if(CastMantalProtections(iMod)) return TRUE;

    // Haste (same as above, but for allies). Moved down below time stop, and the more important spells.
    if(iHasAlly && iAllySeen)
    {
        if(!(GetHasSpellEffect(SPELL_MASS_HASTE, oAlly) || GetHasSpellEffect(SPELL_HASTE, oAlly)
                || jGetHasEffect(EFFECT_TYPE_HASTE, oAlly))  && fAllyDistance < 8.0 && fAllyDistance >= 0.0)
        {
            if(CastNoPotionSpellAtObject(SPELL_HASTE, 9, oAlly, iMod, 13)) return TRUE;
        }
    }

    // INSTANT DEATH SPELLS...if conditions are met.
    // Cloudkill here - if average HD is < 7
    // Random is < 7, always if under 4
    if(iImprovedDeathSpells && iRangeLong && !iEnemyHasMantals)
    {
        if ((iPartyHD < 4) || ((iPartyHD < 7) && (d10() < 4)))
        {
            if(iSeenEnemy)
            { if(CastNoPotionSpellAtObject(SPELL_CLOUDKILL, 11, oSpellTarget, iMod, 15, 100, FALSE)) return TRUE;
            } else { if(CastNoPotionSpellAtLocation(SPELL_CLOUDKILL, 11, lSpellLocation, iMod, 15, FALSE, FALSE)) return TRUE; }
        }
    }
    //Circle of Death
    //CONDITION: Average enemy party hd less than 10
    // This spell only effects level 1-9 people. Good cleaner for lower monsters!
    if (iPartyHD < 10 && iRangeMed && !iEnemyHasMantals)
    {   if(iSeenEnemy)
        { if(CastNoPotionSpellAtObject(SPELL_CIRCLE_OF_DEATH, 1, oSpellTarget, iMod, 16)) return TRUE;
        } else { if(CastNoPotionSpellAtLocation(SPELL_CIRCLE_OF_DEATH, 1, lSpellLocation, iMod, 16)) return TRUE; }
    }
    //Power Word: Kill
    // If improved, will check HP, else just casts it.
    if(iImprovedDeathSpells && iRangeShort && !iEnemyHasMantals)
    {
        if(iPCHP < 100)
        if(iSeenEnemy)
        { if(CastNoPotionSpellAtObject(SPELL_POWER_WORD_KILL, 11, oSpellTarget, iMod, 19)) return TRUE;
        } else { if(CastNoPotionSpellAtLocation(SPELL_POWER_WORD_KILL, 11, lSpellLocation, iMod, 19)) return TRUE; }
    }
    //Physical Damage Protections (Self)
    // Stoneskins, premonition
    if(CastPhysicalProtections(iMod)) return TRUE;

    int iCnt;
    if(fEnemyDistance < 2.25 && fEnemyDistance >= 0.0)
    {
        // These are the pulses. Not much I can be bothered to check for. All good stuff!
        for(iCnt = 281; iCnt <= 289; iCnt++)
        {
            // All innate, so no matter about talents really.
            if(CastSpellNormalAtObject(iCnt)) return TRUE;
        }
    }

    // Then harm/heal
    int iRace = GetRacialType(oSpellTarget);
    if((iPartyHD >= (iMyHD - 5)) && iPCHP > 20)
    {
        if(iSeenEnemy && iRangeTouch && iRace != RACIAL_TYPE_UNDEAD)
        {
            // Harm
            // CONDITION: 6+ hit dice and NOT undead! :) Also checks HP
            if(CastNoPotionSpellAtObject(SPELL_HARM, 3, oSpellTarget, iMod, 16)) return TRUE;
        }
        // (Mass) Heal (used as Harm for undead)
        // CONDITION: Undead at 4+ hd. Never casts twice in time stop, and not over 20 HP.
        if(iRace == RACIAL_TYPE_UNDEAD && iRangeTouch)
        {
            if(CastNoPotionSpellAtLocation(SPELL_MASS_HEAL, 4, lSpellLocation, iMod, 18)) return TRUE;
            if(iSeenEnemy && GetHasSpell(SPELL_HEAL) > 1)// Never use last heal for harming.
                if(CastNoPotionSpellAtObject(SPELL_HEAL, 6, oSpellTarget, iMod, 16)) return TRUE;
        }
    }

    //Power Word: Stun
    // Is not immune to mind spell (I think this is a valid check)
    // And not already
    // Really, if under < 151 HP to be affected    !!!WORKING!!!
    if ((iPCHP < 151) && iSeenEnemy && iRangeTouch && !ImmuneMind && !ImmuneStun)
    {
        if(CastNoPotionSpellAtObject(SPELL_POWER_WORD_STUN, 11, oSpellTarget, iMod, 17)) return TRUE;
    }

    // Elemental shield here, if over 0 melee attackers (and 30% chace) or over 1-4 attackers (level based)
    if((iMeleeEnemy > 0 && d10() > 6) || iMeleeEnemy > (iMyHD / 4))
        if(CastPotionSpellAtObject(SPELL_ELEMENTAL_SHIELD, 12, OBJECT_SELF, iMod, 14)) return TRUE;

    // Dispel Nearest Enemy's Beneficial Spells. Will not cast in time stop twice
    // Casts breaches seperatly...limited spells affected
    // Moved down to below self protections...not sure really.
    // At the moment, no dispelling twice in time stop.
    if(iSeenEnemy && iRangeMed)
    {
        if(GetHasBeneficialBreach(oSpellTarget) && !iInTimeStop)
        {
            if(CastNoPotionSpellAtObject(SPELL_GREATER_SPELL_BREACH, 2, oSpellTarget, iMod, 16)) return TRUE;
            if(CastNoPotionSpellAtObject(SPELL_LESSER_SPELL_BREACH, 2, oSpellTarget, iMod, 14)) return TRUE;
        }

        if(GetHasBeneficialEnhancement(oSpellTarget) && !iInTimeStop)
        {
            if(CastNoPotionSpellAtObject(SPELL_MORDENKAINENS_DISJUNCTION, 11, oSpellTarget, iMod, 19)) return TRUE;
            if(CastNoPotionSpellAtObject(SPELL_GREATER_DISPELLING, 2, oSpellTarget, iMod, 16)) return TRUE;
            if(CastNoPotionSpellAtObject(SPELL_DISPEL_MAGIC, 2, oSpellTarget, iMod, 13)) return TRUE;
            // Only lesser if under 15 HD, because it may not be worth it (DC wise)
            if(iPartyHD < 15)
                if(CastNoPotionSpellAtObject(SPELL_LESSER_DISPEL, 11, oSpellTarget, iMod, 12)) return TRUE;
        }
    }

    // Storm - a very good AOE spell. May as well use here!
    if(fEnemyDistance <= 7.0 && fEnemyDistance >= 0.0)
        if(CastNoPotionSpellAtObject(SPELL_STORM_OF_VENGEANCE, 1, OBJECT_SELF, iMod, 19)) return TRUE;

    // Sets up AOE targets and locations to use.
    object oAOE;
    location lAOELocation;
    // Implosion - great spell! Instant death on a +3 save.
    if(GetIsSpellValid(SPELL_IMPLOSION, 11) && iRangeShort)
    {                                   // its save is at 9 + 3 = 12 DC
        oAOE = GetBestAreaSpellTarget(8.0, RADIUS_SIZE_MEDIUM, 12, nClassLevel, SAVING_THROW_FORT, iSaveDC, SHAPE_SPHERE, iFriendlyFireFriendly, TRUE);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);   }
        else {   lAOELocation = lSpellLocation;    }
           if(CastNoPotionSpellAtLocation(SPELL_IMPLOSION, 11, lAOELocation, iMod, 19)) return TRUE;
    }

    //Wail of the Banshee
    // Fort save, else death, and it never affects allies!
    if(GetIsSpellValid(SPELL_WAIL_OF_THE_BANSHEE, 1) && iRangeShort)
    {
        oAOE = GetBestAreaSpellTarget(8.0, RADIUS_SIZE_COLOSSAL, 9, nClassLevel, SAVING_THROW_FORT, iSaveDC, SHAPE_SPHERE, FALSE, TRUE, TRUE);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);   }
        else {   lAOELocation = lSpellLocation;    }
        if(CastNoPotionSpellAtLocation(SPELL_WAIL_OF_THE_BANSHEE, 1, lAOELocation, iMod, 19, FALSE, FALSE)) return TRUE;
    }

    //Weird - item immunity fear? Need to test
    // Never affects allies. No save type - as it needs 2 and someting happens even if all saved,
    if(GetIsSpellValid(SPELL_WEIRD, 1) && iRangeShort)
    {
        oAOE = GetBestAreaSpellTarget(8.0, RADIUS_SIZE_COLOSSAL, 9, nClassLevel);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);   }
        else {   lAOELocation = lSpellLocation;    }
        if(CastNoPotionSpellAtLocation(SPELL_WEIRD, 1, lAOELocation, iMod, 19, FALSE, FALSE)) return TRUE;
    }

    // Physical Protections (same as above, but for allies)
    // Never moves to allies...and only if they cannot cast G stoneskin, Prem.
    if(iHasAlly && iAllySeen && fAllyDistance < 2.25 && fAllyDistance >= 0.0)
    {
        if ((GetHasSpellEffect(SPELL_PREMONITION) || GetHasSpellEffect(SPELL_GREATER_STONESKIN) ||
             GetHasSpellEffect(SPELL_STONESKIN) || GetHasSpellEffect(SPELL_SHADES_STONESKIN)))
        {
            if (!(GetHasSpellEffect(SPELL_PREMONITION, oAlly) ||
                  GetHasSpellEffect(SPELL_GREATER_STONESKIN, oAlly) ||
                  GetHasSpellEffect(SPELL_SHADES_STONESKIN, oAlly) ||
                  GetHasSpellEffect(SPELL_STONESKIN, oAlly))
                  && !(GetHasSpell(SPELL_GREATER_STONESKIN, oAlly)
                  || GetHasSpell(SPELL_PREMONITION, oAlly)))
            {
                if (CastNoPotionSpellAtObject(SPELL_STONESKIN, 13, oAlly, iMod, 14)) return TRUE;
                if (CastAttemptedTalentAtObject(SPELL_SHADES_STONESKIN, 13, oAlly, iMod, 14)) return TRUE;
            }
        }
    }

    //Gate
    //CONDITION: Protection from Evil active on self
    // Still got this. But no putting on the spell...does not seem to work.
    if ((GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL) ||
        GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL)) && !iSummon)
    {
        if(CastNoPotionSpellAtLocation(SPELL_GATE, 15, lSpellLocation, iMod, 19)) return TRUE;
    }

    //Visibility Protections
    if (!(GetHasSpellEffect(SPELL_MASS_BLINDNESS_AND_DEAFNESS, oSpellTarget) &&
        GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY)))
    {
        if(!SaveImmune(oSpellTarget, 1, iFortitude, iSaveDC, 8) && iRangeMed)
            if(CastNoPotionSpellAtLocation(SPELL_MASS_BLINDNESS_AND_DEAFNESS, 1, lSpellLocation, iMod, 18, FALSE, FALSE)) return TRUE;
        // No invis in time stop.
        if(!iInTimeStop)
            if(CastPotionSpellAtObject(SPELL_IMPROVED_INVISIBILITY, 9, OBJECT_SELF, iMod, 14)) return TRUE;
    }

    // Visibility Protections (same as above, but for allies)
    // Touch is 2.25 range...
    if(iHasAlly && iAllySeen && fAllyDistance < 2.25 && fAllyDistance >= 0.0)
    {
        if (GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY) && !GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY, oAlly))
        {
            if(CastNoPotionSpellAtObject(SPELL_IMPROVED_INVISIBILITY, 9, oAlly, iMod, 14)) return TRUE;
        }
    }

    //Protection from Evil / Magic Circle Against Evil
    // ... in preparation for Gate!
    if(GetHasSpell(SPELL_GATE) && !(GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL) ||
        GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL)))
    {
        // Does this spell even work? The talent seems to.
        if(CastAttemptedTalentAtObject(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, 8, OBJECT_SELF, iMod, 13)) return TRUE;
        if(CastAttemptedTalentAtObject(SPELL_PROTECTION_FROM_EVIL, 13, OBJECT_SELF, iMod, 11)) return TRUE;
    }

    // Protections vs Evil (same as above, but for allies)
    if(iHasAlly && iAllySeen)
    {
        if ((GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL) ||
            GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL)) &&
            !(GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL, oAlly) ||
              GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, oAlly)))
        {
            // Does this spell even work? Talents seem to.
            if(CastAttemptedTalentAtObject(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, 8, oAlly, iMod, 13)) return TRUE;
            if(CastAttemptedTalentAtObject(SPELL_PROTECTION_FROM_EVIL, 13, oAlly, iMod, 11)) return TRUE;
        }
    }

    if(!iSummon)
    {
        // Summon the elemental swarm
        if(CastNoPotionSpellAtLocation(SPELL_ELEMENTAL_SWARM, 15, lSummonLocation, iInTimeStop, iMod, 19)) return TRUE;
        // Summon an eldar elemental.
        if(CastNoPotionSpellAtLocation(SPELL_SUMMON_CREATURE_IX, 15, lSummonLocation, iInTimeStop, iMod, 19)) return TRUE;
        // No-concentration summoned creatures.
        if(CastNoPotionSpellAtLocation(SPELLABILITY_SUMMON_TANARRI, 15, lSummonLocation, 20, 1, TRUE)) return TRUE;
        if(CastNoPotionSpellAtLocation(SPELLABILITY_SUMMON_SLAAD, 15, lSummonLocation, 20, 1, TRUE)) return TRUE;
        if(CastNoPotionSpellAtLocation(SPELLABILITY_SUMMON_CELESTIAL, 15, lSummonLocation, 20, 1, TRUE)) return TRUE;
        if(CastNoPotionSpellAtLocation(SPELLABILITY_SUMMON_MEPHIT, 15, lSummonLocation, 20, 1, TRUE)) return TRUE;
        if(CastNoPotionSpellAtLocation(SPELLABILITY_NEGATIVE_PLANE_AVATAR, 10, lSummonLocation, 20, 1, TRUE)) return TRUE;
    }
    //Dominate
    //CONDITION: Enemies less than 8 levels below me (powerful enemies)
    // Needs to not be immune, and be of right race for DOM PERSON
    // No time stop, and a valid will save to even attempt.
    if(!iInTimeStop)
    {
        if (!(ImmuneDomination || ImmuneMind) && (iPartyHD - iMyHD) >= -8)
        {
            if(iSeenEnemy && iRangeMed)
            {
                if(!SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 9))
                    if(CastNoPotionSpellAtObject(SPELL_DOMINATE_MONSTER, 2, oSpellTarget, iMod, 19)) return TRUE;
                if(GetIsPlayableRacialType(oSpellTarget) && !SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 5))
                    if(CastNoPotionSpellAtObject(SPELL_DOMINATE_PERSON, 2, oSpellTarget, iMod, 15)) return TRUE;
            }
            if(!SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 9) && iRangeShort)
                if(CastNoPotionSpellAtLocation(SPELL_MASS_CHARM, 1, lSpellLocation, iMod, 18)) return TRUE;
        }
    }

    //Protection from Spells
    //CONDITION: Enemies less than 5 levels below me (powerful enemies)
    //CONDITION 2: At least 3 allies
    if(((iPartyHD - iMyHD) >= -5) && ((fAllyDistance > 0.0 && fAllyDistance < 5.0) || (iPartyHD - iMyHD) >= -10))
    {
        if(CastPotionSpellAtObject(SPELL_PROTECTION_FROM_SPELLS, 14, OBJECT_SELF, iMod, 17)) return TRUE;
    }

    // Aura Vs. Alignment. +4 AC and things. May not work...
    int iEnemyAlignment = GetAlignmentGoodEvil(oSpellTarget);
    if(iEnemyAlignment == ALIGNMENT_EVIL)
    {
        if(CastAttemptedTalentAtObject(SPELL_HOLY_AURA, 10, OBJECT_SELF, iMod, 18)) return TRUE;
    }
    else if(iEnemyAlignment == ALIGNMENT_GOOD)
    {
        if(CastAttemptedTalentAtObject(SPELL_UNHOLY_AURA, 10, OBJECT_SELF, iMod, 18)) return TRUE;
    }

    //Mantle Protections
    //CONDITION: Enemies less than 5 levels below me (powerful enemies)
    // Will chance casting these anyway, if no melee attackers, and the enemy has a valid talent.
    // Yes, talents include items...ahh well.
    if((iPartyHD - iMyHD) >= -5)
        if(CastMantalProtections(iMod)) return TRUE;

    //Meteor Swarm
    // CONDITION: Closest enemy 5 ft. (1.5 meters) from me
    // Changed to 10M ... the collosal sized actially used (on self)
    // But only if the enemy is. Removed enemy fire, for now.
    if(fEnemyDistance < 5.0 && fEnemyDistance >= 0.0)
        if(CastNoPotionSpellAtObject(SPELL_METEOR_SWARM, 1, OBJECT_SELF, iMod, 19)) return TRUE;

    // Regenerate 6HP a round is not bad
    if(CastPotionSpellAtObject(SPELL_REGENERATE, 10, OBJECT_SELF, TRUE, iMod + iCureAdj, 17)) return TRUE;

    // Small range, and harms SR.
    if(iRangeShort)
        if(CastNoPotionSpellAtLocation(SPELL_NATURES_BALANCE, 1, lSpellLocation, iMod, 18)) return TRUE;

    // Sunbeam - 100 if undead is target, else 40
    if(iRangeMed)
    {
        if (iRace == RACIAL_TYPE_UNDEAD)
        { if(CastNoPotionSpellAtLocation(SPELL_SUNBEAM, 1, lSpellLocation, iMod, 18)) return TRUE; }
        else { if(CastNoPotionSpellAtLocation(SPELL_SUNBEAM, 1, lSpellLocation, iMod, 18, FALSE, FALSE, 40)) return TRUE; }

        // special case if undeads are target
        if (iRace == RACIAL_TYPE_UNDEAD && iSeenEnemy)
        {
            if(CastNoPotionSpellAtObject(SPELL_SEARING_LIGHT, 2, oSpellTarget, iMod, 13, 100, FALSE)) return TRUE;
        }
    }

    // This spell is cast on self, and has a collossal (10m) radius. At 9.5 for better effect.
    // There is a save, reflex, for this spell. Might as well use it.
    if (fEnemyDistance < 9.5 && fEnemyDistance >= 0.0 && !SaveImmune(oSpellTarget, 1, iReflex, iSaveDC, 8))
        if(CastNoPotionSpellAtObject(SPELL_FIRE_STORM, 1, OBJECT_SELF, iMod + iCureAdj, 18, 100, FALSE)) return TRUE;

    // Best, in my opinion, to worst. May put in clerical checks for the undead creature.
    // They will cast gate first, then lv 9 ones,
    // then any non-concentration summoning abilities, then challenge based, moving down.
    if(!iSummon)
    {
        if(iMyHD <= 20 || iMeleeEnemy < 2)
        {
            if(CastNoPotionSpellAtLocation(SPELL_CREATE_GREATER_UNDEAD, 15, lSummonLocation, iMod, 18, 100, TRUE)) return TRUE;
            if(CastNoPotionSpellAtLocation(SPELL_SUMMON_CREATURE_VIII, 15, lSummonLocation, iMod, 18, 100, TRUE)) return TRUE;
            if(CastNoPotionSpellAtLocation(SPELL_GREATER_PLANAR_BINDING, 15, lSummonLocation, iMod, 18, 100, TRUE)) return TRUE;
        }
    }

    if(iRangeMed)
    {
        //Horrid Wilting
        // CONDITION ADDED - Not undead OR 1d10 <= 3
        // Need to add some check for best target in range...
        if(GetIsSpellValid(SPELL_HORRID_WILTING, 1))
        {
            oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_HUGE, 9, nClassLevel, FALSE, FALSE, SHAPE_SPHERE, FALSE, FALSE, TRUE);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);   }
            else {   lAOELocation = lSpellLocation;    }
            if(jGetRacialTypeCount(RACIAL_TYPE_UNDEAD) == 0 && iRace != RACIAL_TYPE_UNDEAD)
            {
                if(CastNoPotionSpellAtLocation(SPELL_HORRID_WILTING, 1, lAOELocation, iMod, 18, FALSE, FALSE)) return TRUE;
            }
        }
        // Anything you want - even death! This is one good spell.
        // This never affects allies as well! No save! Great Spell!
        if(GetIsSpellValid(SPELL_WORD_OF_FAITH, 1))
        {
            oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_COLOSSAL, 9, nClassLevel);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);   }
            else {   lAOELocation = lSpellLocation;    }
            if(CastNoPotionSpellAtLocation(SPELL_WORD_OF_FAITH, 1, lAOELocation, iMod, 17, FALSE, FALSE)) return TRUE;
        }
    }


    if(iRangeShort)
    {
        // Save vs. death or die - like finger.
        if(!ImmuneDeath &&  !ImmuneNecromancy && !SaveImmune(oSpellTarget, 1, iFortitude, iSaveDC, 7))
            if(CastNoPotionSpellAtObject(SPELL_DESTRUCTION, 2, oSpellTarget, iMod, 17, 100, FALSE)) return TRUE;

        // Gazes here. 80% chance.
        if(Random(4) == 0)
        {
            // Always cast the death one, but not twice in time stop.
            if(!ImmuneDeath)
            {
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_DEATH, 11, lSpellLocation)) return TRUE;
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GOLEM_BREATH_GAS, 11, lSpellLocation)) return TRUE;
            }
            if(iEnemyAlignment == ALIGNMENT_GOOD)
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_DESTROY_GOOD, 11, lSpellLocation)) return TRUE;
            if(iEnemyAlignment == ALIGNMENT_EVIL)
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_DESTROY_EVIL, 11, lSpellLocation)) return TRUE;
            if(GetAlignmentLawChaos(oSpellTarget) == ALIGNMENT_CHAOTIC)
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_DESTROY_CHAOS, 11, lSpellLocation)) return TRUE;
            if(GetAlignmentLawChaos(oSpellTarget) == ALIGNMENT_LAWFUL)
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_DESTROY_LAW, 11, lSpellLocation)) return TRUE;
            if(!ImmuneFear)
            {
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_FEAR, 11, lSpellLocation)) return TRUE;
            }
            if(ImmuneMind)
            {
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_PARALYSIS, 11, lSpellLocation)) return TRUE;
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_STUNNED, 11, lSpellLocation)) return TRUE;
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_CONFUSION, 11, lSpellLocation)) return TRUE;
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_DOOM, 11, lSpellLocation)) return TRUE;
            }
            if(!ImmuneDomination)
            {
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_DOMINATE, 11, lSpellLocation)) return TRUE;
                if(CastNoPotionSpellAtLocation(SPELLABILITY_GAZE_CHARM, 11, lSpellLocation)) return TRUE;
            }
        }

        //Mind Blank, 15% chance
        //CONDITION: Avg enemy party HD at least 12
        //NOTE: Lesser Mind Blank a bit wimpy to be in this talent function?
        // This is a friendly spell anyway!
        // Got some allied checks...gets best target
        if(iPartyHD >= 12 && (d100() < 15))
        {
            if(GetIsSpellValid(SPELL_MIND_BLANK, 9))
            {
                oAOE = GetBestFriendyAreaSpellTarget(8.0, RADIUS_SIZE_HUGE);
                if(GetIsObjectValid(oAOE))
                {   lAOELocation = GetLocation(oAOE);   }
                else {   lAOELocation = lSpellLocation;    }
                    if(CastNoPotionSpellAtLocation(SPELL_MIND_BLANK, 9, lAOELocation, iMod, 18)) return TRUE;
            }
        }
    }

    // >>> LEVEL 7 SPELL SEQUENCE FOR NON-CLERICS <<<
    if(GetIsSpellValid(SPELL_CREEPING_DOOM, 1) && iRangeMed)
    {
        // This affects allies if !GetIsReactionTypeFriendly
        oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_COLOSSAL, 7, nClassLevel, FALSE, FALSE, SHAPE_CUBE, iFriendlyFireFriendly);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);   }
        else {   lAOELocation = lSpellLocation;    }
            if(CastNoPotionSpellAtLocation(SPELL_CREEPING_DOOM, 1, lAOELocation, iMod, 17, FALSE, FALSE)) return TRUE;
    }
    // some strength and other bonuses. Will move with checks sometime.
    if(CastPotionSpellAtObject(SPELL_AURA_OF_VITALITY, 8, OBJECT_SELF, iMod, 17)) return TRUE;

    // Energy Drain - if target is not immune (Necro Spell)
    if(iSeenEnemy && !ImmuneNegativeLevel && iRace != RACIAL_TYPE_UNDEAD && !SaveImmune(oSpellTarget, 1, iFortitude, iSaveDC, 9) && iRangeShort)
        if(CastNoPotionSpellAtObject(SPELL_ENERGY_DRAIN, 2, oSpellTarget, TRUE, iMod, 19)) return TRUE;

    if(CastPotionSpellAtObject(SPELL_SPELL_RESISTANCE, 13, OBJECT_SELF, iMod, 15)) return TRUE;

    //Visage Protections, 50% chance each check.
    if(d2() == 1)
        if(CastVisageProtections(iMod)) return TRUE;

    // Finger of Death - always - great one person spell
    // Not if they are immune to death/necro though...
    if(!ImmuneDeath && iSeenEnemy && !ImmuneNecromancy && !SaveImmune(oSpellTarget, 1, iFortitude, iSaveDC, 7) && iRangeShort)
        if(CastNoPotionSpellAtObject(SPELL_FINGER_OF_DEATH, 2, oSpellTarget, iMod, 17, 100, FALSE)) return TRUE;

    // Anti-undead: Negative Energy Protection (or 20%)
    if (iRace == RACIAL_TYPE_UNDEAD) {
        if(CastPotionSpellAtObject(SPELL_NEGATIVE_ENERGY_PROTECTION, 12, OBJECT_SELF, iMod, 13)) return TRUE;
    }else{ if(CastPotionSpellAtObject(SPELL_NEGATIVE_ENERGY_PROTECTION, 12, OBJECT_SELF, iMod, 13, 20)) return TRUE;}

    // Globes - Great spell immunity
    if(CastGlobeProtections(iMod)) return TRUE;

    //Elemental Protections
    if(CastElementalProtections(iMod)) return TRUE;

    // Good fire damage. Long range. Will not bother with many checks for now.
    if(iRangeLong)
    {
        if(CastNoPotionSpellAtLocation(SPELL_INCENDIARY_CLOUD, 11, lSpellLocation, iMod, 16)) return TRUE;
    }

    // Level 7 summoning spells.
    if(!iSummon && (iMyHD <= 18 || iMeleeEnemy < 2))
    {
        if(CastNoPotionSpellAtLocation(SPELL_MORDENKAINENS_SWORD, 15, lSummonLocation, iMod, 17)) return TRUE;
        if(CastNoPotionSpellAtLocation(SPELL_SUMMON_CREATURE_VII, 15, lSummonLocation, iMod, 17)) return TRUE;
    }

    //Misc Protections
    // Elemental shield - good spell really. Made prioritory above if
    // number of melee attackers are over
    if(CastPotionSpellAtObject(SPELL_ELEMENTAL_SHIELD, 12, OBJECT_SELF, iMod, 14)) return TRUE;

    // Not a bad spell...of they are undead!
    if (iRace == RACIAL_TYPE_UNDEAD && !ImmuneNecromancy && iPartyHD <= (iMyHD * 3) && !SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 7) && iRangeShort)
        if(CastNoPotionSpellAtObject(SPELL_CONTROL_UNDEAD, 2, oSpellTarget, iMod, 16)) return TRUE;

   if(iRangeMed)
   {
        // Cannot really check for a 2x10 box
        if(iSeenEnemy)
            if(CastNoPotionSpellAtObject(SPELL_BLADE_BARRIER, 11, oSpellTarget, iMod, 16, 100, FALSE)) return TRUE;

        // Good damage a lot of the time. It has a save for reflex, might as well make that in, but only the fire will affect allies anyway.
        if(GetIsSpellValid(SPELL_FLAME_STRIKE, 11))
        {
            oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_MEDIUM, 7, nClassLevel, SAVING_THROW_REFLEX, iSaveDC);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);   }
            else {   lAOELocation = lSpellLocation;    }
                if(CastNoPotionSpellAtLocation(SPELL_FLAME_STRIKE, 11, lAOELocation, iMod + iCureAdj, 15, FALSE, FALSE)) return TRUE;
        }
    }

    //Bard War Cry. Fear on enemies, and help for allies.
    if(CastNoPotionSpellAtObject(SPELL_WAR_CRY, 1, OBJECT_SELF, iMod, 14)) return TRUE;

    // Howl! HOOOOOOOOWWWWWWWWWWWLLLLLLLLL! Collosal range on self.
    if(fEnemyDistance < 8.0 && fEnemyDistance >= 0.0 && iSeenEnemy)
    {
        if(CastSpellNormalAtObject(SPELLABILITY_HOWL_DEATH)) return TRUE;
        if(!ImmuneStun)
            if(CastSpellNormalAtObject(SPELLABILITY_HOWL_STUN)) return TRUE;
        if(!ImmuneStun)
            if(CastSpellNormalAtObject(SPELLABILITY_HOWL_PARALYSIS)) return TRUE;
        if(!ImmuneFear)
            if(CastSpellNormalAtObject(SPELLABILITY_HOWL_FEAR)) return TRUE;
        if(!ImmuneMind)
            if(CastSpellNormalAtObject(SPELLABILITY_HOWL_CONFUSE)) return TRUE;
        if(!ImmuneMind)
            if(CastSpellNormalAtObject(SPELLABILITY_HOWL_DAZE)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_HOWL_SONIC)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_HOWL_DOOM)) return TRUE;
    }

    // Random effects, in a cone shape. 78% chance (what? I want an odd number!
    // Will afffect allies if !GetReactionTypeFriendly.
    if(GetIsSpellValid(SPELL_PRISMATIC_SPRAY , 11) && d100() <= 78 && iRangeShort)
    {
        oAOE = GetBestAreaSpellTarget(8.0, 11.0, 7, nClassLevel, FALSE, FALSE, SHAPE_SPELLCONE, iFriendlyFireFriendly);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);   }
        else {   lAOELocation = lSpellLocation;    }
            if(CastNoPotionSpellAtLocation(SPELL_PRISMATIC_SPRAY, 11, lAOELocation, iMod, 17, FALSE, FALSE)) return TRUE;
    }

    if(iRangeMed)
    {
        // Never affects allies, and 1d8/level (to 20d8!).
        if(GetIsSpellValid(SPELL_DELAYED_BLAST_FIREBALL, 11))
        {
            oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_HUGE, 7, nClassLevel, SAVING_THROW_REFLEX, iSaveDC);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);
                if(CastNoPotionSpellAtLocation(SPELL_DELAYED_BLAST_FIREBALL, 11, lAOELocation, iMod, 17, FALSE, FALSE)) return TRUE; }
            else if(fEnemyDistance < RADIUS_SIZE_HUGE && fEnemyDistance >= 0.0 && iElementalProtection)
                {   lAOELocation = lSpellLocation;
                if(CastNoPotionSpellAtLocation(SPELL_DELAYED_BLAST_FIREBALL, 11, lAOELocation, iMod, 17, FALSE, FALSE)) return TRUE; }
        }
        // Chain lightning - no way of hetting immunity to damage..is there?
        // Never affects allies.
        if(GetIsSpellValid(SPELL_CHAIN_LIGHTNING, 1) && d100() <= 60)
        {
            oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_COLOSSAL, 6, nClassLevel, SAVING_THROW_REFLEX, iSaveDC);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);   }
            else {   lAOELocation = lSpellLocation;    }
                if(CastNoPotionSpellAtLocation(SPELL_CHAIN_LIGHTNING, 1, lAOELocation, iMod, 16, FALSE, FALSE)) return TRUE;
        }
    }
    // Fireball - long range, good damage. Reflex saves, and affects allies (depending on area etc,)
    if(iRangeLong)
    {
        if(GetIsSpellValid(SPELL_FIREBALL, 11))
        {
            oAOE = GetBestAreaSpellTarget(40.0, RADIUS_SIZE_HUGE, 6, nClassLevel, SAVING_THROW_REFLEX, iSaveDC, SHAPE_SPHERE, iFriendlyFireFriendly);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);
                if(CastNoPotionSpellAtLocation(SPELL_FIREBALL, 11, lAOELocation, iMod, 13, FALSE, FALSE)) return TRUE; }
            else if(fEnemyDistance < RADIUS_SIZE_HUGE && fEnemyDistance >= 0.0 && iElementalProtection)
                {   lAOELocation = lSpellLocation;
                if(CastNoPotionSpellAtLocation(SPELL_FIREBALL, 11, lAOELocation, iMod, 13, FALSE, FALSE)) return TRUE; }
        }
    }

    // Level 6 summons here.
    if(!iSummon && (iMyHD <= 14 || iMeleeEnemy < 2))
    {
        if(CastNoPotionSpellAtLocation(SPELL_PLANAR_BINDING, 15, lSummonLocation, iMod, 16, FALSE, TRUE, 66)) return TRUE;
        if(CastNoPotionSpellAtLocation(SPELL_SUMMON_CREATURE_VI, 15, lSummonLocation, iMod, 16, FALSE, TRUE, 66)) return TRUE;
    }

    // This is a touch attack...hmmm. Can kill them though!
    if(iRangeTouch && iRace != RACIAL_TYPE_UNDEAD && iSeenEnemy && iRace != RACIAL_TYPE_CONSTRUCT && !ImmuneNecromancy && !SaveImmune(oSpellTarget, 1, iFortitude, iSaveDC, 5))
    {
        if(CastNoPotionSpellAtObject(SPELL_SLAY_LIVING, 2, oSpellTarget, iMod, 15)) return TRUE;
    }

    // This is here, 100%, if they are powerful. Level 4 spell.
    if(iPartyHD - iMyHD > -5)
        if(CastPotionSpellAtObject(SPELL_DEATH_WARD, 9, OBJECT_SELF, iMod - iCureAdj, 14)) return TRUE;

    // Both are med spells, need seen enemies, and are leve 5 will save spells.
    if(iRangeMed && iSeenEnemy && !SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 5))
    {
        // Hold only if it can be paralised
        if(!ImmuneStun)
            if(CastNoPotionSpellAtObject(SPELL_HOLD_MONSTER, 2, oSpellTarget, iMod, 15, 30)) return TRUE;

        // Only lower INT if able to
        if(GetAbilityScore(oSpellTarget, ABILITY_INTELLIGENCE) >= 12)
            if(CastNoPotionSpellAtObject(SPELL_FEEBLEMIND, 2, oSpellTarget,  iMod, 15, 30)) return TRUE;
    }

    if(iRangeLong)
    {
        // Area acid damage.
        if(GetIsSpellValid(SPELL_ACID_FOG, 11) || GetIsSpellValid(SPELL_CLOUDKILL, 11)
                 || GetIsSpellValid(SPELL_MIND_FOG, 11))
        {
            oAOE = GetBestAreaSpellTarget(50.0, RADIUS_SIZE_HUGE, 5, FALSE, FALSE, SHAPE_SPHERE, iFriendlyFireFriendly);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);   }
            else {   lAOELocation = lSpellLocation;    }
                if(CastNoPotionSpellAtLocation(SPELL_ACID_FOG, 11, lAOELocation, iMod, 16, FALSE, FALSE, 50)) return TRUE;
        }
        // Penalty to will saves.
        // Uncommented, at 10%...and best target (uses exact specs of above as well, for AOE)
        if(CastNoPotionSpellAtLocation(SPELL_MIND_FOG, 11, lAOELocation, iMod, 16, FALSE, FALSE, 10)) return TRUE;

        // Area effect - acid and death for low levels. Best target, uses ACID_FOG  AOE
        if(CastNoPotionSpellAtLocation(SPELL_CLOUDKILL, 11, lAOELocation, iMod, 15, FALSE, FALSE, 20)) return TRUE;
    }

    // This HEALS undead, but hurts others.
    if(iRace != RACIAL_TYPE_UNDEAD && GetIsSpellValid(SPELL_CIRCLE_OF_DOOM, 1) && iRangeMed)
    {
        oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_MEDIUM, FALSE, FALSE, SHAPE_SPHERE, iFriendlyFireFriendly, FALSE, TRUE);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);   }
        else {   lAOELocation = lSpellLocation;    }
            if(CastNoPotionSpellAtLocation(SPELL_CIRCLE_OF_DOOM, 1, lAOELocation, iMod, 15, FALSE, FALSE)) return TRUE;
    }

    if(iRangeShort)
    {
        if(GetIsSpellValid(SPELL_CONE_OF_COLD, 11) && d100() <= 70)
        {
            oAOE = GetBestAreaSpellTarget(8.0, 11.0, 5, nClassLevel, SAVING_THROW_REFLEX, iSaveDC, SHAPE_SPELLCONE, iFriendlyFireFriendly);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);   }
            else {   lAOELocation = lSpellLocation;    }
            // No way to check for cold immunity.
                if(CastNoPotionSpellAtLocation(SPELL_CONE_OF_COLD, 11, lAOELocation, iMod, 15, FALSE, FALSE)) return TRUE;
        }

        // This is the only loop that happens every time, for the cones below.
        oAOE = GetBestAreaSpellTarget(8.0, 10.0, 5, nClassLevel, FALSE, FALSE, SHAPE_SPELLCONE, iFriendlyFireFriendly);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);   }
        else {   lAOELocation = lSpellLocation;    }

        if((GetDistanceToObject(oAOE) < 8.0 && GetDistanceToObject(oAOE) >= 0.0 && GetIsObjectValid(oAOE)) || (fEnemyDistance < 8.0 && fEnemyDistance >= 0.0))
        {
            // Uses the loop above. These are the "Cones". Appropriate to put it here, don'tca think?
            for(iCnt = 229; iCnt <= 235; iCnt++)
            {
                if(CastNoPotionSpellAtLocation(iCnt, 11, lAOELocation, 20, 10, FALSE, FALSE, 60)) return TRUE;
            }
        }
        if(CastNoPotionSpellAtLocation(SPELLABILITY_HELL_HOUND_FIREBREATH, 11, lAOELocation, 20, 10, FALSE, FALSE, 60)) return TRUE;
    }

    // 5 summons. Limiting levels to <= 18 always.
    if(!iSummon && (iMyHD <= 12 || iMeleeEnemy < 2) && iMyHD <= 18)
        if(CastNoPotionSpellAtLocation(SPELL_SUMMON_CREATURE_V, 15, lSummonLocation, iMod, 15)) return TRUE;

//44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
//44444444444444444444444444444444  Level 4 spells  444444444444444444444444444444444444444
//44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
    int iLevelSpellAffected = GetSpellLevelEffect(oSpellTarget);

    if(iRangeMed)
    {
        // Nice area effect spell. Divne damage - Level 4, a spell level check
        if(GetHasSpell(SPELL_HAMMER_OF_THE_GODS) && d100() <= 70)
        {                      // Use will save, might as well. Never affects allies.
            oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_HUGE, 4, nClassLevel, SAVING_THROW_WILL, iSaveDC);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);   }
            else {   lAOELocation = lSpellLocation;    }
                if(CastNoPotionSpellAtLocation(SPELL_HAMMER_OF_THE_GODS, 1, lAOELocation, iMod, 14, FALSE, FALSE)) return TRUE;
        }

        if(iLevelSpellAffected < 4)
        {
            // Not too bad fire damage. Good also for killing off protections.
            // Reflex save added.
            if(!SaveImmune(oSpellTarget, 1, iReflex, iSaveDC, 4) || iMeleeEnemy > 2)
                if(CastNoPotionSpellAtLocation(SPELL_WALL_OF_FIRE, 11, lSpellLocation, iMod, 14, FALSE, FALSE, 30)) return TRUE;

            // Cannot take levels if it is immune, else negative level.
            if(iRangeShort && iSeenEnemy && !ImmuneNegativeLevel && !ImmuneNecromancy  && !SaveImmune(oSpellTarget, 1, iFortitude, iSaveDC, 4))
                if(CastNoPotionSpellAtObject(SPELL_ENERVATION, 2, oSpellTarget, iMod, 14, 30)) return TRUE;
        }

        // Area damage (added best target)
        if(GetIsSpellValid(SPELL_EVARDS_BLACK_TENTACLES, 1) && d100() <= 30)
        {
            oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_LARGE, 4, nClassLevel, SAVING_THROW_FORT, iSaveDC, SHAPE_SPHERE, iFriendlyFireHostile);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);   }
            else {   lAOELocation = lSpellLocation;    }
            if(CastNoPotionSpellAtLocation(SPELL_EVARDS_BLACK_TENTACLES, 1, lAOELocation, iMod, 14, FALSE, FALSE)) return TRUE;
        }
    }

    // Ice storm - decent spell. Best target added
    if(GetIsSpellValid(SPELL_ICE_STORM, 11) && d100() <= 30 && iRangeLong)
    {                          // No saves, only hostiles.
        oAOE = GetBestAreaSpellTarget(40.0, RADIUS_SIZE_HUGE, 4, nClassLevel, FALSE, FALSE, SHAPE_SPHERE, iFriendlyFireFriendly);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);   }
        else {   lAOELocation = lSpellLocation;    }
            if(CastNoPotionSpellAtLocation(SPELL_ICE_STORM, 11, lAOELocation, iMod, 14, FALSE, FALSE)) return TRUE;
    }

    if(iSeenEnemy && iRangeMed && d100() < 30)
    {
        // All ability Draining Bolts. All creature, so no limits.
        if(GetAbilityScore(oSpellTarget, ABILITY_DEXTERITY) >= 10)
            if(CastSpellNormalAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_DEXTERITY, TRUE, oSpellTarget)) return TRUE;
        if(GetAbilityScore(oSpellTarget, ABILITY_WISDOM) >= 12)
            if(CastSpellNormalAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_WISDOM, TRUE, oSpellTarget)) return TRUE;
        if(GetAbilityScore(oSpellTarget, ABILITY_CONSTITUTION) >= 12)
            if(CastSpellNormalAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_CONSTITUTION, TRUE, oSpellTarget)) return TRUE;
        if(GetAbilityScore(oSpellTarget, ABILITY_STRENGTH) >= 12)
            if(CastSpellNormalAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_STRENGTH, TRUE, oSpellTarget)) return TRUE;
        if(GetAbilityScore(oSpellTarget, ABILITY_CHARISMA) >= 14)
            if(CastSpellNormalAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_CHARISMA, TRUE, oSpellTarget)) return TRUE;
        if(GetAbilityScore(oSpellTarget, ABILITY_INTELLIGENCE) >= 14)
            if(CastSpellNormalAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_INTELLIGENCE, TRUE, oSpellTarget)) return TRUE;
        // And the damaging bolts.
        for(iCnt = 211; iCnt <= 288; iCnt++)
        {
            if(CastSpellNormalAtObject(iCnt, TRUE, oSpellTarget)) return TRUE;
        }
     }
//BABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBAB
//
//  BAB check, at thier AC + 10, IE 3 attacks will always hit.
//
//BABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBAB
    if(!iRangedFirst)
    {
        if(nClass != CLASS_TYPE_WIZARD && nClass != CLASS_TYPE_SORCERER && nClass != CLASS_TYPE_FEY)
        {
            if(iBAB >= (GetAC(oSpellTarget) + 10))
                return FALSE;
        }
    }
//BABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBAB
    if(iLevelSpellAffected < 4 && iRangeMed) // all but poison is medium spell.
    {
        // Fear! Boo! only if not immune (level 4 spell).
        if(!ImmuneFear && !ImmuneNecromancy && !SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 4) && d100() <= 40)
            if(CastNoPotionSpellAtLocation(SPELL_FEAR, 1, lSpellLocation, iMod, 14, FALSE, FALSE)) return TRUE;

        if(iSeenEnemy)// These need an object
        {
            // All these 3 need will saves, level 4 spells.
            if(!SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 4))
            {
            // Can the target be affected if immune to death? Yes...but only if it saves once,
            // and then only a bit of damage...so DON'T if immune! (also, twice in time stop & level 4 spell)
                if(!ImmuneDeath)
                    if(CastNoPotionSpellAtObject(SPELL_PHANTASMAL_KILLER, 2, oSpellTarget, iMod, 14, 40, FALSE)) return TRUE;

                // This halts the monster. Good if it affects them.
                if(!ImmuneStun)
                    if(CastNoPotionSpellAtObject(SPELL_HOLD_MONSTER, 2, oSpellTarget, iMod, 14, 100, FALSE)) return TRUE;
                // Confusion can easily wreck some creatures.
                if(!ImmuneMind)
                    if(CastNoPotionSpellAtLocation(SPELL_CONFUSION, 1, lSpellLocation, iMod, 14, FALSE, FALSE, 60)) return TRUE;
            }
            // Poision - needs some more race checks. Undead/construct only for now. No save needed!
            if(iRangeTouch && iRace != RACIAL_TYPE_UNDEAD && iRace != RACIAL_TYPE_CONSTRUCT)
                if(CastNoPotionSpellAtObject(SPELL_POISON, 2, oSpellTarget, iMod + iCureAdj, 14, 100, FALSE)) return TRUE;
        }
    }

    // 4 summons. Limiting levels to <= 16 always.
    if(!iSummon && (iMyHD <= 10 || iMeleeEnemy < 2) && iMyHD <= 16)
        if(CastNoPotionSpellAtLocation(SPELL_SUMMON_CREATURE_IV, 15, lSummonLocation, iMod, 14)) return TRUE;


//BABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBAB
//
//   BAB check, at thier AC + 5, IE 2 attacks will always hit.
//
//BABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBAB
    if(iRangedFirst)
    {
        if(nClass != CLASS_TYPE_WIZARD && nClass != CLASS_TYPE_SORCERER && nClass != CLASS_TYPE_FEY)
        {
            if(iBAB >= (GetAC(oSpellTarget) + 5))
                return FALSE;
        }
    }
//BABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBAB

    if(iLevelSpellAffected < 3 && iSeenEnemy && iRangeMed)
    {
        // If not immune to slow, slow them. May add checks for range, and if only melee attacker
        // Or only enemy
        if(!SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 3))
            if(CastNoPotionSpellAtObject(SPELL_SLOW, 1, oSpellTarget, iMod, 13, 30)) return TRUE;

            if(CastNoPotionSpellAtObject(SPELL_SEARING_LIGHT, 2, oSpellTarget, iMod, 13, 100, FALSE)) return TRUE;
    }
    // Nice electrical (reflex) damage, and no ally hurting!
    if(GetIsSpellValid(SPELL_CALL_LIGHTNING, 1) && iRangeLong)
    {
        oAOE = GetBestAreaSpellTarget(40.0, RADIUS_SIZE_HUGE, 3, nClassLevel, SAVING_THROW_REFLEX, iSaveDC);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);   }
        else {   lAOELocation = lSpellLocation;    }
            if(CastNoPotionSpellAtLocation(SPELL_CALL_LIGHTNING, 1, lAOELocation, iMod, 13, FALSE, FALSE)) return TRUE;
    }
    if(iLevelSpellAffected < 3 && iSeenEnemy)
    {
        if(iRace != RACIAL_TYPE_CONSTRUCT && iRace != RACIAL_TYPE_UNDEAD &&
                fEnemyDistance <= 2.25 && fEnemyDistance >= 0.0 && !ImmuneNecromancy && iRangeTouch)
            if(CastNoPotionSpellAtObject(SPELL_VAMPIRIC_TOUCH, 2, oSpellTarget, iMod, 13, 100, FALSE)) return TRUE;

        if(iRace == RACIAL_TYPE_ANIMAL && iRangeMed && !(ImmuneDomination || ImmuneMind) && !SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 3))
            if(CastNoPotionSpellAtObject(SPELL_DOMINATE_ANIMAL, 2, oSpellTarget, iMod, 13)) return TRUE;
    }
    if(iRangeMed)
    {
        // Fort save or be dazed - area effect, and only affects enemies.
        // When checks for best target are up, get most crowded bit.
        if(GetIsSpellValid(SPELL_STINKING_CLOUD, 11) && d100() <= 25)
        {
            oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_LARGE, 3, nClassLevel, SAVING_THROW_FORT, iSaveDC, SHAPE_SPHERE, iFriendlyFireFriendly);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);   }
            else {   lAOELocation = lSpellLocation;    }
                if(CastNoPotionSpellAtLocation(SPELL_STINKING_CLOUD, 11, lAOELocation, iMod, 13, FALSE, FALSE)) return TRUE;
        }

        // A subsitute for fireball, but is electrical. OK at best. Best target + level 3
        if(GetIsSpellValid(SPELL_LIGHTNING_BOLT, 11) && d100() <= 35)
        {
            oAOE = GetBestAreaSpellTarget(20.0, 30.0, 3, nClassLevel, SAVING_THROW_REFLEX, iSaveDC, SHAPE_SPELLCYLINDER, iFriendlyFireFriendly);
            if(GetIsObjectValid(oAOE))
            {   lAOELocation = GetLocation(oAOE);   }
            else {   lAOELocation = lSpellLocation;    }
                if(CastNoPotionSpellAtLocation(SPELL_LIGHTNING_BOLT, 11, lAOELocation, iMod, 13, FALSE, FALSE)) return TRUE;
        }
    }
    // 4-24 (4d6) fire damage. 1 bolt/4 levels. Not too bad against one target.
    if(iLevelSpellAffected < 3 && iSeenEnemy && iRangeLong && !SaveImmune(oSpellTarget, 2, iReflex, iSaveDC, 3))
        if(CastNoPotionSpellAtObject(SPELL_FLAME_ARROW, 2, oSpellTarget, iMod, 13, 50)) return TRUE;

    // Negative energy burst
    if(GetIsSpellValid(SPELL_NEGATIVE_ENERGY_BURST, 1) && d100() <= 40 && iRangeMed)
    {
        oAOE = GetBestAreaSpellTarget(20.0, RADIUS_SIZE_HUGE, 3, nClassLevel, FALSE, FALSE, SHAPE_SPHERE, iFriendlyFireFriendly);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);   }
        else {   lAOELocation = lSpellLocation;    }
            if(CastNoPotionSpellAtLocation(SPELL_NEGATIVE_ENERGY_BURST, 1, lAOELocation, iMod, 13, FALSE, FALSE)) return TRUE;
    }
    if(iLevelSpellAffected < 3 && iSeenEnemy)// All targeted
    {
        if(iRangeMed) // meduim or lower ranges
        {
            // This is quite good - level 2 for mages, 3 for others.
            if(!SaveImmune(oSpellTarget, 1, iFortitude, iSaveDC, 3))
                    if(CastNoPotionSpellAtObject(SPELL_BLINDNESS_AND_DEAFNESS, 2, oSpellTarget, iMod, 13)) return TRUE;

            if(iRangeTouch)
            {
                // Curse - decrease all stats by 2. Not too bad for an NPC to cast cirtainly (as PC's genrall live longer)
                if(!ImmuneNecromancy && !SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 3))
                    if(CastNoPotionSpellAtObject(SPELL_BESTOW_CURSE, 3, oSpellTarget, iMod, 13, 30)) return TRUE;

                // Diesease - a random one. some are quite good! No save!
                if(!ImmuneDisease && !ImmuneNecromancy)
                    if(CastNoPotionSpellAtObject(SPELL_CONTAGION, 3, oSpellTarget, iMod, 13, 30)) return TRUE;
            }
            // Web - good stopper. Not doing area effect best, because needs entangle checks.
            if(!ImmuneEntangle)
            {
                if(CastNoPotionSpellAtObject(SPELL_WEB, 11, oSpellTarget, iMod, 13, 50)) return TRUE;
                if(CastAttemptedTalentAtObject(SPELL_GREATER_SHADOW_CONJURATION_WEB, 11, oSpellTarget, iMod, 13, 50, FALSE)) return TRUE;
            }
        }
    }

    // 3 summons. Limiting levels to <= 14 always.
    if(!iSummon && (iMyHD <= 8 || iMeleeEnemy < 2) && iMyHD <= 14)
    {
        // Summon an undead monster. Level 3.
        if(CastNoPotionSpellAtLocation(SPELL_ANIMATE_DEAD, 1, lSummonLocation, iMod, 13, FALSE, TRUE)) return TRUE;
        // Summons summoning level 3, of course.
        if(CastNoPotionSpellAtLocation(SPELL_SUMMON_CREATURE_III, 15, lSummonLocation, iMod, 13, FALSE, TRUE)) return TRUE;
    }

//BABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBAB
//
//  BAB check, at thier AC, IE 1 attack will always hit.
//
//BABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBAB
    if(!iRangedFirst)
    {
        if(nClass != CLASS_TYPE_WIZARD && nClass != CLASS_TYPE_SORCERER && nClass != CLASS_TYPE_FEY)
        {
            if(iBAB >= GetAC(oSpellTarget))
                return FALSE;
        }
    }
//BABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBABBAB

//22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
//22222222222222222222222222222222  Level 2 spells  222222222222222222222222222222222222222
//22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222

    // Silence - target at the nearest spellcaster...SPELL_SILENCE
    // Not in a talent, so Normal spell at object.
    if(GetHasSpell(SPELL_SILENCE) && iRangeLong)
    {
        object oCaster = GetNearestCreature(CREATURE_TYPE_REPUTATION,
                REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_CLASS,
                    CLASS_TYPE_SORCERER, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        if(GetIsObjectValid(oCaster))
        {
            if(GetSpellLevelEffect(oCaster) < 2 && (GetWillSavingThrow(oCaster) + 1) <= (iSaveDC + 2) && GetObjectSeen(oCaster))
                if(CastSpellNormalAtObject(SPELL_SILENCE, FALSE, oCaster, iMod, 12)) return TRUE;
        }else{
        oCaster = GetNearestCreature(CREATURE_TYPE_REPUTATION,
                REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_CLASS,
                    CLASS_TYPE_WIZARD, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        if(GetIsObjectValid(oCaster))
            if(GetSpellLevelEffect(oCaster) < 2 && (GetWillSavingThrow(oCaster) + 1) <= (iSaveDC + 2) && GetObjectSeen(oCaster))
                if(CastSpellNormalAtObject(SPELL_SILENCE, FALSE, oCaster, iMod, 12)) return TRUE;
        }
    }

    // Darkness - at the moment, only if ultravision is castable.
    if(GetHasSpell(SPELL_DARKNESS) && !GetHasSpellEffect(SPELL_DARKNESS))
    {
        // Have we got darkvision (ultravision)
        int iDarkvision = FALSE;
        if(GetHasSpell(SPELL_DARKVISION) || GetHasSpellEffect(SPELL_DARKVISION)) iDarkvision = TRUE;
        // 3 Cases. 1: We have melee attackers, and have darkvision.
        if(iMeleeEnemy > 0 && iDarkvision)
        {
            if(CastSpellNormalAtObject(SPELL_DARKNESS, TRUE, OBJECT_SELF, iMod, 12)) return TRUE;
        }
        int iThemUltravision = jGetHasEffect(EFFECT_TYPE_ULTRAVISION, oSpellTarget);
        // Case 2: Enemy is over 5.0M, got darkvision, and they don't have ultravison. Cast on them.
        if(fEnemyDistance > 5.0 && iDarkvision && !iThemUltravision && iRangeLong)
        {
            if(CastNoPotionSpellAtLocation(SPELL_DARKNESS, 11, lSpellLocation, iMod, 12)) return TRUE;
        }
        // If we are not a spellcaster fully, and we have 2 + melee enemy - thus would be
        // good to get consealment, then do it! (we don't NEED ultravision for this)
        // Because it won't be cast by any class that can normally, we don't bother to add in requirements.
        if(nClass != CLASS_TYPE_WIZARD && nClass != CLASS_TYPE_FEY && nClass != CLASS_TYPE_BARD &&
           nClass != CLASS_TYPE_SORCERER && iMeleeEnemy > 1 && !iThemUltravision)
        {
            if(CastSpellNormalAtObject(SPELL_DARKNESS, TRUE)) return TRUE;
        }
    }
    // Not too bad - especially the stun and damage that is sonic (1d8)
    if(GetIsSpellValid(SPELL_SOUND_BURST, 11) && iRangeLong)
    {
        oAOE = GetBestAreaSpellTarget(40.0, RADIUS_SIZE_MEDIUM, 2, nClassLevel, FALSE, FALSE, SHAPE_SPHERE, iFriendlyFireFriendly);
        if(GetIsObjectValid(oAOE))
        {   lAOELocation = GetLocation(oAOE);
            if(CastNoPotionSpellAtLocation(SPELL_SOUND_BURST, 11, lAOELocation, iMod, 12, FALSE, FALSE)) return TRUE; }
        else if(fEnemyDistance < RADIUS_SIZE_MEDIUM && fEnemyDistance >= 0.0 && iElementalProtection)
            {   lAOELocation = lSpellLocation;
            if(CastNoPotionSpellAtLocation(SPELL_SOUND_BURST, 11, lAOELocation, iMod, 12, FALSE, FALSE)) return TRUE; }
    }

    // Acid arrow - good spell. 3d6 acid damage, and more each round
    if(iLevelSpellAffected < 2 && iSeenEnemy && iRangeLong)
    {
        // Ghoul touch OOOOOHHHHHHHHHHHHHHHHHHHHHHHHHHHHH! BOO!
        if(fEnemyDistance < 2.25 && fEnemyDistance >= 0.0 && !ImmuneNecromancy && !SaveImmune(oSpellTarget, 1, iFortitude, iSaveDC, 2) && iRangeTouch)
            if(CastNoPotionSpellAtObject(SPELL_GHOUL_TOUCH, 13, oSpellTarget, iMod, 12)) return TRUE;
        // Melfs arrows are damn-good-spells! L
        if(CastNoPotionSpellAtObject(SPELL_MELFS_ACID_ARROW, 2, oSpellTarget, iMod, 12, 100, FALSE)) return TRUE;
        if(CastAttemptedTalentAtObject(SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW, 2, oSpellTarget, iMod, 12, 100, FALSE)) return TRUE;
        if(iRangeMed)
        {
            // Hold animal - only on animals!
            if(iRace == RACIAL_TYPE_ANIMAL && !ImmuneStun)
                if(CastNoPotionSpellAtObject(SPELL_HOLD_ANIMAL, 2, oSpellTarget, iMod, 13)) return TRUE;
            // Flame lash - fire damage.
            if(iRangeShort && !SaveImmune(oSpellTarget, 2, iReflex, iSaveDC, 2))
                if(CastNoPotionSpellAtObject(SPELL_FLAME_LASH, 2, oSpellTarget, iMod, 12, 100, FALSE)) return TRUE;
        }
    }

    // Level 2 summons. <= 10
    if(!iSummon && (iMyHD <= 6 || iMeleeEnemy < 2) && iMyHD <= 10)
            if(CastNoPotionSpellAtLocation(SPELL_SUMMON_CREATURE_II, 2, lSpellLocation, iMod, 13)) return TRUE;
    // Barkskin - some more AC is not a bad thing.
    if(CastPotionSpellAtObject(SPELL_BARKSKIN, 13, OBJECT_SELF, iMod, 12)) return TRUE;

//11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
//11111111111111111111111111111111  Level 1 spells  111111111111111111111111111111111111111
//11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
//
//   This is a BAB check...if we have a huge BAB. This time, it is AC - 5. Means we need very
//   little to hit them, almost noting, IE 5 or more on a 1d20 to hit.
//
    if(!iRangedFirst)
    {
        if(nClass != CLASS_TYPE_WIZARD && nClass != CLASS_TYPE_SORCERER && nClass != CLASS_TYPE_FEY)
        {
            if(iBAB >= (GetAC(oSpellTarget) - 5))
                return FALSE;
        }
    }
//11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
//11111111111111111111111111111111  Level 1 spells  111111111111111111111111111111111111111
//11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
// Protection from alignment

    // Quite good, I think. +4 AC means much harder to hit (imagine a fighter with no strength bonuses)
    if(CastPotionSpellAtObject(SPELL_MAGE_ARMOR, 13, OBJECT_SELF, iMod, 11)) return TRUE;

    // Cheat and use protection froms. Have to rely upon talents :-/ as cannot specify useing ActionCast
    if(iEnemyAlignment == ALIGNMENT_GOOD)
    {
        if(CastAttemptedTalentAtObject(SPELL_PROTECTION_FROM_GOOD, 13, OBJECT_SELF, iMod, 11)) return TRUE;
    }
    else if(iEnemyAlignment == ALIGNMENT_EVIL)
    {
        if(CastAttemptedTalentAtObject(SPELL_PROTECTION_FROM_EVIL, 13, OBJECT_SELF, iMod, 11)) return TRUE;
    }

    if(iLevelSpellAffected < 1 && iRangeLong)
    {
        if(iSeenEnemy)
        {
        // Negative energy ray is slightly better than MM. Only if can though...
            if(!ImmuneNecromancy && iRace != RACIAL_TYPE_UNDEAD && iRangeMed)
                if(CastNoPotionSpellAtObject(SPELL_NEGATIVE_ENERGY_RAY, 2, oSpellTarget, iMod, 11, 70, FALSE)) return TRUE;

        // 1-5 Magical damaging balls strike the target. 70% chance here, before moving down.
            if(CastNoPotionSpellAtObject(SPELL_MAGIC_MISSILE, 2, oSpellTarget, iMod, 11, 70, FALSE)) return TRUE;
        }
        // Druidy spell - Entangles, and stops, targets if not immune.
        if(!ImmuneEntangle && d100() <= 30)
            if(fEnemyDistance > 4.0)
            {   if(CastNoPotionSpellAtLocation(SPELL_ENTANGLE, 11, lSpellLocation, iMod, 11, FALSE, FALSE)) return TRUE;    }
            else {   if(CastNoPotionSpellAtLocation(SPELL_ENTANGLE, 11, lSpellLocation, iMod, 11, FALSE, FALSE)) return TRUE;    }

        // Slows everyone. Will do it if far enough away
        if(fEnemyDistance > 4.0)
        {   if(CastNoPotionSpellAtLocation(SPELL_GREASE, 12, lSpellLocation, iMod, 11, FALSE, FALSE)) return TRUE;    }
        else {   if(CastNoPotionSpellAtLocation(SPELL_GREASE, 12, lSpellLocation, iMod, 11, FALSE, FALSE, 30)) return TRUE;    }

        if(iSeenEnemy)
        {
            // 1-5 Magical damaging balls strike the target. This is always cast here.
            if(CastNoPotionSpellAtObject(SPELL_MAGIC_MISSILE, 2, oSpellTarget, iMod, 11, 100, FALSE)) return TRUE;

            // Doom is a -2 to many things - skill checks, attack rolls and so on.
            if(!ImmuneMind && !SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 1) && iRangeMed)
                if(CastNoPotionSpellAtObject(SPELL_DOOM, 2, oSpellTarget, iMod, 11)) return TRUE;
        }

        if(iRangeShort)
        {
            if(!SaveImmune(oSpellTarget, 2, iReflex, iSaveDC, 1))
            {
                // 1d4 damage a level, to 5d4. Spell cone and 10.0 range.
                if(iSeenEnemy)
                { if(CastNoPotionSpellAtObject(SPELL_BURNING_HANDS, 11, oSpellTarget, iMod, 11, FALSE, FALSE)) return TRUE; }
                else { if(CastNoPotionSpellAtLocation(SPELL_BURNING_HANDS, 11, lSpellLocation, iMod, 11, FALSE, FALSE)) return TRUE; }
            }
            // Color Spray is an odd spell. <= 2 Sleep, > 2 < 5 Blind, >= 5 Stun
            if(!SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 1))
                if(iSeenEnemy)
                { if(CastNoPotionSpellAtObject(SPELL_COLOR_SPRAY, 11, oSpellTarget, iMod, 11, FALSE, FALSE)) return TRUE; }
                else { if(CastNoPotionSpellAtLocation(SPELL_COLOR_SPRAY, 11, lSpellLocation, iMod, 11, FALSE, FALSE)) return TRUE; }

            // Strength damage is not too bad, but we won't use it on low strength people.
            if(!ImmuneNecromancy && GetAbilityScore(oSpellTarget, ABILITY_STRENGTH) > 10  && !SaveImmune(oSpellTarget, 1, iFortitude, iSaveDC, 1))
                if(CastNoPotionSpellAtObject(SPELL_RAY_OF_ENFEEBLEMENT, 2, oSpellTarget, iMod, 11, 70)) return TRUE;

            // Fear rules...here...only low creatures.
            if(!ImmuneNecromancy && !ImmuneFear && iSeenEnemy && !ImmuneMind && GetHitDice(oSpellTarget) < 6 && !SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 1))
                if(CastNoPotionSpellAtObject(SPELL_SCARE, 11, oSpellTarget, iMod, 11, 70)) return TRUE;
        }

        if(!SaveImmune(oSpellTarget, 3, iWill, iSaveDC, 1))
        {
            // Sleep is good...here...only low creatures. SHAPE_SPHERE, RADIUS_SIZE_HUGE
            if(GetHitDice(oSpellTarget) < 9 && !ImmuneSleep && iRangeMed)
            {
                if(iSeenEnemy)
                { if(CastNoPotionSpellAtObject(SPELL_SLEEP, 11, oSpellTarget, iMod, 11, 70)) return TRUE; }
                else { if(CastNoPotionSpellAtLocation(SPELL_SLEEP, 11, lSpellLocation, iMod, 11, 70)) return TRUE; }
            }
            // Can charm one person...
            if(GetIsHumanoid(oSpellTarget) && iSeenEnemy && !(ImmuneDomination || ImmuneMind) && iRangeShort)
                if(CastNoPotionSpellAtObject(SPELL_CHARM_PERSON, 2, oSpellTarget, iMod, 11)) return TRUE;
        }
    }

    // Level 1 summons, must be <= level 8
    if(!iSummon && (iMyHD <= 4 || iMeleeEnemy < 2) && iMyHD <= 8)
        if(CastNoPotionSpellAtLocation(SPELL_SUMMON_CREATURE_I, 15, lSummonLocation, iMod, 11)) return TRUE;

    // This is when it may loop back, after moving forward a bit
    // Ranges: 40, then 20, 8, and 2.5.
    if((iSeenEnemy || GetObjectHeard(oSpellTarget)) && iRangedFirst)
    {
        if(!iRangeLong)
        {
            SetLocalFloat(OBJECT_SELF, "AI_RANGE_TO_MOVE_TO", 38.0);
            ClearAllActions();
            DebugActionSpeak("Moving nearer, long range not in range. [Enemy]" + GetName(oSpellTarget));
            ActionMoveToObject(oSpellTarget, TRUE, 38.0);
            return TRUE;
        }
        else if(!iRangeMed)
        {
            SetLocalFloat(OBJECT_SELF, "AI_RANGE_TO_MOVE_TO", 18.0);
            ClearAllActions();
            DebugActionSpeak("Moving nearer, medium range not in range. [Enemy]" + GetName(oSpellTarget));
            ActionMoveToObject(oSpellTarget, TRUE, 18.0);
            return TRUE;
        }
        else if(!iRangeShort)
        {
            SetLocalFloat(OBJECT_SELF, "AI_RANGE_TO_MOVE_TO", 6.0);
            ClearAllActions();
            DebugActionSpeak("Moving nearer, short range not in range. [Enemy]" + GetName(oSpellTarget));
            ActionMoveToObject(oSpellTarget, TRUE, 6.0);
            return TRUE;
        }
        else if(!iRangeTouch)
        {
            SetLocalFloat(OBJECT_SELF, "AI_RANGE_TO_MOVE_TO", 1.5);
            ClearAllActions();
            DebugActionSpeak("Moving nearer, touch range not in range. [Enemy]" + GetName(oSpellTarget));
            ActionMoveToObject(oSpellTarget, TRUE, 1.5);
            return TRUE;
        }
    }

    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name ImportCantripSpells
//::///////////////////////////////////////////////
    This will not be used on creatures over 7HD, as
    most will do little damage, and little effect.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int ImportCantripSpells(object oSpellTarget, object oAlly, int iHasAlly, float fAllyDistance, float fEnemyDistance, int iMeleeEnemy, int iRangedEnemy, int iMyHD, int iPartyHD, int iPCHP, int iBAB)
{
//00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
//00000000000000000000000000000000  Level 0 spells  000000000000000000000000000000000000000
//00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    // Not sure of effectiveness...so acting as a contrip.
    if(CastPotionSpellAtObject(SPELL_SANCTUARY, 9, OBJECT_SELF)) return TRUE;

    // iMod is considered 20 for these - they only need 10 int/wis anyway. Would be a waste to check :-)
    int iLevelEffect = GetSpellLevelEffect(oSpellTarget);
    if(iLevelEffect < 1 && GetObjectSeen(oSpellTarget))
    {
        if(CastNoPotionSpellAtObject(SPELL_RAY_OF_FROST, 1, oSpellTarget)) return TRUE;
        // Not too bad, daze is not, if it will affect them!.
        if(!jGetSpawnInCondition(ATTACK_FROM_AFAR_FIRST))
        {
            if(GetHitDice(oSpellTarget) <= 5  && (GetWillSavingThrow(oSpellTarget) + 1) <= (14))
                if(CastNoPotionSpellAtObject(SPELL_DAZE, 1, oSpellTarget, 20, 10, 100, TRUE)) return TRUE;
        }
    }
    if(fEnemyDistance > 3.0 && (GetCurrentHitPoints()  > (GetMaxHitPoints()/4)))
    {
        if(iPartyHD < 4)
        {
            if(CastPotionSpellAtObject(SPELL_RESISTANCE, 9, OBJECT_SELF)) return TRUE;
            if(CastPotionSpellAtObject(SPELL_VIRTUE, 9, OBJECT_SELF)) return TRUE;
            if(iHasAlly && fAllyDistance < 3.0 && fAllyDistance >= 0.0)
            {
                if(CastPotionSpellAtObject(SPELL_RESISTANCE, 9, oAlly)) return TRUE;
                if(CastPotionSpellAtObject(SPELL_VIRTUE, 9, oAlly)) return TRUE;
            }
        }
        if(iHasAlly)
        {
            if(GetHasSpell(SPELL_LIGHT))
            {
                if(GetIsAreaDark())
                {    if(CastSpellNormalAtObject(SPELL_LIGHT, TRUE, OBJECT_SELF, 20, 1, 50)) return TRUE;   }
            }
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name UseSpecialSkills
//::///////////////////////////////////////////////
    This will use pickpocketing (if defined, on spawn)
    taunt, and empathy, if skilled and if appropriate INT
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int UseSpecialSkills(object oEnemy, int iInt, float fEnemyRange, int iMyHD)
{
    if(fEnemyRange < 4.0 && !jGetSpawnInCondition(ARCHER_ATTACKING) && !jGetSpawnInCondition(ATTACK_FROM_AFAR_FIRST))
    {
        if(jGetSpawnInCondition(USE_PICKPOCKETING) && fEnemyRange < 4.0 && iInt >= 3)
        {   // Need appropriate level of skill
            if(GetSkillRank(SKILL_PICK_POCKET) > (iMyHD / 4) && d10() == 1)
            {
                ClearAllActions();
                jEquipAppropriateWeapons(oEnemy, iInt);
                DebugActionSpeak("Using pickpocket [Enemy]" + GetName(oEnemy));
                ActionUseSkill(SKILL_PICK_POCKET, oEnemy);
                ActionAttack(oEnemy);
                return TRUE;
            }
        }
        // If we have 50% in taunt (a decent amount), and concentration ETC are OK...do it!
        if(GetSkillRank(SKILL_TAUNT) >= iMyHD/2 && (GetSkillRank(SKILL_TAUNT) + Random(10) >= GetSkillRank(SKILL_CONCENTRATION, oEnemy)+ Random(10)) && d10() == 1 && iInt >= 2)
        {
            ClearAllActions();
            string sTaunt = GetLocalString(OBJECT_SELF, "AI_TALK_ON_TAUNT");
            if(sTaunt != "") SpeakString(sTaunt);
            jEquipAppropriateWeapons(oEnemy, iInt);
            DebugActionSpeak("Using taunt [Enemy]" + GetName(oEnemy));
            ActionUseSkill(SKILL_TAUNT, oEnemy);
            ActionAttack(oEnemy);
            return TRUE;
        }
        if(d2() == 1 && iInt >= 4)
        {
            int iRace = GetRacialType(oEnemy);
            if(iRace == RACIAL_TYPE_ANIMAL) // 20DC + Hd for animals.
            {
                if((GetSkillRank(SKILL_ANIMAL_EMPATHY) + 10) >= (GetHitDice(oEnemy) + 20))
                {
                    ClearAllActions();
                    DebugActionSpeak("Using animal empathy [Enemy]" + GetName(oEnemy));
                    ActionUseSkill(SKILL_ANIMAL_EMPATHY, oEnemy);
                    return TRUE;
                }
            }
            else if(iRace == RACIAL_TYPE_BEAST || iRace == RACIAL_TYPE_MAGICAL_BEAST)
            {                                  // 24 DC + HD for these.
                if((GetSkillRank(SKILL_ANIMAL_EMPATHY) + 10) >= (GetHitDice(oEnemy) + 24))
                {
                    ClearAllActions();
                    DebugActionSpeak("Using animal empathy [Enemy]" + GetName(oEnemy));
                    ActionUseSkill(SKILL_ANIMAL_EMPATHY, oEnemy);
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name CastCombatHostileSpells
//::///////////////////////////////////////////////
    This will cast all buffs needed, or wanted, before actual combat.
    EG bulls strength for HTH, Cats grace for ranged and so on. Rages
    here, else it may run out if we use spells, and other lower spells as well.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int CastCombatHostileSpells(int nClass, object oTarget, float fEnemyRange, int iMeleeAttackers, object oAlly, int iHasAlly, float fAllyRange, int iMyHD, int iEnemyHD, int iMyBAB)
{
    int iUseSpells = TRUE;
    // Don't chance the use of broken paladin and ranger spells.
    if(nClass == CLASS_TYPE_PALADIN || nClass == CLASS_TYPE_RANGER)
        iUseSpells = FALSE;

    if(iUseSpells)
    {
        if(WandsAvalible || PotionsAvalible)
        {
            if(!jGetHasEffect(EFFECT_TYPE_INVISIBILITY))
            {
                if(CastPotionSpellAtObject(SPELL_INVISIBILITY, 9)) return TRUE;
                if(CastPotionSpellAtObject(SPELL_INVISIBILITY_SPHERE, 8)) return TRUE;
            }
        }
        if(CastSpellNormalAtObject(SPELLABILITY_DIVINE_STRENGTH)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_BATTLE_MASTERY)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_DIVINE_TRICKERY)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_ROGUES_CUNNING)) return TRUE;
        // Good
        if(CastPotionSpellAtObject(SPELL_DIVINE_POWER, 10)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_BULLS_STRENGTH, 9)) return TRUE;
        if(GetAC(OBJECT_SELF) < (iMyHD + 15) && (iMeleeAttackers < 2 || (iMeleeAttackers < 3 && iMyHD < 12)))
        {
            if(CastPotionSpellAtObject(SPELL_CATS_GRACE, 9)) return TRUE;
        }
        int iAC = GetAC(oTarget);
        if(iMyHD < 15 && iMyBAB < iAC + 20 && (iMeleeAttackers < 1 || (iMeleeAttackers < 3 && iMyHD < 10)))
        {
            // Rest of spells. Prayer ETC.
            if(CastPotionSpellAtObject(SPELL_PRAYER, 8)) return TRUE;
            if(iMyHD < 16)
            {
                if(CastPotionSpellAtObject(SPELL_AID, 9)) return TRUE;
                if(iMyHD < 12)
                {
                    // Basically all other spells. Bless and so forth.
                    if(CastPotionSpellAtObject(SPELL_BLESS, 9)) return TRUE;
                }
            }
        }
    }
    // Use all potions, if we are of an invalid class - IE bugged ranger, paladin.
    else
    {
        // This will check it is valid, an so on.
        talent tPotion = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_PROTECTION_POTION, 20);
        if(CastSpellTalentAtObject(tPotion)) return TRUE;
        tPotion = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_POTION, 20);
        if(CastSpellTalentAtObject(tPotion)) return TRUE;
    }
    // Rage - Uses spell script 307.
    if(!GetHasSpellEffect(307) &&
        !GetHasSpellEffect(SPELLABILITY_FEROCITY_1) && !GetHasSpellEffect(SPELLABILITY_FEROCITY_2) && !GetHasSpellEffect(SPELLABILITY_FEROCITY_3) &&
        !GetHasSpellEffect(SPELLABILITY_RAGE_3) && !GetHasSpellEffect(SPELLABILITY_RAGE_4) && !GetHasSpellEffect(SPELLABILITY_RAGE_5) &&
        !GetHasSpellEffect(SPELLABILITY_INTENSITY_1) && !GetHasSpellEffect(SPELLABILITY_INTENSITY_2) && !GetHasSpellEffect(SPELLABILITY_INTENSITY_3))
    {
        if(UseFeatOnObject(FEAT_BARBARIAN_RAGE)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_INTENSITY_1)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_INTENSITY_2)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_INTENSITY_3)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_FEROCITY_1)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_FEROCITY_2)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_FEROCITY_3)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_RAGE_3)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_RAGE_4)) return TRUE;
        if(CastSpellNormalAtObject(SPELLABILITY_RAGE_5)) return TRUE;
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name PolyMorph
//::///////////////////////////////////////////////
    If we are not affected by polymorph, going down from
    best to worst, we will polymorph. Use after combat buffs,
    after spells (although because some are random, this
    may fire when they still have some) and before we attack.
//::///////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
int PolyMorph()
{
    if(!jGetSpawnInCondition(NO_POLYMORPHING))
    {
        if(jGetSpawnInCondition(ARCHER_ATTACKING))
        {
            if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_ARROWS)) || GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BULLETS)) ||
               GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BOLTS)))
            {
                return FALSE;
            }
        }
        // Spells that are tensers transformation and polymorth here.
        // Will cast 100% on all shapechanges. Need to make it check for any spells.
        // Check values needed
        if(!jGetHasEffect(EFFECT_TYPE_POLYMORPH))
        {
            if(CastSpellNormalAtObject(SPELL_SHAPECHANGE, TRUE)) return TRUE;
            if(!GetHasSpellEffect(319))
                if(UseFeatOnObject(FEAT_ELEMENTAL_SHAPE)) return TRUE;
            if(CastPotionSpellAtObject(SPELL_TENSERS_TRANSFORMATION, 10)) return TRUE;
            if(!GetHasSpellEffect(320))
                if(UseFeatOnObject(FEAT_WILD_SHAPE)) return TRUE;
            if(CastSpellNormalAtObject(SPELL_POLYMORPH_SELF, TRUE)) return TRUE;
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name jTalentMeleeAttack
//::///////////////////////////////////////////////
    This was a bioware script. It has been changed a lot.
    Best target if normal int (equal or more than 2).

    Will play a random attack taunt, sometimes.
//::///////////////////////////////////////////////
//:: Created By: Bioware, Modified (a lot) by: Jasperre
//:://///////////////////////////////////////////*/
int jTalentMeleeAttack(object oIntruder, int iInt)
{
    // Default to nearest...
    object oTarget = jGetNearestSeenOrHeardEnemy();;
    if(iInt >= 2)
    {
        oTarget = GetBestTarget();
    }
    object oAreaSelf = GetArea(OBJECT_SELF);
    if(!GetIsObjectValid(oTarget) || GetArea(oTarget) != oAreaSelf || GetIsDead(oTarget))
    {
        // Attempt to get who we attacked last, if no nearest seen/heard/lowest AC
        oTarget = GetAttemptedAttackTarget();
        if(!GetIsObjectValid(oTarget) || GetIsDead(oTarget) || (!GetObjectSeen(oTarget) && !GetObjectHeard(oTarget))
             || GetArea(oTarget) != oAreaSelf)
        {
            // If no valid attack attempt, we will have to have a valid intruder normally.
            oTarget = oIntruder;
            if(!GetIsObjectValid(oTarget) || GetIsDead(oTarget))
            {
                return FALSE;
            }
        }
    }
    // Taunt the enemy!
    if(d100() < 7) PlayRandomAttackTaunt();
    // Clear all acions, and equip our weapons.
    ClearAllActions();
    jEquipAppropriateWeapons(oTarget, iInt);
    // Get the feat to use.
    int iFeat = GetBestFightingFeat(oTarget, BaseAttackBonus(), GetAC(oTarget));
    if(iFeat > 0 && !jGetHasEffect(EFFECT_TYPE_POLYMORPH))
    {
        if(UseFeatOnObject(iFeat, oTarget, FALSE)) return TRUE;
    }
    else
    {
        DebugActionSpeak("Attacking. No Feat. [Enemy] " + GetName(oTarget));
        ActionAttack(oTarget);
        return TRUE;
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name jEquipAppropriateWeapons
//::///////////////////////////////////////////////
    After determining if it has a stored ranged, still
    has it and does not want to use it, it will check
    melee weapons and equip them. Failing it all, it
    goes back to the "most damaging" function.
//::///////////////////////////////////////////////
//:: Created By: Bioware, Modified (a lot) by: Jasperre
//:://///////////////////////////////////////////*/
void jEquipAppropriateWeapons(object oTarget, int iInt)
{
    float fRange = 5.0;
    if(iInt >= 6) fRange = 3.0;
    object oRanged = GetLocalObject(OBJECT_SELF, "DW_RANGED");
        int iRanged = GetIsObjectValid(oRanged);
        if(iRanged && GetItemPossessor(oRanged) != OBJECT_SELF)
        {
            DeleteLocalObject(OBJECT_SELF, "DW_RANGED");
            iRanged = FALSE;
        }
    object oRight = (GetItemInSlot(INVENTORY_SLOT_RIGHTHAND));
    if((GetDistanceToObject(oTarget) > fRange || (GetHasFeat(FEAT_POINT_BLANK_SHOT) && jGetSpawnInCondition(ARCHER_ATTACKING)))
        && iRanged && (oRight != oRanged) && GetIsObjectValid(oTarget))
    {
        ActionEquipItem(oRanged, INVENTORY_SLOT_RIGHTHAND);
    }
    else if(GetDistanceToObject(oTarget) <= fRange || !GetIsObjectValid(oTarget) || !iRanged)
    {
        object oPrimary = GetLocalObject(OBJECT_SELF, "DW_PRIMARY");
            int iPrimary = GetIsObjectValid(oPrimary);
            if(iPrimary && GetItemPossessor(oPrimary) != OBJECT_SELF)
            {
                DeleteLocalObject(OBJECT_SELF, "DW_PRIMARY");
                iPrimary = FALSE;
            }
        object oSecondary = GetLocalObject(OBJECT_SELF, "DW_SECONDARY");
            int iSecondary = GetIsObjectValid(oSecondary);
            if(iPrimary && GetItemPossessor(oSecondary) != OBJECT_SELF)
            {
                DeleteLocalObject(OBJECT_SELF, "DW_SECONDARY");
                iSecondary = FALSE;
            }
        object oShield = GetLocalObject(OBJECT_SELF, "DW_SHIELD");
            int iShield = GetIsObjectValid(oShield);
            if(iPrimary && GetItemPossessor(oShield) != OBJECT_SELF)
            {
                DeleteLocalObject(OBJECT_SELF, "DW_SHIELD");
                iShield = FALSE;
            }
        object oTwoHanded = GetLocalObject(OBJECT_SELF, "DW_TWO_HANDED");
            int iTwoHanded = GetIsObjectValid(oTwoHanded);
            if(iTwoHanded && GetItemPossessor(oTwoHanded) != OBJECT_SELF)
            {
                DeleteLocalObject(OBJECT_SELF, "DW_TWO_HANDED");
                iTwoHanded = FALSE;
            }

        object oLeft = (GetItemInSlot(INVENTORY_SLOT_LEFTHAND));
        // Complete change - it will check the slots, if not eqip, then do so.
        if(iPrimary && (oRight != oPrimary))
        {
            ActionEquipItem(oPrimary, INVENTORY_SLOT_RIGHTHAND);
        }
        if(iSecondary && (oLeft != oSecondary))
        {
            ActionEquipItem(oSecondary, INVENTORY_SLOT_LEFTHAND);
        }
        else if(!iSecondary && iShield && (oLeft != oShield))
        {
            ActionEquipItem(oShield, INVENTORY_SLOT_LEFTHAND);
        }
        if(!iPrimary && iTwoHanded && (oRight != oTwoHanded))
        {
            ActionEquipItem(oTwoHanded, INVENTORY_SLOT_RIGHTHAND);
        }
        // If all else fails...TRY most damaging melee weapon.
        if(!iPrimary && !iTwoHanded)
            ActionEquipMostDamagingMelee(oTarget, TRUE);
    }
}

/*::///////////////////////////////////////////////
//:: GetBestHealingKit
//::///////////////////////////////////////////////
   Returns the best healing kit we have.
//::///////////////////////////////////////////////
//:: Created by: Jasperre
//:://///////////////////////////////////////////*/
object GetBestHealingKit()
{
    object oKit = OBJECT_INVALID;
    object oItem = GetFirstItemInInventory();
    int iRunningValue = 0;
    int iItemValue, iStackSize;
    while(GetIsObjectValid(oItem))
    {
        if(GetBaseItemType(oItem) == BASE_ITEM_HEALERSKIT)
        {
            iItemValue = GetGoldPieceValue(oItem);
            iStackSize = GetNumStackedItems(oItem);
            // Stacked kits be worth what they should be seperatly.
            iItemValue = iItemValue/iStackSize;
            if(iItemValue > iRunningValue)
            {
                iRunningValue = iItemValue;
                oKit = oItem;
            }
        }
        oItem = GetNextItemInInventory();
    }
    return oKit;
}

/*::///////////////////////////////////////////////
//:: ReturnHealingInfo
//::///////////////////////////////////////////////
   Returns the healing info of spell value X
//::///////////////////////////////////////////////
//:: Created by: Jasperre
//:://///////////////////////////////////////////*/
int ReturnHealingInfo(int iSpellID, int iHealAmount)
{
    switch(iSpellID)
    {
// RANK - NAME = D8 AMOUNTs + RANGE OF CLERIC LEVELS ADDED. MAX. AVERAGE OF DICE. ABOUT 2/3 OF MODIFIERS.
        case 31:
        {
            //  20 - Critical = 4d8 + 7-20. Max of 32. Take as 24. Take modifiers as 10.
            if(iHealAmount){ return 34; } else { return 10; }
        }
        break;
        case 32:
        {
            // 8 - Light = 1d8 + 2-5. Max of 8. Take as 6. Take modifiers as 3.
            if(iHealAmount){ return 9; } else { return 2; }
        }
        break;
        case 33:
        {
            // 4 - Minor = 1. Max of 1. Take as 1. Take modifiers as 0.
            // No need for check - healing and rank are both 1.
            return 1;
        }
        break;
        case 34:
        {
            // 12 - Moderate = 2d8 + 3-10. Max of 16. Take as 12. Take modifiers as 5.
            if(iHealAmount){ return 17; } else { return 3; }
        }
        break;
        case 35:
        {
            // 16 - Serious = 3d8 + 5-15. Max of 24. Take as 18. Take modifiers as 7.
            if(iHealAmount){ return 25; } else { return 4; }
        }
        break;
        case 80:
        {
            // 14 - Healing circle = 1d8 + 9-20. Max of 8. Take as 8. Take modifiers as 10.
            if(iHealAmount){ return 18; } else { return 4; }
        }
        break;
        case 277:
        {
            // 10 - Lesser Bodily Adjustment = 1d8 + 1-5. Max of 8. Take as 6. Take modifiers as 3.
            // NOTE: same spell script as Cure Light Wounds, but no concentration check!
            if(iHealAmount){ return 18; } else { return 4; }
        }
        break;
    }
    // On error - return 0 rank, or 0 heal.
    return FALSE;
}

/*::///////////////////////////////////////////////
//:: jGetIsFighting
//::///////////////////////////////////////////////
   Checks if we have any valid targets.
//::///////////////////////////////////////////////
//:: Created by : Bioware. Modified by: Jasperre
//:://///////////////////////////////////////////*/
int jGetIsFighting(int iIncludeInCombat = TRUE)
{
    // My set local target, and combat music checks, if appliable.
    int iMyTarget = FALSE;
    int iInCombat = FALSE;
    if(iIncludeInCombat)
    {
        object oMyTarget = GetLocalObject(OBJECT_SELF, "AI_TO_ATTACK");
        if(GetIsObjectValid(oMyTarget))
        {
            if(GetArea(OBJECT_SELF) == GetArea(oMyTarget))
            {
                iMyTarget = TRUE;
            }
        }
        iInCombat = GetIsInCombat();
    }
    if(GetIsObjectValid(GetAttemptedAttackTarget()) || GetIsObjectValid(GetAttackTarget()) || GetIsObjectValid(GetAttemptedSpellTarget()) || (iInCombat) || (iMyTarget))
    {
        return TRUE;
    }
    return FALSE;
}

/*::///////////////////////////////////////////////
//:: PlayRandomAttackTaunt
//::///////////////////////////////////////////////
    This will play a random taunt or phrase.
    Battle ones only really.
//::///////////////////////////////////////////////
//:: Created by : Jasperre
//:://///////////////////////////////////////////*/
void PlayRandomAttackTaunt(int iRandomness, object oSpeaker)
{
    int iRandom = Random(iRandomness);
    int iVoice = VOICE_CHAT_ATTACK;
    switch (iRandom)
    {
        case 0: iVoice = VOICE_CHAT_ATTACK; break;
        case 1: iVoice = VOICE_CHAT_TAUNT; break;
        case 2: iVoice = VOICE_CHAT_BATTLECRY1; break;
        case 3: iVoice = VOICE_CHAT_BATTLECRY2; break;
        case 4: iVoice = VOICE_CHAT_BATTLECRY3; break;
        case 5: iVoice = VOICE_CHAT_ENEMIES; break;
        case 6: iVoice = VOICE_CHAT_GROUP; break;
        case 7: iVoice = VOICE_CHAT_HELP; break;
        default: iVoice = VOICE_CHAT_ATTACK; break;
    }
    if(jGetSpawnInCondition(GROUP_LEADER) && iVoice == VOICE_CHAT_ATTACK) iVoice = VOICE_CHAT_BATTLECRY1;
    PlayVoiceChat(iVoice, oSpeaker);
}

/*::///////////////////////////////////////////////
//:: Spell casting functions
//::///////////////////////////////////////////////
    Spell casting functions.
//::///////////////////////////////////////////////
//:: Created by : Jasperre
//:://///////////////////////////////////////////*/

// Special case - it checks the talent again, in silence (if not already so) and
// uses the item, if it is an equal talent.
int CastItemEqualTo(object oTarget, int iSpellID, int nTalent, object oEnemy)
{
    int iReturn = FALSE;
    if(ReturnIfTalentEqualsSpell(iSpellID, nTalent))
    {
        // If we are NOT set to only use items, apply silence.
        if(!OnlyUseItems)
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSilence(), OBJECT_SELF);
        }
        talent tBestOfIt = GetCreatureTalentBest(nTalent, 20);
        if(GetIsTalentValid(tBestOfIt) && GetTypeFromTalent(tBestOfIt) == TALENT_TYPE_SPELL
                && GetIdFromTalent(tBestOfIt) == iSpellID)
        {
            ClearAllActions();
            if(iInTimeStop) SetTimeStopStored(iSpellID);
            DebugActionSpeak("Talent(item) [SpellID] " + IntToString(iSpellID) + " [TalentID] " + IntToString(GetIdFromTalent(tBestOfIt)) + " [Target] " + GetName(oTarget));
            // Use this only for items, so we should not have the spell.
            ActionUseTalentOnObject(tBestOfIt, oTarget);
            // As it was an item - attack after (if appropriate).
            if(GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) < 4.0 && GetDistanceToObject(oEnemy) > 0.0)
                    ActionAttack(oEnemy);
            // Return TRUE
            iReturn = TRUE;
        }
        // remove the silence, if so.
        if(!OnlyUseItems)
        {
            effect eSilence = GetFirstEffect(OBJECT_SELF);
            while(GetIsEffectValid(eSilence))
            {
                if(GetEffectType(eSilence) == EFFECT_TYPE_SILENCE)
                {
                    RemoveEffect(OBJECT_SELF, eSilence);
                    break;
                }
                eSilence = GetNextEffect(OBJECT_SELF);
            }
        }
    }
    return iReturn;
}
// Location Variant.
int CastItemLocationEqualTo(location lLocation, int iSpellID, int nTalent, object oEnemy)
{
    int iReturn = FALSE;
    if(ReturnIfTalentEqualsSpell(iSpellID, nTalent))
    {
        // If we are NOT set to only use items, apply silence.
        if(!OnlyUseItems)
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSilence(), OBJECT_SELF);
        }
        talent tBestOfIt = GetCreatureTalentBest(nTalent, 20);
        if(GetIsTalentValid(tBestOfIt) && GetTypeFromTalent(tBestOfIt) == TALENT_TYPE_SPELL
                && GetIdFromTalent(tBestOfIt) == iSpellID)
        {
            ClearAllActions();
            if(iInTimeStop) SetTimeStopStored(iSpellID);
            DebugActionSpeak("Talent(item) Location [SpellID] " + IntToString(iSpellID) + " [TalentID] " + IntToString(GetIdFromTalent(tBestOfIt)));
            // Use this only for items, so we should not have the spell.
            ActionUseTalentAtLocation(tBestOfIt, lLocation);
            // As it was an item - attack after (if appropriate).
            if(GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) < 4.0 && GetDistanceToObject(oEnemy) > 0.0)
                    ActionAttack(oEnemy);
            // Return TRUE
            iReturn = TRUE;
        }
        // remove the silence, if so.
        if(!OnlyUseItems)
        {
            effect eSilence = GetFirstEffect(OBJECT_SELF);
            while(GetIsEffectValid(eSilence))
            {
                if(GetEffectType(eSilence) == EFFECT_TYPE_SILENCE)
                {
                    RemoveEffect(OBJECT_SELF, eSilence);
                    break;
                }
                eSilence = GetNextEffect(OBJECT_SELF);
            }
        }
    }
    return iReturn;
}
int CastSpellNormalAtObject(int nSpellID, int iNoAttackAfter, object oTarget, int iModifier, int iRequirement, int iChance)
{
    if(GetHasSpell(nSpellID) && iModifier >= iRequirement && !OnlyUseItems)
    {
        if(iChance < 100)
        {
            if(d100() > iChance) return FALSE;
        }
        if(!GetHasSpellEffect(nSpellID, oTarget))
        {
            ClearAllActions();
            if(iInTimeStop)  SetTimeStopStored(nSpellID);
            DebugActionSpeak("NormalSpell. [ID] " + IntToString(nSpellID) + " [Target] " + GetName(oTarget));
            ActionCastSpellAtObject(nSpellID, oTarget);
            if(oTarget == OBJECT_SELF && !iNoAttackAfter)
            {
                object oEnemy = jGetNearestSeenOrHeardEnemy();
                if(GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) < 6.0 && GetDistanceToObject(oEnemy) > 0.0)
                    ActionAttack(oEnemy);
            }
            return TRUE;
        }
    }
    return FALSE;
}

int CastPotionSpellAtObject(int iSpellID, int nTalent, object oTarget, int iModifier, int iRequirement, int iChance)
{
    if(iChance < 100)
    {
        if(d100() > iChance) return FALSE;
    }
    if(!GetHasSpellEffect(iSpellID, oTarget))
    {
        if((iInTimeStop && !CompareTimeStopStored(iSpellID)) || !iInTimeStop)
        {
            // Cast the spell, if we have the right modifier.
            if(GetHasSpell(iSpellID) && iModifier >= iRequirement && !OnlyUseItems)
            {
                ClearAllActions();
                if(iInTimeStop) SetTimeStopStored(iSpellID);
                DebugActionSpeak("NormalSpell. [ID] " + IntToString(iSpellID) + " [Target] " + GetName(oTarget));
                ActionCastSpellAtObject(iSpellID, oTarget);
                return TRUE;
            }
            if(WandsAvalible)// Need to have some items for these talents!
            {
                if(CastItemEqualTo(oTarget, iSpellID, nTalent, jGetNearestSeenOrHeardEnemy())) return TRUE;
            }
            if(oTarget == OBJECT_SELF && PotionsAvalible)
            {
                // Potion spell setting correctly. SELF and SINLGE checked in potions (not AOE's).
                int iPotionSpell = 0;
                if(nTalent == 7){ iPotionSpell = 20; }
                else if(nTalent == 9 || nTalent == 10){ iPotionSpell = 21; }
                else if(nTalent == 12 || nTalent == 13){ iPotionSpell = 20; }
                if(iPotionSpell > 0)
                {
                    if(CastItemEqualTo(oTarget, iSpellID, nTalent, jGetNearestSeenOrHeardEnemy())) return TRUE;
                }
            }
        }
    }
    return FALSE;
}

int CastNoPotionSpellAtObject(int iSpellID, int nTalent, object oTarget, int iModifier, int iRequirement, int iChance, int DoubleTimeStop)
{
    if(iChance < 100)
    {
        if(d100() > iChance) return FALSE;
    }
    if(!GetHasSpellEffect(iSpellID, oTarget)
        && ((DoubleTimeStop && iInTimeStop && !CompareTimeStopStored(iSpellID))
        || !DoubleTimeStop || !iInTimeStop))
    {
        if(GetHasSpell(iSpellID) && iModifier >= iRequirement && !OnlyUseItems)
        {
            ClearAllActions();
            DebugActionSpeak("NormalSpell. [ID] " + IntToString(iSpellID) + " [Target] " + GetName(oTarget));
            ActionCastSpellAtObject(iSpellID, oTarget);
            return TRUE;
        }
        if(WandsAvalible)// Need to have some items for these talents!
        {
            if(CastItemEqualTo(oTarget, iSpellID, nTalent, jGetNearestSeenOrHeardEnemy())) return TRUE;
        }
    }
    return FALSE;
}

int CastNoPotionSpellAtLocation(int iSpellID, int nTalent, location lLocation, int iModifier, int iRequirement,  int AndAttack, int DoubleTimeStop, int iChance)
{
    if(iChance < 100)
    {
        if(d100() > iChance) return FALSE;
    }
    if((DoubleTimeStop && iInTimeStop && !CompareTimeStopStored(iSpellID)) || !iInTimeStop || !DoubleTimeStop)
    {
        object oEnemy = OBJECT_INVALID;
        if(AndAttack)
        {
            object oEnemy = jGetNearestSeenOrHeardEnemy();
        }
        if(GetHasSpell(iSpellID) && iModifier >= iRequirement && !OnlyUseItems)
        {
            ClearAllActions();
            DebugActionSpeak("NormalSpell. Location. [ID] " + IntToString(iSpellID));
            // BUGGY! Metamagic feats and this bugger it up!
            // We will only do this if we cannot see target, hopefully.
            ActionCastSpellAtLocation(iSpellID, lLocation);
            if(AndAttack)
            {
                if(GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) < 4.0)
                    ActionAttack(oEnemy);
            }
            return TRUE;
        }
        if(WandsAvalible)// Need to have some items for these talents!
        {
            if(CastItemLocationEqualTo(lLocation, iSpellID, nTalent, jGetNearestSeenOrHeardEnemy())) return TRUE;
        }
    }
    return FALSE;
}

int CastSpellTalentAtObject(talent tTalent, object oTarget)
{
    if(GetIsTalentValid(tTalent) && !GetHasSpellEffect(GetIdFromTalent(tTalent), oTarget))
    {
        ClearAllActions();
        DebugActionSpeak("Talent(item or spell). [ID] " + IntToString(GetIdFromTalent(tTalent)) + " [Target] " + GetName(oTarget));
        if(!GetHasSpell(GetIdFromTalent(tTalent)) && GetTypeFromTalent(tTalent) == TALENT_TYPE_SPELL)
        {
            ActionUseTalentOnObject(tTalent, oTarget);
            if(oTarget == OBJECT_SELF)
            {
                object oEnemy = jGetNearestSeenOrHeardEnemy();
                if(GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) < 4.0 && GetDistanceToObject(oEnemy) > 0.0)
                     ActionAttack(oEnemy);
            }
        }
        else if(!OnlyUseItems)
            //Else we either have the spell, or it is not a spell at all. Need to be not silenced if so.
        {
            ActionUseTalentOnObject(tTalent, oTarget);
        }
        return TRUE;
    }
    return FALSE;
}

int CastAttemptedTalentAtObject(int iSpellID, int nTalent, object oTarget, int iModifier, int iRequirement, int iChance, int iDoubleTimeStop)
{
    if(iChance < 100)
    {
        if(d100() > iChance) return FALSE;
    }
    if(!GetHasSpellEffect(iSpellID, oTarget) &&  (iInTimeStop && iDoubleTimeStop &&
       !CompareTimeStopStored(iSpellID) || !iDoubleTimeStop || !iInTimeStop))
    {
        talent tUse;
        if(GetHasSpell(iSpellID) && iModifier >= iRequirement && !OnlyUseItems)
        {
            tUse = GetCreatureTalentBest(nTalent, 20);
            if(GetIsTalentValid(tUse) && GetIdFromTalent(tUse) == iSpellID)
            {
                ClearAllActions();
                DebugActionSpeak("Talent(Attempted)(Spell). [ID] " + IntToString(iSpellID) + " [TalentID] " + IntToString(GetIdFromTalent(tUse)) + " [Target] " + GetName(oTarget));
                ActionUseTalentOnObject(tUse, oTarget);
            }
        }
        if(WandsAvalible)
        {
            if(CastItemEqualTo(oTarget, iSpellID, nTalent, jGetNearestSeenOrHeardEnemy())) return TRUE;
        }
        if(oTarget == OBJECT_SELF && PotionsAvalible)
        {
            // Potion spell setting correctly. SELF and SINLGE checked in potions (not AOE's).
            int iPotionSpell = 0;
            if(nTalent == 7){ iPotionSpell = 20; }
            else if(nTalent == 9 || nTalent == 10){ iPotionSpell = 21; }
            else if(nTalent == 12 || nTalent == 13){ iPotionSpell = 20; }
            if(iPotionSpell > 0)
            {
                if(CastItemEqualTo(oTarget, iSpellID, nTalent, jGetNearestSeenOrHeardEnemy())) return TRUE;
            }
        }
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: GoodTimeToInvisSelf
//::///////////////////////////////////////////////
   Checks enemy condition, and if they can cast invis and protections they
   do not have...then casts spells if appropriate.
//::///////////////////////////////////////////////
//:: Created by : Jasperre
//:://///////////////////////////////////////////*/
int GoodTimeToInvisSelf(int iAttackers, int iMyHD, int iRangedAttackers, int iAverageHD)
{
    int iDarkness = FALSE;
    if(GetHasSpell(SPELL_DARKNESS) && GetHasSpell(SPELL_DARKVISION)) iDarkness = TRUE;
    if(GetHasSpell(SPELL_IMPROVED_INVISIBILITY) || GetHasSpell(SPELL_INVISIBILITY) ||
       GetHasSpell(SPELL_INVISIBILITY_SPHERE) || (iDarkness))
    {
        // Have we got the invisibility effects from a spell? Don't want to.
        if(!jGetHasEffect(EFFECT_TYPE_INVISIBILITY) && !jGetHasEffect(EFFECT_TYPE_IMPROVEDINVISIBILITY))
        {
            // Can anyone see me? (has spell effects of X)
            object oSeeMe = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_HAS_SPELL_EFFECT, SPELL_TRUE_SEEING);
            if(!GetIsObjectValid(oSeeMe))
            {
                oSeeMe = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_HAS_SPELL_EFFECT, SPELL_SEE_INVISIBILITY);
                if(!GetIsObjectValid(oSeeMe))
                {
                    oSeeMe = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_HAS_SPELL_EFFECT, SPELL_INVISIBILITY_PURGE);
                }
            }
            // First, need the spell and only if anyone in 60M can hear/see already (eg stealth)
            if(!GetIsObjectValid(oSeeMe))
            {
                if((iAttackers > (iMyHD / 4)) || (iAverageHD > iMyHD - 2) || (iRangedAttackers > iMyHD / 3))
                {
                    // We need to have darkvision as well, for darkness.
                    if(iDarkness) if(CastSpellNormalAtObject(SPELL_DARKNESS)) return TRUE;
                    if(CastPotionSpellAtObject(SPELL_IMPROVED_INVISIBILITY, 9)) return TRUE;
                    if(CastPotionSpellAtObject(SPELL_INVISIBILITY_SPHERE, 8)) return TRUE;
                    if(CastPotionSpellAtObject(SPELL_INVISIBILITY, 9)) return TRUE;
                }
            }
        }
    }
    // Else cannot cast invis, or not worth it.
    return FALSE;
}

int AmInvisibleCasting(int iMod, object NearestEnemy)
{
    if(!GetIsAnyoneAttackingTarget())
    {
        if(((jGetHasEffect(EFFECT_TYPE_INVISIBILITY) || jGetHasEffect(EFFECT_TYPE_IMPROVEDINVISIBILITY)) &&
            ((GetHasSpellEffect(SPELL_DARKNESS) && GetHasSpellEffect(SPELL_DARKVISION)) || !GetHasSpellEffect(SPELL_DARKNESS)))
            || !GetObjectSeen(NearestEnemy))
        {
        // Actions for invis spells...
            if(CastPotionSpellAtObject(SPELL_HASTE, 9, OBJECT_SELF, iMod, 13)) return TRUE;
            if(CastPhysicalProtections(iMod)) return TRUE;
            if(CastMantalProtections(iMod)) return TRUE;
            if(CastPotionSpellAtObject(SPELL_TRUE_SEEING, 6, OBJECT_SELF, iMod, 16)) return TRUE;
            if(CastVisageProtections(iMod)) return TRUE;
            if(CastPotionSpellAtObject(SPELL_ELEMENTAL_SHIELD, 12, OBJECT_SELF, iMod, 14)) return TRUE;
            if(CastElementalProtections(iMod)) return TRUE;
            if(CastGlobeProtections(iMod)) return TRUE;
            if(CastPotionSpellAtObject(SPELL_PROTECTION_FROM_SPELLS, 14, OBJECT_SELF, iMod, 17)) return TRUE;
            if(GetHitDice(OBJECT_SELF) < 14)
                if(CastPotionSpellAtObject(SPELL_MAGE_ARMOR, 13, OBJECT_SELF, iMod, 11)) return TRUE;
        }
    }
    return FALSE;
}

int CastRightSpellHelp(int nClass, int iMod)
{
    if(nClass == CLASS_TYPE_WIZARD)
    {
        if(CastPotionSpellAtObject(SPELL_FOXS_CUNNING, 9, OBJECT_SELF, iMod, 12)) return TRUE;
    }
    else if(nClass == CLASS_TYPE_DRUID || nClass == CLASS_TYPE_CLERIC)
    {
        if(CastPotionSpellAtObject(SPELL_OWLS_WISDOM, 9, OBJECT_SELF, iMod, 12)) return TRUE;
    }
    else // Monsters probably benifit from this as well.
    {
        if(CastPotionSpellAtObject(SPELL_EAGLE_SPLEDOR, 9, OBJECT_SELF, iMod, 12)) return TRUE;
    }
    return FALSE;
}

// Stoneskin protections. Will return TRUE if it casts it on self.
int CastPhysicalProtections(int iMod)
{
    if(!HasStoneskinProtections())
    {
        if(CastPotionSpellAtObject(SPELL_PREMONITION, 12, OBJECT_SELF, iMod, 18)) return TRUE;// !!!WORKING!!!
        if(CastPotionSpellAtObject(SPELL_GREATER_STONESKIN, 12, OBJECT_SELF, iMod, 16)) return TRUE;// !!!WORKING!!!
        if(CastPotionSpellAtObject(SPELL_STONESKIN, 13, OBJECT_SELF, iMod, 14)) return TRUE;// !!!WORKING!!!
    }
    return FALSE;
}
// Spell Mantals on self
int CastMantalProtections(int iMod)
{
    if(!HasMantalProtections())
    {
        if(CastPotionSpellAtObject(SPELL_GREATER_SPELL_MANTLE, 12, OBJECT_SELF, iMod, 19)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_SPELL_MANTLE, 12, OBJECT_SELF, iMod, 17)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_LESSER_SPELL_MANTLE, 12, OBJECT_SELF, iMod, 15)) return TRUE;
    }
    return FALSE;
}
// Both Globes, if it can
int CastGlobeProtections(int iMod)
{
    if(!HasGlobeProtections())
    {
        if(CastPotionSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, 12, OBJECT_SELF, iMod, 16)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, 12, OBJECT_SELF, iMod, 14)) return TRUE;
        if(CastAttemptedTalentAtObject(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE, 12, OBJECT_SELF, iMod, 14)) return TRUE;
    }
    return FALSE;
}
// Things like elemental buffer, or whatever..
int CastElementalProtections(int iMod)
{
    if(!HasElementalProtections())
    {
        if(CastPotionSpellAtObject(SPELL_ENERGY_BUFFER, 12, OBJECT_SELF, iMod, 15)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_PROTECTION_FROM_ELEMENTS, 13, OBJECT_SELF, iMod, 13)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_RESIST_ELEMENTS, 13, OBJECT_SELF, iMod, 12)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_ENDURE_ELEMENTS, 13, OBJECT_SELF, iMod, 11)) return TRUE;
    }
    return FALSE;
}

// Shadow shield, etc. Best.
int CastVisageProtections(int iMod)
{
    if(!HasVisageProtections())
    {
        if(CastPotionSpellAtObject(SPELL_SHADOW_SHIELD, 12, OBJECT_SELF, iMod, 17)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_ETHEREAL_VISAGE, 10, OBJECT_SELF, iMod, 16)) return TRUE;
        if(CastPotionSpellAtObject(SPELL_GHOSTLY_VISAGE, 12, OBJECT_SELF, iMod, 12)) return TRUE;
    }
    return FALSE;
}
// If they have the feat, they will use it on the target, and return TRUE
int UseFeatOnObject(int iFeat, object oObject, int iClearActions)
{
    if(GetHasFeat(iFeat) && GetIsObjectValid(oObject))
    {
        if(!GetHasFeatEffect(iFeat, oObject))
        {
            if(iClearActions)
                ClearAllActions();
            DebugActionSpeak("Feat. [ID] " + IntToString(iFeat) + " [Enemy] " + GetName(oObject));
            ActionUseFeat(iFeat, oObject);
            if(oObject == OBJECT_SELF)
            {
                object oEnemy = jGetNearestSeenOrHeardEnemy();
                if(GetIsObjectValid(oEnemy))
                    ActionAttack(oEnemy);
            }
            return TRUE;
        }
    }
    return FALSE;
}

/*::///////////////////////////////////////////////
//:: Respond To Shouts
//:: Copyright (c) 2001 Bioware Corp.
//::///////////////////////////////////////////////
 Useage:

//NOTE ABOUT BLOCKERS

    int NW_GENERIC_SHOUT_BLOCKER = 2;

    It should be noted that the Generic Script for On Dialogue attempts to get a local
    set on the shouter by itself. This object represents the LastOpenedBy object.  It
    is this object that becomes the oIntruder within this function.

//NOTE ABOUT INTRUDERS

    These are the enemy that attacked the shouter.

//NOTE ABOUT EVERYTHING ELSE

    int I_WAS_ATTACKED = 1;

    If not in combat, attack the attackee of the shouter

    int CALL_TO_ARMS = 3;

    If not in combat, determine combat round.

//::///////////////////////////////////////////////
// Modified almost completely: Jasperre
//:://///////////////////////////////////////////*/

void jRespondToShout(object oShouter, int nShoutIndex, object oIntruder)
{
    // Set up fleeing items, which we will always use just now.
    object oFleeTo = GetLocalObject(OBJECT_SELF, "AI_FLEE_TO");
    int iFlee = GetIsObjectValid(oFleeTo);
    float fFleeDistance = GetDistanceToObject(oFleeTo);
    // If we are wanting to flee, do not react.
    if((iFlee && fFleeDistance < 8.0 && fFleeDistance > 0.0) || !iFlee)
    {
        float fRangeToAlly  = IntToFloat(GetCreatureSize(OBJECT_SELF) * 3) + 1.6;
        switch (nShoutIndex)
        {
            case ASSOCIATE_COMMAND_ATTACKNEAREST:
            {
                // If a leader says this (checked in default4),
                // they will attack the enemy (if no melee attackers or not already, and seen)
                if(GetIsObjectValid(oIntruder) && jGetNumberOfMeleeAttackers() < 1 && GetAttackTarget() != oIntruder && GetObjectSeen(oIntruder))
                {
                    ClearAllActions();
                    jDetermineCombatRound(oIntruder);
                }
            }
            break;

            case 0://ANYTHING_SAID, used to attack ENEMY SPEAKERS:
            {
                if(GetIsEnemy(oShouter) && !GetFactionEqual(oShouter))
                {
                    if((iFlee && fFleeDistance < 8.0 && fFleeDistance > 0.0) || !iFlee)
                    {
                        // if I can see neither the shouter nor the enemy
                        if(!GetObjectSeen(oShouter))
                        {
                            ClearAllActions();
                            // and move to that location
                            ActionMoveToObject(oShouter, TRUE, fRangeToAlly);
                        }
                        // If we can see the intruder OR the shouter, attack the intruder.
                        else if(GetObjectSeen(oShouter))
                        {
                            ClearAllActions();
                            jDetermineCombatRound(oShouter);
                        }
                        // Shout to other allies, after a second.
                        float fDelay = (IntToFloat(d10())/10);
                        DelayCommand(fDelay, SpeakString("I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK));
                    }
                }
            }
            break;

            case 1://I_WAS_ATTACKED:
            {
                if(GetDistanceToObject(oShouter) > 3.0)// If they are close, don't react.
                {
                    if((iFlee && fFleeDistance < 8.0 && fFleeDistance > 0.0) || !iFlee)
                    {
                        if(GetIsObjectValid(oShouter) && GetIsObjectValid(oIntruder)&& !GetFactionEqual(oIntruder))
                        {
                            if(GetObjectSeen(oIntruder))
                            {
                                // Stop, and attack, if we can see them!
                                ClearAllActions();
                                DebugActionSpeak("Attacking seen intruder [Intruder] " + GetName(oIntruder));
                                jDetermineCombatRound(oIntruder);
                            }
                            else // Else the enemy is not seen
                            {
                                // If I can see neither the shouter nor the enemy
                                if(!GetObjectSeen(oShouter))
                                {
                                    // stop what I am doing, and move to them.
                                    ClearAllActions();
                                    DebugActionSpeak("Moving to location of shouter [Shouter] " + GetName(oShouter));
                                    ActionMoveToLocation(GetLocation(oShouter), TRUE);
                                }
                                // Otherwise, if I can see the shouter but not the enemy
                                else if(GetObjectSeen(oShouter))
                                {
                                    // stop what I am doing
                                    ClearAllActions();
                                    // and move towards the shouter
                                    DebugActionSpeak("Moving to shouter [Shouter] " + GetName(oShouter));
                                    ActionMoveToObject(oShouter, TRUE);
                                }
                            }
                            // Shout to other allies, after a second.
                            //float fDelay = IntToFloat(d3());
                            //DelayCommand(fDelay, SpeakString("HELP_MY_FRIEND", TALKVOLUME_SILENT_TALK));
                        }
                    }
                }
            }
            break;

            //For this shout to work the object must shout the following
            //string sHelp = "NW_BLOCKER_BLK_" + GetTag(OBJECT_SELF);
            case 2: //BLOCKER OBJECT HAS BEEN DISTURBED
            {
                if((iFlee && fFleeDistance < 8.0 && fFleeDistance > 0.0) || !iFlee)
                {
                    if(GetIsObjectValid(oIntruder) && !GetIsDM(oIntruder) && !GetFactionEqual(oIntruder))
                    {
                        SetIsTemporaryEnemy(oIntruder);
                        DebugActionSpeak("Attacking a blocker [Blocker Intruder] " + GetName(oIntruder));
                        jDetermineCombatRound(oIntruder);
                    }
                }
            }
            break;

            case 3: //CALL_TO_ARMS
            {
                if((iFlee && fFleeDistance < 8.0 && fFleeDistance > 0.0) || !iFlee)
                {
                    if(d4() == 1)
                    {
                        PlayRandomAttackTaunt();
                    }
                    DebugActionSpeak("Responding to Call To Arms.");
                    jDetermineCombatRound();
                }
            }
            break;

            case 4:// HELP_MY_FRIEND
            {
                if(GetCurrentAction() != ACTION_MOVETOPOINT)
                {
                    if((iFlee && fFleeDistance < 8.0 && fFleeDistance > 0.0) || !iFlee)
                    {
                        float fShouterDistance = GetDistanceToObject(oShouter);
                        // All this does is move the person, if they are within 60.0M
                        if(fShouterDistance < 60.0 && fShouterDistance > 0.0)
                        {
                            // If they are valid, we will attack them.
                            if(GetIsObjectValid(oIntruder))
                            {
                                DebugActionSpeak("Help Friend. Attack Intruder [Intruder] " + GetName(oIntruder));
                                jDetermineCombatRound(oIntruder);
                            }
                            else
                            {
                                // If we do not know of the friend attacker, we will follow them
                                ClearAllActions();
                                DebugActionSpeak("Moving to shouter, of friend call [Ally] " + GetName(oShouter));
                                ActionMoveToObject(oShouter, TRUE, fRangeToAlly);
                            }
                        }
                    }
                }
            }
            break;

            case 5:// LEADER_FLEE_NOW
            {
                // Special: Intruder is the ally we are running to!
                if(GetCurrentAction() != ACTION_MOVETOPOINT)
                {
                    object oFlee = GetLocalObject(OBJECT_SELF, "AI_TO_FLEE");
                    // RUN! If intruder set is over 5.0M or no valid intruder
                    ClearAllActions();
                    if(GetIsObjectValid(oIntruder) && GetIsFriend(oIntruder) && GetDistanceToObject(oIntruder) > 5.0)
                    {
                        if(oIntruder != oFlee)
                           SetLocalObject(OBJECT_SELF, "AI_TO_FLEE", oIntruder);
                        DebugActionSpeak("Fleeing, as leader states [Leader]" + GetName(oShouter) + " [To Flee To] " + GetName(oIntruder));
                        ActionMoveToObject(oIntruder);
                    }
                    else // Else, we will just follow our leader!
                    {
                        SetLocalObject(OBJECT_SELF, "AI_TO_FLEE", oShouter);
                        DebugActionSpeak("Fleeing, following leader leader states [Leader]" + GetName(oShouter));
                        ActionForceFollowObject(oShouter, fRangeToAlly);
                    }
                }
            }
            break;
        }
    }
}

/*::///////////////////////////////////////////////
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: jDetermineCombatRound
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////

    This runs what the creature will cast or attack or heal

//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Modified heavily By: Jasperre
//:: Created On: Oct 16, 2001. Modified from: Jan, 13, 2003
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//::////////////////////////////////////////////*/

void jDetermineCombatRound(object oIntruder = OBJECT_INVALID)
{
    // New check - If they are commandable, and no stupid ones.
    if (GetIsUnCommandable())
         return;

    int iAction = GetCurrentAction();
    // If we are using a cirtain skill or similar, don't try and attack.
    if(iAction == ACTION_TAUNT || iAction == ACTION_SETTRAP || iAction == ACTION_PICKUPITEM ||
       iAction == ACTION_PICKPOCKET || iAction == ACTION_OPENDOOR || iAction == ACTION_OPENLOCK ||
       iAction == ACTION_HEAL || iAction == ACTION_ANIMALEMPATHY)
            return;
    // Set oAlly to nearest ally
    object oAlly = GetNearestAlly();
    int iHasAlly = GetIsObjectValid(oAlly);
    object oTarget;
    // How intelligent shall we be?
    int iMyIntelligence = jGetIntelligence();
    // Because Dwarf is 0, we add one to the race to use at spawn, then
    // take one here, to have a valid check.
    int iFavouredRace = GetLocalInt(OBJECT_SELF, "AI_FAVOURED_ENEMY_RACE");
    if(iFavouredRace > 0)
    {
        iFavouredRace = iFavouredRace - 1;
        if(GetRacialType(oTarget) != iFavouredRace || !GetIsObjectValid(oTarget))
        {
            object oFavoured = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_RACIAL_TYPE, iFavouredRace);
            if(GetIsObjectValid(oFavoured) && !GetIsDead(oFavoured))
            {
                oTarget = oFavoured;
            }
        }
    }
    // These scripts use an ally as the target...have we got one?
    if (((jGetHasEffect(EFFECT_TYPE_CONFUSED) && d2() == 1) ||
          jGetHasEffect(EFFECT_TYPE_CHARMED)) && iHasAlly)
    {
        if(iHasAlly)
        {
            oTarget = oAlly;
        }
        else
        {
            return;
        }
    }
    int iMyRace = GetRacialType(OBJECT_SELF);
    // This is set OnSpawn - if we have items with spells, we will try talents
    // else not. To save memory.
    int iItems, iPotions;
    // We cannot use items as cirtain races! Duh!
    if(iMyRace == RACIAL_TYPE_ABERRATION || iMyRace == RACIAL_TYPE_ANIMAL || iMyRace == RACIAL_TYPE_BEAST ||
       iMyRace == RACIAL_TYPE_CONSTRUCT || iMyRace == RACIAL_TYPE_DRAGON || iMyRace == RACIAL_TYPE_ELEMENTAL ||
       iMyRace == RACIAL_TYPE_MAGICAL_BEAST || iMyRace == RACIAL_TYPE_OUTSIDER || iMyRace == RACIAL_TYPE_SHAPECHANGER ||
       iMyRace == RACIAL_TYPE_VERMIN)
    {
        iItems = FALSE;
        iPotions = FALSE;
    }
    else
    {
        iItems = GetLocalInt(OBJECT_SELF, "AI_ITEM_SPELL");
        iPotions = GetLocalInt(OBJECT_SELF, "AI_GOT_POTION");
    }
    iInTimeStop = GetHasSpellEffect(SPELL_TIME_STOP);
    // What class shall I use for things?
    int nClass = jDetermineClassToUse();
    // Special checks...They work now! Darkness and AOE spells
    if(SpecialChecks(nClass)) return;
    // This is used here, to see if we can see any targets to cast spells at.
    // We need all these checks - as we don't want to drop out of combat!!!
    // At object spells need a seen enemy to work. Uses and alive enemy that is seen.
    object oNearestSeen = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    if(!GetIsObjectValid(oTarget) || GetIsDead(oTarget) || oTarget == OBJECT_SELF || GetIsDM(oTarget) || GetFactionEqual(oTarget))
    {
        // If the favoured, or charmed ally target is not valid, then check the intrder
        object oNew = oIntruder;
        if(!GetIsObjectValid(oNew) || oNew == OBJECT_SELF || GetIsDead(oNew) || GetIsDM(oNew) || GetFactionEqual(oNew))
        {
            oNew = GetAttackTarget();
            if(!GetIsObjectValid(oNew) || oNew == OBJECT_SELF || GetIsDead(oNew) || GetFactionEqual(oNew) || GetIsDM(oNew))
            {
                oNew = oNearestSeen;
                if(!GetIsObjectValid(oNew) || oNew == OBJECT_SELF || GetIsDead(oNew) || GetFactionEqual(oNew) || GetIsDM(oNew))
                {
                    oNew = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN);
                    if(!GetIsObjectValid(oNew) || oNew == OBJECT_SELF || GetIsDead(oNew) || GetFactionEqual(oNew) || GetIsDM(oNew))
                    {
                        oNew = GetLocalObject(OBJECT_SELF, "AI_TO_ATTACK");
                        if(!GetIsObjectValid(oNew) || oNew == OBJECT_SELF || GetIsDead(oNew) || GetFactionEqual(oNew) || GetIsDM(oNew))
                        {
                            oNew = GetAttemptedAttackTarget();
                            if(!GetIsObjectValid(oNew) || oNew == OBJECT_SELF || GetIsDead(oNew) || GetFactionEqual(oNew) || GetIsDM(oNew))
                            {
                                oNew = GetAttemptedSpellTarget();
                                if(!GetIsObjectValid(oNew) || oNew == OBJECT_SELF || GetIsDead(oNew) || GetFactionEqual(oNew) || GetIsDM(oNew))
                                {
                                    oNew = GetLastHostileActor();
                                    if(!GetIsObjectValid(oNew) || oNew == OBJECT_SELF || GetIsDead(oNew) || GetFactionEqual(oNew) || GetIsDM(oNew))
                                    {
                                        oNew = GetLastHostileActor(oAlly);
                                        if(!GetIsObjectValid(oNew) || oNew == OBJECT_SELF || GetIsDead(oNew) || GetFactionEqual(oNew) || GetIsDM(oNew) || GetIsFriend(oNew))
                                        {
                                            // Added - if not one valid target...heals others and self (as per normal)
                                            // Heal self - if under  99% HP
                                            if(jTalentHealingSelf(99, 20, 1, OBJECT_INVALID, 0, TRUE)) return;
                                            //Remove negative effects from allies, and self (thus TRUE)
                                            if(jTalentCureCondition(TRUE, iMyIntelligence)) return;
                                            //Check if allies or self are injured
                                            if(jTalentHeal(iHasAlly, OBJECT_INVALID, 20, 0, TRUE)) return;
                                            // We may find a dying PC!
                                            if(GoForTheKill(OBJECT_INVALID, iMyIntelligence)) {return;}
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if(GetIsObjectValid(oNew) && oNew != OBJECT_SELF && !GetIsDead(oNew) && !GetFactionEqual(oNew) && !GetIsDM(oNew))
        {
            // Now another target is the new one, if all above is ok
            oTarget = oNew;
        }
    }
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@ MAIN AI FUNCTIONS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // If the target is eventually valid...
    if(GetIsObjectValid(oTarget))
    {
        // Commoners always flee (basic 10.0 M)
        if(nClass == CLASS_TYPE_COMMONER)
        {
            if(FleeFrom(oTarget)){ return; }
            return;
        }
        else // No commoner...
        {
            // Used to actually define if we should bother checking spells.
            SetMySpells();
            // First, we need to check our things for items to cast spells with, potions
            // and the like
            CheckInventory();
            if(GetLocalObject(OBJECT_SELF, "AI_TO_ATTACK") != oTarget) SetLocalObject(OBJECT_SELF, "AI_TO_ATTACK", oTarget);
            SpeakString("[AI] Valid Target: " + GetName(oTarget) + " [Potions] " + IntToString(PotionsAvalible) + " [Items] " + IntToString(WandsAvalible), TALKVOLUME_SILENT_TALK);

            // We may shout, if there are allies to hear...
            // Also counts up things as well! (and sets them to ints)
            CountCreatures();

            // We may want to use a spell trigger.
            if(SpellTriggersActivate()){ return; }

            // If we want to summon a familiar/companion, do so.
            if(DoSummonFamiliar()){ return; }

            // What is the number of allies an enemies?
            int iNumOfAllies = GetLocalInt(OBJECT_SELF, "AI_ALLIES_COUNT");
            int iNumOfEnemies = GetLocalInt(OBJECT_SELF, "AI_ENEMY_COUNT");

            // Used in fleeing, spellcasting ETC.
            int iPartyHD = GetAverageHD();

            // HD is used to check appropriate spells, while challenge is for fleeing and similar.
            int iHitDice = GetHitDice(OBJECT_SELF);
            int iChallenge = GetChallengeOf(OBJECT_SELF);

            object oLeader = GetNearestLeaderInSight();
            int iLeaderBonus = 0;
            if(GetIsObjectValid(oLeader))
                iLeaderBonus = GetHitDice(oLeader)/3;

            // Some things used for teleporting
            int iMeleeEnemy = jGetNumberOfMeleeAttackers();

            // Weee! Teleport!
            if(Teleport(iHitDice, iMeleeEnemy)){ return; }

            // Fleeing checks, will we flee?
            if(Flee(oTarget, iMyIntelligence, iPartyHD, iChallenge, iLeaderBonus)){ return; }

            // Attempts to get the BAB of the target. Uses classes BAB chart, and Dex or Str.
            int iBAB = BaseAttackBonus();
            // Main spell/attack needs...
            int iPCHP = GetCurrentHitPoints(oTarget);
            float fEnemyDistance = GetDistanceToObject(oTarget);

            // We may shout something to allies.
            LeaderActions(oTarget, iPartyHD, iHitDice, iHasAlly, oAlly, iBAB);

            // If we are meant to be range attacking with spells, we will move closer if we want to.
            if(jGetSpawnInCondition(ATTACK_FROM_AFAR_FIRST))
            {
                float fRangeToMoveTo = GetLocalFloat(OBJECT_SELF, "AI_RANGE_TO_MOVE_TO");
                if(fRangeToMoveTo > 0.0)// On Error it should be 0.0
                {
                    if(fEnemyDistance < fRangeToMoveTo + 2.0)
                    {
                        DeleteLocalFloat(OBJECT_SELF, "AI_RANGE_TO_MOVE_TO");
                    }
                    else if(fEnemyDistance >= fRangeToMoveTo + 2.0)
                    {
                        ClearAllActions();
                        DebugActionSpeak("Moving forward, for 'Ranged Attacking' [Enemy] " + GetName(oTarget));
                        // Then move and stop checking what to do.
                        ActionMoveToObject(oTarget, TRUE, fRangeToMoveTo);
                        return;
                    }
                }
            }
            // This is one very very sneaky check. If there are any dying (-1 to -10 HP) creatures
            // then they will attempt to go and kill them, with HTH or a small spell if low melee targets.
            if(GoForTheKill(oTarget, iMyIntelligence, iPCHP, fEnemyDistance, iMeleeEnemy, iBAB)) { return; }

            // Now, if it has any valid ones, it will fire them.
            if(AbilityAura()) {return;}
            // Will not do things when polymorphed.
            if(jGetHasEffect(EFFECT_TYPE_POLYMORPH))
                //Attack only
                if(jTalentMeleeAttack(oTarget, iMyIntelligence)){ return; }
            // Will attempt to use spells (and potions if appropriate)
            // TOP prioritory. Takes appropriate healing.
            if(jTalentHealingSelf(90, iHitDice, iPartyHD, oTarget, iMeleeEnemy)) { return; }

            // Defines once here to use in functions
            // Ranged attackers are people out of 1.5 M that have us as thier target.
            int iRangedEnemy = jGetNumberOfRangedAttackers();
            float fAllyDistance = 0.0;
            if(iHasAlly)
            {
                fAllyDistance = GetDistanceToObject(oAlly);
            }

            // If we want to, we will move back to use out missile weapons.
            if(ArcherRetreat(iHasAlly, fAllyDistance, oTarget, fEnemyDistance)){ return; }

            // We will attempt to heal others, if a cirtain class.
            if(nClass == CLASS_TYPE_BARD || nClass == CLASS_TYPE_CLERIC || nClass == CLASS_TYPE_PALADIN ||
               nClass == CLASS_TYPE_DRUID || nClass == CLASS_TYPE_DRAGON || nClass == CLASS_TYPE_RANGER ||
               ((nClass == CLASS_TYPE_OUTSIDER) && (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_GOOD)))
            {
                //Check if allies or self are injured (undead can do this - it does check race)
                if(jTalentHeal(iHasAlly, oLeader, iHitDice, iMeleeEnemy)){return;}
            }
            // We will turn even if an odd class, and have it.
            if(iMyRace != RACIAL_TYPE_UNDEAD)
            {
                //Turning check (Not if undead!!! will kill themselves!!!)
                if(UseTurning()){return;}
            }
            // Song - Lalalala. No bard check, as other classes may have it.
            if(jTalentBardSong()){return;}
            //Remove negative effects from allies. Mages might also be able to. So no check for class.
            if(jTalentCureCondition(iHasAlly, iMyIntelligence)){return;}
            // Going to change. Only healing others and dragon combat here...
            if(nClass == CLASS_TYPE_DRAGON)
            {
                if(PotionsAvalible || WandsAvalible || CanCastSpells)
                {
                    if(d100() < 15 && iMyIntelligence >= 2)
                    {
                         // Spells - Use them, but not really low level ones BTW, as it is a dragon.
                        if(ImportAllSpells(iMyIntelligence, nClass, oTarget, oAlly, iHasAlly, fAllyDistance, iMeleeEnemy, iRangedEnemy, iHitDice, iPartyHD, iPCHP, iBAB)){ return; }
                    }
                }
                // Dragon combat determine what they do
                // Wing buffet, breath weapon, or attack with best skill.
                if(jTalentDragonCombat(oTarget)) {return;}
            }
            else
            {
                // Import all spells. In here are
                if(PotionsAvalible || WandsAvalible || CanCastSpells)
                {
                    if(!iInTimeStop)
                        // Still testing. Probably just needs some allies to even start it. etc
                        if(ConcentrationCheck(oTarget, iMyIntelligence, nClass, oAlly, iHasAlly, fAllyDistance, fEnemyDistance, iMeleeEnemy, iRangedEnemy, iHitDice, iPartyHD, iPCHP, iBAB)){ return; }
                    if(ImportAllSpells(iMyIntelligence, nClass, oTarget, oAlly, iHasAlly, fAllyDistance, iMeleeEnemy, iRangedEnemy, iHitDice, iPartyHD, iPCHP, iBAB)){ return; }
                    // No cantrips at higher than level 7 parties. My recommendation.
                    if(iPartyHD < 8)
                        if(ImportCantripSpells(oTarget, oAlly, iHasAlly, fAllyDistance, fEnemyDistance, iMeleeEnemy, iRangedEnemy, iHitDice, iPartyHD, iPCHP, iBAB)){ return; }
                }
                // This will use skills like taunt, empathy and pickpocketing.
                if(UseSpecialSkills(oTarget, iMyIntelligence, fEnemyDistance, iHitDice)){return;}
                // Buff us up!
                if(CastCombatHostileSpells(nClass, oTarget, fEnemyDistance, iMeleeEnemy, oAlly, iHasAlly, fAllyDistance, iHitDice, iPartyHD, iBAB)){ return; }
                // Polymorph if no decent sneak attacks or spells.
                if(PolyMorph()){return;}
                //Attack if out of spells
                if(jTalentMeleeAttack(oTarget, iMyIntelligence)) { return; }
            }// End not dragon.
        }
        DebugActionSpeak("Erm...valid target...but no actions?! [Target] " + GetName(oTarget));
        // Return, as we had a valid target!
        return;
    }
// This is a call to the function which determines which way point to go back to.
// This will only run if it cannot heal self, is not in an AOE spell, and no target.
    SetLocalObject(OBJECT_SELF, "NW_GENERIC_LAST_ATTACK_TARGET", OBJECT_INVALID);
    // This will return the creauture to thier starting place, if they are guarding somewhere.
    if(ReturnToStartingPlace()){return;}
    ExecuteScript("j_ai_walkwaypoin", OBJECT_SELF);
}

void DebugActionSpeak(string sString)
{
    string nNew = "[AI] " + GetName(OBJECT_SELF) + " [Area] " + GetName(GetArea(OBJECT_SELF)) + " [Debug] " + sString;
//    SpeakString(nNew, TALKVOLUME_SILENT_TALK);
//    WriteTimestampedLogEntry(nNew);
}

//void main(){}
