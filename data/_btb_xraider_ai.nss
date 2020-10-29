void main()
{
    // If get away location exists this is a valid check to run.
    object getAwayLoc = GetNearestObjectByTag("hlf1_xvart_exit", OBJECT_SELF);
    if(getAwayLoc != OBJECT_INVALID) {
        // If not in combat and around more than 4 heartbeats run away.
        if(GetLocalInt(OBJECT_SELF, "heartbeat_cnt") > 5) {
            if(!GetIsInCombat(OBJECT_SELF)){
                AssignCommand(OBJECT_SELF,
                    ActionMoveToObject(getAwayLoc, TRUE, 0.0));
                    return;

            }
        } else {
            // count how many times heartbeat has been called.
            SetLocalInt(OBJECT_SELF, "heartbeat_cnt",
                GetLocalInt(OBJECT_SELF, "heartbeat_cnt") + 1);
        }
    }
}
