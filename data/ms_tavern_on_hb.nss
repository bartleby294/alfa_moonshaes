#include "nwnx_data"
#include "nwnx_object"
#include "ms_tavern_const"
#include "ms_tavern_util"

void JustArrived(object oArea, int wpCnt) {
    // Move to a random waypoint.
    object oWP = NWNX_Data_Array_At_Obj(oArea, MS_TAVERN_WALK_WP_ARRAY,
                                        Random(wpCnt));
    SetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_WP, oWP);
    SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                MS_TAVERN_PATRON_MOVE_TO_WP);
    AssignCommand(OBJECT_SELF, ActionMoveToObject(oWP));
}

void MoveToWP(object oArea) {
    object oWP = GetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_WP);
    if(GetDistanceToObject(oWP) < 1.5) {
        int randomDecision = Random(100);
        // 50% Chance we sit down
        if(randomDecision < 50) {
            SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                        MS_TAVERN_PATRON_MOVE_TO_CHAIR);
        // 30% Chance we go to the bar
        } else if(randomDecision < 80) {
            SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                        MS_TAVERN_PATRON_MOVE_TO_BAR);
        // 20% Chance we leave
        } else {
            SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                        MS_TAVERN_PATRON_MOVE_TO_EXIT);
        }
    } else {
        AssignCommand(OBJECT_SELF, ActionMoveToObject(oWP));
    }
}

void MoveToChair(object oArea, int chairCnt) {
    object oChair = GetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_CHAIR);

    if(oChair == OBJECT_INVALID) {
        oChair = GetValidChair(oArea, chairCnt);
    }

    if(oChair == OBJECT_INVALID) {
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                MS_TAVERN_PATRON_MOVE_TO_WP);
    } else {
        SetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_CHAIR, oChair);
        SetLocalInt(oChair, MS_TAVERN_CHAIR_IN_USE, TRUE);
        if(GetDistanceToObject(oChair) < 1.0) {
            AssignCommand(OBJECT_SELF, ActionSit(oChair));
            SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_SITTING_TURNS, 0);
            SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_MAX_SITTING_TURNS,
                        Random(100));
        } else {
            AssignCommand(OBJECT_SELF, ActionMoveToObject(oChair));
        }
    }
}

void SittingState(object oArea) {
    int sitTurns = GetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_SITTING_TURNS);
    int maxSitTurns = GetLocalInt(OBJECT_SELF,
                                  MS_TAVERN_PATRON_MAX_SITTING_TURNS);

    if(sitTurns > maxSitTurns) {
        ClearAllActions();
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                MS_TAVERN_PATRON_MOVE_TO_WP);
    } else {
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_SITTING_TURNS, sitTurns + 1);
    }
}

void MoveToBar(object oArea) {

}


void MoveToExit(object oArea) {

}



void main()
{
    if(GetIsDMPossessed(OBJECT_SELF)) {
        return;
    }

    object oPatron = OBJECT_SELF;
    object oArea = GetArea(oPatron);
    object oControler = GetLocalObject(oArea, MS_TAVERN_CONTROLLER_OBJECT);

    // Something is out of sync abort for now hope is syncs back up.
    if(oControler == OBJECT_INVALID) {
        return;
    }

    int doorCnt = GetLocalInt(oControler, MS_TAVERN_DOOR_COUNT);
    int chairCnt = GetLocalInt(oControler, MS_TAVERN_CHAIR_COUNT);
    int wpCnt = GetLocalInt(oControler, MS_TAVERN_WALK_WP_COUNT);

    // Something is out of sync abort for now hope is syncs back up.
    if(oControler == OBJECT_INVALID) {
        return;
    }

    int patronState = GetLocalInt(oPatron, MS_TAVERN_PATRON_STATE);

    if(patronState == MS_TAVERN_PATRON_JUST_ARRIVED) {
        JustArrived(oArea, wpCnt);
    } else if(patronState == MS_TAVERN_PATRON_MOVE_TO_WP) {
        MoveToWP(oArea);
    } else if(patronState == MS_TAVERN_PATRON_MOVE_TO_CHAIR) {
        MoveToChair(oArea, chairCnt);
    } else if(patronState == MS_TAVERN_PATRON_SITTING) {
        SittingState(oArea);
    } else if(patronState == MS_TAVERN_PATRON_MOVE_TO_BAR) {
        MoveToBar(oArea);
    } else if(patronState == MS_TAVERN_PATRON_MOVE_TO_EXIT) {
        MoveToExit(oArea);
    }

}
