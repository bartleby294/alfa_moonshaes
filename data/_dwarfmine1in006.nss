#include "nw_i0_henchman"

void main()
{
      object Rock6 = GetObjectByTag("DwarfMineRock6");
       object Dwarf6 = GetObjectByTag("Dwarfminer6");
        DelayCommand(0.6, AssignCommand(Dwarf6, DoPlaceableObjectAction(Rock6, PLACEABLE_ACTION_BASH)));

}
