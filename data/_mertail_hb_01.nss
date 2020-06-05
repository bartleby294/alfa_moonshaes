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

    object sail1 = GetObjectByTag("MermaidsTailSailor1");
    object sail2 = GetObjectByTag("MermaidsTailSailor2");
    object sail3 = GetObjectByTag("MermaidsTailSailor3");
    object sail4 = GetObjectByTag("MermaidsTailSailor4");;
    object captain  = OBJECT_SELF;

    int x = GetLocalInt(captain, "HBState");
    int y = GetLocalInt(captain, "HBEndFireOnce");

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
  // sail 1
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
          DelayCommand(1.0, AssignCommand(sail1, ActionInteractObject(rope)));
       }
       if(z == 3)
       {
            DelayCommand(0.5, AssignCommand(sail1, ActionRandomWalk()));
       }
       if(z == 4)
       {
           AssignCommand(sail1, SpeakString("*Hums to himself*"));
       }
    }
    // sail 2
   if(d2(1) == 1)
    {
       int z = d4(1);

       if(z == 1)
       {
          //change nothing
       }
       if(z == 2)
       {
           DelayCommand(1.5, AssignCommand(sail3, ActionRandomWalk()));
       }
       if(z == 3)
       {
          object boom = GetObjectByTag("_s_boomtiedown");
          DelayCommand(1.0, AssignCommand(sail3, ActionInteractObject(boom)));
       }
       if(z == 4)
       {
          AssignCommand(sail3, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR,1.0 ,8.0));
       }
    }




    if(x >= 30)
    {
        if(y != 1)
        {
         AssignCommand(sail2, ClearAllActions());
         AssignCommand(captain, SpeakString("Land HO!"));
         DelayCommand(1.0, AssignCommand(sail2, SpeakString("All ashore whos goen ashore")));
         AssignCommand(sail2, ActionInteractObject(GetObjectByTag("Lifeboat_On_Ship_Activate")));
         SetLocalInt(captain, "HBEndFireOnce", 1);
        }
    }
    else
    {
        SetLocalInt(captain, "HBState", x);
    }
}
