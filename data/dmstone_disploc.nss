#include "nwnx_area"

void main()
{
    object oPC = GetPCSpeaker();
    location oPCLocation = GetLocation(oPC);
    vector oPCLocationVector = GetPositionFromLocation(oPCLocation);
    SendMessageToPC(oPC, "(" + FloatToString(oPCLocationVector.x) + ","
                             + FloatToString(oPCLocationVector.y) + ","
                             + FloatToString(oPCLocationVector.z)+ ")");
}
