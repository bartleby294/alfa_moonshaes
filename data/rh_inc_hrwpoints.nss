/*******************************************************************************
Name:      Rhone's Hour-based WayPoint Walker
Author:    Thomas J. Hamman (Rhone)
E-Mail:    hammant@panther.adelphi.edu
Filename:  rh_inc_hrwpoints
Version:   1.21

This script contains the bulk of the actual code for the Hour-based Waypoint
Walker.
*******************************************************************************/

void HourWayPoints(int nRun = FALSE, float fPause = 1.0, int nCircle = FALSE);
void HourRunCircuit(string sPrefix, int nWPStart = 1, int nReverse = FALSE, int nRun=FALSE, float fPause = 1.0, int nCircle = FALSE);
void HourGoToPost(object oPost, int nRun = FALSE);
int GetEventForWP(object oWP, int nNum);
string PosIntTo2DigitString(int nNum);
float GetFacingCorrectly(object oTarget);

//This should be called in place of WalkWayPoints.  There is one extra parameter
//(nCircle), which allows NPCs to walk in a circle instead of back and forth.
void HourWayPoints(int nRun = FALSE, float fPause = 1.0, int nCircle = FALSE)
{
    //nDontWalkWP can be set in scripts to temporarily disable waypoint walking
    //for a particular NPC.
    if (GetLocalInt(OBJECT_SELF, "nDontWalkWP"))
        return;

    string sWalker = GetTag(OBJECT_SELF);
    string sWPPrefix;
    string sPostPrefix;
    int nWPStart = GetLocalInt(OBJECT_SELF, "nNextWP");
    int nDay;
    object oWP;
    object oPost;

    ClearAllActions();

    //Before we start checking the hour and day/night status, let's see if the
    //NPC uses 24-hour waypoints/post.
    sWPPrefix = "WP_24_";
    sPostPrefix = "POST_24_";
    oWP = GetObjectByTag(sWPPrefix + sWalker + "_01");
    oPost = GetObjectByTag(sPostPrefix + sWalker);

    //Send NPC to 24-hour WP or Post; resume if the NPC has already started waypoints.
    if (GetIsObjectValid(oWP)) {
        if (!nWPStart)
            nWPStart = 1;
        HourRunCircuit(sWPPrefix, nWPStart, FALSE, nRun, fPause, nCircle);
        return;
    } else if (GetIsObjectValid(oPost)) {
        HourGoToPost(oPost, nRun);
        return;
    }

    //No 24-hour waypoints or posts, so let's try night/day.
    if (GetIsDay() || GetIsDawn()) {
        sWPPrefix = "WP_DY_";
        sPostPrefix = "POST_DY_";
        nDay = 1;
    } else {
        sWPPrefix = "WP_NT_";
        sPostPrefix = "POST_NT_";
        nDay = 2;
    }

    oWP = GetObjectByTag(sWPPrefix + sWalker + "_01");
    oPost = GetObjectByTag(sPostPrefix + sWalker);

    //If the NPC has day/night waypoints or posts, send him to them.
    if (GetIsObjectValid(oWP)) {
        int nOldDay = GetLocalInt(OBJECT_SELF, "nDayPoints");
        if (!(nWPStart && nOldDay && nOldDay == nDay)) {
            SetLocalInt(OBJECT_SELF, "nDayPoints", nDay);
            nWPStart = 1;
        }
        HourRunCircuit(sWPPrefix, nWPStart, FALSE, nRun, fPause, nCircle);
        return;
    } else if (GetIsObjectValid(oPost)) {
        SetLocalInt(OBJECT_SELF, "nDayPoints", nDay);
        HourGoToPost(oPost);
        return;
    }

    //Code for hour-based waypoints starts here.
    int nHour = GetTimeHour();
    sWPPrefix = "WP_" + PosIntTo2DigitString(nHour) + "_";
    sPostPrefix = "POST_" + PosIntTo2DigitString(nHour) + "_";
    oWP = GetObjectByTag(sWPPrefix + sWalker + "_01");
    oPost = GetObjectByTag(sPostPrefix + sWalker);

    //The important thing we're doing in the following loop is checking every hour,
    //starting with the current hour and counting backwards, until we either find
    //an hour for which the NPC has waypoints to walk (so an NPC with 8am waypoints
    //will keep walking them for every hour until the next hour he has waypoints
    //set for) or we reach nLastHourWalked (at which point we don't need to look
    //back any further).
    //
    //If the NPC is running HourWayPoints for the first time (e.g. he just spawned)
    //then nStartedWaypoints isn't set yet, so we set nLastHourWalked to an hour
    //ahead of the current time--that way, every hour can be checked for waypoints.
    //
    //nLastHourChecked is being set for use in the OnHeartbeat script.
    if (!GetLocalInt(OBJECT_SELF, "nStartedWaypoints")) {
        if (nHour == 23)
            SetLocalInt(OBJECT_SELF, "nLastHourWalked", 0);
        else
            SetLocalInt(OBJECT_SELF, "nLastHourWalked", nHour + 1);
    }

    while (nHour != GetLocalInt(OBJECT_SELF, "nLastHourWalked")) {
        if (GetIsObjectValid(oWP)) {
            nWPStart = 1;
            SetLocalInt(OBJECT_SELF, "nLastHourWalked", nHour);
            SetLocalInt(OBJECT_SELF, "nLastHourChecked", GetTimeHour());
            SetLocalInt(OBJECT_SELF, "nStartedWaypoints", TRUE);
            HourRunCircuit(sWPPrefix, nWPStart, FALSE, nRun, fPause, nCircle);
            return;
        } else if (GetIsObjectValid(oPost)) {
            SetLocalInt(OBJECT_SELF, "nLastHourWalked", nHour);
            SetLocalInt(OBJECT_SELF, "nLastHourChecked", GetTimeHour());
            SetLocalInt(OBJECT_SELF, "nStartedWaypoints", TRUE);
            HourGoToPost(oPost, nRun);
            return;
        } else {
            nHour--;
            if (nHour < 0)
                nHour = 23;
            sWPPrefix = "WP_" + PosIntTo2DigitString(nHour) + "_";
            sPostPrefix = "POST_" + PosIntTo2DigitString(nHour) + "_";
            oWP = GetObjectByTag(sWPPrefix + sWalker + "_01");
            oPost = GetObjectByTag(sPostPrefix + sWalker);
        }
    }

    //If we reach nLastHourWalked before finding waypoints for later hours, we
    //check to make sure that there are valid waypoints/posts for that hour and
    //send the NPC to them if so.
    if (GetIsObjectValid(oWP)) {
        SetLocalInt(OBJECT_SELF, "nLastHourWalked", nHour);
        SetLocalInt(OBJECT_SELF, "nLastHourChecked", GetTimeHour());
        SetLocalInt(OBJECT_SELF, "nStartedWaypoints", TRUE);
        HourRunCircuit(sWPPrefix, nWPStart, FALSE, nRun, fPause, nCircle);
        return;
    }
    if (GetIsObjectValid(oPost)) {
        SetLocalInt(OBJECT_SELF, "nLastHourWalked", nHour);
        SetLocalInt(OBJECT_SELF, "nLastHourChecked", GetTimeHour());
        SetLocalInt(OBJECT_SELF, "nStartedWaypoints", TRUE);
        HourGoToPost(oPost, nRun);
        return;
    }
}

//This is the replacement for the original RunCircuit (it does not use a
//RunNextCircuit equivalent), which sends the NPC to his waypoints in order.
//
//It was originally designed with a while loop to loop through the waypoints,
//but I had to change it to loop by recursion instead.  Using a while loop, I
//was unable to get the UserDefined actions (triggered by the SignalEvent at
//each waypoint) to fit in their correct place in the action queue.  No matter
//what I tried, the scripted actions for every waypoint would run at the end of
//the circuit (right before the function called itself again).  So, I made the
//function call itself again for every waypoint, and viola, the userdefined
//actions take place when they should.
//
//Note that this functions allows for circular waypoint walking through a function
//parameter (filtered down from HourWayPoints), and it also allows for waypoints
//and a post to be set for the same time--what happens then is that the NPC walks
//his waypoints once and then goes to his post, where he stays.
void HourRunCircuit(string sPrefix, int nNext = 1, int nReverse=FALSE, int nRun=FALSE, float fPause = 1.0, int nCircle = FALSE)
{
    string sWalker = GetTag(OBJECT_SELF);
    object oWP = GetWaypointByTag(sPrefix + sWalker + "_" + PosIntTo2DigitString(nNext));
    object oPost = GetWaypointByTag("POST_" + GetSubString(sPrefix, 3, 3) + sWalker);
    object oArea = GetArea(OBJECT_SELF);
    object oNearestPCArea = GetArea(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF));

    if (GetIsObjectValid(oWP)) {
        SetLocalInt(OBJECT_SELF, "nNextWP", nNext);
        SetLocalInt(OBJECT_SELF, "nAmbientAnimations", 0);
        if (oArea == oNearestPCArea)
            ActionForceMoveToObject(oWP, nRun, 1.0, 60.0);
        else
            ActionForceMoveToObject(oWP, nRun, 1.0, 20.0);
        ActionWait(fPause);
        SignalEvent(OBJECT_SELF, EventUserDefined(GetEventForWP(oWP, nNext)));
        if (!nReverse)
            nNext++;
        else
            nNext--;
    } else if (GetIsObjectValid(oPost)) {
        ActionDoCommand(HourGoToPost(oPost, nRun));
        return;
    } else {
        if (nCircle) {
            nReverse = FALSE;
            nNext = 1;
        } else {
            nReverse = !nReverse;
            if (!nReverse)
                nNext += 2;
            else
                nNext -= 2;
        }
    }
    ActionDoCommand(HourRunCircuit(sPrefix, nNext, nReverse, nRun, fPause, nCircle));
}

//Go to a Post.
void HourGoToPost(object oPost, int nRun = FALSE)
{
    object oArea = GetArea(OBJECT_SELF);
    object oNearestPCArea = GetArea(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF));

    SetLocalInt(OBJECT_SELF, "nNextWP", 100);
    SetLocalInt(OBJECT_SELF, "nAmbientAnimations", 0);
    if (oArea == oNearestPCArea)
        ActionForceMoveToObject(oPost, nRun, 1.0, 60.0);
    else
        ActionForceMoveToObject(oPost, nRun, 1.0, 20.0);
    float fFacing = GetFacingCorrectly(oPost);
    ActionDoCommand(SetFacing(fFacing));
    SignalEvent(OBJECT_SELF, EventUserDefined(GetEventForWP(oPost, 0)));
}


//Convert 1, 2, 3 ... 9 ints into 01, 02, 03 ... 09 strings.
string PosIntTo2DigitString(int nNum)
{
    string sString;
    if (nNum > 9)
        return IntToString(nNum);
    else if (nNum < 10 && nNum >= 0)
        return ("0" + IntToString(nNum));
    else
        return "This function is not for negative numbers.";
}

//A workaround for GetFacing, which is currently broken.  This will cease to
//be necessary when/if Bioware fixes GetFacing, but it won't break anything.
float GetFacingCorrectly(object oTarget)
{
    float fFacing;
    fFacing = GetFacing(oTarget);
    if (fFacing >= 360.0)
        fFacing = 720.0 - fFacing;
    return fFacing;
}

//This is the function for putting together a number for an event to trigger in
//the NPC's OnUserDefined script.
int GetEventForWP(object oWP, int nNum)
{
    string sTime;
    string sNum;
    string sEventNum;
    int nEventNum;

    if (!nNum) {
        sNum = "00";
        sTime = GetSubString(GetTag(oWP), 5, 2);
    } else {
        sNum = GetStringRight(GetTag(oWP), 2);
        sTime = GetSubString(GetTag(oWP), 3, 2);
    }

    if (sTime == "DY")
        sTime = "25";
    else if (sTime == "NT")
        sTime = "26";

    sEventNum = "9" + sTime + sNum;
    nEventNum = StringToInt(sEventNum);
    return nEventNum;
}
