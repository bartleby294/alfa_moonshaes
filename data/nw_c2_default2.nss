//:: Default On Percieve
//:: NW_C2_DEFAULT2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks to see if the perceived target is an
    enemy and if so fires the Determine Combat
    Round function
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

// Modified by georage to add 098 subrace token system

#include "NW_I0_GENERIC"
#include "nw_i0_plot"


void main()
{
    //This is the equivalent of a force conversation bubble, should only be used if you want an NPC
    //to say something while he is already engaged in combat.
    if(GetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION) && GetIsPC(GetLastPerceived()) && GetLastPerceptionSeen())
    {
        SpeakOneLinerConversation();
    }
    //If the last perception event was hearing based or if someone vanished then go to search mode
    if ((GetLastPerceptionVanished()) && GetIsEnemy(GetLastPerceived()))
    {
        object oGone = GetLastPerceived();
        if((GetAttemptedAttackTarget() == GetLastPerceived() ||
           GetAttemptedSpellTarget() == GetLastPerceived() ||
           GetAttackTarget() == GetLastPerceived()) && GetArea(GetLastPerceived()) != GetArea(OBJECT_SELF))
        {
           ClearAllActions();
           DetermineCombatRound();
        }
    }
    //Do not bother checking the last target seen if already fighting
    else if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
    {
        //Check if the last percieved creature was actually seen
        if(GetLastPerceptionSeen())
        {
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
            {
                DetermineSpecialBehavior();
            }
            else if(GetIsEnemy(GetLastPerceived()))
            {
                if(!GetHasEffect(EFFECT_TYPE_SLEEP))
                {
                    SetFacingPoint(GetPosition(GetLastPerceived()));
                    SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
                    DetermineCombatRound();
                }
            }
            //Linked up to the special conversation check to initiate a special one-off conversation
            //to get the PCs attention
            else if(GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION) && GetIsPC(GetLastPerceived()))
            {
                ActionStartConversation(OBJECT_SELF);
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT) && GetLastPerceptionSeen())
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1002));
    }

//-------------------------------------------------------------------------------
//--------------------------098 Subrace Token Perception Script------------------
//-------------------------------------------------------------------------------

// This modification of nw_c2_default2 (onperception event)
// makes an NPC (or creature) look for tokens
// in the PC's left claw creature slot and react accordingly
//
// how the NPC or creature reacts is determine by 2 things
// 1) what token they find on the PC
// 2) what token the NPC is carrying

// There are 10 tokens (0-9) that can be applied to a player
// token 0 means no one will atack the PC
// token 1 means only NPCs with an Underdark Friend token will attack
// token 2-8 means only NPCs with NO TOKEN (default) will attack
// token 9 means everyone will attack

// there are 4 NPC tokens but only one is really necessary
// the one you will use most often is NPC Underdark Friend
// which you will place in all Underdark NPC's inventory
// this will make them NOT ATTACK drow, svirfneblin, duergar, half-orcs
// or anyone else with token 2-8
// and make them ATTACK anyone that has token 1 (surface lover) or token 9 (pariah)

// the NPC tokens you will probably not use are:
// NPC Underdark Enemy: This is the default. Adding this token to an NPC does nothing!
// NPC Underdark Neutral: This makes it so the NPC will not attack, but WILL NOT
//      engage in conversation with the PC either.
// NPC Underdark Flee: If this is the NPC's inventory they will RUN towards the nearest
//      waypoint called "WP_NPCEXIT" whenever they see token 2-9
//      they will also say something appropriate as they flee

// only look for token on PCs, not DM-possessed NPCs
//if(GetAge(GetLastPerceived()) != 0)
//if (GetIsPC(GetLastPerceived()))
//    {
//    object oPC = GetLastPerceived();
//    object oToken = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC);
//    string sTag = "underdark_token";
//    string sUbrace = GetStringRight(GetTag(oToken), 1);
//    string sNPC_UDfriend = "npc_ud_friend"; //friendly to underdark races
//    string sNPC_UDneutral = "npc_ud_neutral"; //neutral to underdark races
//    string sNPC_UDenemy = "npc_ud_enemy"; //enemies of underdark races (default)
//    string sNPC_UDflee = "npc_ud_flee"; //flee from underdark races, read notes above

    // DEFAULT: NPCs with no NPC token will attack PC tokens 2-9 by default
//    if (sUbrace != "1") // returns 0, 2-9
//    {
//    SetIsTemporaryEnemy(oPC, OBJECT_SELF);
//    DetermineCombatRound();
//    }

    // apply NPC reactions to those WITH TOKENS

    // NPC Underdark Friend reactions
//    if (HasItem(OBJECT_SELF, sNPC_UDfriend))
//    {
        // be friendly to token 0, 2-9
//        if (sUbrace != "1")// returns 0, 2-9
//        SetIsTemporaryFriend(oPC, OBJECT_SELF);
        // attack token 1
//        if (sUbrace == "1")
//        {
//        SetIsTemporaryEnemy(oPC, OBJECT_SELF);
//        DetermineCombatRound();
//        }
//    }

    // NPC Underdark Neutral reactions
    // for those that would treat underdark races as neutral, maybe evil commoners,
    // note the NPC will remain "red" and PCs cannot initiate conversation
    // so this will have limited use
//    else if (HasItem(OBJECT_SELF, sNPC_UDneutral))
//    {
        // be neutral to token 2-9
//        if (sUbrace != "1") // returns 0, 2-9
//        SetIsTemporaryNeutral(oPC, OBJECT_SELF);
        // but attack token 9
//        if (sUbrace == "9") // returns 9
//        {
//        SetIsTemporaryEnemy(oPC, OBJECT_SELF);
//        DetermineCombatRound();
//        }
        // be friendly to everyone else
//        if (sUbrace == "1") // returns 1
//        SetIsTemporaryFriend(oPC, OBJECT_SELF);
//    }

    // NPC Underdark Enemy reactions
    // THIS IS THE DEFAULT
    // you do not need to add Underdark Enemy tokens to NPCs
//    else if (HasItem(OBJECT_SELF, sNPC_UDenemy))
//    {
    // attack tokens 2-9
//        if (sUbrace != "1") // returns 0, 2-9
//        {
//        SetIsTemporaryEnemy(oPC, OBJECT_SELF);
//        DetermineCombatRound();
//        }
//    }

    //for NPCs that will flee from underdark races, see notes above
//    else if (HasItem(OBJECT_SELF, sNPC_UDflee))
//    {
//        string sFindExit = "WP_NPCEXIT";
//        object oFindExit = GetNearestObjectByTag(sFindExit);
//        if (sUbrace != "1") // returns 0, 2-9
//            {
//            ActionSpeakString("Run for your life!");
//            AssignCommand(OBJECT_SELF, ActionMoveToObject(oFindExit, TRUE, 6.0));
//            ActivateFleeToExit();
//            }
//                else
//                {
//                SetIsTemporaryFriend(oPC, OBJECT_SELF);
//                }
//    }


    // apply reactions to those with universal love/hate tokens (0 and 9)
    // a PC with underdark_token0 is a friend to all
//    if (sUbrace == "0")
//        {
//        SetIsTemporaryFriend(oPC, OBJECT_SELF);
//        }

    // the pariah - a PC with underdark_token9 is an enemy to all
//    if (sUbrace == "9")
//        {
//        SetIsTemporaryEnemy(oPC, OBJECT_SELF);
//        DetermineCombatRound();
//        }
//}
//-------------------------------------------------------------------------------
//--------------------------End of 098 Subrace Token Perception Script-----------
//-------------------------------------------------------------------------------
}
