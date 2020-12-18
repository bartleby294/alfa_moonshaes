#include "x0_i0_position"
#include "nw_i0_2q4luskan"
#include "nw_i0_plot"
#include "x0_i0_partywide"


void main()
{
    object oPC = GetPCSpeaker();
    object Gaurd = GetObjectByTag("ThaneGaurd2");
    object Door = GetObjectByTag("ThaneDoor1");
    object PosIni = GetObjectByTag("Mines02GaurdIni2");
    object FaceThis = GetObjectByTag("Mines02Gaurd2Face");

    object VarStore1 = GetObjectByTag("Dwarven_Mines02_var_store1");

        SetLocalInt(VarStore1, "GaurdState", 1);
        AssignCommand(Gaurd, ClearAllActions());
        DelayCommand(2.0, AssignCommand(Gaurd, ActionSpeakString("*Grunts*") ));
        DelayCommand(6.0, AssignCommand(Gaurd, ActionOpenDoor(Door)));

            DelayCommand(40.0, AssignCommand(Gaurd, ActionCloseDoor(Door)));
            DelayCommand(41.0, AssignCommand(Gaurd, ActionLockObject(Door)));
            DelayCommand(43.0,AssignCommand(Gaurd, ActionMoveToObject(PosIni, FALSE, 0.0)));
            DelayCommand(48.0, TurnToFaceObject(FaceThis, Gaurd));
            DelayCommand(49.0, SetLocalInt(VarStore1, "GaurdState", 0));
            return;
}
