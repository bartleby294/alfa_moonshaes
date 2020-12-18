#include "NW_I0_GENERIC"

void main()
{

if(!GetFleeToExit())
{
if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
{
if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
{
if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
{
DetermineSpecialBehavior(GetLastDamager());
}
else if(GetIsObjectValid(GetLastDamager()))
{
DetermineCombatRound();
if(!GetIsFighting(OBJECT_SELF))
{
object oTarget = GetLastDamager();
if(!GetObjectSeen(oTarget) && GetArea(OBJECT_SELF) == GetArea(oTarget))
{
ActionMoveToLocation(GetLocation(oTarget), TRUE);
ActionDoCommand(DetermineCombatRound());
}
}
}
}
else if (!GetIsObjectValid(GetAttemptedSpellTarget()))
{
object oTarget = GetAttackTarget();
if(!GetIsObjectValid(oTarget))
{
oTarget = GetAttemptedAttackTarget();
}
object oAttacker = GetLastHostileActor();
if (GetIsObjectValid(oAttacker) && oTarget != oAttacker && GetIsEnemy(oAttacker) &&
(GetTotalDamageDealt() > (GetMaxHitPoints(OBJECT_SELF) / 4) ||
(GetHitDice(oAttacker) - 2) > GetHitDice(oTarget) ) )
{
DetermineCombatRound(oAttacker);
}
}
}
}
if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
{
SignalEvent(OBJECT_SELF, EventUserDefined(1006));
}
//-----------------------------
// added for 098 dragon script
//-----------------------------
object oPC = GetLastDamager();
object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
int iMostElvesAreGay = (GetWeaponRanged(oWeapon)); //check to see if they are using a ranged weapon
if (iMostElvesAreGay == TRUE) //if it is then ...
SetLocalInt(OBJECT_SELF,"098dragonAI",0);
}
