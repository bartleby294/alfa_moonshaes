void main()
{
    object victem = OBJECT_SELF;
    object Attacker = GetLastAttacker(victem );

    int roll = d4(1);

    if(roll == 1)
    {   AssignCommand(victem, ActionPlayAnimation(28, 1.0, 999.0));
        DelayCommand(0.1, AssignCommand(victem, SpeakString("AHHHH!!!")));
    }
    if(roll == 2)
    {
        AssignCommand(victem, ActionPlayAnimation(28, 1.0, 999.0));
        DelayCommand(0.1, AssignCommand(victem, SpeakString("Please Please Stop!!")));
    }
    if(roll == 3)
    {
        AssignCommand(victem, ActionPlayAnimation(28, 1.0, 999.0));
        DelayCommand(0.1, AssignCommand(victem, SpeakString("I wont do it again i swear!")));
    }
    if(roll == 4)
    {
        AssignCommand(victem, ActionPlayAnimation(28, 1.0, 999.0));
        DelayCommand(0.1, AssignCommand(victem, SpeakString("Ill kill you! Ill kill you!")));
    }
}
