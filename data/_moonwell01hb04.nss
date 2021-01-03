#include "_btb_util"
#include "nw_i0_generic"
#include "_moonwell01const"

int druidLevel(object oPC) {
    int i = 1;
    for(i; i < 4; i++) {
        if(GetClassByPosition(i, oPC) == CLASS_TYPE_DRUID) {
            return i;
        }
    }
    return 0;
}

object highestLevelKnownDruid(object oPC) {
    int highestDruidLvl = 0;
    int highestKnownDruidLvl = 0;
    object highestDruid = OBJECT_INVALID;
    object highestDruidKnown = OBJECT_INVALID;
    object partyMember = GetFactionLeader(oPC);

    while(partyMember != OBJECT_INVALID) {
        int druidLvls = druidLevel(partyMember);
        int knownDruid = GetLocalInt(partyMember, "Moonwell01Known");
        if(druidLvls > highestDruidLvl) {
            highestDruidLvl = druidLvls;
            highestDruid = partyMember;
        }
        if(knownDruid == 1 && druidLvls > highestKnownDruidLvl) {
            highestKnownDruidLvl = druidLvls;
            highestDruidKnown = partyMember;
        }
        partyMember = GetNextFactionMember(partyMember, TRUE);
    }

    if(highestDruidKnown != OBJECT_INVALID) {
        return highestDruidKnown;
    }

    return highestDruid;
}

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

void startConversation(int state, object oPC, object highDruid) {
    object partyDruid = highestLevelKnownDruid(oPC);

    if(highDruid != OBJECT_INVALID) {
        SendMessageToPC(oPC, "highDruid != OBJECT_INVALID");
    } else {
        SendMessageToPC(oPC, "highDruid == OBJECT_INVALID");
    }

    AssignCommand(highDruid, ClearAllActions());
    effect Walk = EffectMovementSpeedDecrease(40);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, highDruid);
    SetLocalInt(OBJECT_SELF, "state", CONVERSATION_STATE);
    location WalkLoc = GetLocalLocation(OBJECT_SELF, "WalkLoc");
    AssignCommand(highDruid, ActionMoveToLocation(WalkLoc, FALSE));
    //This goes through to see if there is a druid in the party
    //If there is the High druid will address the druid of the party
    //It will also check to see if he knows the druid or other char if he does then another convo will trigger.
    // convo state = 0 -> no instructions
    // convo state = 1 -> theres a druid convo
    // convo state = 2 -> theres a druid i know convo
    // convo state = 3 -> theres someone that isnt a druid and i dont know them.
    if(partyDruid != OBJECT_INVALID) {
        if(GetLocalInt(partyDruid, "Moonwell01Known") == 1)
        {
           //Execute I know you Druid Hello
            DelayCommand(5.0, AssignCommand(highDruid,
                ActionStartConversation(partyDruid,
                "_moonpool01con02", FALSE, FALSE)));
            return;
        }

        //Execute Generic Druid Hello
        DelayCommand(5.0, AssignCommand(highDruid,
            ActionStartConversation(partyDruid,
            "_moonpool01con03", FALSE, FALSE)));
        return;
    }

    DelayCommand(5.0, AssignCommand(highDruid, ActionStartConversation(oPC,
                            "_moonpool01con01", FALSE, FALSE)));
}

void main()
{
    int state = GetLocalInt(OBJECT_SELF, "state");
    object oPC = GetLocalObject(OBJECT_SELF, "oPC");
    object light = GetLocalObject(OBJECT_SELF, "lightobject");
    WriteTimestampedLogEntry("State: " + IntToString(state));
    object highDruid = GetLocalObject(OBJECT_SELF, "highDruid");
    // if a dm has disabled the scene or its not in progress skip out.
    if(state == DM_DISABLED_STATE || state == NO_STATE) {
        return;
    // if the trigger has been tripped start interogating.
    } else if(state == INTEROGATION_STATE) {
         // the pc steped into the light
         if(GetDistanceBetween(light, oPC) < 0.4) {
            startConversation(state, oPC, highDruid);
         } else {
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
                attack(highDruid, oPC);
            }
            SetLocalInt(OBJECT_SELF, "timer", timer + 1);
        }
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
