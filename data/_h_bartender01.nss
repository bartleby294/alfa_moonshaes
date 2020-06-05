#include "x0_i0_position"
#include "nw_i0_2q4luskan"
#include "nw_i0_plot"

void main()
{
   object oPC = GetPCSpeaker();
   object AlePlace = GetObjectByTag("_h_aleplace");
   object Bartender = GetObjectByTag("hammerstaadbarkeep1");
   location tankardLoc = GetLocation(AlePlace);

   int gold = GetGold(oPC);

   if(gold > 0)
    {
        TakeGold(2, oPC, TRUE);
        AssignCommand(Bartender, ClearAllActions());
        AssignCommand(Bartender, ActionSpeakString("*Grabs a mug*"));
        DelayCommand(1.1, AssignCommand(Bartender, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0) ));

        DelayCommand(2.2, CreateObjectVoid(OBJECT_TYPE_ITEM , "_ale_stein", tankardLoc, FALSE));
        return;
    }

    if(gold < 2)
    {
       AssignCommand(Bartender, ClearAllActions());
       AssignCommand(Bartender, ActionSpeakString("You sure you got that kind o gold?"));
       return;
    }
}
