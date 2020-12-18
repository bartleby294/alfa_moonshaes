#include "nw_i0_henchman"

void main()
{
 object Rock9 = GetObjectByTag("DwarfMineRock9");
  object Dwarf9 = GetObjectByTag("Dwarfminer9");
   DelayCommand(0.1,AssignCommand(Dwarf9, DoPlaceableObjectAction(Rock9, PLACEABLE_ACTION_BASH)));
}
