#include "nw_i0_henchman"

void main()
{
  object Rock1 = GetObjectByTag("DwarfMineRock1");
  object Dwarf1 = GetObjectByTag("Dwarfminer1");

  DelayCommand(0.2,AssignCommand(Dwarf1, DoPlaceableObjectAction(Rock1, PLACEABLE_ACTION_BASH)));

}
