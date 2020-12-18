// part of the door scripts...this one rewards the unlocker and party, but it's based on tags...
// if the rogue unlocks another chest with the same tag, no xp is rewarded

// Ben W-Husey (B G P Hughes)
// This script rewards the PC for unlocking a door/placeable based on the difficulty of the lock - not to be used on doors with keys.
// Include cu_functions for AllParty to work  (prevents multiple characters getting the same xp in the same party)
#include "CU_FUNCTIONS"
#include "sos_include"
//#include "nw_i0_tool"

//void main()
//{
 //   string sLockName = "un"+GetTag(OBJECT_SELF);      //Set variable sLockName to object's tag
//    int nOnce = SOS_GetPersistentInt(GetLastUnlocked(), sLockName);  //Check to see if PC has unlocked this door before
//    int nLockXPGain = GetLockUnlockDC(OBJECT_SELF) +5;  //Give xp equal to unlock DC + 20 (set as you like)
//    object oPC = GetLastUnlocked();  // oPC is the unlocking PC
    //if (nLockXPGain < 0)             // Make sure minimum xp given is 10
    //    {nLockXPGain = 10;}
 //   if (nOnce==FALSE)                //If not given XP before for unlocking this Lock, then run the routine now
  //  {
//    FloatingTextStringOnCreature("XP Gained - use of skill",GetLastUnlocked()); //Inform PC of XP for use of skill
//    AllParty(sLockName,oPC,1);  //Set so no one else in the party (and the opener) can get this xp again.
//    }
//}
