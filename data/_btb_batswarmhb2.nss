#include "_btb_util"
 #include "x0_i0_position"

location pickSpawnLoc2(vector pcVector, float pcAngle) {

    vector bandVector = GetPosition(OBJECT_SELF);
    vector normPcVector = AngleToVector(pcAngle);

    float x = normPcVector.x;
    float y = normPcVector.y;

    int distance = 100;

    vector norm = VectorNormalize(Vector(x, y, 0.0));
    float spawnX = bandVector.x + (distance * norm.x) + Random(10)/6;
    float spawnY = bandVector.y + (distance * norm.y) + Random(10)/6;

    return Location(GetArea(OBJECT_SELF), Vector(spawnX, spawnY, 0.0), 0.0);
}

void mai2()
{
   //return;

    int hbCount = GetLocalInt(OBJECT_SELF, "hbCount");
    if(hbCount > 4) {
        DestroyObject(OBJECT_SELF);
    } else {
        object oArea = GetArea(OBJECT_SELF);
        location center = GetLocalLocation(OBJECT_SELF, "center");
        location nextWP =  pickSpawnLoc2(GetPositionFromLocation(center),
                                         GetFacing(OBJECT_SELF));
        AssignCommand(OBJECT_SELF, ActionMoveToLocation(nextWP, TRUE));
        SetLocalInt(OBJECT_SELF, "hbCount", hbCount + 1);
    }
}

void main()
{
    int hbCount = GetLocalInt(OBJECT_SELF, "hbCount");
    if(hbCount > 3) {
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
