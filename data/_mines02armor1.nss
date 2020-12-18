#include "nw_i0_henchman"

void main()
{
    object ArmorBasher1 = GetObjectByTag("Mines02ArmorBasher01");
    object ArmorBashed1 = GetObjectByTag("Mines02BashArmor01");
    DelayCommand(0.2,AssignCommand(ArmorBasher1, DoPlaceableObjectAction(ArmorBashed1, PLACEABLE_ACTION_BASH)));

}
