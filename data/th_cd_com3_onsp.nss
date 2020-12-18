//  This is an initial script to test my general NPC script
#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"
#include "TH_NPC_INCLUDE"
void main()
{
    // OPTIONAL BEHAVIORS (Comment In or Out to Activate ) ****************************************************************************
     //SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);
     //SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
                // This causes the creature to say a special greeting in their conversation file
                // upon Perceiving the player. Attach the [NW_D2_GenCheck.nss] script to the desired
                // greeting in order to designate it. As the creature is actually saying this to
                // himself, don't attach any player responses to the greeting.
     //SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);
                // This will set the listening pattern on the NPC to attack when allies call
     //SetSpawnInCondition(NW_FLAG_STEALTH);
                // If the NPC has stealth and they are a rogue go into stealth mode
     //SetSpawnInCondition(NW_FLAG_SEARCH);
                // If the NPC has Search go into Search Mode
     //SetSpawnInCondition(NW_FLAG_SET_WARNINGS);
                // This will set the NPC to give a warning to non-enemies before attacking
     //SetSpawnInCondition(NW_FLAG_SLEEP);
                //Creatures that spawn in during the night will be asleep.
       SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING);
     //SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);
       SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
     //SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
                //This will play Ambient Animations until the NPC sees an enemy or is cleared.
                //NOTE that these animations will play automatically for Encounter Creatures.
    // NOTE: ONLY ONE OF THE FOLOOWING ESCAPE COMMANDS SHOULD EVER BE ACTIVATED AT ANY ONE TIME.
    //SetSpawnInCondition(NW_FLAG_ESCAPE_RETURN);    // OPTIONAL BEHAVIOR (Flee to a way point and return a short time later.)
    //SetSpawnInCondition(NW_FLAG_ESCAPE_LEAVE);     // OPTIONAL BEHAVIOR (Flee to a way point and do not return.)
    //SetSpawnInCondition(NW_FLAG_TELEPORT_LEAVE);   // OPTIONAL BEHAVIOR (Teleport to safety and do not return.)
    //SetSpawnInCondition(NW_FLAG_TELEPORT_RETURN);  // OPTIONAL BEHAVIOR (Teleport to safety and return a short time later.)
// CUSTOM USER DEFINED EVENTS
/*
    The following settings will allow the user to fire one of the blank user defined events in the NW_D2_DefaultD.  Like the
    On Spawn In script this script is meant to be customized by the end user to allow for unique behaviors.  The user defined
    events user 1000 - 1010
*/
      SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1001
    //SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
    //SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    //SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    //SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007
    // DEFAULT GENERIC BEHAVIOR (DO NOT TOUCH) *****************************************************************************************
    //SetListeningPatterns();    // Goes through and sets up which shouts the NPC will listen to.
    //GenerateNPCTreasure();     //* Use this to create a small amount of treasure on the creature
    //  Reset all waypoints to start.
    RemoveAllTasks();
    //  Random or in a set order.
    SetTaskOrder(NPC_WPTYPE_RANDOM);    //  This parameter does nothing atm
    struct sNpcTask        yarriTask;
    object                 oWayPoint;
    //  Set waypoint/task 1 (Starts a conversation with patron)
    oWayPoint = GetNearestObjectByTag("th_cd_com2");
    yarriTask.oWaypoint = oWayPoint;
    yarriTask.associatedCommand = NPC_COMMAND_TALKNORMAL;
    yarriTask.dayNight = NPC_TIME_ALWAYS;
    //yarriTask.percentChance = 50;  //  This parameter does nothing atm
    yarriTask.fDuration = 30.0;
    yarriTask.bRunToPoint = FALSE;
    AddTask(yarriTask);
    //  Set waypoint/task 2 (Starts a conversation with patron)
    oWayPoint = GetNearestObjectByTag("th_cd_com5");
    yarriTask.oWaypoint = oWayPoint;
    yarriTask.associatedCommand = NPC_COMMAND_TALKNORMAL;
    yarriTask.dayNight = NPC_TIME_ALWAYS;
    //yarriTask.percentChance = 50;  //  This parameter does nothing atm
    yarriTask.fDuration = 30.0;
    yarriTask.bRunToPoint = FALSE;
    AddTask(yarriTask);
    //  Set waypoint/task 3 (Starts a conversation with patron)
    oWayPoint = GetNearestObjectByTag("th_cd_com1");
    yarriTask.oWaypoint = oWayPoint;
    yarriTask.associatedCommand = NPC_COMMAND_TALKNORMAL;
    yarriTask.dayNight = NPC_TIME_ALWAYS;
    //yarriTask.percentChance = 50;  //  This parameter does nothing atm
    yarriTask.fDuration = 30.0;
    yarriTask.bRunToPoint = FALSE;
    AddTask(yarriTask);
    //  Set waypoint/task 4 (Drinks while conversing with another patron)
    oWayPoint = GetNearestObjectByTag("th_cd_com4");
    yarriTask.oWaypoint = oWayPoint;
    yarriTask.associatedCommand = NPC_COMMAND_DRINK;
    yarriTask.dayNight = NPC_TIME_ALWAYS;
    //yarriTask.percentChance = 50;   //  This parameter does nothing atm
    yarriTask.fDuration = 30.0;
    yarriTask.bRunToPoint = FALSE;
    AddTask(yarriTask);
    }

