//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    ExecuteScript("nw_c2_default1", OBJECT_SELF);

    object AI = GetNearestObjectByTag("AIToggle", OBJECT_SELF, 1);
    int AIState = GetLocalInt(AI, "AIState");

    object captain = OBJECT_SELF;
    object shipguy1 = GetObjectByTag("RottsheimSailor");


    //if AI is turned off ignore scripts
    if(AIState == 1)
    {

        AssignCommand(shipguy1, ClearAllActions(TRUE));
        AssignCommand(captain, ClearAllActions(TRUE));
        return;
    }
    //otherwise run the ai
    int x = GetLocalInt(captain, "HBState");
    int y = GetLocalInt(captain, "HBEndFireOnce");
    int z = GetLocalInt(captain, "OffSetVar");

        x=x+1;


    // the captain
    if(d2(1) == 1)
    {
       int z = d4(1);

       if(z == 1)
       {
          //change nothing
       }
       if(z == 2)
       {
         AssignCommand(captain, SpeakString("*Looks through spy glass*"));
       }
       if(z == 3)
       {
          AssignCommand(captain, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0 ,8.0));
       }
       if(z == 4)
       {
          AssignCommand(captain, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0 ,8.0));
       }
    }
    // every 12 seconds the sailor will yell all ashore whos goign ashore.
    if(y == 1)
     {
        if(z !=1)
        {
            DelayCommand(1.0, AssignCommand(shipguy1, SpeakString("All ashore whos goen ashore")));
            SetLocalInt(captain, "OffSetVar", 1);
            return;
        }
        if(z == 1)
        {
            SetLocalInt(captain, "OffSetVar", 0);
            return;
        }
     }




    if(x >= 30)
    {
        if(y != 1)
        {
         AssignCommand(shipguy1, ClearAllActions());
         AssignCommand(captain, SpeakString("All right lets get a move on."));
         DelayCommand(1.0, AssignCommand(shipguy1, SpeakString("All ashore whos goen ashore")));
         SetLocalInt(captain, "HBEndFireOnce", 1);

         object oPC1 = GetFirstPC();

            while(oPC1 != OBJECT_INVALID)
            {
                SendMessageToPC(oPC1, "The ship comes with in sight of land and a number of the crew start to make ready for landfall.  Perhaps you should speak with one of them.");
                oPC1 = GetNextPC();
            }
        }
    }
    else
    {
        SetLocalInt(captain, "HBState", x);
    }
}
