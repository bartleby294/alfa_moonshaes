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

    //this is an interupter so that if you wanted to add a convo to the farmer you could
    //you just need to have him change the oxes on convo state to 1 when it starts and the ox will stop
    //when the convo ends change the state to 0 again and the ox will move
    if(GetLocalInt(OBJECT_SELF, "convostate") != 0)
    {
       ClearAllActions();
    }

    object WP8 = GetNearestObjectByTag("PlowOx8WP", OBJECT_SELF);
    object WP7 = GetNearestObjectByTag("PlowOx7WP", OBJECT_SELF);
    object WP6 = GetNearestObjectByTag("PlowOx6WP", OBJECT_SELF);
    object WP5 = GetNearestObjectByTag("PlowOx5WP", OBJECT_SELF);
    object WP4 = GetNearestObjectByTag("PlowOx4WP", OBJECT_SELF);
    object WP3 = GetNearestObjectByTag("PlowOx3WP", OBJECT_SELF);
    object WP2 = GetNearestObjectByTag("PlowOx2WP", OBJECT_SELF);
    object WP1 = GetNearestObjectByTag("PlowOx1WP", OBJECT_SELF);

    int PlowState = GetLocalInt(OBJECT_SELF, "PlowState");
    int PlowStop = GetLocalInt(OBJECT_SELF, "PlowStop");
    int PlowStop2 =  PlowStop + 1;

// Detects and keeps track of where the plow is going and will update its actions acordingly
    if(PlowStop == 2)
    {
        SetLocalInt(OBJECT_SELF, "PlowStop", 0);
        ClearAllActions();
        return;
    }

    if(PlowState ==0)
    {
       ActionForceMoveToObject(WP2, FALSE, 1.0, 30.0);
       SetLocalInt(OBJECT_SELF, "PlowStop", PlowStop2);
       if(GetDistanceBetween(OBJECT_SELF, WP2) < 1.0)
       {
            SetLocalInt(OBJECT_SELF, "PlowState", 1);
       }
    }

    if(PlowState ==1)
    {
      ActionForceMoveToObject(WP3, FALSE, 1.0, 30.0);
      SetLocalInt(OBJECT_SELF, "PlowStop", PlowStop2);
       if(GetDistanceBetween(OBJECT_SELF, WP3) < 1.0)
       {
            SetLocalInt(OBJECT_SELF, "PlowState", 2);
       }
    }

    if(PlowState ==2)
    {
       ActionForceMoveToObject(WP4, FALSE, 1.0, 30.0);
       SetLocalInt(OBJECT_SELF, "PlowStop", PlowStop2);
       if(GetDistanceBetween(OBJECT_SELF, WP4) < 1.0)
       {
            SetLocalInt(OBJECT_SELF, "PlowState", 3);
       }
    }

    if(PlowState ==3)
    {
       ActionForceMoveToObject(WP5, FALSE, 1.0, 30.0);
       SetLocalInt(OBJECT_SELF, "PlowStop", PlowStop2);
       if(GetDistanceBetween(OBJECT_SELF, WP5) < 1.0)
       {
            SetLocalInt(OBJECT_SELF, "PlowState", 4);
       }
    }

    if(PlowState ==4)
    {
        ActionForceMoveToObject(WP6, FALSE, 1.0, 30.0);
        SetLocalInt(OBJECT_SELF, "PlowStop", PlowStop2);
       if(GetDistanceBetween(OBJECT_SELF, WP6) < 1.0)
       {
            SetLocalInt(OBJECT_SELF, "PlowState", 5);
       }
    }

    if(PlowState ==5)
    {
         ActionForceMoveToObject(WP7, FALSE, 1.0, 30.0);
         SetLocalInt(OBJECT_SELF, "PlowStop", PlowStop2);
       if(GetDistanceBetween(OBJECT_SELF, WP7) < 1.0)
       {
            SetLocalInt(OBJECT_SELF, "PlowState", 6);
       }
    }

    if(PlowState ==6)
    {
         ActionForceMoveToObject(WP8, FALSE, 1.0, 30.0);
         SetLocalInt(OBJECT_SELF, "PlowStop", PlowStop2);
       if(GetDistanceBetween(OBJECT_SELF, WP8) < 1.0)
       {
            SetLocalInt(OBJECT_SELF, "PlowState", 7);
       }
    }
    if(PlowState ==7)
    {
         ActionForceMoveToObject(WP1, FALSE, 1.0, 30.0);
         SetLocalInt(OBJECT_SELF, "PlowStop", PlowStop2);
       if(GetDistanceBetween(OBJECT_SELF, WP1) < 1.0)
       {
            SetLocalInt(OBJECT_SELF, "PlowState", 0);
       }
    }

}
