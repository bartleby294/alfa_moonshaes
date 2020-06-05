//::///////////////////////////////////////////////
//:: Name     Anti-Theft Script v1.1
//:: FileName   thief_functions
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Script Contains Functions for Anti-Theft Script
*/
//:://////////////////////////////////////////////
//:: Created By:  David Corrales
//:: Created On:  August 23, 2002
//:: Modified On: August 29, 2002
//:://////////////////////////////////////////////

//IMPORTANT: WHEN A CHANGE IS MADE TO THIS FILE, DO A *FULL MODULE BUILD* TO
//           UPDATE ALL REFERENCES.

//******************************************************************************

//CONSTANTS **DO NOT CHANGE**
int CALLHELP_THIEF = 2;
int SPOTTED_THIEF = 1;
string GUARD_ALERT = "THEFT_GUARD_ALERT";
//CONSTANTS **DO NOT CHANGE**

//******************************************************************************

//USE_LISTEN_PATTERNS-
//When set to TRUE, this will enable the Guards to Listen for Calls of Help
//NPC will call for help and if the guard is in Listening range he will come.
//Listen Pattern also allows the calling NPC to be affected by spells such as silence.
//When set to FALSE, this will then use alternative means of alerting the guards.
//The NPC will no be effected by Silence spells in this mode, but in this mode you
//can change the range of the alert.

int USE_LISTEN_PATTERNS = TRUE;

//SPAWN_GUARD
//When set to TRUE, a guard will be spawned if a guard in area isn't alerted
//It will spawn a guard at the nearest waypoint tagged "WP_GUARD_SPAWN"
//The waypoint must be in the same area as the alerter.

int SPAWN_GUARD = TRUE;

//******************************************************************************


//ALERT_DISTANCE
//Distance the target can Alert Guards, Also determines the check range in
//LISTEN_PATTERN to determine if a guard should be spawned
//If LISTEN_PATTERN is FALSE, this value can be increase to alert guards at
//greater ranges
float ALERT_DISTANCE = 40.0;

//SPOT_DISTANCE
//Distance can see or hear, when a theft is in progress
//(Set to limit the distance) //Max is around 35 or 40
float SPOT_DISTANCE = 40.0;

//GUARD_TEMPLATE
//Template of guard to summon in Summon_Guard()
//Make sure the template of custom guard as a default tag starting with "GUARD"
string GUARD_TEMPLATE = "wpnchkguard";

//******************************************************************************
//v1.1 Addition
//Set to 0 for no penalty
//Hide Skill applies to covering up other actions too, So low level rogues will
//not want to picklocks with others around
//Temp Skill Penalty for opening stuff (including lockpicking,pickpocket)
int HIDE_SKILL_PENALTY =          10;
//Temp Skill Penalty for bashing
int MOVESILENT_SKILL_PENALTY =    20;
//******************************************************************************

void Theft_AlertGuards(object oThief);
int Summon_Guard(object oThief);
void Theft_SpotThief(object oThief, int bBashHearCheck = FALSE, object oSource = OBJECT_SELF);


void Theft_SpotThief(object oThief, int bBashHearCheck = FALSE, object oSource = OBJECT_SELF)
{
  int i = 0;
  object oNPC;
  //v1.1 Skill penalties
  if(bBashHearCheck) //we bashing?
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_MOVE_SILENTLY,MOVESILENT_SKILL_PENALTY),oThief,1.0);

  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_HIDE,HIDE_SKILL_PENALTY),oThief,1.0);

  while((oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oSource,i))!= OBJECT_INVALID)
  {
        if(GetDistanceBetween(oNPC,oSource) > SPOT_DISTANCE)
            break;

        if(GetObjectSeen(oThief,oNPC)||(bBashHearCheck && GetObjectHeard(oThief,oNPC)))
        {
           SetLocalInt(oNPC,"SPOTTED_THIEF",SPOTTED_THIEF);
           SetLocalObject(oNPC,"THIEF",oThief);
           if(GetStringLeft(GetTag(oNPC),5)=="GUARD")   //make the guard mad
               SetIsTemporaryEnemy(oThief,oNPC);
        }
       i++;
  }
}

void Theft_AlertGuards(object oThief)
{
    int Guard_Warned = FALSE;
    object oGuard;
    int i = 0;

    if(USE_LISTEN_PATTERNS)
    {
        SpeakString(GUARD_ALERT,TALKVOLUME_SILENT_TALK);
    }

    while((oGuard = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF,i))!= OBJECT_INVALID)
    {
        if(GetDistanceBetween(OBJECT_SELF,oGuard) > ALERT_DISTANCE)
            break;

        if(GetStringLeft(GetTag(oGuard),5)== "GUARD")
        {
            Guard_Warned = TRUE;

            if(USE_LISTEN_PATTERNS)//just needed to check if guard is near my area
                break;

            SetLocalInt(oGuard,"SPOTTED_THIEF",CALLHELP_THIEF);
            SetLocalObject(oGuard,"THIEF",oThief);
            SetIsTemporaryEnemy(oThief,oGuard);
        }
        i++;
     }

     if(!Guard_Warned && SPAWN_GUARD)
         Summon_Guard(oThief);
}

int Summon_Guard(object oThief)
{
   object oGuard;
   object oWaypoint;

   if((oWaypoint= GetNearestObjectByTag("WP_GUARD_SPAWN",OBJECT_SELF))!= OBJECT_INVALID)
   {
        if(GetArea(oWaypoint) == GetArea(OBJECT_SELF)) //Only if in same area
        {
            location loc = GetLocation(oWaypoint);
               //Ok spawn a guard
            if((oGuard = CreateObject(OBJECT_TYPE_CREATURE,GUARD_TEMPLATE,loc))!=OBJECT_INVALID)
            {
                SetIsTemporaryEnemy(oThief,oGuard);
                AssignCommand(oGuard,ActionAttack(oThief));
                return TRUE;
            }
        }
    }
   return FALSE;
}
