void main()
{
    object lastUsed = GetLastUsedBy();
    if(GetTag(lastUsed) == "clav"
        || GetTag(lastUsed) == "jart"
        || GetTag(lastUsed) == "rolling") {
        AssignCommand(lastUsed, ActionSpeakString("*Tends to the corn*"));
        AssignCommand(lastUsed, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0));
        DelayCommand(5.0, SetLocalInt(lastUsed, "walkingToCorn", 0));
    }
}
