#include "nwnx_data"
#include "nwnx_object"
#include "ms_tavern_const"
#include "ms_tavern_util"
#include "x0_i0_anims"

int GetBarAnimation() {

    switch(Random(8) + 1) {
        case 1:
            return ANIMATION_LOOPING_TALK_NORMAL;
        case 2:
            return ANIMATION_LOOPING_TALK_PLEADING;
        case 3:
            return ANIMATION_LOOPING_TALK_LAUGHING;
        case 4:
            return ANIMATION_LOOPING_TALK_FORCEFUL;
        case 5:
            return ANIMATION_LOOPING_PAUSE;
        case 6:
            return ANIMATION_LOOPING_GET_MID;
        case 7:
            return ANIMATION_LOOPING_PAUSE_TIRED;
        case 8:
            return ANIMATION_LOOPING_PAUSE2;
    }
    return ANIMATION_LOOPING_TALK_NORMAL;
}

int amISitting() {
    object oChair = GetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_CHAIR);
    if(GetSittingCreature(oChair) == OBJECT_SELF) {
        return TRUE;
    }
    return FALSE;
}

void stopSitting() {
    ClearAllActions();
    object oChair = GetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_CHAIR);
    SetLocalInt(oChair, MS_TAVERN_CHAIR_IN_USE, FALSE);
    SetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_CHAIR, OBJECT_INVALID);
    SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                MS_TAVERN_PATRON_JUST_ARRIVED);
    SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_SITTING_TURNS, 0);
    SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_MAX_SITTING_TURNS, 0);
}

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
    if(GetDistanceToObject(oWP) < 2.0) {
        int randomDecision = Random(100);
        // 35% Chance we sit down
        if(randomDecision < 35) {
            SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                        MS_TAVERN_PATRON_MOVE_TO_CHAIR);
        // 15% Chance we go to the bar
        } else if(randomDecision < 50) {
            SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                        MS_TAVERN_PATRON_MOVE_TO_BAR);
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
                    MS_TAVERN_PATRON_JUST_ARRIVED);
    } else {
        SetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_CHAIR, oChair);
        SetLocalInt(oChair, MS_TAVERN_CHAIR_IN_USE, TRUE);
        if(GetDistanceToObject(oChair) < 1.0) {
            AssignCommand(OBJECT_SELF, ActionSit(oChair));
            SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                    MS_TAVERN_PATRON_SITTING);
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

    if(amISitting() == FALSE) {
        int tryTurns = GetLocalInt(OBJECT_SELF,
                                   MS_TAVERN_PATRON_TURNS_TRYING_TO_SIT);
        if(tryTurns > 4) {
            stopSitting();
        } else {
            SetLocalInt(OBJECT_SELF,
                        MS_TAVERN_PATRON_TURNS_TRYING_TO_SIT, tryTurns + 1);
        }
        return;
    }

    if(sitTurns > maxSitTurns) {
        stopSitting();
    } else {
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_SITTING_TURNS, sitTurns + 1);
    }
}

void MoveToBar(object oArea, int barCnt) {

    object oBar = GetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_BAR);

    if(oBar == OBJECT_INVALID && barCnt > 0) {
        oBar = NWNX_Data_Array_At_Obj(oArea, MS_TAVERN_BAR_ARRAY,
                                        Random(barCnt));
        SetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_BAR, oBar);
    }

    // if still no bar set back to just arrived and exit.
    if(oBar == OBJECT_INVALID) {
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                    MS_TAVERN_PATRON_JUST_ARRIVED);
        return;
    } else {
        if(GetDistanceToObject(oBar) < 1.0) {
            AssignCommand(OBJECT_SELF,
                          ActionPlayAnimation(GetBarAnimation(), 2.0));
            DelayCommand(5.0, SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                                          MS_TAVERN_PATRON_JUST_ARRIVED));
        } else {
            AssignCommand(OBJECT_SELF, ActionMoveToObject(oBar));
        }
    }
}

void MoveToStand(object oArea, int standCnt) {

    object oStand = GetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_STAND);

    if(oStand == OBJECT_INVALID && standCnt > 0) {
        oStand = NWNX_Data_Array_At_Obj(oArea, MS_TAVERN_STAND_ARRAY,
                                        Random(standCnt));
        SetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_STAND, oStand);
    }

    // if still no stand set back to just arrived and exit.
    if(oStand == OBJECT_INVALID) {
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                    MS_TAVERN_PATRON_JUST_ARRIVED);
        return;
    } else {
        if(GetDistanceToObject(oStand) < 3.0) {
            SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                        MS_TAVERN_PATRON_STAND);
        } else {
            AssignCommand(OBJECT_SELF, ActionMoveToObject(oStand));
        }
    }
}

void StandState(object oArea) {
    int standTurns = GetLocalInt(OBJECT_SELF,
                                 MS_TAVERN_PATRON_STAND_TURNS);
    int maxStandTurns = GetLocalInt(OBJECT_SELF,
                                    MS_TAVERN_PATRON_MAX_STAND_TURNS);
    if(standTurns == 0) {
        AnimActionFindFriend(3.0);
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STAND_TURNS, 1);
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_MAX_STAND_TURNS,
                    Random(50));
    } else if (standTurns < maxStandTurns) {
        AnimActionFindFriend(3.0);
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STAND_TURNS,
                    standTurns + 1);
    } else {
        ClearAllActions();
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STAND_TURNS, 0);
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_MAX_STAND_TURNS,0);
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
            MS_TAVERN_PATRON_JUST_ARRIVED);
    }
}

void MoveToExit(object oArea, int exitCnt, object oControler, int patronCnt) {
    object oExit = GetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_EXIT);

    if(oExit == OBJECT_INVALID && exitCnt > 0) {
        oExit = NWNX_Data_Array_At_Obj(oArea, MS_TAVERN_DOOR_ARRAY,
                                        Random(exitCnt));
        SetLocalObject(OBJECT_SELF, MS_TAVERN_PATRONS_EXIT, oExit);
    }

    // if still no stand set back to just arrived and exit.
    if(oExit == OBJECT_INVALID) {
        SetLocalInt(OBJECT_SELF, MS_TAVERN_PATRON_STATE,
                    MS_TAVERN_PATRON_JUST_ARRIVED);
        return;
    } else {
        if(GetDistanceToObject(oExit) < 1.0) {
            DestroyPatron(OBJECT_SELF, oControler, patronCnt);
        } else {
            AssignCommand(OBJECT_SELF, ActionMoveToObject(oExit));
        }
    }
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
    int barCnt = GetLocalInt(oControler, MS_TAVERN_BAR_COUNT);
    int standCnt = GetLocalInt(oControler, MS_TAVERN_STAND_COUNT);
    int patronCnt = GetPatronCount(oControler, oArea);

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
        MoveToBar(oArea, barCnt);
    } else if(patronState == MS_TAVERN_PATRON_MOVE_TO_STAND) {
        MoveToStand(oArea, standCnt);
    } else if(patronState == MS_TAVERN_PATRON_STAND) {
        StandState(oArea);
    } else if(patronState == MS_TAVERN_PATRON_MOVE_TO_EXIT) {
        MoveToExit(oArea, doorCnt, oControler, patronCnt);
    }
}
