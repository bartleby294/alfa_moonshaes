//::///////////////////////////////////////////////
//:: Anti-Theft OnOpened
//:: theft_onopen
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
 For Doors to detect thief opening door
*/
//:://////////////////////////////////////////////
//:: Created By: David "The Shadowlord" Corrales
//:: Created On: August 23,2002
//:://////////////////////////////////////////////
#include "NW_O2_CONINCLUDE"
#include "theft_functions"

void main()
{
  if(GetIsPC(GetLastOpener()))
  {
    Theft_SpotThief(GetLastOpener());
    //AdjustAlignment(GetLastOpener(),ALIGNMENT_CHAOTIC,2);
  }
  DelayCommand(1800.0,ActionCloseDoor(OBJECT_SELF));
}
