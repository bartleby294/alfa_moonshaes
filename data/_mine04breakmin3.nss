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
    object stool = GetObjectByTag("Mines04RockSeat05");
    object Dwarf = GetObjectByTag("MinesO4SittingDwarf03");

     ExecuteScript("nw_c2_default4", OBJECT_SELF);

     DelayCommand(0.3, AssignCommand(Dwarf, ActionSpeakString("Im on break.") ));

     DelayCommand(0.5, AssignCommand(Dwarf, ActionInteractObject(stool)) );



}
