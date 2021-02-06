/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.4

For download info, please visit:
http://www.lilacsoul.revility.com    */

//Put this OnUsed
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;
if (GetIsDM(oPC)) return;


if(GetPCPlayerName(oPC) == "ayergovich" || GetPCPlayerName(oPC) == "Rick7475" || GetPCPlayerName(oPC) == "QRRCXUDW" || GetPCPlayerName(oPC) == "Q6UWTARJ" || GetPCPlayerName(oPC) == "Stormbring3r" || GetPCPublicCDKey(oPC) == "QRRVC76P" || GetPCPlayerName(oPC) == "jmecha" || GetPCPublicCDKey(oPC) == "QRRP4UFX"){
AssignCommand(oPC, ClearAllActions());

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("ponlinteleport");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));
GiveXPToCreature(oPC, 1);
}
}