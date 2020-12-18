//::///////////////////////////////////////////////
//:: an_animal_heartb
//:: This script goes in the OnHeartbeat spot
//:: By Rhox505 @ stuart_heinrich@hotmail.com
//::
//:: Modified : Rahvin Talemon April/May 2004 v1.0
//:://////////////////////////////////////////////

#include "an_animal_ai_inc"

void main()
{
    object oSelf = OBJECT_SELF,
           oTarget = GetNearestScary(oSelf, PERCEPTION_RANGE_FLEE), //OBJECT_INVALID if none
           oFood = GetEatingFood(oSelf),                            //food that is being hunted or eaten
           oAttacker = GetLastHostileActor(oSelf);

    IncreaseHunger(oSelf, GetHungerRate(oSelf));

    if (!GetIsHungry(oSelf) && GetDecideToEat(oSelf))
        SetHungry(oSelf, TRUE);
    if(GetHunger(oSelf) > GetStarveHunger(oSelf)*EXHAUSTION_HUNGER_PERCENT)
        SetExhaustion(oSelf, TRUE);
    if(GetHunger(oSelf) > GetStarveHunger(oSelf))
        ActionDieOfStarvation(oSelf);

    // If we are in combat, we don't want to do any of the hunting gathering type of things.
    if (GetIsInCombat(oSelf))
    {
        //PrintString("Heartbeat, In Combat");
        if (GetLocalInt(OBJECT_SELF, I_AM_FLEEING))
        {
            // PrintString(GetName(oTarget) + " is the nearest scary.");
            ///PrintString("Flee variable set, I'm running from " + GetName(oAttacker));
            ActionFleeFrom(oSelf, oAttacker);
        }
        return;
    }
    else
    {
         if (!GetObjectSeen(oAttacker, oSelf))
         {
            // PrintString("Clearing Flee value.");
            SetLocalInt(oTarget, I_AM_FLEEING, FALSE);
         }
    }

    if (GetIsObjectValid(oTarget))  //RT.4.30.4 Probably need it to check for percieved here instead of exists.
    {
        // PrintString("Normal heartbeat, object is valid and it is: " + GetName(oTarget));
        ActionFleeFrom(oSelf, oTarget);
        SetEating(oSelf, FALSE);
    }
    else if (GetIsEating(oSelf) || GetShouldEatPlant(oSelf, oFood) || GetShouldEatCorpse(oSelf, oFood))
        ActionEat(oSelf, oFood);
    else if (GetIsHungry(oSelf))
        ActionLookForFood(oSelf);
    // If member of pack and not the leader then just follow the leader. RT.4.27.4
    else if (RT_IsMemberOfPack(oSelf) && !RT_IsLeaderOfPack(oSelf))
        RT_ActionFollowPackLeader(oSelf);
    else
        ActionRandomExplore(oSelf);

    if (GetCreatureSize(oSelf) >= CREATURE_SIZE_MEDIUM)
        LeaveAnimalTracks(oSelf);
}


