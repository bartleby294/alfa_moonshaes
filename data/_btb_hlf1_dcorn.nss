void main()
{
    object lastAttacker = GetLastAttacker(OBJECT_SELF);
    object getAwayLocation = GetObjectByTag("hlf1_xvart_1_exit");
    if(GetTag(lastAttacker) == "xvart_raider") {
        AssignCommand(lastAttacker, ActionSpeakString("*Steals Corn*"));
        CreateItemOnObject("corn", lastAttacker, 1);
        AssignCommand(lastAttacker,
            ActionMoveToObject(getAwayLocation, TRUE, 0.0));
    }

    DestroyObject(OBJECT_SELF, 1.0);
}
