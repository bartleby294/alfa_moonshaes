//borrowed tag script Im lazy so sue me.


//tag-playing children by Ralf Schemmann
//July 17th, 2002
//
//Minor additions by Elhimac
//Updated 22 July 2002
//
//if owner is chasing
void main()
{
    int nUser = GetUserDefinedEventNumber();

        if(GetIsNight())
        {
            return;

        }
        if(GetIsDusk())
        {
            return;

        }


    if(nUser == 1001) //HEARTBEAT EVENT
    {
        object oPlayground = GetWaypointByTag("KidTagCenter");
        object oTagArea = GetWaypointByTag("TagArea"+IntToString(Random(4)));

        //checks to see if its night if its night and the children arent goign home it tells them to go home and despawn.


            if (GetDistanceToObject(oPlayground) > 6.0f)
            {
                ClearAllActions();
                ActionForceMoveToObject(oTagArea,TRUE, 0.0f);
            }
            if (GetDistanceToObject(oPlayground) < 6.0f)
            {
                if (GetLocalInt(OBJECT_SELF, "nChasing") == 1)
                {
                    //Find kid to chase
                    object oChased = GetNearestObjectByTag("TAGCHILD");
                    //Is owner close enough to tag?
                    if (GetDistanceToObject(oChased) < 2.0f )
                    {
                        //Tag and switch roles
                        SpeakString("Tag!", TALKVOLUME_TALK);
                        AssignCommand(oChased, ClearAllActions());
                        SetLocalInt(OBJECT_SELF, "nChasing", 0);
                        SetLocalInt(oChased, "nTagged", 1);
                        //RemoveEffect(OBJECT_SELF, EffectHaste());
                        ClearAllActions();
                        ActionMoveAwayFromObject(oChased, TRUE);
                    }
                    //if still too far away, move after target
                    else
                    {
                        ActionForceMoveToObject(oChased, TRUE, 0.0f);
                    }
                }
                //owner is being chased
                else
                {
                //If kid has been tagged, wait a hearbeat then start chasing
                if (GetLocalInt(OBJECT_SELF, "nTagged") == 1)
                {
                    SetLocalInt(OBJECT_SELF, "nTagged", 0);
                    SetLocalInt(OBJECT_SELF, "nChasing", 1);
                    //ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHaste(), OBJECT_SELF);
                }
                //if not been tagged, run away from chaser or move closer to other kids
                else
                {
                        //Find Nearest tag-playing child
                        object oChaser = GetNearestObjectByTag("TAGCHILD");
                        //if this is the chaser
                        if (GetLocalInt(oChaser, "nChasing") == 1)
                            //run away from chaser
                            ActionMoveAwayFromObject(oChaser, TRUE);
                        else
                            //run after other kid
                            ActionForceMoveToObject(oChaser, TRUE, 4.0f);
                }
        }
}
}
}

