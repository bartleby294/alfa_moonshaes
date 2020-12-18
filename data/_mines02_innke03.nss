#include "x0_i0_position"
#include "nw_i0_2q4luskan"
#include "nw_i0_plot"

void main()
{
    object oPC = GetPCSpeaker();

    object Board = GetObjectByTag("_mines02_innkeep02");
    object Stand = GetObjectByTag("_mines02_innkeep01");
    object KeyPlace = GetObjectByTag("_mines02_inkeep_keyplace");

    object InnKeep = GetObjectByTag("_mines_02_innkeeper");
    location KeyLoc = GetLocation(KeyPlace);
    int gold = GetGold(oPC);

if(gold > 4)
{
    TakeGold(5, oPC, TRUE);
    AssignCommand(InnKeep, ClearAllActions());
    TurnToFaceObject(Board, InnKeep);
    DelayCommand(0.2, AssignCommand(InnKeep, ActionMoveToObject(Board, FALSE, 0.0)));

    DelayCommand(2.0, AssignCommand(InnKeep, ActionSpeakString("*Takes key off of peg.*") ));
    DelayCommand(2.1, AssignCommand(InnKeep, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0) ));

    DelayCommand(4.1, TurnToFaceObject(Stand, InnKeep));
    DelayCommand(4.2, AssignCommand(InnKeep, ActionMoveToObject(Stand, FALSE, 0.0)));
    DelayCommand(7.1, AssignCommand(InnKeep, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0) ));

    DelayCommand(12.2, CreateObjectVoid(OBJECT_TYPE_ITEM , "_mine02_innkey03", KeyLoc, FALSE));
    DelayCommand(15.1, TurnToFaceObject(KeyPlace, InnKeep));
    SetLocalInt(InnKeep, "three", 1);
    return;
}

if(gold < 5)
{
   AssignCommand(InnKeep, ClearAllActions());
   AssignCommand(InnKeep, ActionSpeakString("*Wistles looking at you while waiting.*"));
   return;
}


}
