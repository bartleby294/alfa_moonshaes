#include "x2_inc_toollib"

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    int ship_state = GetLocalInt(OBJECT_SELF, "ship_state");

    if(ship_state == 1) {
        SetLocalInt(OBJECT_SELF, "ship_state", 0);
        SpeakString("Unhide ship");
        TLResetAreaGroundTiles(oArea, GetAreaSize(AREA_WIDTH), GetAreaSize(AREA_HEIGHT));
    } else {
        SetLocalInt(OBJECT_SELF, "ship_state", 1);
        SpeakString("Hide Ship");
        TLChangeAreaGroundTiles(oArea, X2_TL_GROUNDTILE_GRASS, 10, 21, 3.0f);
        TLChangeAreaGroundTiles(oArea, X2_TL_GROUNDTILE_WATER,  9, 21, 2.0f);
    }
}
