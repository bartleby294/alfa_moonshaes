//  The global Area OnEnter script
//  This script should be in every areas OnEnter Handler
//  All area templates have this script installed


#include "alfa_include"
#include "spawn_functions"
//    Purpose:
//    Prevent a bug in NWN that causes shadow artifacts
//    and odd shadow behavior when transitioning with a light
//    source equiped or the spell light applied to the character
//
//    Returns False if
//           - the entering object is not a player or
//           - it is day or
//           - the entering player has no light emiting items equiped
int GetHasLight(object oEnter);
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

object oEnter = GetEnteringObject();

if(GetHasLight(oEnter)==TRUE)
  {
      object oArea = GetArea(OBJECT_SELF);
      //Reset shadows
      //RecomputeStaticLighting(oArea);


    object oEntering = GetEnteringObject();
    if(GetIsPC(oEntering))
        {SetLocalInt(oArea,"InPlay",TRUE);}

  }


//
// NESS V8.1
//
// Spawn sample onEnter
//
// If you want to use pseudo-heartbeats and do not already have an area onEnter
// script, you can use this one.  Otherwise, just add Spawn_OnAreaEnter() to
// your existing onEnter handler.  Note that you use this (and
// SpawnOnAreaExit()) INSTEAD OF Spawn() / spawn_sample_hb.
//


  // Spawn_OnAreaEnter() can take three arguments - the name of the heartbeat
  // script to execute, the heartbeat duration, and a delay for the first
  // heartbeat.  They default to spawn_sample_hb, 6.0, and 0.0 respectively; as
  // if it were called like:
  // Spawn_OnAreaEnter( "spawn_sample_hb", 6.0, 0.0 );



      object oArea = GetArea(OBJECT_SELF);
      if ( GetIsAreaAboveGround( oArea ) &&
         ! GetIsAreaNatural( oArea ) )
      {
        // Indoors - no delay on the first HB
        //Spawn_OnAreaEnter( "spawn_sample_hb", 10.0 );
      }

      else
      {
        // Outdoors or underground - do a 3 second delay on the first HB
        //Spawn_OnAreaEnter( "spawn_sample_hb", 10.0, 3.0 );
      }
}
