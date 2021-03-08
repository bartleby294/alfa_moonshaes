//::///////////////////////////////////////////////
//:: Default On Attacked
//:: NW_C2_DEFAULT5
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If already fighting then ignore, else determine
    combat round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "nw_i0_generic"

//*************************** ALFA Mod - include for weapon breakage
//#include "alfa_combat"
//*************************** End ALFA Mod

void main()
{
    if(GetFleeToExit()) {
        // Run away!
        ActivateFleeToExit();
    } else if (GetSpawnInCondition(NW_FLAG_SET_WARNINGS)) {
        // We give an attacker one warning before we attack
        // This is not fully implemented yet
        SetSpawnInCondition(NW_FLAG_SET_WARNINGS, FALSE);

        //Put a check in to see if this attacker was the last attacker
        //Possibly change the GetNPCWarning function to make the check
    } else {
        object oAttacker = GetLastAttacker();
        if (!GetIsObjectValid(oAttacker)) {
            //Shout Attack my target, only works with the On Spawn In setup
            SendMessageToAllDMs("Attack Script: Invalid target");

            //Shout that I was attacked
            //SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_PARTY);
            // Don't do anything, invalid attacker

        } else if (!GetIsFighting(OBJECT_SELF)) {
            // We're not fighting anyone else, so
            // start fighting the attacker
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL)) {
                SetSummonHelpIfAttacked();
                DetermineSpecialBehavior(oAttacker);
            } else if (GetArea(oAttacker) == GetArea(OBJECT_SELF)) {
                SetSummonHelpIfAttacked();
                DetermineCombatRound(oAttacker);
            }

            //SendMessageToAllDMs("Attack Script: I am not fighting but starting.");

            //SetListenPattern( OBJECT_SELF, "NW_I_WAS_ATTACKED",5000);
            //SetListenPattern( OBJECT_SELF, "I_WAS_ATTACKED",5001);

            //Shout Attack my target, only works with the On Spawn In setup
            //SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

            //Shout that I was attacked
            //SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
        }
    }
   // SetListenPattern( OBJECT_SELF, "NW_I_WAS_ATTACKED",25);
    //SetListenPattern( OBJECT_SELF, "I_WAS_ATTACKED",26);

    SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
    //SpeakString("I_WAS_ATTACKED", TALKVOLUME_SILENT_SHOUT);

    if(GetSpawnInCondition(NW_FLAG_ATTACK_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_ATTACKED));
    }


//****************************** ALFA Mod -  for weapon breakage
    //ALFA_CheckWeaponBreakage();
//****************************** End ALFA Mod

}
