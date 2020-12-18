#include "nw_i0_henchman"

void main()
{
     object Rock4 = GetObjectByTag("DwarfMineRock4");
      object Dwarf4 = GetObjectByTag("Dwarfminer4");
       DelayCommand(2.2,AssignCommand(Dwarf4, DoPlaceableObjectAction(Rock4, PLACEABLE_ACTION_BASH)));
}
