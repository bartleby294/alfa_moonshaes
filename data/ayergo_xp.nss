//::///////////////////////////////////////////////
//:: NW_O2_SKELETON.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Gives XP to player ayergovich for testing

*/
//:://////////////////////////////////////////////
//:: Created By:   Ayergo
//:: Created On:   October 9 2016
//:://////////////////////////////////////////////



#include "csm_include"

void main()
{

    object oPC = GetEnteringObject();

    object oDM = GetPCSpeaker();
    object oTarget = oPC;
    object oModule = GetModule();
    string sID = GetName( oTarget ) + GetPCPublicCDKey( oTarget );


    SetLocalInt( oModule, ALFA_ALLOW_LEVELUP+sID, TRUE );
    SetLocalInt( oPC, "X1_AllowShadow", 0);

     if(GetPCPlayerName(oPC) == "ayergovich"){
        GiveXPToCreature(oPC, 1000);
        GiveGoldToCreature(oPC, 200);
      }
      if(GetPCPlayerName(oPC) == "Rick7475"){
        GiveXPToCreature(oPC, 1000);
        GiveGoldToCreature(oPC, 200);
      }
      if(GetPCPlayerName(oPC) == "QRRCXUDW"){
        GiveXPToCreature(oPC, 1000);
        GiveGoldToCreature(oPC, 200);
      }
      if(GetPCPlayerName(oPC) == "Q6UWTARJ"){
        GiveXPToCreature(oPC, 1000);
        GiveGoldToCreature(oPC, 200);
      }
      if(GetPCPlayerName(oPC) == "Stormbring3r"){
        GiveXPToCreature(oPC, 1000);
        GiveGoldToCreature(oPC, 200);
      }
      if(GetPCPublicCDKey(oPC) == "QRRVC76P"){
        GiveXPToCreature(oPC, 1000);
        GiveGoldToCreature(oPC, 200);
      }
      if(GetPCPlayerName(oPC) == "jmecha"){
        GiveXPToCreature(oPC, 1000);
        GiveGoldToCreature(oPC, 200);
      }
      if(GetPCPublicCDKey(oPC) == "QRRP4UFX"){
        GiveXPToCreature(oPC, 1000);
        GiveGoldToCreature(oPC, 200);
      }

    ;

}





