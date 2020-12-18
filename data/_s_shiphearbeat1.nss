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

    object shipguy = GetObjectByTag("Smuggler5a");
    object hin = GetObjectByTag("Smuggler3a");
    object captain = GetObjectByTag("Smuggler4a");
    object rasta = OBJECT_SELF;
    object quequeg = GetObjectByTag("Smuggler2a");

    //if AI is turned off ignore scripts
    if(AIState == 1)
    {
        return;
    }
    //otherwise run the ai
    int x = GetLocalInt(rasta, "HBState");
    int y = GetLocalInt(rasta, "HBEndFireOnce");
    int z = GetLocalInt(rasta, "OffSetVar");

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
          AssignCommand(captain, SpeakString("Come on ya curs put your backs into it!"));
       }
       if(z == 4)
       {
          AssignCommand(captain, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0 ,8.0));
       }
    }
  // quequeg
 if(d2(1) == 1)
    {
       int z = d4(1);

       if(z == 1)
       {
          //change nothing
       }
       if(z == 2)
       {
          object rope = GetObjectByTag("_s_interactablerope");
          DelayCommand(1.0, AssignCommand(quequeg, ActionInteractObject(rope)));
       }
       if(z == 3)
       {
            DelayCommand(0.5, AssignCommand(quequeg, ActionRandomWalk()));
       }
       if(z == 4)
       {
           AssignCommand(quequeg, SpeakString("*Hums to himself*"));
       }
    }
    // The runt
   if(d2(1) == 1)
    {
       int z = d4(1);

       if(z == 1)
       {
          //change nothing
       }
       if(z == 2)
       {
           DelayCommand(1.5, AssignCommand(hin, ActionRandomWalk()));
       }
       if(z == 3)
       {
          object boom = GetObjectByTag("_s_boomtiedown");
          DelayCommand(1.0, AssignCommand(hin, ActionInteractObject(boom)));
       }
       if(z == 4)
       {
          AssignCommand(hin, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0 ,8.0));
       }
    }

    // every 12 seconds the sailor will yell all ashore whos goign ashore.
    if(y == 1)
     {
        if(z !=1)
        {
            DelayCommand(1.0, AssignCommand(shipguy, SpeakString("All ashore whos goen ashore")));
            SetLocalInt(rasta, "OffSetVar", 1);
            return;
        }
        if(z == 1)
        {
            SetLocalInt(rasta, "OffSetVar", 0);
            return;
        }
     }




    if(x >= 30)
    {
        if(y != 1)
        {
         AssignCommand(shipguy, ClearAllActions());
         AssignCommand(captain, SpeakString("All right lets get a move on."));
         DelayCommand(1.0, AssignCommand(shipguy, SpeakString("All ashore whos goen ashore")));
         SetLocalInt(rasta, "HBEndFireOnce", 1);

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
        SetLocalInt(rasta, "HBState", x);
    }
}
