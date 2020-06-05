//#include "mje_flocking_01"

void main()
{
     int eventNum = GetUserDefinedEventNumber();
      int nUser = GetUserDefinedEventNumber();
     switch (eventNum)
     {
        case 5001 :
            // run the flocking routine
            ExecuteScript("mje_flocking_01", OBJECT_SELF);

            // add another call to myEvent to the action queue.
            // NOTE: we add this to the action queue, to fire
            // once every few seconds
            event myEvent = EventUserDefined(5001);
            DelayCommand(1.0f,
                    ActionDoCommand(SignalEvent(OBJECT_SELF,
                                                myEvent)));
            break;
     }
     if(nUser == 1003) // END OF COMBAT ROUND
    {
        // Babble only 10% of the time
        if (d10() < 2)
        {
            switch (d8())
            {
                case 1:  SpeakString("We will smash!!"); break;
                case 2:  SpeakString("*sniff* Guk..."); break;
                case 3:  SpeakString("Eeeeek!"); break;
                case 4:  SpeakString("Dance in blood!"); break;
                case 5:  SpeakString("Rips dem in three!"); break;
                case 6:  SpeakString("Spikey death!  *eep*"); break;
                case 7:  SpeakString("Wallop their heads! Crack skulls my goblin kin!"); break;
                case 8:  SpeakString("We's be cooking meat tonight!!"); break;
                case 9:  SpeakString("Kill them all!!!"); break;
                case 10: SpeakString("Keep killing!!"); break;
            }
        }
    }

    else if(nUser == 1006) // ON DAMAGED
    {
        // Babble only 10% of the time
        if (d10() < 2)
        {
            switch (d6())
            {
                case 1: SpeakString("*Eeeep*"); break;
                case 2: SpeakString("What's all this green stuff?"); break;
                case 3: SpeakString("Ack!!!"); break;
                case 4: SpeakString("Run away!!"); break;
                case 5: SpeakString("*gulp*"); break;
                case 6: SpeakString("Dying bravely here!"); break;
            }
        }
    }


}
