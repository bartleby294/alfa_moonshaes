#include "_btb_util"
#include "nw_i0_generic"
#include "_btb_moonwellcon"

string getDruidString(int timer){
    switch(timer)
    {
        case 0:
            return "";
        case 1:
            return "";
        case 2:
            return "";
        case 3:
            return "The Green Light Step into it NOW!";
        case 4:
            return "Step Into the Green Light or we will be forced to attack you!";
        case 5:
            return "This is no joke step into the light!";
        case 6:
            return "Step into the green light this is your final warning!";
    }
    return "";
}

void attack(object highDruid, object oPC) {
    SetLocalInt(OBJECT_SELF, "state", ATTACK_STATE);
    object Druid01 = GetNearestObjectByTag("moonwelldruid001");
    object Druid02 = GetNearestObjectByTag("moonwelldruid002");
    object Druid03 = GetNearestObjectByTag("moonwelldruid003");
    object Druid04 = GetNearestObjectByTag("moonwelldruid004");
    AssignCommand(highDruid, SpeakString(
                "**Frowns and signals the other druids to attack**"));
    AssignCommand(Druid01, ActionAttack(oPC, TRUE));
    AssignCommand(Druid02, ActionAttack(oPC, TRUE));
    AssignCommand(Druid03, ActionAttack(oPC, TRUE));
    AssignCommand(Druid04, ActionAttack(oPC, TRUE));
    AssignCommand(highDruid, ActionAttack(oPC, TRUE));
    SetLocalInt(OBJECT_SELF, "state", ATTACKING_STATE);
}

void main()
{
    return;
    int state = GetLocalInt(OBJECT_SELF, "state");
    object oPC = GetLocalObject(OBJECT_SELF, "oPC");
    //WriteTimestampedLogEntry("State: " + IntToString(state));
    object highDruid = GetNearestObjectByTag("MoonwellHighDruid");
    // if a dm has disabled the scene or its not in progress skip out.
    if(state == DM_DISABLED_STATE || state == NO_STATE) {
        return;
    // if the trigger has been tripped start interogating.
    } else if(state == INTEROGATION_STATE) {
        // get the timeer and do its thing.
        int timer = GetLocalInt(OBJECT_SELF, "timer");
        // if less than 7 keep warning.
        if(timer < 7) {
            string druidStr = getDruidString(timer);
            if(druidStr != "") {
                AssignCommand(highDruid, SpeakString(druidStr));
                SendMessageToPC(oPC, "High Druid: " + druidStr);
            }
        // they said they were going to attack.
        } else {
            oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                                        PLAYER_CHAR_IS_PC, OBJECT_SELF);
            if(GetDistanceBetween(oPC, OBJECT_SELF) < 200.0){
                attack(highDruid, oPC);
            }
        }

        SetLocalInt(OBJECT_SELF, "timer", timer + 1);
    } else if (state == ATTACK_STATE) {
        object oPC = GetFirstPCInArea(GetArea(OBJECT_SELF));
        int attackBool = FALSE;
        while(oPC != OBJECT_INVALID) {
            if(GetDistanceBetween(OBJECT_SELF, oPC) < 30.0) {
                attackBool = TRUE;
            }
            oPC = GetNextPCInArea(GetArea(OBJECT_SELF));
        }
        if(attackBool == TRUE) {
            attack(highDruid, oPC);
        } else {
            SetLocalInt(OBJECT_SELF, "state", LEAVING_STATE);
        }
    } else if (state == WARN_STATE) {
        string warnStr = "Leave now this is your final warning!";
        AssignCommand(highDruid, SpeakString(warnStr));
        SendMessageToPC(oPC, "High Druid: " + warnStr);
        SetLocalInt(OBJECT_SELF, "state", ATTACK_STATE);
    } else if (state == LEAVING_STATE) {
        object Druid01 = GetNearestObjectByTag("MoonwellDruid01");
        object Druid02 = GetNearestObjectByTag("MoonwellDruid02");
        object Druid03 = GetNearestObjectByTag("MoonwellDruid03");
        object Druid04 = GetNearestObjectByTag("MoonwellDruid04");

        if(Druid01 == OBJECT_INVALID && Druid02 == OBJECT_INVALID
            && Druid03 == OBJECT_INVALID && Druid04 == OBJECT_INVALID
            && highDruid == OBJECT_INVALID) {
            SetLocalInt(OBJECT_SELF, "state", DONE_STATE);
            return;
        }

        location HighDruidDespawnLoc = GetLocalLocation(OBJECT_SELF,
                                                         "HighDruidDespawnLoc");
        location Druid01DespawnLoc = GetLocalLocation(OBJECT_SELF,
                                                          "Druid01DespawnLoc");
        location Druid02DespawnLoc = GetLocalLocation(OBJECT_SELF,
                                                          "Druid02DespawnLoc");
        location Druid03DespawnLoc = GetLocalLocation(OBJECT_SELF,
                                                           "Druid03DespawnLoc");
        location Druid04DespawnLoc = GetLocalLocation(OBJECT_SELF,
                                                           "Druid04DespawnLoc");

        AssignCommand(highDruid, ActionMoveToLocation(HighDruidDespawnLoc,
                                                                       FALSE));
        AssignCommand(Druid01, ActionMoveToLocation(Druid01DespawnLoc, FALSE));
        AssignCommand(Druid02, ActionMoveToLocation(Druid02DespawnLoc, FALSE));
        AssignCommand(Druid03, ActionMoveToLocation(Druid03DespawnLoc, FALSE));
        AssignCommand(Druid04, ActionMoveToLocation(Druid04DespawnLoc, FALSE));

        if(GetDistanceBetweenLocations(
            GetLocation(Druid01), Druid01DespawnLoc) < 2.0) {
            DelayCommand(1.0, AssignCommand(highDruid,
                                         SpeakString("1Disapears into forest")));
            DestroyObject(Druid01, 3.0);
        }

        if(GetDistanceBetweenLocations(
            GetLocation(Druid02), Druid02DespawnLoc) < 2.0) {
            DelayCommand(1.0, AssignCommand(Druid02,
                                         SpeakString("1Disapears into forest")));
            DestroyObject(Druid01, 3.0);
        }

        if(GetDistanceBetweenLocations(
            GetLocation(Druid03), Druid03DespawnLoc) < 2.0) {
            DelayCommand(1.0, AssignCommand(Druid03,
                                         SpeakString("1Disapears into forest")));
            DestroyObject(Druid01, 3.0);
        }

        if(GetDistanceBetweenLocations(
            GetLocation(Druid04), Druid04DespawnLoc) < 2.0) {
            DelayCommand(1.0, AssignCommand(Druid04,
                                         SpeakString("1Disapears into forest")));
            DestroyObject(Druid01, 3.0);
        }

        if(GetDistanceBetweenLocations(
            GetLocation(highDruid), HighDruidDespawnLoc) < 2.0) {
            DelayCommand(1.0, AssignCommand(highDruid,
                                         SpeakString("1Disapears into forest")));
            DestroyObject(Druid01, 3.0);
        }
    }
}
