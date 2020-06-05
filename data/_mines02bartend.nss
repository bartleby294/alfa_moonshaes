#include "x0_i0_position"
#include "nw_i0_2q4luskan"
#include "nw_i0_plot"

void main()
{


    object oPC = GetPCSpeaker();
    object Stand = GetObjectByTag("Mines02Bartender01");
    object Keg = GetObjectByTag("Mines02Bartender02");
    object AlePlace = GetObjectByTag("Mines02Bartender03");

    object Bartender = GetObjectByTag("DwarvenMineBartender01");
    location tankardLoc = GetLocation(AlePlace);
    int gold = GetGold(oPC);

if(gold > 0)
{
    TakeGold(2, oPC, TRUE);
    AssignCommand(Bartender, ClearAllActions());
    TurnToFaceObject(Keg, Bartender);
    DelayCommand(0.2, AssignCommand(Bartender, ActionMoveToObject(Keg, FALSE, 0.0)));

    AssignCommand(Bartender, ActionSpeakString("*Grabs a Tankard*"));
    DelayCommand(2.0, AssignCommand(Bartender, ActionSpeakString("*Pours ale*") ));
    DelayCommand(2.1, AssignCommand(Bartender, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0) ));

    DelayCommand(4.1, TurnToFaceObject(Stand, Bartender));
    DelayCommand(4.2, AssignCommand(Bartender, ActionMoveToObject(Stand, FALSE, 0.0)));
    DelayCommand(5.1, AssignCommand(Bartender, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0) ));

    DelayCommand(7.2, CreateObjectVoid(OBJECT_TYPE_ITEM , "_ale_stein", tankardLoc, FALSE));
    return;
}

if(gold < 2)
{
   AssignCommand(Bartender, ClearAllActions());
   AssignCommand(Bartender, ActionSpeakString("Afraid you need to pay first lad."));
   return;
}


}
