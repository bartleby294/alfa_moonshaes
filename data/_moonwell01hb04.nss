#include "_btb_util"
#include "nw_i0_generic"
#include "_btb_moonwellcon"
#include "x0_i0_position"
#include "_moonwell01spawn"

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
    object Druid01 = GetObjectByTag("moonwelldruid001");
    object Druid02 = GetObjectByTag("moonwelldruid002");
    object Druid03 = GetObjectByTag("moonwelldruid003");
    object Druid04 = GetObjectByTag("moonwelldruid004");
    AssignCommand(highDruid, SpeakString(
                "**Frowns and signals the other druids to attack**"));
    AssignCommand(Druid01, ActionAttack(oPC, TRUE));
    AssignCommand(Druid02, ActionAttack(oPC, TRUE));
    AssignCommand(Druid03, ActionAttack(oPC, TRUE));
    AssignCommand(Druid04, ActionAttack(oPC, TRUE));
    AssignCommand(highDruid, ActionAttack(oPC, TRUE));
    SetLocalInt(OBJECT_SELF, "state", ATTACKING_STATE);
}

location GetDruidWalkLocation(object playerToTalkTo) {
    return pickSpawnLoc(OBJECT_SELF, playerToTalkTo, 1.0, 0.0);
}

void startConversation(int state, object oPC, object highDruid) {
    object playerToTalkTo = oPC;
    object partyDruid = highestLevelKnownDruid(oPC);

    if(partyDruid != OBJECT_INVALID) {
        playerToTalkTo =  partyDruid;
    }
    location WalkLoc = GetLocalLocation(OBJECT_SELF, "WalkLoc");
    location highDruidLoc = GetLocation(highDruid);
    location playerToTalkToLoc = GetLocation(playerToTalkTo);

    vector druidTalkVec = GetPositionFromLocation(playerToTalkToLoc);
    location druidTalkLoc = GetDruidWalkLocation(playerToTalkTo);

    // Decide where to walk to.
    float pcDist = GetDistanceBetweenLocations(highDruidLoc, playerToTalkToLoc);
    float walkDist=GetDistanceBetweenLocations(highDruidLoc, WalkLoc);

    if(walkDist < 0.5) {
        AssignCommand(highDruid, ActionMoveToLocation(druidTalkLoc));
    } else {
        float pcAngel =GetAngleBetweenLocations(highDruidLoc,playerToTalkToLoc);
        float walkAngel = 10.0;//f(highDruidLoc, WalkLoc);

        // if the abs of the diff in angels is less than 55 its in front enough
        if(absFloat(pcAngel - walkAngel) < 55.0) {
            float walkDist = GetDistanceBetweenLocations(highDruidLoc, WalkLoc);
            AssignCommand(highDruid, ClearAllActions());
            if(walkDist < pcDist) {
                AssignCommand(highDruid, ActionMoveToLocation(WalkLoc));
                AssignCommand(highDruid,ActionMoveToLocation(druidTalkLoc));
            } else {
                AssignCommand(highDruid,ActionMoveToLocation(druidTalkLoc));
            }
        // else if its not in front of us just move to player.
        } else {
            AssignCommand(highDruid, ActionMoveToLocation(druidTalkLoc));
        }
    }

    //This goes through to see if there is a druid in the party
    //If there is the High druid will address the druid of the party
    //It will also check to see if he knows the druid or other char if he does then another convo will trigger.
    // convo state = 0 -> no instructions
    // convo state = 1 -> theres a druid convo
    // convo state = 2 -> theres a druid i know convo
    // convo state = 3 -> theres someone that isnt a druid and i dont know them.

    // If within range start conversation.
    if(pcDist < 5.0) {
        if(partyDruid != OBJECT_INVALID) {
            if(GetLocalInt(partyDruid, "Moonwell01Known") == 1)
            {
               //Execute I know you Druid Hello
                AssignCommand(highDruid,
                    ActionStartConversation(partyDruid,
                    "_moonpool01con02", FALSE, FALSE));
                SetLocalInt(OBJECT_SELF, "state", CONVERSATION_STATE);
                return;
            }

            //Execute Generic Druid Hello
            AssignCommand(highDruid,
                ActionStartConversation(partyDruid,
                "_moonpool01con03", FALSE, FALSE));
            SetLocalInt(OBJECT_SELF, "state", CONVERSATION_STATE);
            return;
        }

        AssignCommand(highDruid, ActionStartConversation(oPC,
                                "_moonpool01con01", FALSE, FALSE));
        SetLocalInt(OBJECT_SELF, "state", CONVERSATION_STATE);
    }
}

void logStr(string str) {
    string uuid = GetLocalString(OBJECT_SELF, "uuid");
    //WriteTimestampedLogEntry(uuid + ": " + str);
}

int InCombat(object highDruid, object Druid01, object Druid02,
              object Druid03, object Druid04) {
    if(GetIsInCombat(highDruid)) {
        return TRUE;
    }
    if(GetIsInCombat(Druid01)) {
        return TRUE;
    }
    if(GetIsInCombat(Druid02)) {
        return TRUE;
    }
    if(GetIsInCombat(Druid03)) {
        return TRUE;
    }
    if(GetIsInCombat(Druid04)) {
        return TRUE;
    }
    return FALSE;
}

void main()
{
    string uuid = GetLocalString(OBJECT_SELF, "uuid");

    if(uuid== "") {
        SetLocalString(OBJECT_SELF, "uuid", GetRandomUUID());
    }

    int state = GetLocalInt(OBJECT_SELF, "state");
    object oPC = GetLocalObject(OBJECT_SELF, "oPC");
    SendMessageToPC(oPC, "state: " + IntToString(state) + " uuid: " + uuid);
    object light = GetLocalObject(OBJECT_SELF, "lightobject");
    logStr("State: " + IntToString(state));
    object highDruid = GetLocalObject(OBJECT_SELF, "highDruid");
    object Druid01 = GetLocalObject(OBJECT_SELF, "Druid01");
    object Druid02 = GetLocalObject(OBJECT_SELF, "Druid02");
    object Druid03 = GetLocalObject(OBJECT_SELF, "Druid03");
    object Druid04 = GetLocalObject(OBJECT_SELF, "Druid04");

    if(InCombat(highDruid, Druid01, Druid02, Druid03, Druid04)) {
        return ;
    }
    // if a dm has disabled the scene or its not in progress skip out.
    if(state == DM_DISABLED_STATE || state == NO_STATE  || state == DONE_STATE){
        return;
    } else if(state == SPAWN_STATE) {
        moonwellSpawn(oPC, OBJECT_SELF);
    // if the trigger has been tripped start interogating.
    } else if(state == INTEROGATION_STATE) {
         // the pc steped into the light
         if(GetDistanceBetween(light, oPC) < 0.6) {
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
    } else if(state == CONVERSATION_STATE) {
        if(!IsInConversation(highDruid)) {
            AssignCommand(highDruid, ClearAllActions());
            startConversation(state, oPC, highDruid);
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
        SendMessageToPC(oPC, "LEAVING_STATE");
        float Druid01Dist = GetDistanceToObject(Druid01);
        float Druid02Dist = GetDistanceToObject(Druid02);
        float Druid03Dist = GetDistanceToObject(Druid03);
        float Druid04Dist = GetDistanceToObject(Druid04);
        float highDruidDist = GetDistanceToObject(highDruid);
        if(Druid01Dist < 0.0 && Druid02Dist < 0.0
            && Druid03Dist < 0.0 && Druid04Dist < 0.0
            && highDruidDist < 0.0) {
            SendMessageToPC(oPC, "DONE_STATE");
            SetLocalInt(OBJECT_SELF, "state", DONE_STATE);
            SetLocalInt(OBJECT_SELF, "leaveCnt", 0);
            return;
        }

        int leaveCnt = GetLocalInt(OBJECT_SELF, "leaveCnt");
        SetLocalInt(OBJECT_SELF, "leaveCnt", leaveCnt = leaveCnt + 1);

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

        AssignCommand(highDruid, ActionMoveToLocation(HighDruidDespawnLoc));
        AssignCommand(Druid01, ActionMoveToLocation(Druid01DespawnLoc));
        AssignCommand(Druid02, ActionMoveToLocation(Druid02DespawnLoc));
        AssignCommand(Druid03, ActionMoveToLocation(Druid03DespawnLoc));
        AssignCommand(Druid04, ActionMoveToLocation(Druid04DespawnLoc));

        SendMessageToPC(oPC, "Druid01 Dist: " + FloatToString(Druid01Dist));
        if(Druid01Dist > 20.0 || leaveCnt > 5) {
            DelayCommand(1.0, AssignCommand(Druid01,
                                       SpeakString("*Disapears into forest*")));
            DestroyObject(Druid01, 3.0);
            DelayCommand(3.1, SetLocalObject(OBJECT_SELF, "Druid01",
                                                               OBJECT_INVALID));
        }
        SendMessageToPC(oPC, "Druid02 Dist: " + FloatToString(Druid02Dist));
        if(Druid02Dist > 20.0 || leaveCnt > 5) {
            DelayCommand(1.0, AssignCommand(Druid02,
                                       SpeakString("*Disapears into forest*")));
            DestroyObject(Druid02, 3.0);
            DelayCommand(3.1, SetLocalObject(OBJECT_SELF, "Druid02",
                                                               OBJECT_INVALID));
        }
        SendMessageToPC(oPC, "Druid03 Dist: " + FloatToString(Druid03Dist));
        if(Druid03Dist > 20.0 || leaveCnt > 5) {
            DelayCommand(1.0, AssignCommand(Druid03,
                                       SpeakString("*Disapears into forest*")));
            DestroyObject(Druid03, 3.0);
            DelayCommand(3.1, SetLocalObject(OBJECT_SELF, "Druid03",
                                                               OBJECT_INVALID));
        }
        SendMessageToPC(oPC, "Druid04 Dist: " + FloatToString(Druid04Dist));
        if(Druid04Dist > 20.0 || leaveCnt > 5) {
            DelayCommand(1.0, AssignCommand(Druid04,
                                       SpeakString("*Disapears into forest*")));
            DestroyObject(Druid04, 3.0);
            DelayCommand(3.1, SetLocalObject(OBJECT_SELF, "Druid04",
                                                               OBJECT_INVALID));
        }
        SendMessageToPC(oPC, "highDruid Dist: " + FloatToString(highDruidDist));
        if(highDruidDist > 20.0 || leaveCnt > 5) {
            DelayCommand(1.0, AssignCommand(highDruid,
                                       SpeakString("*Disapears into forest*")));
            DestroyObject(highDruid, 3.0);
            DelayCommand(3.1, SetLocalObject(OBJECT_SELF, "highDruid",
                                                               OBJECT_INVALID));
        }
    }
}
