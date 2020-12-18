/******************************************************************
 * Name: alfa_onareaenter
 * Type: OnAreaEnter
 * ---
 * Author: Cereborn
 * Date: 10/24/03
 * ---
 * This handles the module OnAreaEnter event.
 * You can add custom code in the appropriate section
 ******************************************************************/

/* Includes */
#include "alfa_include"

void main()
{
  ALFA_OnAreaEnter();

  /**************** Add Custom Code Here ***************/
    object Bash = GetObjectByTag("Mines04DwarfBash");
    object Basher = GetObjectByTag("Mines04DwarfBasher");

    DelayCommand(0.2,AssignCommand(Basher, DoPlaceableObjectAction(Bash, PLACEABLE_ACTION_BASH)));

    object stool1 = GetObjectByTag("Mines04RockSeat01");
    object stool2 = GetObjectByTag("Mines04RockSeat02");
    object stool3 = GetObjectByTag("Mines04RockSeat05");

    object Dwarf1 = GetObjectByTag("MinesO4SittingDwarf01");
    object Dwarf2 = GetObjectByTag("MinesO4SittingDwarf02");
    object Dwarf3 = GetObjectByTag("MinesO4SittingDwarf03");



     AssignCommand(Dwarf1, ActionInteractObject(stool1) );
     AssignCommand(Dwarf2, ActionInteractObject(stool2) );
     AssignCommand(Dwarf3, ActionInteractObject(stool3) );

   /*****************************************************/
}
