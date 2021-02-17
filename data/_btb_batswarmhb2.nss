#include "_btb_util"

location pickSpawnLoc2(vector pcVector, float pcAngle) {

    vector bandVector = GetPosition(OBJECT_SELF);
    vector normPcVector = AngleToVector(pcAngle);

    float x = normPcVector.x;
    float y = normPcVector.y;

    int distance = 1000;

    vector norm = VectorNormalize(Vector(x, y, 0.0));
    float spawnX = pcVector.x + (distance * norm.x);
    float spawnY = pcVector.y + (distance * norm.y);

    return Location(GetArea(OBJECT_SELF), Vector(spawnX, spawnY, 0.0), 0.0);
}

void main()
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
