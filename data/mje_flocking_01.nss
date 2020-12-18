//::///////////////////////////////////////////////
//:: Neverwinter Nights Flocking script
//:: mje_flocking_01
//:: Copyright (c) 2003 Michael England
//:://////////////////////////////////////////////
/*
    This script is a nwscript implementation of
    Craig Reynold's 1987 a-life classic 'Boids'.

    The intent of the script is to give creatures
    realistic flocking movement. This is done by
    giving each creature a simple set of rules
    to follow:
       -- avoid crowding flockmates
       -- fly in the direction in which flockmates
          are flying
       -- fly towards nearby flockmates
       -- maintain current direction (my rule)

    The interaction of these simple rules results in
    complex behaviour... what the a-life folks like
    to call emergence.
*/
//:://////////////////////////////////////////////
//:: Version: 0.1
//:: Created By: Michael England
//:: Created On: 1/10/2003
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

//------------------ Misc. Control Variables ----------------
// Step size of each move.
float stepSize = 20.0f;//8.0f;

// The distance under which attraction turns to repulsion
float repelLimit = 2.0f;

// the max distance at which friends are noticed
float attractLimit = 60.0f;

// if we have moved less than stuckDeltaLimit, then we are stuck
float stuckDeltaLimit = 0.5f;

//---------------------- Vector Weights ---------------------
// importance of avoiding the edge of the map
float edgeAvoidWeight = 5.0f;

// the importance of our own current direction
float selfDirectionWeight = 2.0f;

// the importance of the current direction of our friends
float friendDirectionWeight = 6.0f;

// the importance of avoiding nearby friends
float repelWeight = 3.0f;

// the importance of moving towards friends
float attractWeight = 8.5f;

//------------------- Area size "constants" -----------------
float MAX_X = 70.0;
float MAX_Y = 140.0;
float MIN_X = 20.0;
float MIN_Y = 90.0;

//----------------------- Debug Routines --------------------
int isDebugOn = FALSE;

/*
 * Print a string to the log-file
 */
void DebugString(string outputString)
{
    if (isDebugOn)
    {
        PrintString(outputString);
    }
}

/*
 * Print an int -- preprended by a string -- to the log-file
 */
void DebugInt(string outputString, int outputInt)
{
    if (isDebugOn)
    {
        PrintString(outputString + " : " + IntToString(outputInt));
    }
}

/*
 * Print a float -- preprended by a string -- to the log-file
 */
void DebugFloat(string outputString, float outputFloat)
{
    if (isDebugOn)
    {
        PrintString(outputString + " : " + FloatToString(outputFloat, 8, 4));
    }
}

/*
 * Print a vector -- preprended by a string -- to the log-file
 */
void DebugVector(string outputString, vector outputVector)
{
    if (isDebugOn)
    {
        string x = FloatToString(outputVector.x, 8, 4);
        string y = FloatToString(outputVector.y, 8, 4);
        string z = FloatToString(outputVector.z, 8, 4);

        PrintString(outputString + " : (" + x + ", " + y + ", " + z + ")");
    }
}

//----------------------- Util Routines --------------------

/*
 * Get the distance between two points A and B.
 */
float VectorDistance(vector vA, vector vB)
{
    float sum = pow(vA.x-vB.x, 2.0) + pow(vA.y-vB.y, 2.0) + pow(vA.z-vB.z, 2.0);
    return sqrt(sum);
}

/*
 * Addresses known bug in getFacing logic.
 *
 * Acknowledgement: this fix comes from the excellent NWN Lexicon
 * http://www.reapers.org/nwn/reference/
 * Author : John Shuell
 */
float GetCorrectFacing(object obj)
{
    float fFacing = GetFacing(obj);

    if (fFacing >= 360.0) fFacing = 720.0 - fFacing;
    if (fFacing < 0.0) fFacing += (360.0);
    return fFacing;
}

/*
 * Spin randomly 45 degrees left or right.
 */
void SetRandomFacing(object target)
{
    float facing = GetCorrectFacing(target);
    float delta = IntToFloat(Random(91))-45.0f; // -45 to 45
    float newFacing = facing+delta;
    if (newFacing > 360.0f) newFacing -= 360.0;
    if (newFacing < 0.0f) newFacing += 360.0;
    SetFacing(newFacing);
}

/*
 * Given an area, a position and a heading, create a new
 * location at position+heading
 */
location GetTargetLocation(object area, vector selfVector, vector heading)
{
    vector newPosition = selfVector + heading;
    DebugVector("newPosition", newPosition);

    // now get the new location to which we will move,
    // using the newPosition, and face in heading direction
    location resultLocation = Location(area,
                                       newPosition,
                                       VectorToAngle(heading));
    return resultLocation;
}

/*
 * Get the facing angle of an object. Result is normalized
 */
vector CalculateFacingVector(object obj)
{
    float facing = GetCorrectFacing(obj);
    return AngleToVector(facing);
}

/*
 * Return the distance from the current position to the
 * lower-bound X border, scaled onto [0, 1]
 */
float GetScaledX(float x)
{
    return (x-MIN_X)/(MAX_X-MIN_X);
}

/*
 * Return the distance from the current position to the
 * lower-bound Y border, scaled onto [0, 1]
 */
float GetScaledY(float y)
{
    return (y-MIN_Y)/(MAX_Y-MIN_Y);;
}

/*
 * Determine if creature is a friend (belongs to the group)
 */
int GetIsInGroup(object self, object creature)
{
    int result = FALSE;
    if (GetIsFriend(self, creature))
    {
        // see if we have the same tags
        string selfTag = GetTag(self);
        string creatureTag = GetTag(creature);

        if (selfTag == creatureTag)
        {
            result = TRUE;
        }
    }

    return result;
}


//----------------------- Flocking Routines --------------------

/*
 * Calculate the impact of edge avoidance. The importance of this
 * impact increases the closer we get to the edge of the map.
 * The logic is that if we are close to the left edge, then
 * weightRight-weightLeft>0. So the X portion of the vector
 * will be positive, implying a move to the right. Similar
 * calcs can be made for each edge.
 */
vector calculateEdgeAvoidanceVector(object self)
{
    // get our current pos
    vector selfVector = GetPositionFromLocation(GetLocation(self));

    // get weight for each... falls off with square of dist
    float weightLeft = pow(GetScaledX(selfVector.x), 2.0);
    float weightRight = pow(1-GetScaledX(selfVector.x), 2.0);
    float weightDown = pow(GetScaledY(selfVector.y), 2.0);
    float weightUp = pow(1-GetScaledY(selfVector.y), 2.0);

    vector edgeAvoid = Vector(weightRight-weightLeft,
                              weightUp-weightDown,
                              0.0f);

    // weight, to overcome other effects
    edgeAvoid *= edgeAvoidWeight;
    DebugVector("EdgeAvoid", edgeAvoid);

    return edgeAvoid;
}

/*
 * Calculate the direction in which we are moving.
 */
vector CalculateSelfDirectionVector(object self)
{
    // where are we going
    vector direction = CalculateFacingVector(self);

    // weight accordingly
    direction = direction * selfDirectionWeight;
    DebugVector("Self Direction", direction);

    // send it home
    return direction;
}

/*
 * Calculate the direction in which our friend is moving.
 */
vector CalculateFriendDirectionVector(object friend)
{
    // where is the friend heading?
    vector direction = CalculateFacingVector(friend);

    // weight accordingly
    direction = direction * friendDirectionWeight;
    DebugVector("Friend direction", direction);

    // send it home
    return direction;
}

/*
 * Calculate the forces of attraction or repulsion that exist
 * between ourself and a friend.
 *
 * Repulsion occurs when we are too close to our friend, otherwise
 * we are attracted. Beyond the max distance, we are un-affected.
 */
vector CalculateAttractRepelVector(vector selfVector,
                                   object friend)
{
    // temp variable for heading
    vector attractRepel = Vector(0.0f, 0.0f, 0.0f);

    // get location of our friend
    location friendLocation = GetLocation(friend);
    vector friendVector = GetPositionFromLocation(friendLocation);
    DebugVector("Friend", friendVector);

    // how close is our friend
    float dist = VectorDistance(friendVector, selfVector);
    DebugFloat("Distance", dist);

    if (dist < repelLimit)
    {
        // if repulse, the vector points away from friend
        attractRepel = selfVector - friendVector;

        // normalize result
        attractRepel = VectorNormalize(attractRepel);

        // weight result -- closer gets higher weight
        attractRepel *= pow(1.0-dist/repelLimit, 2.0)*repelWeight;
        DebugVector("Repulse", attractRepel);
    }
    else
    {
        // if attract, the vector points towards friend
        attractRepel = friendVector - selfVector;

        // normalize result
        attractRepel = VectorNormalize(attractRepel);

        // weight result -- further gets higher weight
        float temp = pow((dist-repelLimit)/(attractLimit-repelLimit), 2.0);
        attractRepel *= temp*attractWeight;
        DebugVector("Attract", attractRepel);
    }

    return attractRepel;
}

/*
 * Calculate the affect of our friends. For each of the friends
 * that we wish to consider, we determine:
 * 1. whether they attract us (a vector towards) or repel
 *    us (a vector away)
 * 2. their current heading, with which we will align ourselves
 *
 * For attraction/repulsion see CalculateAttractRepelVector
 * For heading see CalculateFriendDirectionVector
 */
vector CalculateFriendAffectVector(object self, vector selfVector)
{
    // declare local variables -- do this because of 'break' bug
    object friend;
    vector attractRepel;
    vector align;
    int countFriends = 0;

    // the vector to hold the results
    vector friendAffectVector = Vector(0.0f, 0.0f, 0.0f);

    // obtain a creature within attractLimit meters
    friend = GetFirstObjectInShape(SHAPE_SPHERE,
                                   attractLimit,
                                   GetLocation(self),
                                   TRUE,
                                   OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(friend)&&
           GetIsInGroup(friend, self))
    {
        // we've found a friend
        DebugInt("*** Loop : ", countFriends);
        DebugString("Friend Valid");

        // determine the contribution of attraction/repulsion
        attractRepel = CalculateAttractRepelVector(
                               selfVector,
                               friend);
        friendAffectVector += attractRepel;

        // determine the contribution of friend's direction
        align = CalculateFriendDirectionVector(friend);
        friendAffectVector += align;

        // and increment the number of friends found
        countFriends++;
        DebugVector("FriendAffect", friendAffectVector);

        // get the next creature
        friend = GetNextObjectInShape(SHAPE_SPHERE,
                                      attractLimit,
                                      GetLocation(self),
                                      TRUE,
                                      OBJECT_TYPE_CREATURE);

    } // end loop
    DebugString("End Loop ***");

    // weight by number of friends found
    if (countFriends > 0)
    {
        friendAffectVector /= IntToFloat(countFriends);
    }
    else
    {
        // ??? What to do if no friends?
    }
    DebugVector("friendAffect -- final", friendAffectVector);

    return friendAffectVector;
}

/*
 * Determine the new location to which the current creature
 * should move
 */
location GetNewLocation(object self)
{
    // where we are
    location selfLocation = GetLocation(self);
    vector selfVector = GetPositionFromLocation(selfLocation);

    DebugString("******* start ********");
    DebugVector("selfVector", selfVector);

    // where we want to go
    location resultLocation;
    vector heading = Vector(0.0f, 0.0f, 0.0f);

    // first calculate the impact of our friends
    heading = CalculateFriendAffectVector(self, selfVector);

    // add our current heading into the mix
    vector selfDirection = CalculateSelfDirectionVector(self);
    heading = heading + selfDirection;
    DebugVector("Heading + direction", heading);

    // and add the edge-avoidance heading in, too
    vector edgeAvoidance = calculateEdgeAvoidanceVector(self);
    heading = heading + edgeAvoidance;
    DebugVector("Heading + edge avoidance", heading);

    // normalize one last time
    heading = VectorNormalize(heading);

    // and multiply by the step size
    heading = heading * stepSize;
    DebugVector("Final heading", heading);

    // and calc the final location towards which we will move
    resultLocation = GetTargetLocation(GetArea(self),
                                       selfVector,
                                       heading);

    return resultLocation;
}

/*
 * If our position is unchanged, we are no doubt stuck. Spin to
 * face a new direction. Hopefully, that direction will free us.
 */
void ClearStuck(object self)
{
    // get last position
    location lastLocation = GetLocalLocation(self, "LAST_LOCATION");
    DebugVector("Last Location", GetPositionFromLocation(lastLocation));

    // get and update our position
    location currentLocation = GetLocation(self);
    SetLocalLocation(self, "LAST_LOCATION", currentLocation);
    DebugVector("Current Location", GetPositionFromLocation(currentLocation));

    // have we moved since last we were here
    // Note: fn returns -1 when lastLocation is undefined
    float delta = GetDistanceBetweenLocations(lastLocation, currentLocation);
    if ((delta < stuckDeltaLimit) && (delta >= 0.0f))
    {
        // probably stuck -- get away by changing direction
        SetRandomFacing(self);
        DebugString("Stuck");
    }
}

/*
 * Calculate a new location to which we should move, and then
 * move there.
 */
void ActionMoveToFlockingLocation(object self)
{
    // make sure we aren't stuck. This method will rotate self
    // in a new direction. Immediate action... should not queue
    ClearStuck(self);

    // calculate our new location, and move to it. Will be queued
    location loc = GetNewLocation(self);
    ActionDoCommand(ActionMoveToLocation(loc, FALSE));
}

void main()
{
    ActionMoveToFlockingLocation(OBJECT_SELF);
}

