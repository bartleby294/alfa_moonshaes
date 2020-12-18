//::///////////////////////////////////////////////
//:: Name x2_def_onconv
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Conversation script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    object stool = GetObjectByTag("Mines04RockSeat02");
    object Dwarf = GetObjectByTag("MinesO4SittingDwarf02");

      ExecuteScript("nw_c2_default4", OBJECT_SELF);

     DelayCommand(0.3, AssignCommand(Dwarf, ActionSpeakString("Were on break.") ));

     DelayCommand(0.5, AssignCommand(Dwarf, ActionInteractObject(stool)) );



}
