#include "nw_i0_henchman"

void main()
{
  object Rock5 = GetObjectByTag("DwarfMineRock5");
   object Dwarf5 = GetObjectByTag("Dwarfminer5");
    DelayCommand(0.4,AssignCommand(Dwarf5, DoPlaceableObjectAction(Rock5, PLACEABLE_ACTION_BASH)));
}
