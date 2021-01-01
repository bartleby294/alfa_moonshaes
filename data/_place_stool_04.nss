#include "nw_i0_2q4luskan"
#include "x0_i0_position"

void main()
{
   object  oPC = OBJECT_SELF;

    AssignCommand(oPC, ActionSpeakString("*Sets up stool.*"));

   object oArea = GetArea(oPC);
   object oItem = GetItemActivated();
   location ChairLoc = GetItemActivatedTargetLocation();
   location oPCLoc = GetLocation(oPC);

    float oPCfacing = GetFacingFromLocation(oPCLoc)+180;
    vector ChairVec = GetPositionFromLocation(ChairLoc);

    location ChairLocFinal = Location(oArea, ChairVec, oPCfacing);

    //signCommand(oPC, ActionSpeakString("*Sets up stool.*"));
    CreateObjectVoid(OBJECT_TYPE_PLACEABLE , "useablestool01", ChairLocFinal, FALSE);

}
