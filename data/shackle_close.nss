#include "nw_i0_tool"

void main()
{
object oPC = GetPCSpeaker();
object oWP = GetNearestObjectByTag("WP_Shackle", oPC);
object oShackle=GetNearestObjectByTag("Shackle", oPC);
location lShackle = GetLocation(oShackle);
int counter;
int x=GetLocalInt(oShackle, "InUse");

    if (x<1)
    {
    SetLocalObject(oShackle, "Prisoner", oPC);
    SetLocalInt(oShackle, "InUse", 1);
    SetLocalInt(oShackle, "knockdown", 1);
    //SetLocalInt(oPC, "shackled6", 1);
    ActionPauseConversation();

    AssignCommand(oPC, JumpToObject(oWP));

    float fDirectionbase = GetFacing(oWP);

    DelayCommand(1.95, AssignCommand(oPC, SetFacing(0.0f)));
    DelayCommand(1.5,PlaySound("as_na_branchsnp3"));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BELT, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC))));
   //Disabled due to new  PC  skins
   //DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_NECK, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC))));
    DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC))));

    DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectKnockdown(), oPC));
    //DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(), oPC, 20.0f));
    DelayCommand(2.05,SetFacing(fDirectionbase));

    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_solblue", lShackle,FALSE);
    //DelayCommand(2.5,SetCommandable(FALSE, oPC));

    //  x=GetLocalInt(oShackle, "InUse");

    //while (x>0)
      //  {
      //  x=GetLocalInt(oShackle, "InUse");
      //  AssignCommand(oPC, ClearAllActions());
      //  AssignCommand(oPC, JumpToObject(oWP));
      //  DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(), oPC, 6.0f));
      //  AssignCommand(oPC, ActionWait(5.0f));
      //  }

    DelayCommand(3.5,ActionResumeConversation());
    }
}
