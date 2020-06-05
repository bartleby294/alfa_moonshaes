#include "x0_i0_position"
#include "nw_i0_2q4luskan"
#include "nw_i0_plot"
#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();
    object Gaurd1 = GetObjectByTag("ThaneGaurd1");
    object Gaurd2 = GetObjectByTag("ThaneGaurd2");
    object Door = GetObjectByTag("ThaneDoor1");
    object Finance = GetObjectByTag("Mines02FiscalAdvisor");
    object PosIni = GetObjectByTag("Mines02GaurdIni2");
    object FaceThis = GetObjectByTag("Mines02FaceThis2");
    object FaceThis2 = GetObjectByTag("Mines02Gaurd2Face");
    object Move2 = GetObjectByTag("Mines02Move2");
    object Move1 = GetObjectByTag("Mines02Move1");
    object Move3 = GetObjectByTag("Mines02ThaneMiddleFloor");
    object Move4 = GetObjectByTag("Mines02ThaneOutSideDoor");
    object throneright = GetObjectByTag("DwarfMines02ThrownRight");

    AssignCommand(Finance, ClearAllActions());
    DelayCommand(1.0, AssignCommand(Finance, ActionSpeakString("Good day.") ));
    DelayCommand(2.0, AssignCommand(Finance, ActionOpenDoor(Door)));
    DelayCommand(3.0, AssignCommand(Finance, ActionMoveToObject(Move1, FALSE, 0.0)));
    DelayCommand(4.0, AssignCommand(Finance, ActionCloseDoor(Door)));
    DelayCommand(5.0, AssignCommand(Finance, ActionLockObject(Door)));

    DelayCommand(8.0, AssignCommand(Finance, ActionMoveToObject(Move3, FALSE, 0.0)));
    DelayCommand(9.0, AssignCommand(Finance, ActionMoveToObject(Move2, FALSE, 0.0)));
    DelayCommand(10.0, AssignCommand(Finance, ActionInteractObject(throneright)));
}
