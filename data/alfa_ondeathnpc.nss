
/******************************************************************
 * Name: alfa_ondeath   ((replaced with JAI/ALFA injected code, Ron Letourneau))
 * Type: OnPlayerDeath
 * ---
 * Author: Modal
 * Date: 08/30/02
 * ---
 * This handles the module OnPlayerDeath event.
 * You can add custom code in the appropriate section, as well as
 * in alfa_userdef.
 ******************************************************************/
// OnDeath
// Speeded up no end, when compiling, with seperate Include.
// I have witnessed no errors, so -Working-
// Cleans up all un-droppable items, all ints and all local things when destroyed.
#include "j_inc_ondeath"
#include "subraces"
#include "alfa_deathnotify"

void main()
{
    int iDeathEffect = GetLocalInt(OBJECT_SELF, "AI_DEATH_VISUAL_EFFECT");
    if(iDeathEffect > 0)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(iDeathEffect), GetLocation(OBJECT_SELF));
    }
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(GetLevelByClass(CLASS_TYPE_COMMONER) > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        object oKiller = GetLastKiller();
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }
    // Always shout when we are attacked, if not fighting.
    SpeakString("I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
    // Speaks the set death speak.
    string sDeathString = GetLocalString(OBJECT_SELF, "AI_TALK_ON_DEATH");
    if(sDeathString != "")
        SpeakString(sDeathString);

    // Sets that we should die. Used in the check.
    SetLocalInt(OBJECT_SELF, "IS_DEAD", TRUE);
    // We will actually dissapear after 30.0 seconds if not raised.
    int iTime = GetLocalInt(OBJECT_SELF, "AI_CORPSE_DESTROY_TIME");
    if(iTime > 0)
    {   DelayCommand(IntToFloat(iTime), DeathCheck());   }
    else
    {   DelayCommand(30.0, DeathCheck()); iTime = 30;    }

    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    // SEI_NOTE: Reward experience for killing this creature.
    XP_RewardXPForKill();

    // Tell spawn system of the creature's demise.  Each spawn system provides
    // its own implementation of this function in alfa_deathnotify
    ALFA_DeathNotifySpawner(OBJECT_SELF);

    // Ensure that the corpses are destroyable. Jasperre sets to undestroyable.
    // Gets rid of perma corpses. (Thanks Cereborn!)
    SetIsDestroyable(TRUE, FALSE, FALSE);

    // ********************* KILL TASK CODE ***********************
    // initialise local variables
   // int    nKillFlag = GetLocalInt(GetLastKiller(), "KILL_TASK_FLAG");
   // object oPC = GetLastKiller();

   // int    nKilled = GetLocalInt(oPC, "KILL_TASK_KILLED");
   // int    nKillNumber = GetLocalInt(oPC, "KILL_TASK_NUMBER");

  //  string sKilled;
  //  string sKillNumber = IntToString(nKillNumber);

  //  string sTagSelf = GetTag(OBJECT_SELF);
  //  string sTagSelfShort = GetStringLeft(sTagSelf, 7);

  //  string sTagTarget = GetLocalString(oPC, "KILL_TASK_TARGET");
  //  string sTagTargetShort = GetStringLeft(sTagTarget, 7);

    // check for correct kill task target and increase number killed by one
  //  if(sTagSelfShort == sTagTargetShort && nKillFlag == 1)
 //   {
   //     nKilled = nKilled +1;
    //    SetLocalInt(oPC, "KILL_TASK_KILLED", nKilled);

        // inform player how many killed if they have not killed enough
     //   if(sTagSelfShort == sTagTargetShort && nKillFlag == 1 && nKilled < nKillNumber)
    //    {
      //      string sKilled = IntToString(nKilled);

     //       FloatingTextStringOnCreature("You have killed " + sKilled + " of " + sKillNumber + " tasked " + sTagSelf + "'s so far.", oPC, FALSE);
     //   }

        // check for correct kill task target and complete
     //   else if(sTagSelfShort == sTagTargetShort && nKillFlag == 1 && nKilled >= nKillNumber)
     //   {
     //       SetLocalInt(oPC, "KILL_TASK_FLAG", 2);
    //        AddJournalQuestEntry("kt_journal_01", 99, oPC);
     //   }

        // if player has killed more than enough creatures, send them back to the PD's
    //    else
    //    {
    //        FloatingTextStringOnCreature("You should report back to the Purple Dragons.  You have completed the task they assigned to you.", oPC, FALSE);
    //    }
   // }
    // ********************* KILL TASK CODE ***********************
}
