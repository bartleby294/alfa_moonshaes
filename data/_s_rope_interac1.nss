void main()
{
    object user = GetLastUsedBy();
    DelayCommand(1.0, AssignCommand(user, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 120.0)));
    AssignCommand(user, SpeakString("*Organizes rope*"));
}
