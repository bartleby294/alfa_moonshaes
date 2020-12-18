#include "nw_i0_tool"

void main()
{
     int nUser = GetUserDefinedEventNumber();
     if (nUser == 1002) // OnPerception event
     {
        object oTarget;
        object oPC = GetLastPerceived();
        object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
        int nType = GetBaseItemType(oItem);

        oTarget = OBJECT_SELF;

        if(nType != BASE_ITEM_TORCH && GetIsObjectValid(oItem))
        {
        AssignCommand(oPC,AdjustReputation(oPC, oTarget, -5));
        AssignCommand(oTarget,ActionSpeakString("*Glances at weapon*"));
        DelayCommand(2.0, AssignCommand(oPC,ActionSpeakString("This is no place for drawn weapons.")));

        }
}
}

