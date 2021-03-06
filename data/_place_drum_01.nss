#include "nw_i0_2q4luskan"
#include "x0_i0_position"

void main()
{
   object  oPC = OBJECT_SELF;
   object oArea = GetArea(oPC);
   object oItem = GetItemActivated();
   location TentLoc = GetItemActivatedTargetLocation();

   location oPCLoc = GetLocation(oPC);

   float oPCfacing = GetFacingFromLocation(oPCLoc);
   vector TentVec = GetPositionFromLocation(TentLoc);

   location TentLocFinal = Location(oArea, TentVec, oPCfacing);


   AssignCommand(oPC, ActionSpeakString("*Takes out a drum*"));
   CreateObjectVoid(OBJECT_TYPE_PLACEABLE , "usabledrum", TentLocFinal, FALSE);

}
