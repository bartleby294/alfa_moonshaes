#include "_btb_util"
#include "x0_i0_position"

string RandomBatSound() {

    switch(Random(9) + 1) {
        case 1:
            return "as_an_bat1";
        case 2:
            return "as_an_bat2";
        case 3:
            return "as_an_bat3";
        case 4:
            return "as_an_batflap1";
        case 5:
            return "as_an_batflap2";
        case 6:
            return "as_an_bats1";
        case 7:
            return "as_an_bat2";
        case 8:
            return "as_an_batsflap1";
        case 9:
            return "as_an_batsflap2";
    }
    return "";
}

void main()
{
    int hbCount = GetLocalInt(OBJECT_SELF, "hbCount");
    if(hbCount > 2) {
        DestroyObject(OBJECT_SELF);
    } else {

        object oArea = GetArea(OBJECT_SELF);
        float facing = GetFacing(OBJECT_SELF);
        location center = GetLocalLocation(OBJECT_SELF, "center");
        location curLoc = GetLocation(OBJECT_SELF);
        vector curPos = GetPosition(OBJECT_SELF);

        if(GetDistanceBetweenLocations(center, curLoc) < 15.0) {
            facing = facing - 180;
        }

        SetLocalLocation(OBJECT_SELF, "center", curLoc);
        vector newVec = GetChangedPosition(curPos, 100.0, facing);
        location newLoc = Location(oArea, newVec, facing);
        AssignCommand(OBJECT_SELF, ActionMoveToLocation(newLoc, TRUE));
        SetLocalInt(OBJECT_SELF, "hbCount", hbCount + 1);
    }
}
