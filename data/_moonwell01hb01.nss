#include "_btb_util"
#include "nw_i0_generic"
#include "_moonwell01const"

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

void attack(object highDruid) {
    SetLocalInt(OBJECT_SELF, "state", ATTACK_STATE);
    object oPC = GetLocalObject(OBJECT_SELF, "oPC");
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
    int state = GetLocalInt(OBJECT_SELF, "state");
    object highDruid = GetNearestObjectByTag("MoonwellHighDruid");
    // if a dm has disabled the scene or its not in progress skip out.
    if(state = DM_DISABLED_STATE || state == NO_STATE) {
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
            }
        // they said they were going to attack.
        } else {
            attack(highDruid);
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
            attack(highDruid);
        } else {
            SetLocalInt(OBJECT_SELF, "state", LEAVING_STATE);
        }
    } else if (state == WARN_STATE) {
        AssignCommand(highDruid, SpeakString(
                                    "Leave now this is your final warning!"));
        SetLocalInt(OBJECT_SELF, "state", ATTACK_STATE);
    } else if (state == LEAVING_STATE) {
        object Druid01 = GetNearestObjectByTag("MoonwellDruid01");
        object Druid02 = GetNearestObjectByTag("MoonwellDruid02");
        object Druid03 = GetNearestObjectByTag("MoonwellDruid03");
        object Druid04 = GetNearestObjectByTag("MoonwellDruid04");

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

        DestroyObject(highDruid, 16.0);
        DestroyObject(Druid01, 16.0);
        DestroyObject(Druid02, 16.0);
        DestroyObject(Druid03, 16.0);
        DestroyObject(Druid04, 16.0);

        DelayCommand(15.0, AssignCommand(highDruid,
                                         SpeakString("Disapears into forest")));
        DelayCommand(15.0, AssignCommand(Druid01,
                                         SpeakString("Disapears into forest")));
        DelayCommand(15.0, AssignCommand(Druid02,
                                         SpeakString("Disapears into forest")));
        DelayCommand(15.0, AssignCommand(Druid03,
                                         SpeakString("Disapears into forest")));
        DelayCommand(15.0, AssignCommand(Druid04,
                                        SpeakString("Disapears into forest")));
        SetLocalInt(OBJECT_SELF, "state", DONE_STATE);
    }
}
