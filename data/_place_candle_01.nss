#include "nw_i0_2q4luskan"
#include "x0_i0_position"

void main()
{
   object  oPC = OBJECT_SELF;
   object oArea = GetArea(oPC);
   object oItem = GetItemActivated();
   location oItemLoc = GetItemActivatedTargetLocation();

   location oPCLoc = GetLocation(oPC);

   float oPCfacing = GetFacingFromLocation(oPCLoc);
   vector oItemVec = GetPositionFromLocation(oItemLoc);

   location oItemLocFinal = Location(oArea, oItemVec, oPCfacing);


   AssignCommand(oPC, ActionSpeakString("*Takes out a candle and lights it.*"));
   CreateObjectVoid(OBJECT_TYPE_PLACEABLE , "placecandle01", oItemLocFinal , FALSE);

}
