#include "nwnx_area"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int areaHeight = GetAreaSize(AREA_HEIGHT, oArea);
    int areaWidth = GetAreaSize(AREA_WIDTH, oArea);

    int x = 0;
    int y = 0;

    WriteTimestampedLogEntry("===============================================");
    WriteTimestampedLogEntry("Tiles Used in Area: " + GetName(oArea));
    WriteTimestampedLogEntry("===============================================");

    while(y < areaHeight) {
        float curY = y * 10.0 + 5.0;
        while(x < areaWidth) {
            float curX = x * 10.0 + 5.0;
            string tileResRef = NWNX_Area_GetTileModelResRef(oArea, curX, curY);
            WriteTimestampedLogEntry("(" + IntToString(x + 1) +","
                                     + IntToString(y + 1) + ") ResRef: "
                                     + tileResRef);
            x++;
        }
        x = 0;
        y++;
    }
}
