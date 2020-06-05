void main()
{
    object oPC = OBJECT_SELF;

    DelayCommand(0.1,AssignCommand(oPC, ActionPlayAnimation(30, 1.0, 10.0) ));
    DelayCommand(0.0, AssignCommand(oPC, ActionSpeakString("30")));

    DelayCommand(10.1,AssignCommand(oPC, ActionPlayAnimation(29, 1.0, 10.0) ));
    DelayCommand(10.0, AssignCommand(oPC, ActionSpeakString("29")));

    DelayCommand(20.1,AssignCommand(oPC, ActionPlayAnimation(28, 1.0, 10.0) ));
    DelayCommand(20.0, AssignCommand(oPC, ActionSpeakString("28")));

    DelayCommand(30.1,AssignCommand(oPC, ActionPlayAnimation(27, 1.0, 10.0) ));
    DelayCommand(33.0, AssignCommand(oPC, ActionSpeakString("27")));

    DelayCommand(40.1,AssignCommand(oPC, ActionPlayAnimation(26, 1.0, 10.0) ));
    DelayCommand(40.0, AssignCommand(oPC, ActionSpeakString("26")));

    DelayCommand(50.1,AssignCommand(oPC, ActionPlayAnimation(25, 1.0, 10.0) ));
    DelayCommand(50.0, AssignCommand(oPC, ActionSpeakString("25")));

    DelayCommand(60.1,AssignCommand(oPC, ActionPlayAnimation(24, 1.0, 10.0) ));
    DelayCommand(60.0, AssignCommand(oPC, ActionSpeakString("24")));

    DelayCommand(70.1,AssignCommand(oPC, ActionPlayAnimation(23, 1.0, 10.0) ));
    DelayCommand(70.0, AssignCommand(oPC, ActionSpeakString("23")));

    DelayCommand(80.1,AssignCommand(oPC, ActionPlayAnimation(22, 1.0, 10.0)) );
    DelayCommand(80.0, AssignCommand(oPC, ActionSpeakString("22")));

    DelayCommand(80.1,AssignCommand(oPC, ActionPlayAnimation(21, 1.0, 10.0)) );
    DelayCommand(80.0, AssignCommand(oPC, ActionSpeakString("21")));

    DelayCommand(90.1,AssignCommand(oPC, ActionPlayAnimation(20, 1.0, 10.0)) );
    DelayCommand(90.0, AssignCommand(oPC, ActionSpeakString("20")));

    DelayCommand(100.1,AssignCommand(oPC, ActionPlayAnimation(20, 1.0, 10.0)) );
    DelayCommand(100.0, AssignCommand(oPC, ActionSpeakString("20")));

}
