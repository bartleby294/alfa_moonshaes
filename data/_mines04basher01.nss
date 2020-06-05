#include "nw_i0_henchman"

void main()
{
  object Rock1 = GetObjectByTag("Mines04DwarfBash");
  object Dwarf1 = GetObjectByTag("Mines04DwarfBasher");

  DelayCommand(0.2,AssignCommand(Dwarf1, DoPlaceableObjectAction(Rock1, PLACEABLE_ACTION_BASH)));

}
