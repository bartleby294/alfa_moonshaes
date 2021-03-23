#include "_btb_moonwellcon"
#include "_btb_moonwelluti"
#include "_btb_util"

#include "x0_i0_position"

location GetDruidWalkLocation(object playerToTalkTo, object obHbObj) {
    return pickSpawnLoc(obHbObj, playerToTalkTo, 1.0, 0.0);
}

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

object getPlayerToTalkTo(object oPC) {
    object playerToTalkTo = oPC;
    object partyDruid = highestLevelKnownDruid(oPC);

    if(partyDruid != OBJECT_INVALID) {
        playerToTalkTo =  partyDruid;
    }

    return  playerToTalkTo;
}

int goToWalkLocation(object highDruid, object playerToTalkTo, object obHbObj,
                     location WalkLoc, location druidTalkLoc) {

    location highDruidLoc = GetLocation(highDruid);
    location playerToTalkToLoc = GetLocation(playerToTalkTo);
    vector druidTalkVec = GetPositionFromLocation(playerToTalkToLoc);

    float pcDist = GetDistanceBetweenLocations(highDruidLoc, playerToTalkToLoc);
    float walkDist=GetDistanceBetweenLocations(highDruidLoc, WalkLoc);

    if(walkDist < 0.5) {
        return TRUE;
    } else {
        float pcAngel =GetAngleBetweenLocations(highDruidLoc,playerToTalkToLoc);
        float walkAngel = GetAngleBetweenLocations(highDruidLoc, WalkLoc);

        // if the abs of the diff in angels is less than 55 its in front enough
        if(absFloat(pcAngel - walkAngel) < 55.0) {
            float walkDist = GetDistanceBetweenLocations(highDruidLoc, WalkLoc);
            if(walkDist < pcDist) {
                return TRUE;
            } else {
                return FALSE;
            }
        // else if its not in front of us just move to player.
        } else {
            return FALSE;
        }
    }
}

void startConversation(int state, object oPC, object highDruid, object obHbObj){

    object playerToTalkTo = getPlayerToTalkTo(oPC);
    location WalkLoc = GetLocalLocation(obHbObj, "WalkLoc");
    location druidTalkLoc = GetDruidWalkLocation(playerToTalkTo, obHbObj);
    float pcDist = GetDistanceBetweenLocations(GetLocation(highDruid),
                                               GetLocation(playerToTalkTo));
    if(pcDist == -1.0) {
        //WriteTimestampedLogEntry("WARN: pcDist == -1");
    } else if(pcDist < 5.0) {
        //WriteTimestampedLogEntry("PC Distance < 5.0");
        if(druidLevel(playerToTalkTo) > 0
            && GetLocalInt(playerToTalkTo, "Moonwell01Known") == 1) {
            // Execute I know you Druid Hello
            AssignCommand(highDruid, ActionStartConversation(playerToTalkTo,
                                            "_btb_moon_con01", FALSE, FALSE));
                                            //"_btb_moon_con02", FALSE, FALSE));
        } else if (druidLevel(playerToTalkTo) > 0) {
            // Execute Generic Druid Hello
            AssignCommand(highDruid, ActionStartConversation(playerToTalkTo,
                                            "_btb_moon_con01", FALSE, FALSE));
                                            // "_btb_moon_con03", FALSE, FALSE));
        } else {
            // Execute Generic Hello
            AssignCommand(highDruid, ActionStartConversation(playerToTalkTo,
                                             "_btb_moon_con01", FALSE, FALSE));
        }
        //WriteTimestampedLogEntry("State Change From: " + getState(state) +
        //                 " To: " + getState(CONVERSATION_STATE));
        SetLocalInt(OBJECT_SELF, "state", CONVERSATION_STATE);
    } else if (pcDist > 15.0) {
        //WriteTimestampedLogEntry("PC Distance > 15.0");
        AssignCommand(highDruid, ClearAllActions());
        AssignCommand(highDruid, ActionMoveToLocation(WalkLoc));
    } else {
        // Clear all current commands set new queue
        //WriteTimestampedLogEntry("PC Distance > 5.0");
        AssignCommand(highDruid, ClearAllActions());
        if(goToWalkLocation(highDruid, playerToTalkTo, obHbObj,
                                           WalkLoc, druidTalkLoc)) {
            AssignCommand(highDruid, ActionMoveToLocation(WalkLoc));
        }
        AssignCommand(highDruid, ActionMoveToLocation(druidTalkLoc));
    }
}
