#include "_btb_moonwellcon"
#include "_btb_moonwelluti"
#include "_btb_moonwellspa"
#include "_btb_moonwelltal"
#include "_btb_moonwellint"
#include "_btb_moonwelllea"

void main()
{
    object obHbObj = OBJECT_SELF;
    object highDruid = GetNearestObjectByTag("moonwelldruid");
    object Druid01 = GetNearestObjectByTag("moonwelldruid001");
    object Druid02 = GetNearestObjectByTag("moonwelldruid002");
    object Druid03 = GetNearestObjectByTag("moonwelldruid003");
    object Druid04 = GetNearestObjectByTag("moonwelldruid004");
    object light = GetNearestObjectByTag("alfa_shaftligt6");

    int timer = GetLocalInt(obHbObj, "timer");
    int state = GetLocalInt(obHbObj, "state");
    object oPC = GetLocalObject(obHbObj, "oPC");

    logDruidInitialCond(highDruid, Druid01, Druid02, Druid03,Druid04,state,oPC);
    checkInputs(obHbObj, highDruid, Druid01, Druid02, Druid03, Druid04, oPC);

    // If anyone is in combat exit out of here.
    if(InCombat(highDruid, Druid01, Druid02, Druid03, Druid04)) {
        WriteTimestampedLogEntry("In Combat Exit");
        return ;
    }

    // if a dm has disabled the scene or its not in progress skip out.
    if(state == DM_DISABLED_STATE || state == NO_STATE  || state == DONE_STATE
        || state == ATTACKING_STATE){
        WriteTimestampedLogEntry("In Do Not Run State Exit");
        return;
    // if were starting fresh or over spawn or reset peices.
    } else if(state == SPAWN_STATE) {
        WriteTimestampedLogEntry("In Spawn State");
        moonwellSpawn(oPC, obHbObj, highDruid, Druid01,
                        Druid02, Druid03, Druid04, state, light);
    // if the peices are set start interogating.
    } else if(state == INTEROGATION_STATE) {
        WriteTimestampedLogEntry("In Interogation State");
         // the pc steped into the light
         if(GetDistanceBetween(light, oPC) < 0.6) {
            startConversation(state, oPC, highDruid, obHbObj);
         } else {
            interogate(timer, highDruid, oPC, obHbObj, state);
        }
    // if were supposed to be talking still and arent talk again.
    } else if(state == CONVERSATION_STATE) {
        WriteTimestampedLogEntry("In Conversation State");
        if(!IsInConversation(highDruid)) {
            startConversation(state, oPC, highDruid, obHbObj);
        }
    } else if (state == ATTACK_STATE) {
            WriteTimestampedLogEntry("In Attack State");
            AssignCommand(highDruid, SpeakString(
                "**Frowns and signals the other druids to attack**"));
            AssignCommand(Druid01, ActionAttack(oPC, TRUE));
            AssignCommand(Druid02, ActionAttack(oPC, TRUE));
            AssignCommand(Druid03, ActionAttack(oPC, TRUE));
            AssignCommand(Druid04, ActionAttack(oPC, TRUE));
            AssignCommand(highDruid, ActionAttack(oPC, TRUE));
            WriteTimestampedLogEntry("State Change From: " + getState(state) +
                         " To: " + getState(ATTACKING_STATE));
            SetLocalInt(OBJECT_SELF, "state", ATTACKING_STATE);
    } else if (state == LEAVING_STATE) {
        WriteTimestampedLogEntry("In Leave State");
        druidsLeave(oPC, obHbObj, highDruid, Druid01, Druid02, Druid03,
                    Druid04, state, light);
    }
}
