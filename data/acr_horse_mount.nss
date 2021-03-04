//////////////////////////////////////////////////////////////////
//
//     acr_horse_mount.nss
//      by AcadiusLost (2006/09/02)
//
//  Called from conversation "acr_horse_conv", when speaking
//  to a valid mount which is owned by the player.  Allows
//  the PC to mount the horse, by invoking ALFA_MountHorse
//  from the master include, "acr_horse_i"
//
//////////////////////////////////////////////////////////////////


#include "acr_horse_i"

void main()
{
    object oPC = GetPCSpeaker();
    object oHorse = OBJECT_SELF;

    ALFA_MountHorse(oPC, oHorse);
    if(GetHasFeat(3075, oPC)) ExecuteScript("alfa_mountcombat", oPC);
}
