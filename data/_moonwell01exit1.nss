void main()
{
    object oPC = GetExitingObject();

    object HighDruidStandWP = GetNearestObjectByTag("High_Druid_Stand01");
    object HighDruidSpawnWP = GetNearestObjectByTag("High_Druid_Spawn01");

    object Druid01StandWP = GetNearestObjectByTag("Druid01_Stand01");
    object Druid01SpawnWP = GetNearestObjectByTag("Druid01_Spawn01");

    object Druid02StandWP = GetNearestObjectByTag("Druid02_Stand01");
    object Druid02SpawnWP = GetNearestObjectByTag("Druid02_Spawn01");

    object Druid03StandWP = GetNearestObjectByTag("Druid03_Stand01");
    object Druid04StandWP = GetNearestObjectByTag("Druid04_Stand01");

    object DruidLight = GetNearestObjectByTag("Druid_Light_WP1");
    object OnHBObj = GetNearestObjectByTag("Moonwell01OnHBObj");
    // if moonwelltrigger == 0 then start the sceen ... This Var is stored on the on heartbeat rock
    if(GetLocalInt(OnHBObj, "Moonwell01Trigger01") == 0)
    {
        //Setting the timer on the stone or other object in the area with the apropriate tag
        //This object will run an on heart beat script that will tell the player they only have
        //a certain amount of time to step into the light.  If they take too long they will be
        //attacked
        //The on heartbeat script will also serve to reset the timmer for the event
        //The condition of the event taking place is time related not PC related.
        SetLocalInt(OnHBObj, "Moonwell01HBTimer", 1);
        SetLocalInt(OnHBObj, "Moonwell01Trigger01", 1);
        SetLocalInt(OnHBObj, "Moonwell01Trigger02", 0);
        SetLocalObject(OnHBObj, "PlayerEnteringGrove", oPC);

        //Spawns the druids in
        object HighDruid = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid", GetLocation(HighDruidSpawnWP));
        object Druid01 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid001", GetLocation(Druid01SpawnWP));
        object Druid02 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid002", GetLocation(Druid02SpawnWP));
        object Druid03 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid003", GetLocation(Druid03StandWP));
        object Druid04 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid004", GetLocation(Druid04StandWP));
        //Tells them to start walking
        AssignCommand(HighDruid, ActionMoveToObject(HighDruidStandWP, FALSE, 1.0));
        AssignCommand(Druid01, ActionMoveToObject(Druid01StandWP, FALSE, 1.0));
        AssignCommand(Druid02, ActionMoveToObject(Druid02StandWP, FALSE, 1.0));

        //This goes through to see if there is a druid in the party
        //If there is the High druid will address the druid of the party
        //It will also check to see if he knows the druid or other char if he does then another convo will trigger.
        // convo state = 0 -> no instructions
        // convo state = 1 -> theres a druid convo
        // convo state = 2 -> theres a druid i know convo
        // convo state = 3 -> theres someone that isnt a druid and i dont know them.
        object PartyMember = GetFactionLeader(oPC);
        while(PartyMember != OBJECT_INVALID)
        {
             if(GetClassByPosition(1, PartyMember) == CLASS_TYPE_DRUID)
            {
                if(GetLocalInt(PartyMember, "Moonwell01Known") == 1)
                {
                   //Execute I know you Druid Hello
                   //BeginConversation("_moonpool01con02", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 2);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con02", FALSE, FALSE));
                    return;
                }
                //Execute Druid Hello
                //BeginConversation("_moonpool01con03", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 1);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con03", FALSE, FALSE));
                return;
            }
             if(GetClassByPosition(2, PartyMember) == CLASS_TYPE_DRUID)
            {
                if(GetLocalInt(PartyMember, "Moonwell01Known") == 1)
                {
                  //Execute I know you Druid Hello
                  //BeginConversation("_moonpool01con02", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 2);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con02", FALSE, FALSE));
                  return;
                }
                //Execute Druid Hello
                //BeginConversation("_moonpool01con03", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 1);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con03", FALSE, FALSE));
                return;
            }
             if(GetClassByPosition(3, PartyMember) == CLASS_TYPE_DRUID)
            {
                if(GetLocalInt(PartyMember, "Moonwell01Known") == 1)
                {
                  //Execute I know you Druid Hello
                  //BeginConversation("_moonpool01con02", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 2);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con02", FALSE, FALSE));
                  return;
                }
                //Execute Druid Hello
                //BeginConversation("_moonpool01con03", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 1);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con03", FALSE, FALSE));
                return;
            }


         PartyMember = GetNextFactionMember( PartyMember,TRUE);
        }

       //Create shaft of light and store the object to the stone for deletion later
       object Light = CreateObject(OBJECT_TYPE_PLACEABLE, "alfa_shaftligt6", GetLocation(DruidLight));
       SetLocalObject(OnHBObj, "lightobject", Light);

        AssignCommand(HighDruid, DelayCommand(12.0, SpeakString("Step Into The Light!")));
        return;


    }



}
