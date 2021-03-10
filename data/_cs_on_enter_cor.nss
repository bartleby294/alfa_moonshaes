//  The global Area OnEnter script
//  This script should be in every areas OnEnter Handler
//  All area templates have this script installed
#include "alfa_include"
#include "spawn_functions"
#include "x2_inc_toollib"
#include "ms_xp_util"
//    Purpose:
//    Prevent a bug in NWN that causes shadow artifacts
//    and odd shadow behavior when transitioning with a light
//    source equiped or the spell light applied to the character
//
//    Returns False if
//           - the entering object is not a player or
//           - it is day or
//           - the entering player has no light emiting items equiped
int GetHasLight(object oEnter)
{
      if(GetIsPC(oEnter)==FALSE ||GetIsDay()==FALSE){return FALSE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetHasSpellEffect(SPELL_LIGHT,oEnter)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_LEFTRING,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_NECK,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_HEAD,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_CLOAK,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_CHEST,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_ARMS,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_BELT,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_BOOTS,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
      else if(GetItemHasItemProperty(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oEnter),ITEM_PROPERTY_LIGHT)==TRUE)
       {return TRUE;}
     else{return FALSE;}
}

void main()
{

    ALFA_OnAreaEnter();

    object oArea = GetArea(OBJECT_SELF);
    object oEnter = GetEnteringObject();

    if(GetHasLight(oEnter)==TRUE)
    {
        //Reset shadows
        //RecomputeStaticLighting(oArea);
        object oEntering = GetEnteringObject();
        if(GetIsPC(oEntering)) {
            SetLocalInt(oArea,"InPlay",TRUE);
        }
    }

    //TLChangeAreaGroundTiles(oArea, X2_TL_GROUNDTILE_WATER, 10, 21, -0.92f);
    //TLChangeAreaGroundTiles(oArea, X2_TL_GROUNDTILE_WATER,  9, 21, -0.92f);
}
