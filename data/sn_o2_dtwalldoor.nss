//::///////////////////////////////////////////////
//:: nw_o2_dttrapdoor.nss
//:: Copyright (c) 2001-2 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script runs on either the Hidden Trap Door
    or Hidden Wall Door Trigger invisible objects.
    This script will do a check and see
    if any PC comes within a radius of this Trigger.

    If the PC has the search skill or is an Elf then
    a search check will be made.

    It will create a Trap or Wall door that will have
    its Destination set to a waypoint that has
    a tag of DST_<tag of this object>

    The radius is determined by the Reflex saving
    throw of the invisible object

    The DC of the search stored by the Willpower
    saving throw.

*/
//:://////////////////////////////////////////////
//:: Created By  : Robert Babiak
//:: Created On  : June 25, 2002
//::---------------------------------------------
//:: Modifyed By : Robert, Andrew, Derek
//:: Modifyed On : July - September
//:://////////////////////////////////////////////
//:: Modifyed By : Saar - Snag
//:: Modifyed On : Jan 14, 2003
//:://////////////////////////////////////////////

void main()
{
    // Snag Add ----------------------------------------------------
    int    N_ROUNDS_TO_RESET  = 4;  // should be 24 seconds
    int    N_ALWAYS_COUNT_DOWN = FALSE; // Count down even if there is a PC in the search Radius.
    int    N_MAX_INDEX = 64; // max player to remember
    int    N_ADJUST_PC_WILL_SEARCH = 3; // This number will be added to the PC search DICE
    int    N_STORE_PC_NAME = TRUE; // If FALSE: the trap will not store PC names who found it to adjust, later on, the will check

    // -------------------------------------------------------------

    // get the radius and DC of the secret door.
    float fSearchDist = IntToFloat(GetReflexSavingThrow(OBJECT_SELF));
    int nDiffaculty = GetWillSavingThrow(OBJECT_SELF);


    // what is the tag of this object used in setting the destination
    string sTag = GetTag(OBJECT_SELF);

    // has it been found?
    int nDone = 0; //GetLocalInt(OBJECT_SELF,"D_"+sTag); // SNAG CHANGE
    int nReset = GetLocalInt(OBJECT_SELF,"Reset");


    // SNAG Add --------------------------------------------------------
    // Counting Down the Reset Variable
    if (nReset > 1 && N_ALWAYS_COUNT_DOWN)
    {
       SetLocalInt(OBJECT_SELF, "Reset", (nReset-1));
    } // if
    // -----------------------------------------------------------------


    // ok reset the door is destroyed, and the done and reset flas are made 0 again
    if (nReset == 1)
    {
        nDone = 0;
        nReset = 0;

        SetLocalInt(OBJECT_SELF,"D_"+sTag,nDone);
        SetLocalInt(OBJECT_SELF,"Reset",nReset);

        object oidDoor= GetLocalObject(OBJECT_SELF,"Door");
        if (oidDoor != OBJECT_INVALID)
        {
            SetPlotFlag(oidDoor,0);
            DestroyObject(oidDoor,GetLocalFloat(OBJECT_SELF,"ResetDelay"));
        }

    }


    int nBestSkill = -50;
    object oidBestSearcher = OBJECT_INVALID;
    int nCount = 1;

    // Find the best searcher within the search radius.
    object oidNearestCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    int nDoneSearch = 0;
    int nFoundPCs = 0;


    while ((nDone == 0) &&
           (nDoneSearch == 0) &&
           (oidNearestCreature != OBJECT_INVALID)
          )
    {
        // what is the distance of the PC to the door location
        float fDist = GetDistanceBetween(OBJECT_SELF,oidNearestCreature);

        if (fDist <= fSearchDist)
        {
            int nSkill = GetSkillRank(SKILL_SEARCH,oidNearestCreature);

            if (nSkill > nBestSkill)
            {
                nBestSkill = nSkill;
                oidBestSearcher = oidNearestCreature;
            }
            nFoundPCs = nFoundPCs +1;
        }
        else
        {
            // If there is no one in the search radius, don't continue to search
            // for the best skill.
            nDoneSearch = 1;
        }
        nCount = nCount +1;
        oidNearestCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF ,nCount);
    }


    if ((nDone == 0) &&
        (nFoundPCs != 0) &&
        (GetIsObjectValid(oidBestSearcher)) &&
        (!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "Door"))) // SNAG: check if door is not there
       )
    {

       // SNAG ADD ------------
       // Check if the PC has found it before

          int i=1;
          int nAdjust = 0;
          int nVisitFlag = FALSE;

          string sPCName = GetName(oidBestSearcher);
          string sLocPCName = GetLocalString(OBJECT_SELF, "pc_name" + IntToString(i));

          while (i<=N_MAX_INDEX && sLocPCName!="" && !nVisitFlag && N_STORE_PC_NAME) // Search for PC stop if found or reached NULL Key string
          {
            if (sLocPCName == sPCName)
            { // been here
                nAdjust = N_ADJUST_PC_WILL_SEARCH;
                nVisitFlag = TRUE;
            }
            i++;
            sLocPCName = GetLocalString(OBJECT_SELF, "pc_name" + IntToString(i));
          } // while

       // ---------------------

//       PrintString("Adjust: " + IntToString(nAdjust)); // DEBUG

       int nMod = (d20() + nAdjust);
       //nMod = (nMod<1)?1:nMod; // check value is not less then 1
/*
       ActionSpeakString("Diffaculty: " + IntToString(nDiffaculty) +
                         "   Before Roll Dice: " + IntToString(nMod-nAdjust) +
                         "   Adjustment to roll: " + IntToString(nAdjust)  +
                         "   After Roll = " + IntToString(nMod) +
                         "   Not count search skills");   // DEBUG
*/

            // did we find it.
       if ((nBestSkill +nMod > nDiffaculty))
       {
            location locLoc = GetLocation (OBJECT_SELF);
            object oidDoor;

            // yes we found it, now create the appropriate door

            oidDoor = CreateObject(OBJECT_TYPE_PLACEABLE, "NW_PL_HIDDENDR01" ,locLoc,TRUE);

            SetLocalString( oidDoor, "Destination" , "DST_"+sTag );

            // Snag added -------------------------------------------------
            // Here I'm using the Local variable "Reset" that BIOWARE uses.

            SetLocalInt   ( OBJECT_SELF, "Reset", N_ROUNDS_TO_RESET);

            if (!nVisitFlag && N_STORE_PC_NAME) // Adds to the Object so finding will be much simpler.
            {
              int    nIndex = GetLocalInt(OBJECT_SELF, "pc_index"); // SNAG: where stored last time

              nIndex++;  // add 1 to the index
              nIndex = (nIndex > N_MAX_INDEX)?1:nIndex; // if not greater then Max stored

              SetLocalString(OBJECT_SELF, ("pc_name" +IntToString(nIndex)), sPCName);
              SetLocalInt   (OBJECT_SELF,  "pc_index", nIndex);
            }
            // ------------------------------------------------------------

            // make this door as found.
            //SetLocalInt(OBJECT_SELF,"D_"+sTag,1);  /Snag Change. value nDone always 0
            SetPlotFlag(oidDoor,1);
            SetLocalObject(OBJECT_SELF,"Door",oidDoor);

       } // if skill search found
    } // if Object is valid
    else
      // SNAG Add --------------------------------------------------------
      // ONLY if there is no PC Found in check area continue to count down the Reset Variable
       if (!N_ALWAYS_COUNT_DOWN && nFoundPCs==0)
        {
          if (nReset > 1)
          {
             SetLocalInt(OBJECT_SELF, "Reset", (nReset-1));
          } // inner if
        } // if done and no pc found
          // -----------------------------------------------------------------

}// MAIN


