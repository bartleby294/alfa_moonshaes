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

    object WP1 = GetNearestObjectByTag("RedStag_WP1");
    object WP2 = GetNearestObjectByTag("RedStag_WP2");
    object WP3 = GetNearestObjectByTag("RedStag_WP3");
    object WP5 = GetNearestObjectByTag("RedStag_WP5");
    object WP6 = GetNearestObjectByTag("RedStag_WP6");


    /*
    PosState Var Values
    0 = uninitialized move to WP1
    1 = initilized and in process of going to WP1 will remain =1 untill prox to WP is made
    2 = Creature is near enough to WP1 now is going to WP 2 will stay goign to wp2 untill prox is met
    3 = Creature is near enough to WP2 or WP5 and is now deciding where to go either sit or through the door.
    4 = Creatrue is in progress of finding a chair and sitting
    5 = Creature is sitting or through the door
    6 = Creature is walking around table to WP4
    7 = Creature is still walking around table to WP5
    */
    int PosState = GetLocalInt(OBJECT_SELF, "PosState");
    int StateTime6 = GetLocalInt(OBJECT_SELF, "StateTime6");

    if(PosState == 0)
    {
        if(GetDistanceBetween(OBJECT_SELF, WP6) > 5.0)
        {
            object Chair = GetNearestObjectByTag("Chair_redstag", OBJECT_SELF, 1);
            AssignCommand(OBJECT_SELF, ActionInteractObject(Chair));
            SetLocalInt(OBJECT_SELF, "PosState",4);
            return;
        }
        ActionForceMoveToObject(WP3, FALSE, 1.0, 30.0);
        SetLocalInt(OBJECT_SELF, "PosState",1);
        //SpeakString("PosState == 0");

        return;
    }

    if(PosState == 1)
    {
        //SpeakString("PosState == 1");
        if(GetDistanceBetween(OBJECT_SELF, WP3) > 2.0)
        {
            ActionForceMoveToObject(WP3, FALSE, 1.0, 30.0);
            return;
        }
        else
        {
            //ActionForceMoveToObject(WP2, FALSE, 1.0, 30.0);
            SetLocalInt(OBJECT_SELF, "PosState",3);
            return;
        }
    }

    if(PosState == 2)
    {
        //SpeakString("PosState == 2");
      if(GetDistanceBetween(OBJECT_SELF, WP2) > 2.0)
        {
            ActionForceMoveToObject(WP2, FALSE, 1.0, 30.0);
            return;
        }
        else
        {
            SetLocalInt(OBJECT_SELF, "PosState",3);
            return;
        }
    }

    if(PosState == 3)
    {
        //SpeakString("PosState == 3");
        ClearAllActions();
        int x = d10(1);
        object Chair = GetNearestObjectByTag("Chair_redstag", OBJECT_SELF, x);
        int z = 0;
        if(x == 10)
        {
            ActionForceMoveToObject(WP3, FALSE, 1.0, 30.0);
            SetLocalInt(OBJECT_SELF, "PosState",10);
            //SpeakString("Walk out door");
            return;
        }

        while(z != 1)
        {
            if(Chair != OBJECT_INVALID && !GetIsObjectValid(GetSittingCreature(Chair)))
            {
               //effect Walk = EffectMovementSpeedDecrease(50);
               //ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, OBJECT_SELF);

               //AssignCommand(OBJECT_SELF, ActionInteractObject(Chair));
               //This is new


                location ChairLoc = GetLocation(Chair);
                float facing = GetFacingFromLocation(ChairLoc);
                vector CVector = GetPosition(Chair);
                float x = CVector.x;
                float y = CVector.y;

                x = x + 2 *(sin(facing));
                y = y + 2 *(cos(facing));

                location NewLoc = Location(GetArea(Chair), Vector(x,y,0.0), facing);

                SetLocalInt(OBJECT_SELF, "PosState",15);
                SetLocalObject(OBJECT_SELF, "SitChair", Chair);
                SetLocalLocation(OBJECT_SELF, "ChairLoc", NewLoc);
               //////////////////////////////
               z = 1;
               //SpeakString("Chair found");
               //SpeakString(IntToString(x));
               return;
            }
                x = d6(1);
                object Chair = GetNearestObjectByTag("Chair_redstag", OBJECT_SELF, x);
                //SpeakString("Chair not found");
        }
    }

    if(PosState == 4)
    {
       //SpeakString("PosState == 4");
       int Time = GetLocalInt(OBJECT_SELF,"ChairLookingTime");

       if(GetLocalInt(OBJECT_SELF, "IsSitting") == 1)
       {
            SetLocalInt(OBJECT_SELF, "PosState", 5);
            return;
       }

            if(Time > 4)
            {
                ClearAllActions();
                //effect Walk2 = EffectMovementSpeedIncrease(99);
                //ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk2, OBJECT_SELF);
                SetLocalInt(OBJECT_SELF,"ChairLookingTime", 0);
                SetLocalInt(OBJECT_SELF, "PosState",6);
                //SpeakString("lookign for a new chair");
            }
            else
            {
                int Time2 = Time + 1;
                SetLocalInt(OBJECT_SELF,"ChairLookingTime", Time2);
                //SpeakString("Looking for a new chair int incremented by 1");
            }

    }

    if(PosState == 5)
    {
        int SittingTime = GetLocalInt(OBJECT_SELF,"ChairSittingTime");
        int randTime = d100(1);

        if(SittingTime + randTime > 150)
        {
          ClearAllActions();

          int u = d2(1);

          if(u == 1)
          {
           // Go back upstairs
            SetLocalInt(OBJECT_SELF, "PosState",7);
            //effect Walk2 = EffectMovementSpeedIncrease(99);
            //ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk2, OBJECT_SELF);
            return;
          }
          if(u == 2)
          {
            // go get a drink come back
            SetLocalInt(OBJECT_SELF, "PosState",10);
            //effect Walk2 = EffectMovementSpeedIncrease(99);
            //ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk2, OBJECT_SELF);
            return;
          }

        }
        else
        {
         SittingTime = SittingTime +1;
         SetLocalInt(OBJECT_SELF,"ChairSittingTime", SittingTime);
        }

        object Chair = GetNearestObjectByTag("Chair_redstag", OBJECT_SELF, 1);
        AssignCommand(OBJECT_SELF, ActionInteractObject(Chair));

    }

    if(PosState == 6)
    {
        //SpeakString("PosState == 6");
        object WP4 = GetLocalObject(OBJECT_SELF, "NewChairWP");
        int q;

        if(WP4 == OBJECT_INVALID)
        {
           //this var is a means of changing up which wp the npc goes to to try to make it more realisticly choose a chair
            q = GetLocalInt(OBJECT_SELF, "WPchooser");
            q = q +1;
            if(q > 3)
            {
                q = 1;
            }
            SetLocalInt(OBJECT_SELF, "WPchooser",q);

            WP4 = GetNearestObjectByTag("RedStag_WP4", OBJECT_SELF, q);
            SetLocalObject(OBJECT_SELF, "NewChairWP", WP4);
        }

        if(GetDistanceBetween(OBJECT_SELF, WP4) > 1.0)
        {
            StateTime6 = StateTime6 + 1;
            if(StateTime6 > 10)
            {
             DestroyObject(OBJECT_SELF, 0.01);
            }
            ActionForceMoveToObject(WP4, FALSE, 1.0, 30.0);
            SetLocalInt(OBJECT_SELF,"StateTime6", StateTime6);
            return;
        }
        else
        {
            SetLocalObject(OBJECT_SELF, "NewChairWP", WP4);
            SetLocalInt(OBJECT_SELF, "PosState",3);
            SetLocalInt(OBJECT_SELF,"StateTime6", 0);
            return;
        }
    }

    if(PosState == 7)
    {
       ClearAllActions();
       if(GetDistanceBetween(OBJECT_SELF, WP2) > 2.0)
        {
            ActionForceMoveToObject(WP2, FALSE, 1.0, 30.0);
            return;
        }
        else
        {
           SetLocalInt(OBJECT_SELF, "PosState",8);
           return;
        }
    }

    if(PosState == 8)
    {
       ClearAllActions();
       if(GetDistanceBetween(OBJECT_SELF, WP1) > 2.0)
        {
            ActionForceMoveToObject(WP1, FALSE, 1.0, 30.0);
            return;
        }
        else
        {
           SetLocalInt(OBJECT_SELF, "PosState",9);
           return;
        }
    }

    if(PosState == 9)
    {
       ClearAllActions();
       if(GetDistanceBetween(OBJECT_SELF, WP5) > 2.0)
        {
            ActionForceMoveToObject(WP5, FALSE, 1.0, 30.0);
            return;
        }
        else
        {
           DestroyObject(OBJECT_SELF, 0.1);
        }
    }

    if(PosState == 10)
    {
       ClearAllActions();
       if(GetDistanceBetween(OBJECT_SELF, WP3) > 2.0)
        {
            ActionForceMoveToObject(WP3, FALSE, 1.0, 30.0);
            return;
        }
        else
        {
          SetLocalInt(OBJECT_SELF, "PosState",11);
        }
    }
    if(PosState == 11)
    {
       ClearAllActions();
       if(GetDistanceBetween(OBJECT_SELF, WP6) > 2.0)
        {
            ActionForceMoveToObject(WP6, FALSE, 1.0, 30.0);
            return;
        }
        else
        {
          DestroyObject(OBJECT_SELF, 0.1);
        }
    }

    if(PosState == 15)
    {
        location WalkLoc = GetLocalLocation(OBJECT_SELF, "ChairLoc");

        if(GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), WalkLoc) > 2.0)
        {
           ActionForceMoveToLocation(WalkLoc, FALSE, 30.0);
           return;
        }
        else
        {
          SetLocalInt(OBJECT_SELF, "PosState",16);
        }
    }

    if(PosState == 16)
    {
        //SpeakString("Trying to sit");
        AssignCommand(OBJECT_SELF, ActionInteractObject(GetLocalObject(OBJECT_SELF, "SitChair")));
        SetLocalInt(OBJECT_SELF, "PosState", 4);
    }

}
