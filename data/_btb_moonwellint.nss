#include "_btb_moonwelluti"

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

void interogate(int timer, object highDruid, object oPC, object obHbObj,
                int state)
{
    // if less than 7 keep warning.
    if(timer < 7) {
        string druidStr = getDruidString(timer);
        if(druidStr != "") {
            AssignCommand(highDruid, SpeakString(druidStr));
            SendMessageToPC(oPC, "High Druid: " + druidStr);
        }
        SetLocalInt(obHbObj, "timer", timer + 1);
    // they said they were going to attack.
    } else {
        //WriteTimestampedLogEntry("State Change From: " + getState(state) +
        //                 " To: " + getState(ATTACK_STATE));
        SetLocalInt(OBJECT_SELF, "state", ATTACK_STATE);
        SetLocalInt(obHbObj, "timer", 0);
    }
}
