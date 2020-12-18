#include "nw_i0_henchman"

void main()
{
    object ArmorBasher2 = GetObjectByTag("Mines02ArmorBasher02");
    object ArmorBashed2 = GetObjectByTag("Mines02BashArmor02");
    DelayCommand(0.2,AssignCommand(ArmorBasher2, DoPlaceableObjectAction(ArmorBashed2, PLACEABLE_ACTION_BASH)));

}
