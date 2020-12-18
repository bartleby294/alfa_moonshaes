//::///////////////////////////////////////////////
//:: Name x2_def_percept
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Perception script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{

      object oNoticed = GetLastPerceived();

    SetLocalObject(OBJECT_SELF, "spooker", oNoticed);

    // over rides everything if theres combat
    if(GetLocalInt(OBJECT_SELF, "isattacked") == 1)
    {
        ActionMoveAwayFromObject(oNoticed, TRUE, 300.0);
        return;
    }
        // if no combat then check to see if it was spooked


    if(GetStealthMode(oNoticed) == STEALTH_MODE_ACTIVATED)
    {
        if(!GetIsSkillSuccessful(oNoticed, SKILL_MOVE_SILENTLY, 10))
        {

                SetLocalInt(OBJECT_SELF, "spooked", 1);

            if(GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH) == TRUE)
            {
               SetActionMode(OBJECT_SELF,ACTION_MODE_STEALTH, FALSE);
            }

            ActionMoveAwayFromObject(oNoticed, TRUE, 300.0);
            return;
       }

       if(!GetIsSkillSuccessful(oNoticed, SKILL_HIDE, 10))
       {

            SetLocalInt(OBJECT_SELF, "spooked", 1);

            if(GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH) == TRUE)
            {
               SetActionMode(OBJECT_SELF,ACTION_MODE_STEALTH, FALSE);
            }

            ActionMoveAwayFromObject(oNoticed, TRUE, 300.0);
            return;

        }
    }

    else
    {
        ActionMoveAwayFromObject(oNoticed, TRUE, 300.0);

        if(GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH) == TRUE)
            {
               SetActionMode(OBJECT_SELF,ACTION_MODE_STEALTH, FALSE);
            }
        return;
    }

    ExecuteScript("nw_c2_default2", OBJECT_SELF);
}
