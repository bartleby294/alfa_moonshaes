#include "_btb_util"
/**
 *  Select next walk waypoint.
 */
location getNextWaypoint(object oArea, location campfireLoc,
                              int radiusBase, object bat) {
    float theta = GetLocalFloat(bat, "theta");
    float randFloat = GetLocalFloat(bat, "randFloat");
    if(randFloat == 0.0) {
        theta = Random(360) / 1.0;
        randFloat = (Random(4) + 1)/4.0;
        SetLocalFloat(bat, "randFloat", randFloat);
    }
    float radius = radiusBase + randFloat;
    float direction = GetLocalFloat(bat, "direction");
    string uuid = GetLocalString(bat, "uuid");

    if(uuid== "") {
        SetLocalString(bat, "uuid", GetRandomUUID());
    }

    // this is bugged because its 0 and n-1 so always negative but who cares.
    if(direction == 0.0) {
        if(Random(1) == 0){
            SetLocalFloat(bat, "direction", -1.0);
        } else {
            SetLocalFloat(bat, "direction", 1.0);
        }
    }

    theta = theta + (direction * (90.0/radiusBase));
    if(theta > 360.0) {
        theta = theta - 360;
    }
    if(theta < -360.0) {
        theta = theta + 360;
    }

    SetLocalFloat(bat, "theta", theta);

    float x = radius * cos(theta);
    float y = radius * sin(theta);

    vector campfireVector = GetPositionFromLocation(campfireLoc);
    location patrolLoc = Location(oArea,
        Vector(campfireVector.x + x, campfireVector.y+ y, 0.0), 0.0);
    float z = GetGroundHeight(patrolLoc);

    patrolLoc = Location(oArea,
        Vector(campfireVector.x + x, campfireVector.y+ y, z),
            getFacing(campfireVector, GetPositionFromLocation(patrolLoc)));

    return patrolLoc;
}

void main()
{
    object oPC = GetItemActivator();
    object oArea = GetArea(oPC);
    object oItem = GetItemActivated();
    location oItemLoc = GetItemActivatedTargetLocation();
    //location oPCLoc = GetLocation(oPC);
    //float oPCfacing = GetFacingFromLocation(oPCLoc);
    //vector oItemVec = GetPositionFromLocation(oItemLoc);
    //location oItemLocFinal = Location(oArea, oItemVec, oPCfacing);

    int batNum = 0;
    while(batNum < 20) {
        object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        location nextWP = getNextWaypoint(oArea, oItemLoc, 10, bat);
        AssignCommand(bat, ActionMoveToLocation(nextWP, TRUE));
        SetLocalLocation(bat, "center", oItemLoc);
        batNum++;
    }
}
