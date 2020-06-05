string sDeny;

void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "ooc_wyngate_entr")== OBJECT_INVALID)
   {
   sDeny="This portal is for access to Cantrev Wyngate after a mod reset. Please PM Rusty if you don't have access and think you ought to.";

   SendMessageToPC(oPC, sDeny);

   return;
   }

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("WP_mod_wyngate");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));

}

