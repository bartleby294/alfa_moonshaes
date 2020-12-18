#include "nw_i0_henchman"

void main()
{
   object Rock3 = GetObjectByTag("DwarfMineRock3");
    object Dwarf3 = GetObjectByTag("Dwarfminer3");


    DelayCommand(1.1,AssignCommand(Dwarf3, DoPlaceableObjectAction(Rock3, PLACEABLE_ACTION_BASH)));
}
