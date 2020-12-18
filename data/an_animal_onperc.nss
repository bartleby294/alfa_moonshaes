//::///////////////////////////////////////////////
//:: an_animal_onperc
//:: This script should be CALLED by the OnPercieved Event Script.
//:: Author: Rahvin Talemon April/May 2004 v1.0
//:://////////////////////////////////////////////

// Pack on percieved activity.
// This is the pack activity. It should go somewhere in the OnPercieved Event.
// When a creature first percieves a creature of its type it will try to pack
// up with them if it does not currently have a pack. If it does have a pack
// it will ignore the creature.
//
// This script should be used as by placing the following line in the OnPercieved Event script of the creature.
//
// ExecuteScript(OBJECT_SELF, "an_animal_onperc");

#include "an_animal_ai_inc"

void main()
{
    object oCreaturePercieved = GetLastPerceived();

    if (!GetIsObjectValid(oCreaturePercieved))
        return;

    if (!RT_IsPackCreature(OBJECT_SELF))
        return;

    // If the creature actually saw the other one, and they're the same type then do this.
    // Conditions.
    // Seen
    // Same Tag (Animals)
    // A creature that naturally forms a pack
    // Not part of a pack already.
    // Not a pack leader.

    if ( GetLastPerceptionSeen() && ( GetTag(oCreaturePercieved) == GetTag(OBJECT_SELF) ) && RT_IsPackCreature(oCreaturePercieved) && !RT_IsPackLeader(OBJECT_SELF) && !RT_IsMemberOfPack(OBJECT_SELF))
    {
        //PrintString(GetName(oCreaturePercieved) + "Member of pack: " + IntToString(RT_IsMemberOfPack(oCreaturePercieved)));
        //PrintString(GetName(OBJECT_SELF) + "Member of pack: " + IntToString(eld_IsMemberOfPack(OBJECT_SELF)));

        // Encountered creature has no pack leader and neither do I, he and I should form a pack.
        // Case 1. Two unformed creatures get together and form a gang.
        if ( !RT_IsMemberOfPack(oCreaturePercieved) && !RT_IsPackLeader(oCreaturePercieved))
        {
            // Form a pack with just the two of you.
            RT_FormPack(oCreaturePercieved, OBJECT_SELF);
        }

        // Creature has a pack leader but I don't, see if I can join his pack.
        // Though when I join I will challange the current leader.
        // Case 2. The un-packed creature will attempt to join an already established pack.
        //         In the process they will challange the leader for control of the group.
        else if ( RT_IsMemberOfPack(oCreaturePercieved) || RT_IsPackLeader(oCreaturePercieved))
        {
            object oCurrentLeader = RT_GetPackLeader(oCreaturePercieved);
            //PrintString("Current Alpha: " + GetName(oCurrentLeader));

            // If the pack is small enough I can join, challenge the current leader.
            if ( RT_GetPackSize(oCreaturePercieved) < PACK_MAX_SIZE)
            {
                object oNewAlpha = RT_DetermineAlphaMale(OBJECT_SELF, oCurrentLeader);

                //PrintString("New Alpha: " + GetName(oNewAlpha));

                // If the new guy wins, switch leaders. Otherwise new guy just joins the group.
                if (oNewAlpha == OBJECT_SELF)
                    RT_SwitchLeadership(oCurrentLeader, oNewAlpha);
                else
                    RT_SetMyPackLeader(oNewAlpha, OBJECT_SELF);
            }
        }
    }
}
