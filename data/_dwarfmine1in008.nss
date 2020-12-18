#include "nw_i0_henchman"

void main()
{
 object Rock8 = GetObjectByTag("DwarfMineRock8");
  object Dwarf8 = GetObjectByTag("Dwarfminer8");
   DelayCommand(0.1,AssignCommand(Dwarf8, DoPlaceableObjectAction(Rock8, PLACEABLE_ACTION_BASH)));
}
