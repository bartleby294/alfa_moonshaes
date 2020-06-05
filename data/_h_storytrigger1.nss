void main()
{
    object Wino = GetObjectByTag("Wino");
    object oPC = GetEnteringObject();

    object boy1 = GetObjectByTag("_boy1_invis");
    object boy2 = GetObjectByTag("_boy2_invis");
    object boy3 = GetObjectByTag("_boy3_invis");

    object woman1 = GetObjectByTag("Annita");

    if(GetLocalInt(Wino, "storystate") != 1 && GetIsPC(GetEnteringObject()) && GetIsNight())
    {
        AssignCommand(boy3, ClearAllActions());

        SetLocalInt(Wino, "storystate", 1);
        int roll = d4(1);

        if(roll==1)
        {   //troll story
            DelayCommand(0.04, AssignCommand(woman1, ActionSpeakString("One story and then off to bed.")));
            DelayCommand(1.01, AssignCommand(Wino, ActionSpeakString("Which'll it be lads?")));

                //DelayCommand(2.01, AssignCommand(boy2, SpeakString("Arnlaug Birla and the Giant!")));

            DelayCommand(2.01, AssignCommand(boy1, ActionSpeakString("TheLad who had an Eating Match with the Troll!", TALKVOLUME_TALK)));
            DelayCommand(2.51, AssignCommand(boy2, ActionSpeakString("Eating Match with the Troll!", TALKVOLUME_TALK)));
            DelayCommand(3.01, AssignCommand(boy3, ActionSpeakString("Eating Match with the Troll!", TALKVOLUME_TALK)));

            DelayCommand(5.01, AssignCommand(Wino, ActionSpeakString("Alright alright.  Eating match with a troll it is **Smiles**")));

            DelayCommand(9.01, ExecuteScript("_h_winostory1", OBJECT_SELF));
            return;
        }
        if(roll==2)
        {   //Arnlaug Birla
            DelayCommand(0.05, AssignCommand(woman1, ActionSpeakString("One story and then off to bed.")));
            DelayCommand(1.01, AssignCommand(Wino, ActionSpeakString("Which'll it be lads?")));

                //DelayCommand(2.01, AssignCommand(boy2, SpeakString("Arnlaug Birla and the Giant!")));

            DelayCommand(2.01, AssignCommand(boy2, ActionSpeakString("Arnlaug Birla and the Giant!", TALKVOLUME_TALK)));
            DelayCommand(2.51, AssignCommand(boy1, ActionSpeakString("Arnlaug Birla and the Giant!", TALKVOLUME_TALK)));
            DelayCommand(3.01, AssignCommand(boy3, ActionSpeakString("Arnlaug Birla and the Giant!", TALKVOLUME_TALK)));

            DelayCommand(5.01, AssignCommand(Wino, ActionSpeakString("**Grins** Arnlaung Birla it is then!")));

            DelayCommand(9.01, ExecuteScript("_h_winostory2", OBJECT_SELF));
            return;
        }
        if(roll==3)
        {   //Tempus and the Seawolf Serpent
            DelayCommand(0.05, AssignCommand(woman1, ActionSpeakString("One story and then off to bed.")));
            DelayCommand(1.01, AssignCommand(Wino, ActionSpeakString("Which'll it be lads?")));

               // DelayCommand(2.01, AssignCommand(boy2, SpeakString("Arnlaug Birla and the Giant!")));

            DelayCommand(2.01, AssignCommand(boy1, ActionSpeakString("Tempus and the Seawolf Serpent!", TALKVOLUME_TALK)));
            DelayCommand(2.51, AssignCommand(boy3, ActionSpeakString("Yeah that one!", TALKVOLUME_TALK)));
            DelayCommand(3.01, AssignCommand(boy2, ActionSpeakString("The Seawolf Serpent!", TALKVOLUME_TALK)));

            DelayCommand(5.01, AssignCommand(Wino, ActionSpeakString("Alright quiet down then.")));

            DelayCommand(9.01, ExecuteScript("_h_winostory3", OBJECT_SELF));
            return;
        }
        if(roll==4)
        {   //The challenge of Tempus
            DelayCommand(0.05, AssignCommand(woman1, ActionSpeakString("One story and then off to bed.")));
            DelayCommand(1.01, AssignCommand(Wino, ActionSpeakString("Which'll it be lads?")));

                //DelayCommand(2.01, AssignCommand(boy2, SpeakString("Arnlaug Birla and the Giant!")));

            DelayCommand(2.01, AssignCommand(boy3, ActionSpeakString("The challenge of Tempus!", TALKVOLUME_TALK)));
            DelayCommand(2.31, AssignCommand(boy1, ActionSpeakString("Yeah! The challenge of Tempus!", TALKVOLUME_TALK)));
            DelayCommand(2.61, AssignCommand(boy2, ActionSpeakString("Tempus!", TALKVOLUME_TALK)));

            DelayCommand(5.01, AssignCommand(Wino, ActionSpeakString("Listen up then lads!")));

            DelayCommand(8.01, ExecuteScript("_h_winostory4", OBJECT_SELF));
            return;
        }

    }
}
