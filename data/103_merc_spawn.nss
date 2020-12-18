#include "NW_I0_GENERIC"

void main()
{
     SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
     SetSpawnInCondition(NW_FLAG_TELEPORT_RETURN);  // OPTIONAL BEHAVIOR (Teleport to safety and return a short time later.)

// CUSTOM USER DEFINED EVENTS
    SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
   SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    SetIsDestroyable( FALSE, FALSE, FALSE);

// DEFAULT GENERIC BEHAVIOR (DO NOT TOUCH) *****************************************************************************************
    ExecuteScript( GetStringLowerCase( GetTag( OBJECT_SELF))+"_listen",OBJECT_SELF);   // Goes through and sets up which shouts the NPC will listen to.
    WalkWayPoints(FALSE, 3.0);           // Optional Parameter: void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
                                         // 1. Looks to see if any Way Points in the module have the tag "WP_" + NPC TAG + "_0X", if so walk them
                                         // 2. If the tag of the Way Point is "POST_" + NPC TAG the creature will return this way point after
                                         //    combat.

    //Here we create a merchant based upon the tag of the NPC
    //If we can't find a merchant in format "tag" + "int" we use the "default_merchant blueprint

    int iNumMerchants = 5; // Maximum number of stores to cycle

    object oStore = GetNearestObject(OBJECT_TYPE_STORE);
    if (GetDistanceToObject(oStore) < 5.0)
    {
        DestroyObject(oStore);
    }

    //Try to make the store
    oStore = CreateObject(OBJECT_TYPE_STORE,
             ( GetTag(OBJECT_SELF) + IntToString( GetCalendarDay()%iNumMerchants + 1 ) ),
             GetLocation(OBJECT_SELF),
             FALSE,
             "");

    if(GetIsObjectValid(oStore)) return; //First shot, we're good

    else// Use the default
    {
        CreateObject(OBJECT_TYPE_STORE,
                 "default_store",
                 GetLocation(OBJECT_SELF),
                 FALSE,
                 GetTag(OBJECT_SELF));
    }
}


