#include "_btb_util"

void YellRunAway() {
    if(GetTag(OBJECT_SELF) == "clav") {
        AssignCommand(OBJECT_SELF, SpeakString("Here they come, fleeee!"));
    } else if(GetTag(OBJECT_SELF) == "jart") {
        AssignCommand(OBJECT_SELF, SpeakString("Bloody things are back!"));
    } else if(GetTag(OBJECT_SELF) == "rolling") {
        AssignCommand(OBJECT_SELF, SpeakString("Hide, dammit, Hide!"));
    }
}

void RandomlyWalkToCorn(){
    if(GetLocalInt(OBJECT_SELF, "walkingToCorn") == 0){
        int cornNum = Random(48) + 1;
        string BASE_OBJ_TAG = "hlf_f1_corn_obj_";
        object corn = GetObjectByTag(BASE_OBJ_TAG + IntToString(cornNum));
        AssignCommand(OBJECT_SELF, ActionInteractObject(corn));
        SetLocalInt(OBJECT_SELF, "walkingToCorn", 1);
    }
}

void MovementDec() {
    //WriteTimestampedLogEntry("FARMER slowing Movement");
    effect eSpeedDown = EffectMovementSpeedDecrease(50);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeedDown, OBJECT_SELF);
}

void MovementReset() {
    //WriteTimestampedLogEntry("FARMER Resetting Movement");
    effect eSpeedUp = EffectMovementSpeedIncrease(99);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeedUp, OBJECT_SELF);
}

void main()
{
    // if there is no danger do your thing.
    if(GetLocalInt(OBJECT_SELF, "perilalert") == 0){
        if(GetLocalInt(OBJECT_SELF, "walking") == 0){
            SetLocalInt(OBJECT_SELF, "walking", 1);
            MovementDec();
        }
        RandomlyWalkToCorn();
    // else run away
    } else {
        if(GetLocalInt(OBJECT_SELF, "walking") == 1){
            SetLocalInt(OBJECT_SELF, "walking", 0);
            MovementReset();
        }
        AssignCommand(OBJECT_SELF, ClearAllActions());
        YellRunAway();
        AssignCommand(OBJECT_SELF,
            ActionMoveToObject(GetObjectByTag("corn_farmer_despawn"), TRUE));
    }
}
