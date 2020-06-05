//#include "mje_flocking_01"

void main()
{
     int eventNum = GetUserDefinedEventNumber();
     event myEvent = EventUserDefined(5001);
     switch (eventNum)
     {
        case 5001 :
            // run the flocking routine
            ExecuteScript("mje_flocking_02", OBJECT_SELF);

            // add another call to myEvent to the action queue.
            // NOTE: we add this to the action queue, to fire
            // once every few seconds
            //event myEvent = EventUserDefined(5001);
            DelayCommand(1.0f,
                    ActionDoCommand(SignalEvent(OBJECT_SELF,
                                                myEvent)));
            break;

     }
}
