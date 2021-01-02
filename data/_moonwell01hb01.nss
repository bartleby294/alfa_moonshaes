#include "nw_i0_generic"

void main()
{
    object voice = GetNearestObjectByTag("ABoomingVoice");

    if(GetLocalInt(OBJECT_SELF, "Moonwell01HBTimer") == 1)
    {
       int StateVar = GetLocalInt(OBJECT_SELF, "StateStorageVar");
       StateVar = StateVar +1;
       SetLocalInt(OBJECT_SELF, "StateStorageVar", StateVar);
       object oPC = GetLocalObject(OBJECT_SELF, "PlayerEnteringGrove");

       // give the PC warnings the PC cumulitively has 36 seconds to step into the light
       if(StateVar == 3)
       {
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("The Green Light Step into it NOW!"));
         AssignCommand(voice, SpeakString("A Booming Echo: The Green Light Step into it NOW!"));
       }
       if(StateVar == 4)
       {
          AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("Step Into the Green Light or we will be forced to attack you!"));
          AssignCommand(voice, SpeakString("A Booming Echo: Step Into the Green Light or we will be forced to attack you!"));
       }
       if(StateVar == 5)
       {
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("This is no joke step into the light!"));
         AssignCommand(voice, SpeakString("A Booming Echo: This is no joke step into the light!"));

       }
       if(StateVar == 6)
       {
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("Step into the green light this is your final warning!"));
         AssignCommand(voice, SpeakString("A Booming Echo: Step into the green light this is your final warning!"));
       }
       if(StateVar == 7)
       {
         //The Druids attack the PC the timer var is rest as is the state var
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("**Frowns and signals the other druids to attack**"));

        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellHighDruid"),STANDARD_FACTION_HOSTILE));
        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid01"),STANDARD_FACTION_HOSTILE));
        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid02"),STANDARD_FACTION_HOSTILE));
        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid03"),STANDARD_FACTION_HOSTILE));
        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid04"),STANDARD_FACTION_HOSTILE));
        AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"),DetermineCombatRound());
        AssignCommand(GetNearestObjectByTag("MoonwellDruid01"),DetermineCombatRound());
        AssignCommand(GetNearestObjectByTag("MoonwellDruid02"),DetermineCombatRound());
        AssignCommand(GetNearestObjectByTag("MoonwellDruid03"),DetermineCombatRound());
        AssignCommand(GetNearestObjectByTag("MoonwellDruid04"),DetermineCombatRound());

         SetLocalInt(OBJECT_SELF, "StateStorageVar", 0);
         SetLocalInt(OBJECT_SELF, "Moonwell01HBTimer", 5);
       }
    }

    if(GetLocalInt(OBJECT_SELF, "Moonwell01HBTimer") == 2)
    {
       int StateVar = GetLocalInt(OBJECT_SELF, "StateStorageVar2");
       StateVar = StateVar +1;
       SetLocalInt(OBJECT_SELF, "StateStorageVar2", StateVar);

       AssignCommand(voice, SpeakString(IntToString(StateVar)));

       if(StateVar > 20)
       {
            SetLocalInt(OBJECT_SELF, "Moonwell01Trigger01", 0);
            SetLocalInt(OBJECT_SELF, "Moonwell01HBTimer", 0);
            SetLocalInt(OBJECT_SELF, "StateStorageVar2", 0);
       }
    }

    if(GetLocalInt(OBJECT_SELF, "Moonwell01HBTimer") == 3)
     {
       int StateVar = GetLocalInt(OBJECT_SELF, "StateStorageVar3");
       SetLocalInt(OBJECT_SELF, "StateVar", 0);
       StateVar = StateVar +1;
       object oPC = GetLocalObject(OBJECT_SELF, "PlayerEnteringGrove");

       // give the PC warnings the PC cumulitively has 36 seconds to step into the light
       if(StateVar == 1)
       {
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("Im warning you LEAVE THIS PLACE! OR FACE THE CONSEQUENCES!"));
         AssignCommand(voice, SpeakString("A Booming Echo: Im warning you LEAVE THIS PLACE!  OR FACE THE CONSEQUENCES!"));
       }
       if(StateVar == 2)
       {
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("Im warning you LEAVE THIS PLACE! OR FACE THE CONSEQUENCES!"));
        AssignCommand(voice, SpeakString("A Booming Echo: Im warning you LEAVE THIS PLACE!  OR FACE THE CONSEQUENCES!"));
       }
       if(StateVar == 3)
       {
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("Im warning you LEAVE THIS PLACE! OR FACE THE CONSEQUENCES!"));
         AssignCommand(voice, SpeakString("A Booming Echo: Im warning you LEAVE THIS PLACE!  OR FACE THE CONSEQUENCES!"));
       }
       if(StateVar == 4)
       {
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("Im warning you LEAVE THIS PLACE! OR FACE THE CONSEQUENCES!"));
        AssignCommand(voice, SpeakString("A Booming Echo: Im warning you LEAVE THIS PLACE!  OR FACE THE CONSEQUENCES!"));
       }
       if(StateVar == 5)
       {
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("Im warning you LEAVE THIS PLACE! OR FACE THE CONSEQUENCES!"));
         AssignCommand(voice, SpeakString("A Booming Echo: Im warning you LEAVE THIS PLACE!  OR FACE THE CONSEQUENCES!"));
       }
       if(StateVar == 6)
       {
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("Im warning you LEAVE THIS PLACE! OR FACE THE CONSEQUENCES!"));
         AssignCommand(voice, SpeakString("A Booming Echo: Im warning you LEAVE THIS PLACE!  OR FACE THE CONSEQUENCES!"));
       }
       if(StateVar == 7)
       {
         //The Druids attack the PC the timer var is rest as is the state var
         AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("**Frowns and signals the other druids to attack**"));

        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellHighDruid"),STANDARD_FACTION_HOSTILE));
        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid01"),STANDARD_FACTION_HOSTILE));
        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid02"),STANDARD_FACTION_HOSTILE));
        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid03"),STANDARD_FACTION_HOSTILE));
        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid04"),STANDARD_FACTION_HOSTILE));
        AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"),DetermineCombatRound());
        AssignCommand(GetNearestObjectByTag("MoonwellDruid01"),DetermineCombatRound());
        AssignCommand(GetNearestObjectByTag("MoonwellDruid02"),DetermineCombatRound());
        AssignCommand(GetNearestObjectByTag("MoonwellDruid03"),DetermineCombatRound());
        AssignCommand(GetNearestObjectByTag("MoonwellDruid04"),DetermineCombatRound());

         SetLocalInt(OBJECT_SELF, "StateStorageVar3", 0);
         SetLocalInt(OBJECT_SELF, "Moonwell01HBTimer", 5);
       }
   }
//    {
//      int StateVar = GetLocalInt(OBJECT_SELF, "StateStorageVar3");
  //    object oPC = GetLocalObject(OBJECT_SELF, "PlayerEnteringGrove");
    //  object voice = GetNearestObjectByTag("ABoomingVoice");
    //  StateVar = StateVar + 1;

//      AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"), SpeakString("Im warning you LEAVE THIS PLACE! OR FACE THE CONSEQUENCES!"));
  //    AssignCommand(voice, SpeakString("A Booming Echo: Im warning you LEAVE THIS PLACE!  OR FACE THE CONSEQUENCES!"));

    //  if(StateVar == 7)
      //{
//        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellHighDruid"),STANDARD_FACTION_HOSTILE));
  //      AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid01"),STANDARD_FACTION_HOSTILE));
    //    AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid02"),STANDARD_FACTION_HOSTILE));
      //  AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid03"),STANDARD_FACTION_HOSTILE));
//        AssignCommand(voice, ChangeToStandardFaction(GetNearestObjectByTag("MoonwellDruid04"),STANDARD_FACTION_HOSTILE));
  //      AssignCommand(GetNearestObjectByTag("MoonwellHighDruid"),DetermineCombatRound());
    //    AssignCommand(GetNearestObjectByTag("MoonwellDruid01"),DetermineCombatRound());
      //  AssignCommand(GetNearestObjectByTag("MoonwellDruid02"),DetermineCombatRound());
        //AssignCommand(GetNearestObjectByTag("MoonwellDruid03"),DetermineCombatRound());
//        AssignCommand(GetNearestObjectByTag("MoonwellDruid04"),DetermineCombatRound());

//        SetLocalInt(OBJECT_SELF, "StateStorageVar3", 0);
//        SetLocalInt(OBJECT_SELF, "Moonwell01HBTimer", 5);
//        return;
//      }



    if(GetLocalInt(OBJECT_SELF, "Moonwell01HBTimer") == 4)
    {
        object HighDruid = GetNearestObjectByTag("MoonwellHighDruid");
        object HighDruidSpawnWP = GetNearestObjectByTag("High_Druid_Spawn01");

        AssignCommand(HighDruid, ClearAllActions());
        effect Walk2 = EffectMovementSpeedDecrease(0);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk2, HighDruid);

        AssignCommand(HighDruid, ActionMoveToObject(HighDruidSpawnWP, FALSE,1.0));
        DestroyObject(HighDruid, 16.0);

        DelayCommand(15.0, AssignCommand(HighDruid, SpeakString("Disappears into forest")));

        SetLocalInt(OBJECT_SELF, "Moonwell01HBTimer", 2);
    }

    if(GetLocalInt(OBJECT_SELF, "Moonwell01HBTimer") == 5)
    {
        if(CheckEnemyGroupingOnTarget(GetNearestObjectByTag("MoonwellHighDruid"), 80.0) == 0)
        {
            ExecuteScript("_moonwell01leav1", OBJECT_SELF);
        }

    }
}
