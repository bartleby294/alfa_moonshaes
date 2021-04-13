////////////////
//
//  System Name : ALFA Core Rules
//     Filename : acr_horse_i
//      Version : 1.2
//         Date : 9/2/06 (modified 9/8/2006, 9/17/2006 by AcadiusLost)
//       Author : Ronan & AcadiusLost
//
//  Local Variable Prefix = ACR_HORSE
//
//  Dependencies external of nwscript:
//
//
//  Description
//
//  Revision History
//    -v1.1: 9/8/2006: added SetMaximumHenchmen(5) to OnClientEnter, updated UnAquire,
//      commented out some lingering SendMessageToPC() reports.
//    -v1.2: 9/17/2006: added OnAcquire handling for horse items with lost locals,
//      also OnUnAcquire handling for "infinite" shops
//
//  -Currently is called from the following places:
//
//
//      acr_horse_bridle.nss (tag-activate item from the bridle)
//      acr_horse_canmnt.nss (from acr_horse_convo)
//      acr_horse_cantie.nss (from acr_horse_convo)
//      acr_horsecanutie.nss (from acr_horse_convo)
//      acr_horse_death.nss  (custom creature script, set in blueprint)
//      acr_horse_flee.nss   (referenced in LocalString on untrained mounts, by AI)
//      acr_horse_mount.nss  (from acr_horse_convo)
//      acr_horse_onconv.nss (custom creature script, set in blueprint)
//      acr_horse_ondmg.nss  (custom creature script, set in blueprint)
//      acr_horse_spawn.nss  (custom creature script, set in blueprint)
//      acr_horse_tie.nss    (from acr_horse_convo)
//      acr_horse_untie.nss  (from acr_horse_convo)
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_game_loc_i"
#include "acr_tools_i"

const int BASE_ITEM_HORSE_BRIDLE = 223;

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const string _HORSE_RESREF_LS = "ACR_HORSE_RESREF";
const string _HORSE_HP = "ACR_HORSE_HP";
const string _HORSE_BEING_NAMED_LI = "ACR_HORSE_NAMING";

const string _ORIGINAL_PHENOTYPE_LI = "ACR_HORSE_ORIGPHENO";
const string _ORIGINAL_APPEARANCE_LI = "ACR_HORSE_ORIGAPP";
const string _HORSE_PHENOTYPE_LI = "ACR_HORSE_PHENOTYPE";
const string _SUMMONED_HORSE_LO = "ACR_HORSE_CURRENT";
const string _BRIDLE_IN_USE_LI = "ACR_HORSE_INUSE";
const string _HORSE_HAS_CUSTOM_NAME = "ACR_HORSE_HASCUSNAME";
const string _HORSE_SAVED_NAME = "ACR_HORSE_NAME";
const string _HORSE_BASE_NAME = "ACR_HORSE_BASE";
const string _SUMMONED_HORSE_ITEM_LO = "ACR_HORSE_ITEM";
const string _ORIGINAL_FOOTSTEP_TYPE = "ACR_HORSE_OFT";

const string _MOUNTED_HORSE_ITEM_LO = "ACR_HORSE_MITEM";
const string _HORSE_APPEARANCE = "ACR_HORSE_LOOKS";

const string _HORSE_TIED_LOCATION = "ACR_HORSE_TGL";

const string _BRIDLE_TAG = "acr_horse_bridle";

const string _HORSE_ARRAY_LENGTH = "ACR_HORSE_AR";
const string _HORSE_ARRAY = "ACR_HORSE_";
const string _IS_WARHORSE = "ACR_HORSE_IS_WARHORSE";

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//! *** PUBLIC FUNCTIONS ***

// called by acr_horse_bridle.nss, may trigger a number of events:
//  -Recovering to party/henchman of a horse that is owned by oPC
//  -Dismounting a horse oPC is currently riding
//  -respawning a horse which is alive but missing due to some error.
void ALFA_OnActivateHorseItem();

// Pretty self-explanatory.  Called from acr_horse_death, in the on_death event of the horses.
void ALFA_OnHorseDeath();

// dismounts dying PC if it was mounted before.  Also called OnDeath for oPC, just in
//  cast it was a strong hit that skipped the "dying" stage.
void ALFA_MountedDying(object oPC);

// Dismounts oPC for resting.
void ALFA_MountedRest(object oPC);

// Handles application of horse phenotype, sounds, effects, and removal of horse creature.
void ALFA_MountHorse(object oPC, object oHorse);

// Sets up any horses owned by the PC to spawn as the PC enters the module.
// Fires from inside alfa_onenter.nss, ALFA_OnClientEnter() as defined in alfa_include.nss.
void ALFA_OnHorseOwnerEnter(object oPC);


// Called from ALFA_OnClientLeave() in alfa_include.nss, by alfa_onleave.nss
//   cleans up any leftover horses that match ones in the exiting PC's inventory.
void ALFA_OnHorseOwnerLeave();


// checks to see if the bridle that corresponds to the horse is with oPC.
int ALFA_GetIsHorseOwner(object oPC, object oHorse);

// Handles switching back from horse phenotype, removal of horse effects, and calls to spawn
//   the horse creature as a party member/henchman again.
object ALFA_UnmountHorse(object oPC);

// Rather crude coward script, called by acr_horse_flee.nss, which is called by henchmen AI
//   as a custom behaviour, as referenced by a localstring defined in the creature blueprint.
void ALFA_HorseFlee(object oDanger);


// called by the custom onDamaged script for all rideable horses, handles both
//   the adjustment of persistent hitpoints for the horses, but also their ability
//   to break free of tethers when damaged. (to attack or run away, depending).
void ALFA_HorseOnDamaged();

// Not currently used for anything.
void ALFA_HorseOnUnequipItem();

int ALFA_GetIsHorseFollowing(object oPC, object oHorse);

// called from acr_horse_onconv.nss, when the localint tells the horse to listen for it's
//   new name. Saves to the bridle for future use, and sets the LocalInt to warn future
//   attempts not to overwrite the name with a default one.
void ALFA_GrantCustomHorseName(string sHorseName);

// called by acr_horse_tie, in acr_horse_convo.
// Removes the horse as a henchman, and applies an entangle effect to keep it in place.
//   Normally a conversation option is used to clear this, if the horse is unresponsive due
//   to AI, the OnActivate for the appropriate bridle can be used to free it.
//    Also sets a plot flag on the item to keep a PC from selling a nonpresent horse.
void ALFA_LeaveHorse(object oPC, object oHorse);

// called by acr_horse_untie, in acr_horse_convo.
// also called by ALFA_OnActivateHorseItem() when near an owned but not in-party horse.
//    Handles removal of entangle effect, clearing of plot flag on the item, and
//    addition of the horse as a henchman of oPC.
void ALFA_PickUpHorse(object oPC, object oHorse);

// Just checks oPC's phenotype, returns TRUE if it is above the standard unmounted ones.
int ALFA_GetIsMounted(object oPC);

// Used to handle initialization of horse items bought, traded, looted, or picked up.
// Spawns the horse at the holder of the bridle if it doesn'y yet exist, otherwise
// spawns it at it's last tied location, tied up.  If the corresponding horse was a
// current henchman of another PC, it is removed from their control and added as a henchman
// for the PC who has now aquired the bridle.  Note that stealing the bridle will also cause this.
//
// Also, Called when PCs enter the mod as well, as part of the OnClientEnter sequence.
//   However, since nothing else is valid at that time, we avoid trying to do anything here
//   unless the PC who has the item is actually in an Area.
void ALFA_HorseOnAcquireItem();


// Handles the case of horse items bought from an "infinite stock" store, in which the
//  local variables are lost.  Repopulates the necessary local variables with default ones.
int ALFA_FixHorseItem(object oHorseItem);


// Handles all loss of horse items, due to selling, dropping, being looted, or being pickpocketed.
//  unmounts the PC if they were mounted on the corresponding horse, ties up the horse and removes
//  it as a henchman. If it has been sold to a store, the horse creature is destroyed.
void ALFA_HorseOnUnacquireItem();

// Builds up a construction of effects which give the PC the current mount's skill levels for
//   the pertinent skills, plus the 20% movement speed boost.  Uses the EffectSkillSetTo from
//   acr_tools_i.
effect ALFA_GetEffectsOfMountOnPC(object oPC, object oMount);


// Called from ALFA_OnHeartbeat() in alfa_include.nss
//    fires on heartbeat, handles ride skill checks, chance for falling off horse
//    while mounted and "in combat".
void ALFA_HorseOnHeartbeat(object oPC);

//! *** PRIVATE FUNCTIONS ***

// Respawns oPC's horse, represented by oItem. If the horse was tied up, it is
// sent to that location. Otherwise its spawned at the PC.
object _RespawnHorse(object oPC, object oItem);

object _FindLastBridle(object oPC, int nPhenoType);

int _GetIsBridleInUse(object oItem);

int _GetIsPony(object oMount);

int _GetNeedsPony(object oPC);

void _NameMount(object oMount, object oPC);

void _UnmakeHorse(object oHorse, object oItem);

object _MakeHorseFromItemAtLocation(object oItem, location lLocation, int bMakeHenchman = 1);

void _AddToHorseList(object oPC, object oHorse);

void _DoBridleOnEnter(object oPC, object oItem);

void _DoBridleOnExit(object oPC, object oItem);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// *** BEGIN PUBLIC FUNCTIONS ***
////////////////////////////////////////////////////////////////////////////////

void ALFA_OnActivateHorseItem() {
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    string sResRef = GetLocalString(oItem, _HORSE_RESREF_LS);
    object oHorse = GetLocalObject(oItem, _SUMMONED_HORSE_LO);
    object oLastBridle = GetLocalObject(oPC, _MOUNTED_HORSE_ITEM_LO);

    int nHPType = GetLocalInt(oItem, _HORSE_PHENOTYPE_LI);

    // First deal with the case of a bridle that is fully initialized.
    //   If the horse isn't in your party (tied up, or running free), use of the
    //   corresponding bridle within a reasonable range will return the horse to
    //   the PC's party.  This allows the PC to take control when the mount is
    //   unresponsive to conversation attempts due to combat AI, for example.
    if(GetIsObjectValid(oHorse)) {
        if (GetMaster(oHorse) == OBJECT_INVALID) {
            float fRange = GetDistanceBetween(oPC, oHorse);
            if ((fRange > 0.0f ) && (fRange < 3.0f)) {
                ALFA_PickUpHorse(oPC, oHorse);
                return;
            } else {
                SendMessageToPC(oPC, GetName(oHorse)+" is too far away to reach.");
                return;
            }
        } else
            return;
    }
    // If the bridle has had the resref deleted, it means the horse is dead.  Destroy the bridle.
    //  (shouldn't needed, currently, as the bridle is destroyed when the horse dies, acr_horse_death
    //  calls ALFA_OnHorseDeath(), which destroys the corresponding bridle.)
    if(sResRef == "") {
        FloatingTextStringOnCreature("Your horse is dead! You must acquire a new one.", oPC, FALSE);
        DestroyObject(oItem);
        return;
    }
    if( ALFA_GetIsMounted(oPC) && (oItem == oLastBridle)) {
        // PC is mounted, unmount.
        ALFA_UnmountHorse(oPC);
        return;
    }

    // Otherwise, some sort of error? The horse should always be spawned.
    // Respawn it at its last location if it had one, or at the PC's.
    FloatingTextStringOnCreature("(( Respawning horse at its last location. ))", oPC);
    _RespawnHorse(oPC, oItem);
}


// Pretty self-explanatory.  Called from acr_horse_death, in the on_death event of the horses.
void ALFA_OnHorseDeath() {
    DestroyObject( GetLocalObject(OBJECT_SELF, _SUMMONED_HORSE_ITEM_LO) );
}


void ALFA_MountedDying(object oPC) {
    if (ALFA_GetIsMounted(oPC)) {
        SendMessageToPC(oPC, "Your horse pulls free!");
        ALFA_UnmountHorse(oPC);
    }
}


// Dismounts oPC for resting.
void ALFA_MountedRest(object oPC) {
    if (ALFA_GetIsMounted(oPC)) {
    SendMessageToPC(oPC, "You dismount from your horse before settling down to rest.");
    ALFA_UnmountHorse(oPC);
    }
}


// Sets up any horses owned by the PC to spawn as the PC enters the module.
// Fires from inside alfa_onenter.nss, ALFA_OnClientEnter() as defined in alfa_include.nss.
void ALFA_OnHorseOwnerEnter(object oPC) {

   // If the PC isn't in the mod properly yet, wait a few seconds and try again.
   if(GetArea(oPC) == OBJECT_INVALID) {
        // SendMessageToPC(oPC, "Recursing, just a moment...");
        DelayCommand(3.0, ALFA_OnHorseOwnerEnter(oPC));
        return;
    }
    // Arbitrary choice of number, better set in alfa_include, but should work here as well.
    SetMaxHenchmen(5);

    // A PC who logged off mounted on horseback will need to be returned to normal before
    // new mounted effects can be applied.  (the phenotype persists, but not the effects).
    if (ALFA_GetIsMounted(oPC)) {
        ALFA_UnmountHorse(oPC);
        return;
    }
    // Now roll through inventory looking for other bridles, deal with each in turn.
    object oIterate = GetFirstItemInInventory(oPC);
    while(oIterate != OBJECT_INVALID) {
        _DoBridleOnEnter(oPC, oIterate);
        oIterate = GetNextItemInInventory(oPC);
    }
    // Just in case one is equipped, handle it separately.
    _DoBridleOnEnter(oPC, GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));

}


void ALFA_HorseOnUnequipItem() {
    return;
}


// Since the horses may or may not be associates, or may not even exist as creatures
//  (if mounted), safest to clean up horses by checking each bridle.
void ALFA_OnHorseOwnerLeave() {
    object oPC = GetExitingObject();
    object oItem = GetFirstItemInInventory(oPC);
    while( oItem != OBJECT_INVALID ) {
        _DoBridleOnExit(oPC, oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    _DoBridleOnExit(oPC, GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
    /*int nNum = GetLocalInt(oPC, _HORSE_ARRAY_LENGTH);
    int i;
    for(i=0; i<nNum; i++) {

    }*/
}


// Builds up a construction of effects which give the PC the current mount's skill levels for
//   the pertinent skills, plus the 20% movement speed boost.  Uses the EffectSkillSetTo from
//   acr_tools_i.
effect ALFA_GetEffectsOfMountOnPC(object oPC, object oMount) {
    effect eff;
    eff = EffectAdjustedMovementSpeed(oPC, 1.20);
    //eff = EffectLinkEffects(eff, EffectSetSkillTo(oPC, SKILL_CLIMB, GetSkillRank(SKILL_CLIMB, oMount)) );
    eff = EffectLinkEffects(eff, EffectSetSkillTo(oPC, SKILL_HIDE, GetSkillRank(SKILL_HIDE, oMount)) );
    //eff = EffectLinkEffects(eff, EffectSetSkillTo(oPC, SKILL_JUMP, GetSkillRank(SKILL_JUMP, oMount)) );
    eff = EffectLinkEffects(eff, EffectSetSkillTo(oPC, SKILL_MOVE_SILENTLY, GetSkillRank(SKILL_MOVE_SILENTLY, oMount)) );
    //eff = EffectLinkEffects(eff, EffectSetSkillTo(oPC, SKILL_SWIM, GetSkillRank(SKILL_SWIM, oMount)) );
    eff = EffectLinkEffects(eff, EffectSetSkillTo(oPC, SKILL_TUMBLE, GetSkillRank(SKILL_TUMBLE, oMount)) );
    return ExtraordinaryEffect(eff);
}


// Handles application of horse phenotype, sounds, effects, and removal of horse creature.
void ALFA_MountHorse(object oPC, object oHorse) {
    object oItem = GetLocalObject(oHorse, _SUMMONED_HORSE_ITEM_LO);
    object oOwner = GetItemPossessor(oItem);
    //SendMessageToPC(oPC, "ALFA_MountHorse for "+GetName(oHorse)+" tied to "+GetName(oItem)+" held by "+GetName(oOwner));
    effect eHorseEffect = ALFA_GetEffectsOfMountOnPC(oPC, oHorse);

    // Now make sure we want to let the PC mount the horse in question.
    if (oHorse == OBJECT_INVALID) {
        SendMessageToPC(oPC, "Could not get the horse to mount.");
        return;
    }
    if(ALFA_GetIsMounted(oPC)) {
        SendMessageToPC(oPC, "But, you are already mounted!");
        return;
    }
    if (oOwner != oPC) {
        FloatingTextStringOnCreature("This is not your mount.", oPC);
        return;
    }
    if (_GetNeedsPony(oPC) && !(_GetIsPony(oHorse))) {
        FloatingTextStringOnCreature("You are not tall enough to ride the horse!", oPC);
        return;
        }
    else if (!(_GetNeedsPony(oPC)) && _GetIsPony(oHorse)) {
        FloatingTextStringOnCreature("You are too big to ride the pony!", oPC);
        return;
        }

    int nPhenotype = 0;
    if(GetPhenoType(oPC) == 0){
        if(GetLocalInt(oItem, _IS_WARHORSE) == 1) nPhenotype = 6;
        else nPhenotype = 9;
    }
    if(GetPhenoType(oPC) == 2){
        if(GetLocalInt(oItem, _IS_WARHORSE) == 1) nPhenotype = 8;
        else nPhenotype = 5;
    }
    if(nPhenotype) {
        AssignCommand( oPC, ActionEquipItem(oItem, INVENTORY_SLOT_LEFTHAND) );
        SetLocalInt(oItem, _ORIGINAL_FOOTSTEP_TYPE, GetFootstepType(oPC));
        SetFootstepType( GetFootstepType(oHorse), oPC );
        SetLocalInt(oItem, _ORIGINAL_PHENOTYPE_LI, GetPhenoType(oPC));
        SetLocalInt(oItem, _ORIGINAL_APPEARANCE_LI, GetAppearanceType(oPC));
        SetPhenoType(nPhenotype, oPC);
        SetLocalObject(oPC, _MOUNTED_HORSE_ITEM_LO, oItem);
        SetLocalInt(oItem, _BRIDLE_IN_USE_LI, TRUE);
        SetCreatureTailType(GetCreatureTailType(oHorse), oPC);
        //SendMessageToPC(oPC, "Mounting horse using "+ObjectToString(oHorse));

        // Command no longer assigned, due to changes in 1.69
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHorseEffect, oPC);

        // Aligning and scaling mounts to characters requires an appearance change
        // as of 1.69
        int iRacialType = GetRacialType(oPC);
        if(iRacialType == RACIAL_TYPE_DWARF){
            if(GetGender(oPC) == GENDER_FEMALE) SetCreatureAppearanceType(oPC, 482);
            else SetCreatureAppearanceType(oPC, 483); }
        else if(iRacialType == RACIAL_TYPE_ELF){
            if(GetGender(oPC) == GENDER_FEMALE) SetCreatureAppearanceType(oPC, 484);
            else SetCreatureAppearanceType(oPC, 485); }
        else if(iRacialType == RACIAL_TYPE_GNOME){
            if(GetGender(oPC) == GENDER_FEMALE) SetCreatureAppearanceType(oPC, 486);
            else SetCreatureAppearanceType(oPC, 487); }
        else if(iRacialType == RACIAL_TYPE_HALFLING){
            if(GetGender(oPC) == GENDER_FEMALE) SetCreatureAppearanceType(oPC, 488);
            else SetCreatureAppearanceType(oPC, 489); }
        else if(iRacialType == RACIAL_TYPE_HALFELF){
            if(GetGender(oPC) == GENDER_FEMALE) SetCreatureAppearanceType(oPC, 490);
            else SetCreatureAppearanceType(oPC, 491); }
        else if(iRacialType == RACIAL_TYPE_HALFORC) {
            if(GetGender(oPC) == GENDER_FEMALE) SetCreatureAppearanceType(oPC, 492);
            else SetCreatureAppearanceType(oPC, 493); }
        else { // defaults to human
            if(GetGender(oPC) == GENDER_FEMALE) SetCreatureAppearanceType(oPC, 494);
            else SetCreatureAppearanceType(oPC, 495); }

        DeleteGameLocation( oItem, _HORSE_TIED_LOCATION );
        _UnmakeHorse(oHorse, oItem);
    } else {
        FloatingTextStringOnCreature("ERROR, No phenotype specified on " + GetName(oItem), oPC, FALSE);
    }
}


// Handles switching back from horse phenotype, removal of horse effects, and calls to spawn
//   the horse creature as a party member/henchman again.
object ALFA_UnmountHorse(object oPC) {

    if(!ALFA_GetIsMounted(oPC)) {
        SendMessageToPC(oPC, "You can't dismount if you're not riding!");
        return OBJECT_INVALID;
    }
    // Finds the appropriate bridle from a pointer saved on the PC.
    object oItem = GetLocalObject(oPC, _MOUNTED_HORSE_ITEM_LO);
    object oLastHorse = GetLocalObject(oItem, _SUMMONED_HORSE_LO);

    // If the PC has just entered the mod, hunt down the appropriate bridle.
    if (oItem == OBJECT_INVALID)
        oItem = _FindLastBridle(oPC, GetPhenoType(oPC));

    // If we still can't find it, give up.
    if (oItem == OBJECT_INVALID) {
        SendMessageToPC(oPC, "Could not get item to unmount.");
        return OBJECT_INVALID;
    }
    // Loop through effects to find ones owned by the prior horse, remove those.
    effect eLoop=GetFirstEffect(oPC);
    while (GetIsEffectValid(eLoop)) {
        // SendMessageToPC(oPC, "Type: "+IntToString(GetEffectType(eLoop))+", owner: "+ObjectToString(GetEffectCreator(eLoop))+", Stored pointer: "+ObjectToString(GetLocalObject(oItem, _SUMMONED_HORSE_LO)));
        if (GetEffectType(eLoop) == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE &&
            GetEffectSubType(eLoop) == SUBTYPE_EXTRAORDINARY &&
            GetEffectDurationType(eLoop) == DURATION_TYPE_PERMANENT){//checking method changed when 1.69 became an unreliable method of identifying which effects were to be stripped.
            RemoveEffect(oPC, eLoop);}
        if (GetEffectType(eLoop) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE &&
            GetEffectSubType(eLoop) == SUBTYPE_EXTRAORDINARY &&
            GetEffectDurationType(eLoop) == DURATION_TYPE_PERMANENT){//checking method changed when 1.69 became an unreliable method of identifying which effects were to be stripped.
            RemoveEffect(oPC, eLoop);}
        if (GetEffectType(eLoop) == EFFECT_TYPE_SKILL_INCREASE &&
            GetEffectSubType(eLoop) == SUBTYPE_EXTRAORDINARY &&
            GetEffectDurationType(eLoop) == DURATION_TYPE_PERMANENT){//checking method changed when 1.69 became an unreliable method of identifying which effects were to be stripped.
            RemoveEffect(oPC, eLoop);}
        if (GetEffectType(eLoop) == EFFECT_TYPE_SKILL_DECREASE &&
            GetEffectSubType(eLoop) == SUBTYPE_EXTRAORDINARY &&
            GetEffectDurationType(eLoop) == DURATION_TYPE_PERMANENT){//checking method changed when 1.69 became an unreliable method of identifying which effects were to be stripped.
            RemoveEffect(oPC, eLoop);}
        eLoop=GetNextEffect(oPC);
    }

    // Restore prior phenotype (saved on the bridle), and set local integers appropriately.
    SetPhenoType(GetLocalInt(oItem, _ORIGINAL_PHENOTYPE_LI), oPC);
    SetCreatureTailType(CREATURE_TAIL_TYPE_NONE, oPC);
    SetCreatureAppearanceType(oPC, GetLocalInt(oItem, _ORIGINAL_APPEARANCE_LI));
    SetLocalInt(oItem, _BRIDLE_IN_USE_LI, FALSE);
    DeleteLocalObject(oPC, _MOUNTED_HORSE_ITEM_LO);
    SetFootstepType( GetLocalInt(oItem, _ORIGINAL_FOOTSTEP_TYPE), oPC);
    // finally, call the creation function.
    return _MakeHorseFromItemAtLocation(oItem, GetLocation(oPC));
}



// checks to see if the bridle that corresponds to the horse is with oPC.
int ALFA_GetIsHorseOwner(object oPC, object oHorse) {
    object oTargetItem = GetLocalObject(oHorse, _SUMMONED_HORSE_ITEM_LO);
    if (GetItemPossessor(oTargetItem) == oPC)
        return TRUE;
    else if (GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC) ==  oTargetItem)
        return TRUE;
    else
        return FALSE;
}



int ALFA_GetIsHorseFollowing(object oPC, object oHorse) {
    return GetMaster(oHorse) == oPC;
}


// called from acr_horse_onconv.nss, when the localint tells the horse to listen for it's
//   new name. Saves to the bridle for future use, and sets the LocalInt to warn future
//   attempts not to overwrite the name with a default one.
void ALFA_GrantCustomHorseName(string sCustomName) {
        object oBridle = GetLocalObject(OBJECT_SELF, _SUMMONED_HORSE_ITEM_LO);
        SetName( OBJECT_SELF, sCustomName );
        SetLocalInt(oBridle, _HORSE_HAS_CUSTOM_NAME, TRUE);
        SetLocalString(oBridle, _HORSE_SAVED_NAME, sCustomName);
        return;
}

// Rather crude coward script, called by acr_horse_flee.nss, which is called by henchmen AI
//   as a custom behaviour, as referenced by a localstring defined in the creature blueprint.
void ALFA_HorseFlee(object oDanger) {
    object oPC = GetMaster();
    ClearAllActions();
    ActionMoveAwayFromObject(oDanger, TRUE, 40.0);
    SetCommandable(FALSE);
    // allows the horse to be commanded again after a bit of time to calm down.
    DelayCommand(10.0, SetCommandable(TRUE));
    return;
}

// called by the custom onDamaged script for all rideable horses, handles both
//   the adjustment of persistent hitpoints for the horses, but also their ability
//   to break free of tethers when damaged. (to attack or run away, depending).
void ALFA_HorseOnDamaged() {
    object oHorseItem = GetLocalObject(OBJECT_SELF, _SUMMONED_HORSE_ITEM_LO);
    SetLocalInt( oHorseItem, _HORSE_HP, GetCurrentHitPoints(OBJECT_SELF) );
    effect eSearch = GetFirstEffect(OBJECT_SELF);
    while (GetIsEffectValid(eSearch)) {
        // WriteTimestampedLogEntry("Damage, effect: "+IntToString(GetEffectType(eSearch))+", owner "+ObjectToString(GetEffectCreator(eSearch))+", versus "+ObjectToString(OBJECT_SELF));
        if (GetEffectCreator(eSearch) == OBJECT_SELF) {
            if (GetEffectType(eSearch) == EFFECT_TYPE_ENTANGLE) {
                RemoveEffect(OBJECT_SELF, eSearch);
                SpeakString("The horse breaks free of it's bindings!");
            }
        }
        eSearch = GetNextEffect(OBJECT_SELF);
    }
}

// called by acr_horse_tie, in acr_horse_convo.
// Removes the horse as a henchman, and applies an entangle effect to keep it in place.
//   Normally a conversation option is used to clear this, if the horse is unresponsive due
//   to AI, the OnActivate for the appropriate bridle can be used to free it.
//    Also sets a plot flag on the item to keep a PC from selling a nonpresent horse.
void ALFA_LeaveHorse(object oPC, object oHorse) {
    effect eTied = EffectEntangle();
    object oBridle = GetLocalObject(oHorse, _SUMMONED_HORSE_ITEM_LO);
    RemoveHenchman(oPC, oHorse);
    SetLocalGameLocation( oBridle, _HORSE_TIED_LOCATION, GetLocation(oHorse) );
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTied, oHorse);
    SetPlotFlag(oBridle, TRUE);
    SendMessageToPC(oPC, "You tie the horse up.");
    // WriteTimestampedLogEntry("Setting as tied: "+GetName(oHorse)+" : "+ObjectToString(oHorse)+", from object "+GetName(oBridle));

}

// Called by acr_horse_untie.nss, in acr_horse_convo.
//   allows a PC with the proper bridle to clear the entangle effect, add the horse as
//   a henchman, and clears the plot (unsellable) flag on the bridle.
void ALFA_PickUpHorse(object oPC, object oHorse) {
    if( ALFA_GetIsHorseOwner(oPC, oHorse) ) {
        object oBridle = GetLocalObject(oHorse, _SUMMONED_HORSE_ITEM_LO);
        SetPlotFlag(oBridle, FALSE);
        AddHenchman(oPC, oHorse);
        DeleteGameLocation( oBridle, _HORSE_TIED_LOCATION );
        effect eSearch = GetFirstEffect(oHorse);
        while (GetIsEffectValid(eSearch)) {
            //SendMessageToPC(oPC, IntToString(GetEffectType(eSearch))+" <- "+ObjectToString(GetEffectCreator(eSearch))+" vs. "+ObjectToString(oHorse));
            if (GetEffectCreator(eSearch) == oHorse) {
                if (GetEffectType(eSearch) == EFFECT_TYPE_ENTANGLE) {
                    RemoveEffect(oHorse, eSearch);
                    SendMessageToPC(oPC, "You untie the mount.");
                    }
            }
            eSearch = GetNextEffect(oHorse);
        }
    }
}

// Self-explanatory.
int ALFA_GetIsMounted(object oPC) {
    return GetPhenoType(oPC) > 4;
}

void ALFA_HorseOnAcquireItem() {
    object oItem = GetModuleItemAcquired();
    object oPC = GetModuleItemAcquiredBy();
    if(GetBaseItemType(oItem) == BASE_ITEM_HORSE_BRIDLE) {
        // checks for incorrect blueprint for warponies, fixes.
        if (GetStringLeft(GetResRef(oItem), 8) == "acr_warp")
            if (GetStringLeft(GetLocalString(oItem, _HORSE_RESREF_LS), 7) != "PLAYERW") {
                ALFA_FixHorseItem(oItem);
                SendMessageToAllDMs("Repaired resref for warpony item.");
                }
        if (GetArea(oPC) != OBJECT_INVALID) {
            // Check to make sure the horse item has local variables (lost when
            //   sold from merchants with quantity: infinite)
            if (GetLocalString(oItem, _HORSE_RESREF_LS) == "")
                if (!ALFA_FixHorseItem(oItem))
                    SendMessageToPC(oPC, "Error initializing horse item.");
            object oHorse = GetLocalObject(oItem, _SUMMONED_HORSE_LO);
            if( oHorse != OBJECT_INVALID ) {
                // The horse is already summoned.
                if( GetIsValidLocalGameLocation(oItem, _HORSE_TIED_LOCATION) ) {
                    // The horse is tied up somewhere.
                    SendMessageToPC(oPC, "Horse is tied elsewhere.");
                } else {
                    // The horse is not tied up somewhere.
                    SendMessageToPC(oPC, "Transferring horse ownership.");
                    RemoveHenchman( GetMaster(oHorse), oHorse );
                    AddHenchman( oPC, oHorse );
                }
            } else {
                // The horse is not summoned.
                _RespawnHorse( oPC, oItem );
            }
        }
    }
}

int ALFA_FixHorseItem(object oHorseItem) {
    // all horse items have tag = acr_horse_bridle, but their resrefs tell which
    // they are supposed to be.
    string sResRef = GetResRef(oHorseItem);
    string sColor = "";
    string sWar = "";
    string sType = "horse";
    int nPony = FALSE;
    int nWarMount = FALSE;
    // checks to see if it's a warhorse/warpony, sets local int accordingly
    if (GetStringLeft(sResRef, 7) == "acr_war") {
        SetLocalInt(oHorseItem, _IS_WARHORSE, TRUE);
        nWarMount = TRUE;
        sWar = "War";
        if (GetStringLeft(sResRef, 11) == "acr_warpony")
            nPony = TRUE;
        }
    else if (GetStringLeft(sResRef, 8) == "acr_pony")
        nPony = TRUE;
    // Should have correct values for nPony and nWarMount by this point.  Ready
    // to refill the other local variables.
    if (nPony) {
        sType = "pony";
        if (GetStringRight(sResRef, 2) == "wn") {
            SetLocalInt(oHorseItem, _HORSE_PHENOTYPE_LI, 6);
            SetLocalString(oHorseItem, _HORSE_RESREF_LS, "PLAYERHORSE_05");
            sColor = "Brown ";
        } else if (GetStringRight(sResRef, 1) == "y") {
            SetLocalInt(oHorseItem, _HORSE_PHENOTYPE_LI, 7);
            SetLocalString(oHorseItem, _HORSE_RESREF_LS, "PLAYERHORSE_06");
            sColor = "Grey ";
        } else { //  if not brown or grey pony, must be painted.
            SetLocalInt(oHorseItem, _HORSE_PHENOTYPE_LI, 5);
            SetLocalString(oHorseItem, _HORSE_RESREF_LS, "PLAYERHORSE_04");
            sColor = "Paint ";
        }
     } else {
        // if not a pony, it's a horse.  Check which kind based on the suffix
        if (GetStringRight(sResRef, 1) == "k") {
            SetLocalInt(oHorseItem, _HORSE_PHENOTYPE_LI, 7);
            SetLocalString(oHorseItem, _HORSE_RESREF_LS, "PLAYERHORSE_03");
            sColor = "Black ";
        } else if (GetStringRight(sResRef, 1) == "y") {
            SetLocalInt(oHorseItem, _HORSE_PHENOTYPE_LI, 6);
            SetLocalString(oHorseItem, _HORSE_RESREF_LS, "PLAYERHORSE_02");
            sColor = "Grey ";
        } else { //  if not black or grey horse, must be brown.
            SetLocalInt(oHorseItem, _HORSE_PHENOTYPE_LI, 5);
            SetLocalString(oHorseItem, _HORSE_RESREF_LS, "PLAYERHORSE_01");
            sColor = "Brown ";
        }
     }
     //  Now to construct the base name:
     string sBaseName = sColor+sWar+sType;
     SetLocalString(oHorseItem, _HORSE_BASE_NAME, sBaseName);

     // Modify horse resref if it's a wartrained mount.
     if (nWarMount) {
        string sHorseResRef = GetLocalString(oHorseItem, _HORSE_RESREF_LS);
        string sWarResRef = "PLAYERW"+GetStringRight(sHorseResRef, 8);
        SetLocalString(oHorseItem, _HORSE_RESREF_LS, sWarResRef);
     }
return TRUE;
}


void ALFA_HorseOnUnacquireItem() {
    object oItem = GetModuleItemLost();
    object oPC = GetModuleItemLostBy();

    if(!GetIsObjectValid(oItem)) {
        // Horse was sold to "infinite" dealer, so item is already gone...
        int nIndex = 1;
        object oCheckHorse = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
        while (oCheckHorse != OBJECT_INVALID) {
            if (GetName(GetLocalObject(oCheckHorse, _SUMMONED_HORSE_ITEM_LO)) == "") {
                DestroyObject(oCheckHorse);
                return;
            }
            nIndex++;
            oCheckHorse = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nIndex);
         }
    }

    if( GetBaseItemType(oItem) != BASE_ITEM_HORSE_BRIDLE ) {
        return;
    }
    object oHorse;
    if( _GetIsBridleInUse(oItem) ) {
        // PC was mounted to oItem's horse.
        oHorse = ALFA_UnmountHorse(oPC);
        RemoveHenchman(oPC, oHorse);
        DeleteGameLocation(oItem, _HORSE_TIED_LOCATION);
    } else {
        // The PC was not mounted
        oHorse = GetLocalObject(oItem, _SUMMONED_HORSE_LO);
        RemoveHenchman(oPC, oHorse);
        //ALFA_LeaveHorse(oPC, oHorse);
    }
    if(GetObjectType(GetItemPossessor(oItem)) == OBJECT_TYPE_STORE) {
        // Horse was sold.
        _UnmakeHorse(oHorse, oItem);
        DeleteLocalObject(oItem, _SUMMONED_HORSE_LO);
        DeleteGameLocation(oItem, _HORSE_TIED_LOCATION);

    }
    //SendMessageToPC(oPC, "UnAquiring "+GetName(oItem)+" linked to "+GetLocalString(oItem, _HORSE_SAVED_NAME));
}

void ALFA_HorseOnHeartbeat(object oPC) {
    if(ALFA_GetIsMounted(oPC) && GetIsInCombat(oPC)) {
        // PC is mounted and in combat.

        object oItem = GetLocalObject(oPC, _MOUNTED_HORSE_ITEM_LO);
        object oNearest = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC);
        if(oNearest != OBJECT_INVALID && GetDistanceBetween(oPC, oNearest) < 10.0) {
            // If there is a hostile enemy within 10.0 meters.

            if( GetLocalInt(oItem, _IS_WARHORSE) ) {
                //PC is riding a warhorse.
            } else {
                //PC is riding a normal horse.
                if( !GetIsSkillSuccessful(oPC, SKILL_RIDE, 20) ) {
                    if( GetIsSkillSuccessful(oPC, SKILL_RIDE, 15) ) {
                        if(GetGender(oPC) == GENDER_MALE) AssignCommand(oPC, SpeakString("*gets thrown off of his horse*"));
                        else AssignCommand(oPC, SpeakString("*gets thrown off of her horse*"));
                        ALFA_UnmountHorse(oPC);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 4.0);
                        return;
                    } else {
                        if(GetGender(oPC) == GENDER_MALE) AssignCommand(oPC, SpeakString("*gets thrown off of his horse*"));
                        else AssignCommand(oPC, SpeakString("*gets thrown off of her horse*"));
                        ALFA_UnmountHorse(oPC);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 4.0);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d6()), oPC);
                        return;
                    }
                } else {
                    FloatingTextStringOnCreature("*you manage to keep your untrained mount under control*", oPC, FALSE);
                }
            }
        }

        if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC)) == BASE_ITEM_HORSE_BRIDLE) {
            //PC has the reins in his off-hand.
        } else {
            //PC does not have the reins in-hand, must control mount with his knees.

            if( !GetIsSkillSuccessful(oPC, SKILL_RIDE, 5) ) {
                FloatingTextStringOnCreature("*you are forced to grab the reigns to keep control of your mount!*", oPC, FALSE);
                AssignCommand(oPC, ClearAllActions(TRUE));
                AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_LEFTHAND));
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
// *** BEGIN PRIVATE FUNCTIONS ***
////////////////////////////////////////////////////////////////////////////////

object _RespawnHorse(object oPC, object oItem) {
    //PrintString("acr_horse_i::_RespawnHorse: Attempting to respawn " + GetName(oPC) + "'s horse.");
    //SendMessageToPC(oPC, "_RespawnHorse from "+GetName(oItem));
    if( !GetIsValidLocalGameLocation(oItem, _HORSE_TIED_LOCATION) ) {
        //PrintString("acr_horse_i::_RespawnHorse: Invalid game location. Spawning horse at the PC.");
        // No location stored.
        return _MakeHorseFromItemAtLocation(oItem, GetLocation(oPC));
    }
    location loc = GetLocalGameLocation(oItem, _HORSE_TIED_LOCATION);
    if( loc == GetStartingLocation() ) {
        // No valid tie-up location on this server. Do nothing.
        //PrintString("acr_horse_i::_RespawnHorse: Game location is not on this server. Doing nothing.");
        SendMessageToPC(oPC, "Location saved for mount: "+GetLocalString(oItem, _HORSE_SAVED_NAME)+" could not be resolved.");
        return OBJECT_INVALID;
    } else {
        //PrintString("acr_horse_i::_RespawnHorse: Spawning horse at its last tied-up location.");
        return _MakeHorseFromItemAtLocation(oItem, loc, 0);
    }
}

object _FindLastBridle(object oPC, int nPhenoType) {
    object oInHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    object oSearch = GetFirstItemInInventory(oPC);
    //SendMessageToPC(oPC, "Checking "+GetName(oPC)+"'s hand for item "+GetName(oInHand)+" to see if it stores "+IntToString(nPhenoType)+", next will be "+GetName(oSearch));
    if (GetBaseItemType(oInHand) == BASE_ITEM_HORSE_BRIDLE) {
        if(GetLocalInt(oInHand, _HORSE_PHENOTYPE_LI) == nPhenoType) {
            //SendMessageToPC(oPC, "Likely in-hand hit with "+GetName(oInHand));
            if (_GetIsBridleInUse(oInHand))
                return oInHand;
        }
    }
    while (oSearch != OBJECT_INVALID) {
        // SendMessageToPC(oPC, GetName(oSearch));
        if (GetBaseItemType(oSearch) == BASE_ITEM_HORSE_BRIDLE) {
            if(GetLocalInt(oSearch, _HORSE_PHENOTYPE_LI) == nPhenoType) {
                //SendMessageToPC(oPC, "Likely inventory hit with "+GetName(oSearch));
                if (_GetIsBridleInUse(oSearch))
                    return oSearch;
            }
        }
        oSearch = GetNextItemInInventory(oPC);
    }
    //SendMessageToPC(oPC, "Couldn't _FindLastBridle");
    return OBJECT_INVALID;
}

int _GetIsBridleInUse(object oItem) {
    return GetLocalInt(oItem, _BRIDLE_IN_USE_LI);
}


int _GetIsPony(object oMount) {
    string sMountResRef = GetResRef(oMount);
    return (StringToInt(GetStringRight(sMountResRef, 1)) > 3);
}

int _GetNeedsPony(object oPC) {
    int nRiderRace = GetRacialType(oPC);
    return ((nRiderRace == RACIAL_TYPE_DWARF) || (nRiderRace == RACIAL_TYPE_GNOME) || (nRiderRace == RACIAL_TYPE_HALFLING));
}


void _NameMount(object oMount, object oPC) {
    string sPCName = GetName(oPC);
    object oBridle = GetLocalObject(oMount, _SUMMONED_HORSE_ITEM_LO);
    string sBaseName= GetLocalString(oBridle, _HORSE_BASE_NAME);

    // Checks to see if the Horse (or Pony) has been specifically renamed, if so- do not
    // overwrite with one of our default names.  The mount will keep that name until
    // a new custom name is granted.
    if (GetLocalInt(oBridle, _HORSE_HAS_CUSTOM_NAME)) {
        return;
        }
    // If the bridle is not carried/owned by anyone, revert it to the base name by template.
    else if (oPC == OBJECT_INVALID)
        SetLocalString(oBridle, _HORSE_SAVED_NAME, sBaseName);
    // Otherwise, compose the PC's name with the horse's base name to give the new name.
    else SetLocalString(oBridle, _HORSE_SAVED_NAME, sPCName+"'s "+sBaseName);
}


object _MakeHorseFromItemAtLocation(object oItem, location lLocation, int bMakeHenchman = 1) {
    string sResRef = GetLocalString(oItem, _HORSE_RESREF_LS);
    object oHorse = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLocation, TRUE);
    //PrintString("acr_horse_i::_MakeHorseFromItemAtLocation: Making horse '" + GetName(oHorse) + "' from resref '" + sResRef + "'.");
    object oPC = GetItemPossessor(oItem);

    //SendMessageToPC(oPC, "_MakeHorseFrom "+GetName(oItem)+": comes in as "+GetName(oHorse));

    int nHorseHP = GetLocalInt(oItem, _HORSE_HP);
    int nBaseHP = GetMaxHitPoints(oHorse);
    if(!nHorseHP) {
        nHorseHP = nBaseHP;
    }
    if (nHorseHP < nBaseHP) {
        int nTotalDamage = nBaseHP - nHorseHP;
        effect eDamage = EffectDamage(nTotalDamage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oHorse);
    }
    SetLocalObject(oHorse, _SUMMONED_HORSE_ITEM_LO, oItem);
    SetLocalObject(oItem, _SUMMONED_HORSE_LO, oHorse);
    _NameMount(oHorse, oPC);
    SetName(oHorse, GetLocalString(oItem, _HORSE_SAVED_NAME));

    if(GetLocalInt(oItem, _HORSE_APPEARANCE))
        DelayCommand(3.0f, SetCreatureTailType(GetLocalInt(oItem, _HORSE_APPEARANCE), oHorse));

    if(bMakeHenchman) {
        AddHenchman( oPC, oHorse );
    }
    return oHorse;
}

void _UnmakeHorse(object oHorse, object oItem) {
    int nCurrentHorseHP = GetCurrentHitPoints(oHorse);
    SetLocalInt(oItem, _HORSE_HP, nCurrentHorseHP);
    SetLocalString(oItem, _HORSE_SAVED_NAME, GetName(oHorse));
    DeleteLocalObject(oItem, _SUMMONED_HORSE_LO);
    DestroyObject(oHorse);
}

/*void _AddToHorseList(object oPC, object oItem) {
    int nNum = GetLocalInt(oPC, _HORSE_ARRAY_LENGTH);
    SetLocalInt(oPC, _HORSE_ARRAY_LENGTH, nNum);
    SetLocalArrayObject(oPC, _HORSE_ARRAY, nNum, oHorse);
}*/

void _DoBridleOnEnter(object oPC, object oItem) {
    if( GetBaseItemType(oItem) == BASE_ITEM_HORSE_BRIDLE ) {
        // Its a horse item.
        DeleteLocalObject(oItem, _SUMMONED_HORSE_LO);
        object oHorse = _RespawnHorse(oPC, oItem);
    }
}

void _DoBridleOnExit(object oPC, object oItem) {
    if(GetBaseItemType(oItem) == BASE_ITEM_HORSE_BRIDLE) {
        // Its a horse bridle item.
        if( !_GetIsBridleInUse(oItem) ) {
            // PC is not mounted on this horse.
            _UnmakeHorse( GetLocalObject(oItem, _SUMMONED_HORSE_LO), oItem );
        }
    }
}
