//  The global Area OnExit script
//  This script should be in every areas OnExit Handler
//  All area templates have this script installed

#include "spawn_functions"

void main()
{
    //Spawn_OnAreaExit();

    object oArea    = GetArea(OBJECT_SELF);
    object oExiting = GetExitingObject();
    event mEvent = EventUserDefined(3000);
    if(GetIsPC(oExiting))
        {DelayCommand(10.0,SignalEvent(oArea,mEvent));
        SetLocalInt(oArea,"InPlay",FALSE);}
}
