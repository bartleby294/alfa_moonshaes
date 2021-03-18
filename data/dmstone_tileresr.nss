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

    SendMessageToPC(oPC, "Tile Resref: " + tileResRef);
}
