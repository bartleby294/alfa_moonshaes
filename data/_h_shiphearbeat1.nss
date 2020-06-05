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

    object shipguy1 = GetObjectByTag("HammerstaadSailor1");
    object shipguy2 = GetObjectByTag("HammerstaadSailor2");
    object shipguy3 = GetObjectByTag("Sailor3");

    object shipguy4 = GetObjectByTag("Marricho2");
    object shipguy5 = GetObjectByTag("Vichan2");
    object shipguy6 = GetObjectByTag("Westiante2");

    object captain = OBJECT_SELF;

    object Drum = GetNearestObjectByTag("SeaDrum1");

    //if AI is turned off ignore scripts
    if(AIState == 1)
    {
        return;
    }
    //otherwise run the ai
    int x = GetLocalInt(captain, "HBState");
    int y = GetLocalInt(captain, "HBEndFireOnce");
    int z = GetLocalInt(captain, "OffSetVar");

        x=x+1;


    // the captain



    // every 12 seconds the sailor will yell all ashore whos goign ashore.
    if(y == 1)
     {
        if(z !=1)
        {
            DelayCommand(1.0, AssignCommand(shipguy3, SpeakString("All ashore whos goen ashore")));
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
         AssignCommand(shipguy3, ClearAllActions());
         AssignCommand(captain, SpeakString("All right lets get a move on."));
         DelayCommand(1.0, AssignCommand(shipguy3, SpeakString("All ashore whos goen ashore")));
         SetLocalInt(captain, "HBEndFireOnce", 1);

         object oPC1 = GetFirstPC();

            while(oPC1 != OBJECT_INVALID)
            {
                SendMessageToPC(oPC1, "The ship comes with in sight of land and a number of the crew start to make ready for landfall.  Perhaps you should speak with one of them near a boat.");
                oPC1 = GetNextPC();
            }
             return;
        }
    }
    else
    {
        SetLocalInt(captain, "HBState", x);
    }
        AssignCommand(captain, ActionAttack(Drum));

       /*
        AssignCommand(shipguy1, ClearAllActions());
        AssignCommand(shipguy1, SpeakString("**Pulls**"));
        AssignCommand(shipguy1, ActionInteractObject(GetNearestObjectByTag("Chair", shipguy1, 1)));

        AssignCommand(shipguy2, ClearAllActions());
        DelayCommand(0.0001, AssignCommand(shipguy2, SpeakString("**Pulls**")));
        DelayCommand(0.0002, AssignCommand(shipguy2, ActionInteractObject(GetNearestObjectByTag("Chair", shipguy2, 1))));

        AssignCommand(shipguy3, ClearAllActions());
        DelayCommand(0.0001, AssignCommand(shipguy3, SpeakString("**Pulls**")));
        DelayCommand(0.0002, AssignCommand(shipguy3, ActionInteractObject(GetNearestObjectByTag("Chair", shipguy3, 1))));

        AssignCommand(shipguy4, ClearAllActions());
        DelayCommand(0.0001, AssignCommand(shipguy4, SpeakString("**Pulls**")));
        DelayCommand(0.0002, AssignCommand(shipguy4, ActionInteractObject(GetNearestObjectByTag("Chair", shipguy4, 1))));

        AssignCommand(shipguy5, ClearAllActions());
        DelayCommand(0.0001, AssignCommand(shipguy5, SpeakString("**Pulls**")));
        DelayCommand(0.0002, AssignCommand(shipguy5, ActionInteractObject(GetNearestObjectByTag("Chair", shipguy5, 1))));

        AssignCommand(shipguy6, ClearAllActions());
        DelayCommand(0.0001, AssignCommand(shipguy6, SpeakString("**Pulls**")));
        DelayCommand(0.0002, AssignCommand(shipguy6, ActionInteractObject(GetNearestObjectByTag("Chair", shipguy6, 1))));


        AssignCommand(shipguy1, ClearAllActions());
        AssignCommand(shipguy1, ActionStartConversation(shipguy1, "_pulls01", FALSE,  FALSE));

        AssignCommand(shipguy2, ClearAllActions());
        AssignCommand(shipguy2, ActionStartConversation(shipguy2, "_pulls01", FALSE,  FALSE));

        AssignCommand(shipguy4, ClearAllActions());
        AssignCommand(shipguy4, ActionStartConversation(shipguy4, "_pulls01", FALSE,  FALSE));

        AssignCommand(shipguy5, ClearAllActions());
        AssignCommand(shipguy5, ActionStartConversation(shipguy5, "_pulls01", FALSE,  FALSE));

        AssignCommand(shipguy6, ClearAllActions());
        AssignCommand(shipguy6, ActionStartConversation(shipguy6, "_pulls01", FALSE,  FALSE));
        */

}
