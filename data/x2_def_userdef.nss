//::///////////////////////////////////////////////
//:: Name x2_def_userdef
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On User Defined Event script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "sl_generic"
#include "sl_xp_award"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {

    }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {

    }
    else if(nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT
    {

    }
    else if(nUser == EVENT_DIALOGUE) // ON DIALOGUE
    {
        object oShouter = GetLastSpeaker();
        SetXPAValid( oShouter);
    }
    else if(nUser == EVENT_ATTACKED) // ATTACKED
    {
        SetXPAValid( GetLastAttacker());
    }
    else if(nUser == EVENT_DAMAGED) // DAMAGED
    {
        SetXPAValid( GetLastAttacker());
    }
    else if(nUser == 1007) // DEATH  - do not use for critical code, does not fire reliably all the time
    {
       SetXPAValid( GetLastKiller());
       IdInventory( FALSE);
       DelayCommand( 40.0, SetIsDestroyable( TRUE, FALSE, TRUE));

    }
    else if(nUser == EVENT_DISTURBED) // DISTURBED
    {
       SetXPAValid( GetLastDisturbed());
    }
    else if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {

    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {

    }


}


