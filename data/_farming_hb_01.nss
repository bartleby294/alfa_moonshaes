//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script with modified farming additions
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    ExecuteScript("nw_c2_default1", OBJECT_SELF);
  if(GetIsDay())
  {
    int AIState = GetLocalInt(OBJECT_SELF, "AIState");


    //will make the farmer do something if hes been just standing there for 42 seconds
     if(AIState == 0)
    {
        SetLocalInt(OBJECT_SELF, "AIState" , 1);
        return;
    }
     if(AIState == 1)
    {
       SetLocalInt(OBJECT_SELF, "AIState" , 2);
       return;
    }
     if(AIState == 2)
    {
       SetLocalInt(OBJECT_SELF, "AIState" , 3);
       return;
    }
     if(AIState == 3)
    {
       object farm = GetNearestObjectByTag("farmer_attack_obj", OBJECT_SELF, 2);
       AssignCommand(OBJECT_SELF, ActionInteractObject(farm));
       SetLocalInt(OBJECT_SELF, "AIState" , 0);
       return;
    }
   }


}
