void main()
{
    object attacker = GetLastAttacker(OBJECT_SELF);

    //AssignCommand(OBJECT_SELF, SpeakString("On phys attacked", TALKVOLUME_TALK));

    SetLocalObject(OBJECT_SELF, "attacker", attacker);
    SetLocalInt(OBJECT_SELF, "isattacked", 1);

    if(GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH) == TRUE)
    {
        SetActionMode(OBJECT_SELF,ACTION_MODE_STEALTH, FALSE);
    }

    ActionMoveAwayFromObject(attacker, TRUE, 300.0);
}
