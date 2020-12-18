void main()
{
    object user = GetLastUsedBy();
    DelayCommand(1.0, AssignCommand(user, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 120.0)));
    AssignCommand(user, SpeakString("*Secures Boom*"));
}
