#include "nw_i0_henchman"

void main()
{
 object Rock7 = GetObjectByTag("DwarfMineRock7");
  object Dwarf7 = GetObjectByTag("Dwarfminer7");
   DelayCommand(0.2,AssignCommand(Dwarf7, DoPlaceableObjectAction(Rock7, PLACEABLE_ACTION_BASH)));

}
