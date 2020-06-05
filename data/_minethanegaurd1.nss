#include "x0_i0_position"
#include "nw_i0_2q4luskan"
#include "nw_i0_plot"
#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();
    object Gaurd = GetObjectByTag("ThaneGaurd1");
    object Door = GetObjectByTag("ThaneDoor1");
    object Finance = GetObjectByTag("Mines02FiscalAdvisor");
    object VarStore1 = GetObjectByTag("Dwarven_Mines02_var_store1");
    object PosIni = GetObjectByTag("Mines02GaurdIni");
    object FaceThis = GetObjectByTag("Mines02FaceThis");


    int PCRace = GetRacialType(oPC);
    int check = 0;
    int ThaneTry = GetLocalInt(oPC, "ThaneTry");

    SetLocalInt(VarStore1, "GaurdState", 1);

    if(PCRace == RACIAL_TYPE_DWARF)
    {
        //SetLocalInt(VarStore1, "GaurdState", 1);
        DelayCommand(2.0, AssignCommand(Gaurd, ActionSpeakString("*Looks the Dwarf over.*") ));
        DelayCommand(4.0, AssignCommand(Gaurd, ActionSpeakString("Just mind yourself.") ));
        DelayCommand(6.0, AssignCommand(Gaurd, ActionOpenDoor(Door)));

            DelayCommand(40.0, AssignCommand(Gaurd, ActionCloseDoor(Door)));
            DelayCommand(41.0, AssignCommand(Gaurd, ActionLockObject(Door)));
            DelayCommand(43.0, AssignCommand(Gaurd, ActionMoveToObject(PosIni, FALSE, 0.0)));
            DelayCommand(48.0, TurnToFaceObject(FaceThis, Gaurd));
            DelayCommand(48.1, SetLocalInt(VarStore1, "GaurdState", 0));
            return;

    }

    if(GetSkillRank(SKILL_PERSUADE, oPC) + d20(1) > 22)
    {
      if(ThaneTry < 3)
      {
        //SetLocalInt(VarStore1, "GaurdState", 1);
        DelayCommand(2.0, AssignCommand(Gaurd, ActionSpeakString("*Looks you over.*") ));
        DelayCommand(4.0, AssignCommand(Gaurd, ActionSpeakString("Alright but just mind yourself.") ));
        DelayCommand(6.0, AssignCommand(Gaurd, ActionOpenDoor(Door)));

            DelayCommand(40.0, AssignCommand(Gaurd, ActionCloseDoor(Door)));
            DelayCommand(41.0, AssignCommand(Gaurd, ActionLockObject(Door)));
            DelayCommand(43.0, AssignCommand(Gaurd, ActionMoveToObject(PosIni, FALSE, 0.0)));
            DelayCommand(48.0, TurnToFaceObject(FaceThis, Gaurd));
            SetLocalInt(oPC, "ThaneTry", 0);
            DelayCommand(48.1, SetLocalInt(VarStore1, "GaurdState", 0));
            return;
      }
    }

    if(GetIsItemPossessedByParty(oPC, "MarkoftheThain") == TRUE)
    {
        //SetLocalInt(VarStore1, "GaurdState", 1);
        DelayCommand(0.2, AssignCommand(Gaurd, ActionSpeakString("*Shows him a small disk.*") ));
        DelayCommand(2.0, AssignCommand(Gaurd, ActionSpeakString("*Looks you over.*") ));
        DelayCommand(4.0, AssignCommand(Gaurd, ActionSpeakString("Go right in.") ));
        DelayCommand(6.0, AssignCommand(Gaurd, ActionOpenDoor(Door)));

            DelayCommand(40.0, AssignCommand(Gaurd, ActionCloseDoor(Door)));
            DelayCommand(41.0, AssignCommand(Gaurd, ActionLockObject(Door)));
            DelayCommand(43.0,AssignCommand(Gaurd, ActionMoveToObject(PosIni, FALSE, 0.0)));
            DelayCommand(48.0, TurnToFaceObject(FaceThis, Gaurd));
            DelayCommand(48.1, SetLocalInt(VarStore1, "GaurdState", 0));
            return;
    }

 if(ThaneTry == 2)
 {
    DelayCommand(4.0, AssignCommand(Gaurd, ActionSpeakString("I said no.") ));
 }

 if(ThaneTry == 3)
 {
    DelayCommand(4.0, AssignCommand(Gaurd, ActionSpeakString("Go bother sommen else.") ));
 }

  if(ThaneTry > 3)
 {
    DelayCommand(4.0, AssignCommand(Gaurd, ActionSpeakString("*Grips Hammer tightly and glares at you.*") ));
 }

   SetLocalInt(oPC, "ThaneTry", ThaneTry+1);

   DelayCommand(5.5, AssignCommand(Gaurd, ActionSpeakString("The Thane is busy today.") ));
   DelayCommand(6.1, SetLocalInt(VarStore1, "GaurdState", 0));
}
