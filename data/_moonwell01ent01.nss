#include "_btb_moonwellcon"

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

void main()
{
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob");
    int state = GetLocalInt(obHbObj, "state");
    // if a dm has disabled the scene or its not the right time exit.
    if(state != INTEROGATION_STATE) {
        return;
    }

    object oPC = GetEnteringObject();
    object partyDruid = highestLevelKnownDruid(oPC);
    object highDruid = GetNearestObjectByTag("MoonwellHighDruid");

    AssignCommand(highDruid, ClearAllActions());
    effect Walk = EffectMovementSpeedDecrease(50);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, highDruid);
    SetLocalInt(obHbObj, "state", CONVERSATION_STATE);

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
            AssignCommand(highDruid, ActionStartConversation(partyDruid,
                                            "_moonpool01con02", FALSE, FALSE));
            return;
        }

        //Execute Generic Druid Hello
        AssignCommand(highDruid, ActionStartConversation(partyDruid,
                                    "_moonpool01con03", FALSE, FALSE));
        return;
    }

    AssignCommand(highDruid, ActionStartConversation(oPC,
                            "_moonpool01con01", FALSE, FALSE));
}
