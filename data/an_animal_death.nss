// This file needs to be different depending on where its being used. If on ALFA
// where we use NESS, the ness code hanldes dying a little.

// ELDER:   When a PC or animal kills something here we have to take into account
//          the CNR system and the placables it uses to represent a skinnable corpse.
//          When a creature dies, two placables will be created after the corpse is
//          destroyed. Bones and a Skinnable corpse. The skinnable corpse will act
//          as the food source for all carnivores animals will eat that. The bones
//          will contain any items other than the skin the players can obtain.

// ALFA:    ALFA doesn't use the cnr system so a different set of placables will
//          be used that basically do the very same thing. The skinnable corpse
//          will be useless to a PC but will still provide a food source to animals.
//          The bones will contain the skin of the animal and any other creature items
//          they might have had.
//
//
//
// Modified : Rahvin Talemon April/May 2004 v1.0

#include "NW_I0_GENERIC"
#include "an_animal_ai_inc"

#include "sos_include"

#include "subraces"
#include "spawn_functions"

void main()
{
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    location locDeath = GetLocation(OBJECT_SELF);

    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        object oKiller = GetLastKiller();
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);
    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    object oCorpse = OBJECT_SELF;
    object oKiller = GetLastKiller();

    int Size = GetCreatureSize(oCorpse);

    object oCorpseObject = CreateObject(OBJECT_TYPE_PLACEABLE, "cnrcorpseskin", locDeath, FALSE);
    object oBonesObject = CreateObject(OBJECT_TYPE_PLACEABLE, "cnrcorpsebones", locDeath, FALSE);

    // CNR compatability.- Must make bones have an inventory.
    SetLocalObject(oCorpseObject, "CnrCorpseBones", oBonesObject);
    SetLocalString(oCorpseObject, "CnrCorpseType", GetTag(OBJECT_SELF));

    ////////////////////////////////////////////////////////////////////////////
    // ALFA Start

    // Create whatever the beast had in its inventory on the bone placable.
    object oItem = CreateItemOnObject(GetResRef(GetFirstItemInInventory(oCorpse)), oBonesObject);
    while (GetIsObjectValid(oItem))
    {
        // PrintString("Created item: " + ObjectToString(oItem));
        oItem = CreateItemOnObject(GetResRef(GetNextItemInInventory(oCorpse)), oBonesObject);
    }
    DestroyInventory(oCorpse);


    // ALFA END
    ////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////
    // Elder Start
    /*

    // Remove everything the corpse had on it and add something for use with CNR.
    DestroyInventory(oCorpse);
    CreateItemOnObject("cnrbones", oBonesObject); // Update with resref of bones.

    */
    // Elder END
    ////////////////////////////////////////////////////////////////////////////

    // Store the amount of food on the object.
    SetFoodLeft(oCorpseObject, GetFoodOnAnimal(oCorpse));

    // Test to see if carnivore.
    if (GetIsCarnivore(oKiller))
        AssignCommand(oKiller, ActionMoveToObject(oCorpseObject));

    // SEI_NOTE: Reward experience for killing this creature.
    XP_RewardXPForKill();

    // Tell spawn system of the creature's demise.You can comment this out
    // if not using NESS to spawn these creatures
    NESS_ProcessDeadCreature(OBJECT_SELF); // Comment this for Elder.

    // Ensure that the corpses are destroyable. Jasperre sets to undestroyable.
    // Gets rid of perma corpses. (Thanks Cereborn!)
    SetIsDestroyable(TRUE, FALSE, FALSE);

    // Destroy the placables.
    DelayCommand(CORPSE_BONES_TIME, DestroyObject(oCorpseObject));
    DelayCommand(CORPSE_FADE_TIME, DestroyObject(oBonesObject));

    // RT.5.4
    // Animal AI Pack behavior.
    // Remove the pack creature from its pack.
    if ( RT_IsPackCreature(OBJECT_SELF) )
        RT_RemoveFromPack(OBJECT_SELF);
}

