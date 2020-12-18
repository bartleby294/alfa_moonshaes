//::///////////////////////////////////////////////

//:: Custom User Defined Event

//:: FileName kelin_userdefs

//:: Copyright (c) 2001 Bioware Corp.

//:://////////////////////////////////////////////

/* The smith bashes the anvil every other heartbeat

   until a PC approaches, then he stops bashing,

   turns to face the PC, and speaks a random insult.

   Put this script in your blacksmith NPC's

   OnUserDefined slot, rename and edit

   the NPC's OnSpawn script to activate

   the HEARTBEAT user event. Start the smith near

   an anvil that has the tag "llorkh_anvil". If the smith

   is attacked, he will fight back instead of

   bashing the anvil. If he kills the PC, he will

   return to bashing. The smith should NOT have

   a conversation assigned to it.

*/

//:://////////////////////////////////////////////

//:: Created By: Rich Dersheimer

//:: Created On: July 4, 2002

//:://////////////////////////////////////////////

void main()

{

    int nUser = GetUserDefinedEventNumber();

    if(nUser == 1001 && GetIsInCombat(OBJECT_SELF) == FALSE) //HEARTBEAT

    {

    // Find the PC who was percieved by the NPC

    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

    //Get the range to the PC

    float fRange = GetDistanceToObject(oPC);

    //Get where the PC is

    vector vTarget = GetPosition(oPC);

        // Is the PC too far away to talk to?

        if (fRange > 3.0)

        {

        //Bash the object!

        DoPlaceableObjectAction(GetObjectByTag("anvil"), PLACEABLE_ACTION_BASH);

        ActionDoCommand(ClearAllActions());

        }

        else

        {

        // The PC is close

        ClearAllActions();

        // Turn to face the PC

        SetFacingPoint(vTarget);

        // Speak a random insult

        int nRandomInsult = Random(6);

            switch(nRandomInsult)

            {

            case 0:

            ActionSpeakString("Can't you see I'm busy?", TALKVOLUME_TALK);

            ActionDoCommand(ClearAllActions());

            case 1:

            ActionSpeakString("If yer looking to buy, go talk to my brother inside!", TALKVOLUME_TALK);

            ActionDoCommand(ClearAllActions());

            case 2:

            ActionSpeakString("Go bother someone else!", TALKVOLUME_TALK);

            ActionDoCommand(ClearAllActions());

            case 3:

            ActionSpeakString("Beat it!", TALKVOLUME_TALK);

            ActionDoCommand(ClearAllActions());

            case 4:

            ActionSpeakString("Leave me be!", TALKVOLUME_TALK);

            ActionDoCommand(ClearAllActions());

            case 5:

            ActionSpeakString("GO AWAY!", TALKVOLUME_TALK);

            ActionDoCommand(ClearAllActions());

            }

        }

    }

    else if(nUser == 1002) // PERCEIVE

    {

    }

    else if(nUser == 1003) // END OF COMBAT

    {

    }

    else if(nUser == 1004) // ON DIALOGUE

    {

    }

    else if(nUser == 1005) // ATTACKED

    {

    }

    else if(nUser == 1006) // DAMAGED

    {

    }

    else if(nUser == 1007) // DEATH

    {

    }

    else if(nUser == 1008) // DISTURBED

    {

    }

}
