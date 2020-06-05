//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
    modified heartbeat script to dictate actions of lilia in skaug pirate town
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    ExecuteScript("nw_c2_default1", OBJECT_SELF);

// Placement markers to walk to
    object WP1 = GetObjectByTag("_skaug_t01_f");
    object WP2 = GetObjectByTag("_skaug_t02_f");
    object WP3 = GetObjectByTag("_skaug_t03_f");
    object WP4 = GetObjectByTag("_skaug_t02_b");

// main player of script
    object Lilia = OBJECT_SELF;


// keeps track of where to go
    object GoToWP;

// the victems to be whiped
    object victem1 = GetObjectByTag("_TortureVictem01");
    object victem2 = GetObjectByTag("_TortureVictem02");
    object victem3 = GetObjectByTag("_TortureVictem03");

//conversation variable if =1 then in convo true if = 0 then not in convo
    int conState = GetLocalInt(Lilia, "conState");
// Whip variable if shes in the process of whiping someone then =1 else =0
    int whipState = GetLocalInt(Lilia, "whipState");
//Position variable keeps track of where she is
    int posState = GetLocalInt(Lilia, "posState");
//Tells you if the victem has been whiped yet
    int whipedYet = GetLocalInt(Lilia, "whipedYet");


    int randNum = d4(1);

    if( conState != 1)
    {

        if(whipState !=1)
        {
             ExecuteScript("_s_lilia04", Lilia);

            //do nothing
            if(randNum == 1)
            {
               return;
            }
            //taunt
            if(randNum == 2)
            {
               ExecuteScript("_s_lilia04", Lilia);
            }
            //whip someone
            if(randNum == 3|| randNum == 4)
            {

                 //randomly selects next target
                    int randNum2 = d3(1);
                        // sets whipstate to true
                            SetLocalInt(Lilia, "whipState", 1);


                //stores who to whip
                if(randNum2 == 1)
                {
                   SetLocalObject(Lilia, "Whiped", victem1);
                }
                if(randNum2 == 2)
                {
                   SetLocalObject(Lilia, "Whiped", victem2);
                }
                if(randNum2 == 3)
                {
                   SetLocalObject(Lilia, "Whiped", victem3);
                }

                return;
            }
         }

           // IF WHIP STATE == 1
        if(whipState == 1)
        {

           //If shes not next to the person shes going to whip find out who to go to and go there
                if( posState != 1)
                {

                    if(GetLocalObject(Lilia, "Whiped") ==  victem1)
                    {
                        GoToWP = WP1;
                    }
                    if(GetLocalObject(Lilia, "Whiped") ==  victem2)
                    {
                        GoToWP = WP2;
                    }
                    if(GetLocalObject(Lilia, "Whiped") ==  victem3)
                    {
                        GoToWP = WP3;
                    }
                    ExecuteScript("_s_lilia04", Lilia);
                    AssignCommand(Lilia, ActionForceMoveToObject(GoToWP, FALSE, 1.0, 30.0));
                    SetLocalInt(Lilia, "posState", 1);
                    return;
                }

                //if she is next to the person shes going to whip find out if shes whiped him yet if no whip if yes go to home
                if( posState == 1)
                {
                    //whip
                    if(whipedYet != 1)
                    {
                       AssignCommand(Lilia, ActionAttack(GetLocalObject(Lilia, "Whiped"), FALSE));
                       SetLocalInt(Lilia, "whipedYet", 1);
                       DelayCommand(4.0, AssignCommand(Lilia, ClearAllActions(TRUE)));
                       return;
                    }
                    //move
                    if(whipedYet == 1)
                    {
                        AssignCommand(Lilia, ActionForceMoveToObject(WP4, FALSE, 1.0, 30.0));
                        DelayCommand(4.0, AssignCommand(Lilia, SetFacing(90.0)));
                        SetLocalInt(Lilia, "posState", 0);
                        SetLocalInt(Lilia, "whipedYet", 0);
                        SetLocalInt(Lilia, "whipState", 0);
                        return;
                    }
                }

           }

    }
}
