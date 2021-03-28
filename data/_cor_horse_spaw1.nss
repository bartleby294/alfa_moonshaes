//::///////////////////////////////////////////////
//:: Name x2_def_spawn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spawn script


    2003-07-28: Georg Zoeller:

    If you set a ninteger on the creature named
    "X2_USERDEFINED_ONSPAWN_EVENTS"
    The creature will fire a pre and a post-spawn
    event on itself, depending on the value of that
    variable
    1 - Fire Userdefined Event 1510 (pre spawn)
    2 - Fire Userdefined Event 1511 (post spawn)
    3 - Fire both events

*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner, Georg Zoeller
//:: Created On: June 11/03
//:://////////////////////////////////////////////

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

#include "x2_inc_switches"
#include "acr_horse_i2"

void main()
{
    int u = d6(1);
    /*
    if( u == 1)
    {
        SetPhenoType(5, OBJECT_SELF);
    }
    if( u == 2)
    {
        SetPhenoType(6, OBJECT_SELF);
    }
    if( u == 3)
    {
        SetPhenoType(7, OBJECT_SELF);
    }*/

    SetPhenoType(3, OBJECT_SELF);
    //SetCreatureTailType(GetCreatureTailType(oHorse), oPC);

    object oHorse = CreateObject(OBJECT_TYPE_CREATURE, "playerhorse_03",
                                 GetLocation(OBJECT_SELF));
    //ALFA_MountHorse(OBJECT_SELF, oHorse);

    FloatingTextStringOnCreature(IntToString(GetCreatureTailType(oHorse)), OBJECT_SELF);

    SetCreatureTailType(GetCreatureTailType(oHorse), OBJECT_SELF);

    // User defined OnSpawn event requested?
    int nSpecEvent = GetLocalInt(OBJECT_SELF,"X2_USERDEFINED_ONSPAWN_EVENTS");

    // Pre Spawn Event requested
    if (nSpecEvent == 1  || nSpecEvent == 3  )
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_PRESPAWN ));
    }

    /*  Fix for the new golems to reduce their number of attacks */

    int nNumber = GetLocalInt(OBJECT_SELF,CREATURE_VAR_NUMBER_OF_ATTACKS);
    if (nNumber >0 )
    {
        SetBaseAttackBonus(nNumber);
    }

    // Execute default OnSpawn script.
    ExecuteScript("nw_c2_default9", OBJECT_SELF);


    //Post Spawn event requeste
    if (nSpecEvent == 2 || nSpecEvent == 3)
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_POSTSPAWN));
    }

}
