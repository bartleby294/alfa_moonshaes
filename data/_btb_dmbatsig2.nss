#include "_btb_util"
#include "x0_i0_position"

void batScatter(object oArea, location oItemLoc) {
    int batNum = 0;
    while(batNum < 20) {
        object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        location nextWP = getNextWaypoint(oArea, oItemLoc, 150, OBJECT_SELF, 90.0);
        AssignCommand(bat, ActionMoveToLocation(nextWP, TRUE));
        SetLocalLocation(bat, "center", oItemLoc);
        batNum++;
    }
}

// OLD SWARM ITS STILL TOO SLOW
void batCircle(object oArea, location oItemLoc) {
    int batNum = 0;
    while(batNum < 20) {
        object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        float delay = 0.0;
        while(delay < 6.0) {
            location nextWP = getNextWaypoint(oArea, oItemLoc, 7, OBJECT_SELF, 120.0);
            DelayCommand(0.1, AssignCommand(OBJECT_SELF, ActionMoveToLocation(nextWP, TRUE)));
            delay = delay + 0.1;
        }
        SetLocalLocation(bat, "center", oItemLoc);
        batNum++;
    }
}

void batBlast2(object oArea, location oItemLoc, object oPC) {
    int batNum = 0;
    while(batNum < 20) {
        object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        location aheadLoc = GetAheadLocation(oPC);
        vector pos = GetPositionFromLocation(aheadLoc);
        vector batVec = Vector(pos.x + 150, pos.z + 150, 0.0);
        location batLoc = Location(oArea , batVec, 0.0);
        AssignCommand(bat, ActionMoveToLocation(batLoc, TRUE));
        SetLocalLocation(bat, "center", oItemLoc);
        batNum++;
    }
}

/**
    Return a location some units of distance away on a straight line.
 */
location pickSpawnLoc2WORKING(vector pcVector, float pcAngle) {

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

/**
    Return a location some units of distance away on a straight line.
 */
location pickSpawnLoc2(vector pcVector, float pcAngle, location oItemLoc) {

    vector bandVector = GetPositionFromLocation(oItemLoc);
    vector normPcVector = AngleToVector(pcAngle);

    float x = normPcVector.x;
    float y = normPcVector.y;

    int distance = 1000;

    vector norm = VectorNormalize(Vector(x, y, 0.0));
    float spawnX = pcVector.x + (distance * norm.x);
    float spawnY = pcVector.y + (distance * norm.y);

    return Location(GetArea(OBJECT_SELF), Vector(spawnX, spawnY, 0.0), 0.0);
}

void batBlast(object oArea, location oItemLoc, object oPC) {
    int batNum = 0;
    while(batNum < 20) {
        object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        float pcAngle = GetFacing(oPC);
        location batLoc = pickSpawnLoc2(GetPosition(oPC), pcAngle, oItemLoc);
        AssignCommand(bat, ActionMoveToLocation(batLoc, TRUE));
        SetLocalLocation(bat, "center", oItemLoc);
        batNum++;
    }
}

void main()
{
    object oPC = GetItemActivator();
    object oArea = GetArea(oPC);
    object oItem = GetItemActivated();
    location oItemLoc = GetItemActivatedTargetLocation();
    CreateObject(OBJECT_TYPE_CREATURE, "batswarm3", oItemLoc, TRUE);

}
