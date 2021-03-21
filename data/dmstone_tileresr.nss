#include "nwnx_area"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    location oPCLocation = GetLocation(oPC);
    vector oPCLocationVector = GetPositionFromLocation(oPCLocation);

    string tileResRef = NWNX_Area_GetTileModelResRef(oArea,
                                                     oPCLocationVector.x,
                                                     oPCLocationVector.y);
    int x = FloatToInt(oPCLocationVector.x / 10.0) + 1;
    int y = FloatToInt(oPCLocationVector.y / 10.0) + 1;
    SendMessageToPC(oPC, "(" + IntToString(x + 1) +"," + IntToString(y + 1)
                         + ") ResRef: " + tileResRef);
}
