//::///////////////////////////////////////////////
//:://////////////////////////////////////////////
/*
    Woodcuter Heartbeat script

    This script will have an npc carry out actions that make it
    look like hes cutting and putting away wood
*/
//:://////////////////////////////////////////////
//:: Created By: bart
//:: Created On: Dec 12/05
//:://////////////////////////////////////////////

void main()
{
    ExecuteScript("nw_c2_default1", OBJECT_SELF);

    //change these to specific tags or use a getnearestobjectbytag
    object WP1 = GetNearestObjectByTag("_h_woodcutter1", OBJECT_SELF, 1);
    object WP2 = GetNearestObjectByTag("_h_woodcutter2", OBJECT_SELF, 1);
    object WP3 = GetNearestObjectByTag("_h_woodcutter3", OBJECT_SELF, 1);
    object soundobj =  GetObjectByTag("_woodblock");

    int State = GetLocalInt(OBJECT_SELF, "woodcutterstate1");
    // if woodcutstate = 0, cut wood
    // if woodcutstate = 1, move to wp2 pick up wood
    // if woodcutstate = 2, move to wp3 set wood down

    //if hes gathering wood
    if(State == 1)
    {
        if( GetLocalInt(OBJECT_SELF, "timestate") == 0)
        {
            ClearAllActions();
            ActionMoveToObject(WP2, FALSE, 0.0);
            SetFacing(GetFacing(WP2));
            DelayCommand(4.0, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
            SetLocalInt(OBJECT_SELF, "timestate", 1);
            FloatingTextStringOnCreature("**Picks up split wood**", OBJECT_SELF, TRUE);
            return;
        }

        //The time state variable is used for timeing.  If you need a longer period of time
        //in between npc actions then make more timestate steps as filler.
        if( GetLocalInt(OBJECT_SELF, "timestate") == 1)
        {
            ClearAllActions();
            SetLocalInt(OBJECT_SELF, "woodcutterstate1", 2);
            SetLocalInt(OBJECT_SELF, "timestate", 0);
            return;
        }
    }
    //if hes putting wood away
    if(State == 2)
    {
        if( GetLocalInt(OBJECT_SELF, "timestate") == 0)
        {
            ClearAllActions();
            ActionMoveToObject(WP3, FALSE, 0.0);
            SetFacing(GetFacing(WP3));
            DelayCommand(4.0, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
            SetLocalInt(OBJECT_SELF, "timestate", 1);
            FloatingTextStringOnCreature("**Puts wood down**", OBJECT_SELF, TRUE);
            return;
        }

        if( GetLocalInt(OBJECT_SELF, "timestate") == 1)
        {
            ClearAllActions();
            SetLocalInt(OBJECT_SELF, "woodcutterstate1", 0);
            SetLocalInt(OBJECT_SELF, "timestate", 0);
            return;
        }
    }
    // if first time script run or if he just finished putting wood away.
    if(State == 0 || (State != 1 && State != 2))
    {
        //this will check or initialize time state
        if( GetLocalInt(OBJECT_SELF, "timestate") == 0 || (GetLocalInt(OBJECT_SELF, "timestate") != 1 && GetLocalInt(OBJECT_SELF, "timestate") != 2))
        {
            ClearAllActions();
            ActionMoveToLocation(GetLocation(WP1), FALSE);

            if(GetFacing(OBJECT_SELF) == 90.0)
            {
                DelayCommand(4.1,SoundObjectPlay(soundobj));
                DelayCommand(2.0, ActionPlayAnimation(29, 1.0, 20.0));
                SetLocalInt(OBJECT_SELF, "timestate", 1);
                FloatingTextStringOnCreature("**Splits wood**", OBJECT_SELF, TRUE);
                return;
            }
            else
            {
                DelayCommand(0.1, SetFacing(90.0));
                FloatingTextStringOnCreature("**Sets a peice of wood on block**", OBJECT_SELF, TRUE);
                return;
            }
         }

        if( GetLocalInt(OBJECT_SELF, "timestate") == 1)
        {
            SetLocalInt(OBJECT_SELF, "timestate", 2);
            return;
        }

        if( GetLocalInt(OBJECT_SELF, "timestate") == 2)
        {
            SetLocalInt(OBJECT_SELF, "woodcutterstate1", 1);
            SetLocalInt(OBJECT_SELF, "timestate", 0);
            SoundObjectStop(soundobj);
            return;
        }
    }

}
