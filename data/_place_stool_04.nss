#include "nw_i0_2q4luskan"
#include "x0_i0_position"
#include "_btb_writeToLog"

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

  writeToLog("---------------------");
  writeToLog("_place_stool_04");
  writeToLog("useablestool01");
  writeToLog("oArea: " + GetTag(oArea));
  writeToLog("oItem: " + GetTag(oItem));
  writeToLog("ChairLocFinal: " + GetTag(GetAreaFromLocation(ChairLocFinal)));
  writeToLog("oPC: " + GetPCPlayerName(oPC));
  writeToLog("---------------------");

    //signCommand(oPC, ActionSpeakString("*Sets up stool.*"));
    CreateObjectVoid(OBJECT_TYPE_PLACEABLE , "useablestool01", ChairLocFinal, FALSE);

}
