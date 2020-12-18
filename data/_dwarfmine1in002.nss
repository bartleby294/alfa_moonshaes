#include "nw_i0_henchman"

void main()
{
   object Rock2 = GetObjectByTag("DwarfMineRock2");
    object Dwarf2 = GetObjectByTag("Dwarfminer2");

     DelayCommand(1.0,AssignCommand(Dwarf2, DoPlaceableObjectAction(Rock2, PLACEABLE_ACTION_BASH)));
}
