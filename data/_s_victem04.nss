void main()
{
    AssignCommand(OBJECT_SELF, ClearAllActions(TRUE));
    AssignCommand(OBJECT_SELF, ActionPlayAnimation(28, 1.0, 999.0));
    DelayCommand(0.1, AssignCommand(OBJECT_SELF, ActionSpeakString("*LookS at you accusatorily*")));
}
