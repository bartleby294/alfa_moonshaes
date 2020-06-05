//::///////////////////////////////////////////////
//:: Weapon Check Guard v 1.0 & Anti-Theft Guard
//:: On Heartbeat
//:: onheart_chkwpn
//:://////////////////////////////////////////////
/*
Guard will warn player with weapon in hand to put it away.
After a few warnings the guard will attack the offending player.
*/
//:://////////////////////////////////////////////
//:: Created By: David "The Shadowlord" Corrales
//:: Created On: August 20 2002
//:: Modified On: August 23 2002
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "theft_functions"

//VARIABLES START - EDIT AT OWN PLEASURE
string WARNING1 = "Please put away your weapon";
string WARNING2 = "I said put away your weapon!";
string WARNING3 = "I will not tell you again! Put it away!";//Move to Player
string ATTACK_MSG = "You where warned!!! Attack!!";//Attack here
string COMPLY_REPLY = "Good";
float WARN_DISTANCE = 20.0;//Distance in which to spot player
int IS_TEMPORARY_ANGER = TRUE; //Set to FALSE if want to always remain angry
float ANGER_DUR = 120.0; //Length of time (sec) that will remain angry at the pc
//VARIABLES END - EDIT AT OWN PLEASURE

void main()
{
object oPC;
object item;
struct sEnemies strEnemies = DetermineEnemies();
int nTotal;

//*************** THEFT CODE ***********************
int thief_alert = GetLocalInt(OBJECT_SELF,"SPOTTED_THIEF");
if(thief_alert)
{
SetLocalInt(OBJECT_SELF,"SPOTTED_THIEF",0);
object oThief = GetLocalObject(OBJECT_SELF,"THIEF");

if(oThief != OBJECT_INVALID)
{
SetLocalInt(OBJECT_SELF,"SPOTTED_THIEF",0);
ActionAttack(oThief);
DetermineCombatRound(oThief);

SpeakString("Thief!!!");//React to theft

//I saw the crime, Call for help.
if(thief_alert == SPOTTED_THIEF)
Theft_AlertGuards(oThief);
}
}//************************************************
else
{

//gets nearest player char to the NPC
oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF);
nTotal = strEnemies.TOTAL;

if(oPC != OBJECT_INVALID && (GetDistanceBetween(OBJECT_SELF,oPC) < WARN_DISTANCE) && GetObjectSeen(oPC)&& !GetIsEnemy(oPC))
{
//if the PC has a weapon in its hand
if((item = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC))!=OBJECT_INVALID && nTotal==0)
{
if(GetLocalObject(OBJECT_SELF,"LastOffender")==oPC)
{
if(GetLocalInt(OBJECT_SELF,"OffenseCount")==2)
{
SpeakString(ATTACK_MSG);
SetIsTemporaryEnemy(oPC,OBJECT_SELF,IS_TEMPORARY_ANGER,ANGER_DUR);
ActionAttack(oPC);
}
else if(GetLocalInt(OBJECT_SELF,"OffenseCount")==1)
{
ActionMoveToObject(oPC,TRUE);
SetLocalInt(OBJECT_SELF,"OffenseCount",2);
SpeakString(WARNING3);
}
else
{
SetLocalInt(OBJECT_SELF,"OffenseCount",1);
SpeakString(WARNING2);
}
}
else
{
SetLocalInt(OBJECT_SELF,"OffenseCount",0);
SpeakString(WARNING1);
SetLocalObject(OBJECT_SELF,"LastOffender",oPC);
}
}
//if the PC doesn't have a weapon in its hand
else
{
if( GetLocalObject(OBJECT_SELF,"LastOffender")!= OBJECT_INVALID)
SpeakString(COMPLY_REPLY);

DeleteLocalObject(OBJECT_SELF,"LastOffender");
SetLocalInt(OBJECT_SELF,"OffenseCount",0);
}
}
}

if(GetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY))
{
if(TalentAdvancedBuff(40.0))
{
SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY, FALSE);
return;
}
}

if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
{
int nDay = FALSE;
if(GetIsDay() || GetIsDawn())
{
nDay = TRUE;
}
if(GetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT") != nDay)
{
if(nDay == TRUE)
{
SetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT", TRUE);
}
else
{
SetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT", FALSE);
}
WalkWayPoints();
}
}

if(!GetHasEffect(EFFECT_TYPE_SLEEP))
{
if(!GetIsPostOrWalking())
{
if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
{
if(!GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
{
if(!GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL) && !IsInConversation(OBJECT_SELF))
{
if(GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS) || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN))
{
PlayMobileAmbientAnimations();
}
else if(GetIsEncounterCreature() &&
!GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
{
PlayMobileAmbientAnimations();
}
else if(GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS) &&
!GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
{
PlayImmobileAmbientAnimations();
}
}
else
{
DetermineSpecialBehavior();
}
}
else
{
//DetermineCombatRound();
}
}
}
}
else
{
if(GetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT))
{
effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
if(d10() > 6)
{
ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
}
}
}

if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
{
SignalEvent(OBJECT_SELF, EventUserDefined(1001));
}
}
