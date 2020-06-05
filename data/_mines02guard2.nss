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
    object Move2b = GetObjectByTag("Mines02Move2");
    object Move1 = GetObjectByTag("Mines02Move1");
    object Move3 = GetObjectByTag("Mines02ThaneMiddleFloor");
    object Move4 = GetObjectByTag("Mines02ThaneOutSideDoor");

    object VarStore1 = GetObjectByTag("Dwarven_Mines02_var_store1");

    SetLocalInt(VarStore1, "MerchMoveState", 1);

    AssignCommand(Gaurd1, ClearAllActions(FALSE));
    AssignCommand(Gaurd2, ClearAllActions(FALSE));

    DelayCommand(1.0, AssignCommand(Gaurd1, ActionSpeakString("*Grunts*  Buli can you see if Mr. Loilinus Perthik is avaliable for an audience.") ));
    DelayCommand(2.0, AssignCommand(Gaurd2, ActionSpeakString("*Nods*") ));
    DelayCommand(3.0, AssignCommand(Gaurd2, ActionMoveToObject(Move2, FALSE, 0.0)));
    DelayCommand(8.0, AssignCommand(Gaurd2, ActionMoveToObject(Move2b, FALSE, 0.0)));

    DelayCommand(18.0, AssignCommand(Gaurd2, ActionSpeakString("Some one to see you sir.") ));
    DelayCommand(19.0, AssignCommand(Gaurd2, ActionMoveToObject(Move3, FALSE, 0.0)));
    DelayCommand(22.0, AssignCommand(Gaurd2, ActionMoveToObject(PosIni, FALSE, 0.0)));
    DelayCommand(38.0, TurnToFaceObject(FaceThis2, Gaurd2));

    DelayCommand(19.5, AssignCommand(Finance, ClearAllActions()));
    DelayCommand(20.0, AssignCommand(Finance, ActionMoveToObject(Move3, FALSE, 0.0)));
    DelayCommand(25.0, AssignCommand(Finance, ActionMoveToObject(Move1, FALSE, 0.0)));
    DelayCommand(26.0, AssignCommand(Finance, ActionOpenDoor(Door)));
    DelayCommand(27.0, AssignCommand(Finance, ActionMoveToObject(Move4, FALSE, 0.0)));
    DelayCommand(28.0, AssignCommand(Finance, ActionCloseDoor(Door)));
    DelayCommand(29.0, AssignCommand(Finance, ActionLockObject(Door)));
    DelayCommand(31.0, TurnToFaceObject(oPC, Finance));

    DelayCommand(51.0, AssignCommand(Finance, ActionStartConversation(oPC, "_mines02merchant", FALSE, FALSE)));
    DelayCommand(100.0, SetLocalInt(VarStore1, "MerchMoveState", 0));
}
