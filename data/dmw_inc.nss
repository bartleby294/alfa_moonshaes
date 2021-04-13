//////////////////////////////////
/// Script: dmw_inc
/// Purpose: include file for a DM's Helper wand
/// Author: Dopple (dopple@why-bother-me.com
//////////////////////////////////
// function for OnActivateItem
object oMySpeaker = GetLastSpeaker();
object oMyTarget = GetLocalObject(oMySpeaker, "dmwandtarget");
location lMyLoc = GetLocalLocation(oMySpeaker, "dmwandloc");

//void main(){}

void dmwand_activate()
{
   // get the wand's activator and target, put target info into local vars on activator
   object oMyActivator = GetItemActivator();
   object oMyTarget = GetItemActivatedTarget();
   SetLocalObject(oMyActivator, "dmwandtarget", oMyTarget);
   location lMyLoc = GetItemActivatedTargetLocation();
   SetLocalLocation(oMyActivator, "dmwandloc", lMyLoc);

   //Uncomment this for a silent shout whenever the DM wand is used
   //AssignCommand(oMyActivator, ActionSpeakString("Using DM powers..", TALKVOLUME_SILENT_SHOUT));

   //Make the activator start a conversation with itself
   AssignCommand(oMyActivator, ActionStartConversation(oMyActivator, "dmwand", TRUE));
}

//////////////////////////////////
/// Tests for determining if a conversation option should be shown
//////////////////////////////////


int dmwand_istargetplaceable()
{
   int nTargetType = GetObjectType(oMyTarget);
   if(GetIsObjectValid(oMyTarget))
   {
      if(nTargetType == OBJECT_TYPE_PLACEABLE)
      {
         return TRUE;
      }
   }
   return FALSE;
}

// Check if the target can be created with CreateObject
int dmwand_istargetcreateable()
{
   int nTargetType = GetObjectType(oMyTarget);
   if(GetIsObjectValid(oMyTarget))
   {
      if((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE) || (nTargetType == OBJECT_TYPE_CREATURE))
      {
         return TRUE;
      }
   }
   return FALSE;
}

//Check if target is a destroyable object
int dmwand_istargetdestroyable()
{
   int nTargetType = GetObjectType(oMyTarget);
   if(GetIsObjectValid(oMyTarget) && (! GetIsPC(oMyTarget)))
   {
      if((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE))
      {
         return TRUE;
      }
   }
   return FALSE;
}

//Check if the target is a PC
int dmwand_istargetpc()
{
   if(GetIsObjectValid(oMyTarget) && GetIsPC(oMyTarget))
   {
      return TRUE;
   }
   return FALSE;
}

//Check if the target is  not myself
int dmwand_istargetnotme()
{
   if(GetIsObjectValid(oMyTarget) && (oMySpeaker != oMyTarget))
   {
         return TRUE;
   }
   return FALSE;
}

//Check if target is an NPC or monster
int dmwand_istargetnpc()
{
   if(GetIsObjectValid(oMyTarget) && GetAbilityScore(oMyTarget, ABILITY_CONSTITUTION))
   {
      if(! GetIsPC(oMyTarget))
      {
         return TRUE;
      }
   }
   return FALSE;
}

// Check if the target is a PC or NPC
// uses the CON score currently
int dmwand_istargetpcornpc()
{
   return (GetIsObjectValid(oMyTarget) && GetAbilityScore(oMyTarget, ABILITY_CONSTITUTION));
}

// checks if the wand was NOT clicked on an object
int dmwand_istargetinvalid()
{
   return !GetIsObjectValid(oMyTarget);
}

// checks if a nearby object is destroyable
int dmwand_isnearbydestroyable()
{
   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   if(GetIsObjectValid(oMyTest))
   {
      return TRUE;
   }
   return FALSE;
}

///////////////////////////////////////////////////////////////
/// The actual meat of the DM wand

// Give a player the full map of an area
void dmwand_exploreareaforplayer()
{
   object omyarea = GetArea(oMySpeaker);
   ExploreAreaForPlayer(omyarea, oMyTarget);
}

// Reload the current running module, teleporting everyone to the starting position
void dmwand_reloadmodule()
{
   string sModuleName = GetModuleName();
//   SendMessageToPC(oMySpeaker,"CRASHES MODULE-DISABLED");
   StartNewModule(sModuleName);
}

/////////////////////////////////////////////////
// Character Information Scripts

// I designed this script to get around the DM console limitation of not
// being able to get Player info. This script displays all you want to know about
// the player INCLUDING teh players inventory!

// I made all the info you retrieve into FUNCTIONS so you can easily lift them
// and put them in other scripts.

// When a player logs on the information is sent to the Server DM.  I will
// be tweaking this code as I go, hopefully making it to where you can
// pass in a player paramter via teh DM console and get his information.

// Place script in the OnEnter event of the Area

// PLEASE: I script and give away for free, so I ask that any of my code
// you reuse, put my name and email address in it.  You can freely distribute
// any of my code with your own as long as you do so.

// THANKS!

// Robert Bernavich
// robert_bernavich@mentor.com


//------------------------------------
string Gender(object oEntity)
{
   // function returns a string value of objects gender
   switch (GetGender(oEntity))
   {
      case GENDER_MALE:   return "Male"; break;
      case GENDER_FEMALE: return "Female"; break;
      case GENDER_BOTH:   return "Both";  break;
      case GENDER_NONE:   return "None";  break;
      case GENDER_OTHER:  return "Other";  break;
   }

   return "Wierdo";
}
//------------------------------------
//------------------------------------
string Alignment(object oEntity)
{
   // function returns concatenated string version of
   // objects Alignment
   string sReturnString;

   switch (GetAlignmentLawChaos(oEntity))
   {
      case ALIGNMENT_LAWFUL:   sReturnString = "Lawful "; break;
      case ALIGNMENT_NEUTRAL: sReturnString = "Neutral "; break;
      case ALIGNMENT_CHAOTIC:   sReturnString = "Chaotic ";  break;
   }

   switch (GetAlignmentGoodEvil(oEntity))
   {
      case ALIGNMENT_GOOD:   sReturnString = sReturnString + "Good"; break;
      case ALIGNMENT_NEUTRAL: sReturnString = sReturnString +  "Neutral"; break;
      case ALIGNMENT_EVIL:   sReturnString = sReturnString +  "Evil";  break;
   }

   if (sReturnString == "Neutral Neutral"){sReturnString = "True Neutral";}

   return sReturnString;
}
//------------------------------------
//------------------------------------
string Race(object oEntity)
{
   // Returns striong version of objects race
   switch (GetRacialType(oEntity))
   {
      case RACIAL_TYPE_ALL:   return "All"; break;
      case RACIAL_TYPE_ANIMAL:   return "Animal"; break;
      case RACIAL_TYPE_BEAST:   return "Beast"; break;
      case RACIAL_TYPE_CONSTRUCT:   return "Construct"; break;
      case RACIAL_TYPE_DRAGON:   return "Dragon"; break;
      case RACIAL_TYPE_DWARF:   return "Dwarf"; break;
      case RACIAL_TYPE_ELEMENTAL:   return "Elemental"; break;
      case RACIAL_TYPE_ELF:   return "Elf"; break;
      case RACIAL_TYPE_FEY:   return "Fey"; break;
      case RACIAL_TYPE_GIANT:   return "Giant"; break;
      case RACIAL_TYPE_GNOME:   return "Gnome"; break;
      case RACIAL_TYPE_HALFELF:   return "Half Elf"; break;
      case RACIAL_TYPE_HALFLING:   return "Halfling"; break;
      case RACIAL_TYPE_HALFORC:   return "Half Orc"; break;
      case RACIAL_TYPE_HUMAN:   return "Human"; break;
      case RACIAL_TYPE_HUMANOID_GOBLINOID:   return "Goblinoid"; break;
      case RACIAL_TYPE_HUMANOID_MONSTROUS:   return "Monstrous"; break;
      case RACIAL_TYPE_HUMANOID_ORC:   return "Orc"; break;
      case RACIAL_TYPE_HUMANOID_REPTILIAN:   return "Reptillian"; break;
      case RACIAL_TYPE_MAGICAL_BEAST:   return "Magical Beast"; break;
      case RACIAL_TYPE_OUTSIDER:   return "Outsider"; break;
      case RACIAL_TYPE_SHAPECHANGER:   return "Shapechanger"; break;
      case RACIAL_TYPE_UNDEAD:   return "Undead"; break;
      case RACIAL_TYPE_VERMIN:   return "Vermin"; break;
   }

   return "Unknown";
}
//------------------------------------
string ClassLevel(object oEntity)
{
   // Returns all three classes and levels in string format of Object
   string sReturnString;
   string sClass;
   string sClassOne;
   string sClassTwo;
   string sClassThree;
   int nLevelOne;
   int nLevelTwo;
   int nLevelThree;
   int iIndex;

   // Loop through all three classes and pull out info
   for(iIndex == 1;iIndex < 4;iIndex++)
   {
      switch (GetClassByPosition(iIndex,oEntity))
      {
         case CLASS_TYPE_ABERRATION: sClass ="Aberration";break;
         case CLASS_TYPE_ANIMAL:     sClass ="Animal"; break;
         case CLASS_TYPE_BARBARIAN:  sClass ="Barbarian";break;
         case CLASS_TYPE_BARD:         sClass ="Bard"; break;
         case CLASS_TYPE_BEAST:        sClass ="Beast"; break;
         case CLASS_TYPE_CLERIC:       sClass ="Cleric"; break;
         case CLASS_TYPE_COMMONER:     sClass ="Commoner";break;
         case CLASS_TYPE_CONSTRUCT:    sClass ="Construct"; break;
         case CLASS_TYPE_DRAGON:       sClass ="Dragon"; break;
         case CLASS_TYPE_DRUID:        sClass ="Druid";break;
         case CLASS_TYPE_ELEMENTAL:    sClass ="Elemental"; break;
         case CLASS_TYPE_FEY:          sClass ="Fey";break;
         case CLASS_TYPE_FIGHTER:      sClass ="Fighter";  break;
         case CLASS_TYPE_GIANT:        sClass ="Giant";  break;
         case CLASS_TYPE_HUMANOID:     sClass ="Humanoid"; break;
         case CLASS_TYPE_INVALID:      sClass ="";break;
         case CLASS_TYPE_MAGICAL_BEAST:sClass ="Magical Beast"; break;
         case CLASS_TYPE_MONK:         sClass ="Monk";   break;
         case CLASS_TYPE_OUTSIDER:     sClass ="Outsider"; break;
         case CLASS_TYPE_MONSTROUS:    sClass ="Monstrous"; break;
         case CLASS_TYPE_PALADIN:      sClass ="Paladin";break;
         case CLASS_TYPE_RANGER:       sClass ="Ranger";break;
         case CLASS_TYPE_ROGUE:        sClass ="Rogue";break;
         case CLASS_TYPE_SHAPECHANGER: sClass ="Shapechanger";break;
         case CLASS_TYPE_SORCERER:     sClass ="Sorcerer";break;
         case CLASS_TYPE_UNDEAD:       sClass ="Undead";break;
         case CLASS_TYPE_VERMIN:       sClass ="Vermin"; break;
         case CLASS_TYPE_WIZARD:       sClass ="Wizard"; break;
      }

      // Now depending on which iteration we just went through
      // assign it to the proper class
      switch (iIndex)
      {
         case 1: sClassOne =   sClass;  break;
         case 2: sClassTwo =   sClass;  break;
         case 3: sClassThree = sClass;  break;
      }
   };

   // Now get all three class levels.  Wil be 0 if does class pos
   //does not exists
   nLevelOne =   GetLevelByPosition(1,oEntity);
   nLevelTwo =   GetLevelByPosition(2,oEntity);
   nLevelThree = GetLevelByPosition(3,oEntity);

   //Start building return string
   sReturnString = sClassOne + "(" + IntToString(nLevelOne) + ")" ;

   //If second class exists append to return string
   if(nLevelTwo > 0)
   {
      sReturnString =sReturnString + "/" + sClassTwo + "(" + IntToString(nLevelTwo) + ")";
   }

   //If third class exists append to return string
   if(nLevelThree > 0)
   {
      sReturnString =sReturnString + "/" + sClassThree + "(" + IntToString(nLevelThree) + ")";
   }

   return sReturnString;
}
//-----------------------------------------------------
//------------------------------------
string Inventory(object oEntity)
{
   //Loop through the objects inventory and return a string value of entire
   // inventory !

   string sBaseType;
   string sReturnString;

   object  oItem = GetFirstItemInInventory(oEntity);

   while(oItem != OBJECT_INVALID)
   {
      switch(GetBaseItemType(oItem))
      {
         case BASE_ITEM_AMULET: sBaseType ="Amulet";break;
         case BASE_ITEM_ARMOR: sBaseType ="Armor";break;
         case BASE_ITEM_ARROW: sBaseType ="Arrow";break;
         case BASE_ITEM_BASTARDSWORD: sBaseType ="Bastard Sword";break;
         case BASE_ITEM_BATTLEAXE: sBaseType ="Battle Axe";break;
         case BASE_ITEM_BELT: sBaseType ="Belt";break;
         case BASE_ITEM_BOLT : sBaseType ="Bolt";break;
         case BASE_ITEM_BOOK: sBaseType ="Book";break;
         case BASE_ITEM_BOOTS: sBaseType ="Boots";break;
         case BASE_ITEM_BRACER: sBaseType ="Bracer";break;
         case BASE_ITEM_BULLET: sBaseType ="Bullet";break;
         case BASE_ITEM_CBLUDGWEAPON: sBaseType ="Bludgeoning Weap.";break;
         case BASE_ITEM_CLOAK: sBaseType ="Cloak";break;
         case BASE_ITEM_CLUB: sBaseType ="Club";break;
         case BASE_ITEM_CPIERCWEAPON: sBaseType ="Pierceing Weap.";break;
         case BASE_ITEM_CREATUREITEM: sBaseType ="Creature Item";break;
         case BASE_ITEM_CSLASHWEAPON: sBaseType ="Slash Weap.";break;
         case BASE_ITEM_CSLSHPRCWEAP: sBaseType ="Slash/Pierce Weap.";break;
         case BASE_ITEM_DAGGER: sBaseType ="Dagger";break;
         case BASE_ITEM_DART: sBaseType ="Dart";break;
         case BASE_ITEM_DIREMACE: sBaseType ="Mace";break;
         case BASE_ITEM_DOUBLEAXE: sBaseType ="Double Axe";break;
         case BASE_ITEM_GEM: sBaseType ="Gem";break;
         case BASE_ITEM_GLOVES: sBaseType ="Gloves";break;
         case BASE_ITEM_GOLD: sBaseType ="Gold";break;
         case BASE_ITEM_GREATAXE: sBaseType ="Great Axe";break;
         case BASE_ITEM_GREATSWORD: sBaseType ="Great Sword";break;
         case BASE_ITEM_HALBERD: sBaseType ="Halberd";break;
         case BASE_ITEM_HANDAXE: sBaseType ="Hand Axe";break;
         case BASE_ITEM_HEALERSKIT: sBaseType ="Healers Kit";break;
         case BASE_ITEM_HEAVYCROSSBOW: sBaseType ="Heavy Xbow";break;
         case BASE_ITEM_HEAVYFLAIL: sBaseType ="Heavy Flail";break;
         case BASE_ITEM_HELMET: sBaseType ="Helmet";break;
         case BASE_ITEM_INVALID: sBaseType ="";break;
         case BASE_ITEM_KAMA: sBaseType ="Kama";break;
         case BASE_ITEM_KATANA: sBaseType ="Katana";break;
         case BASE_ITEM_KEY: sBaseType ="Key";break;
         case BASE_ITEM_KUKRI: sBaseType ="Kukri";break;
         case BASE_ITEM_LARGEBOX: sBaseType ="Large Box";break;
         case BASE_ITEM_LARGESHIELD: sBaseType ="Large Shield";break;
         case BASE_ITEM_LIGHTCROSSBOW: sBaseType ="Light Xbow";break;
         case BASE_ITEM_LIGHTFLAIL: sBaseType ="Light Flail";break;
         case BASE_ITEM_LIGHTHAMMER: sBaseType ="Light Hammer";break;
         case BASE_ITEM_LIGHTMACE: sBaseType ="Light Mace";break;
         case BASE_ITEM_LONGBOW: sBaseType ="Long Bow";break;
         case BASE_ITEM_LONGSWORD: sBaseType ="Long Sword";break;
         case BASE_ITEM_MAGICROD: sBaseType ="Magic Rod";break;
         case BASE_ITEM_MAGICSTAFF: sBaseType ="Magic Staff";break;
         case BASE_ITEM_MAGICWAND: sBaseType ="Magic Wand";break;
         case BASE_ITEM_MISCLARGE: sBaseType ="Misc. Large";break;
         case BASE_ITEM_MISCMEDIUM: sBaseType ="Misc. Medium";break;
         case BASE_ITEM_MISCSMALL: sBaseType ="Misc. Small";break;
         case BASE_ITEM_MISCTALL: sBaseType ="Misc. Small";break;
         case BASE_ITEM_MISCTHIN: sBaseType ="Misc. Thin";break;
         case BASE_ITEM_MISCWIDE: sBaseType ="Misc. Wide";break;
         case BASE_ITEM_MORNINGSTAR: sBaseType ="Morningstar";break;
         case BASE_ITEM_POTIONS: sBaseType ="Potion";break;
         case BASE_ITEM_QUARTERSTAFF: sBaseType ="Quarterstaff";break;
         case BASE_ITEM_RAPIER: sBaseType ="Rapier";break;
         case BASE_ITEM_RING: sBaseType ="Ring";break;
         case BASE_ITEM_SCIMITAR: sBaseType ="Scimitar";break;
         case BASE_ITEM_SCROLL: sBaseType ="Scroll";break;
         case BASE_ITEM_SCYTHE: sBaseType ="Scythe";break;
         case BASE_ITEM_SHORTBOW: sBaseType ="Shortbow";break;
         case BASE_ITEM_SHORTSPEAR: sBaseType ="Short Spear";break;
         case BASE_ITEM_SHORTSWORD: sBaseType ="Short Sword";break;
         case BASE_ITEM_SHURIKEN: sBaseType ="Shuriken";break;
         case BASE_ITEM_SICKLE: sBaseType ="Sickle";break;
         case BASE_ITEM_SLING: sBaseType ="Sling";break;
         case BASE_ITEM_SMALLSHIELD: sBaseType ="Small Shield";break;
         case BASE_ITEM_SPELLSCROLL: sBaseType ="Spell Scroll";break;
         case BASE_ITEM_THIEVESTOOLS: sBaseType ="Thieves Tools";break;
         case BASE_ITEM_THROWINGAXE: sBaseType ="Throwing Axe";break;
         case BASE_ITEM_TORCH: sBaseType ="Torch";break;
         case BASE_ITEM_TOWERSHIELD: sBaseType ="Tower Shield";break;
         case BASE_ITEM_TRAPKIT: sBaseType ="Trap Kit";break;
         case BASE_ITEM_TWOBLADEDSWORD: sBaseType ="2 Bladed Sword";break;
         case BASE_ITEM_WARHAMMER: sBaseType ="Warhammer";break;
      }

      if (sBaseType != "Gold")
      {
         // If more than one item (stacked)
         if (GetNumStackedItems(oItem) > 1 )
         {
            sReturnString= sReturnString + "\n  (" + IntToString(GetNumStackedItems(oItem)) + ") "+ GetName(oItem) + " (" + sBaseType + ")";
         }
         else
         {
            // Build remainder of output string
            sReturnString= sReturnString + "\n  " + GetName(oItem) + " (" + sBaseType + ")";
         }
      }

      oItem = GetNextItemInInventory(oEntity);

   };   // While loop

   return sReturnString;
}
//------------------------------------


// Send a private message to the DM with the PC or NPC's stats
void dmwand_showattr()
{
   string sSTR = IntToString(GetAbilityScore(oMyTarget,ABILITY_STRENGTH));
   string sINT = IntToString(GetAbilityScore(oMyTarget,ABILITY_INTELLIGENCE));
   string sDEX = IntToString(GetAbilityScore(oMyTarget,ABILITY_DEXTERITY));
   string sWIS = IntToString(GetAbilityScore(oMyTarget,ABILITY_WISDOM));
   string sCON = IntToString(GetAbilityScore(oMyTarget,ABILITY_CONSTITUTION));
   string sCHA = IntToString(GetAbilityScore(oMyTarget,ABILITY_CHARISMA));
   SendMessageToPC(oMySpeaker,"\n-------------------------------------------" +
                       "\nReported: "+IntToString(GetTimeHour())+":"+IntToString(GetTimeMinute())+
                       "\nPlayer Name: " + GetPCPlayerName(oMyTarget) +
                       "PubCDKey: "+GetPCPublicCDKey(oMyTarget) +
                       "\nChar Name:   " + GetName(oMyTarget) +
                       "\n-------------------------------------------" +
                       "\nRace:    " + Race(oMyTarget) +
                       "\nClass:    " + ClassLevel(oMyTarget) +
                       "\nXP:     " + IntToString(GetXP(oMyTarget)) +
                       "\nGender: " + Gender(oMyTarget) +
                       "\nAign:    " + Alignment(oMyTarget) +
                       "\nDiety:  " + GetDeity(oMyTarget) +
                       "\n" +
                       "\nSTR:  " + sSTR +
                       "\nINT:   " + sINT +
                       "\nWIS:  " + sWIS +
                       "\nDEX:  " + sDEX +
                       "\nCON: " + sCON +
                       "\nCHA:  " + sCHA +
                       "\n" +
                       "\nHPs:  " + IntToString(GetCurrentHitPoints(oMyTarget)) +
                           " of " + IntToString(GetMaxHitPoints(oMyTarget)) +
                       "\nAC:  " + IntToString(GetAC(oMyTarget)) +
                       "\n\nGold:  " + IntToString(GetGold(oMyTarget)) +
                       "\nInventory:\n  " + Inventory(oMyTarget) +
                       "\n-------------------------------------------");
}


// Change the lock status of the target
void dmwand_fliplockstatus()
{
   SetLocked(oMyTarget, !GetLocked(oMyTarget));
}

// advance the module time by the specified number of hours
void dmwand_advancetime(int nHours)
{
   int nCurrentHour = GetTimeHour();
   int nCurrentMinute = GetTimeMinute();
   int nCurrentSecond = GetTimeSecond();
   int nCurrentMilli = GetTimeMillisecond();

   nCurrentHour += nHours;
   SetTime(nCurrentHour, nCurrentMinute, nCurrentSecond, nCurrentMilli);
}

// change it instantly to day or night
void dmwand_swapdaynight()
{
   int nCurrentHour = GetTimeHour();
   int nCurrentMinute = GetTimeMinute();
   int nCurrentSecond = GetTimeSecond();
   int nCurrentMilli = GetTimeMillisecond();

   // Since we can't set time backward, we just need to set it to the time
   // needed.
   if((nCurrentHour < 6) || (nCurrentHour > 18))
   {
      nCurrentHour = 7;
   }
   else
   {
      nCurrentHour = 19;
   }
   SetTime(nCurrentHour, nCurrentMinute, nCurrentSecond, nCurrentMilli);
}

// showfullstats code borrowed/adapted from Jhenne's DM tool
void dmwand_shiftalignment(string sAlign, int nShift)
{
   if(TestStringAgainstPattern(sAlign, "Law"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_LAWFUL, nShift);
      return;
   }
   if(TestStringAgainstPattern(sAlign, "Chaos"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_CHAOTIC, nShift);
      return;
   }
   if(TestStringAgainstPattern(sAlign, "Good"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_GOOD, nShift);
      return;
   }
   if(TestStringAgainstPattern(sAlign, "Evil"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_EVIL, nShift);
      return;
   }
}

//Jhenne's Item Stripper - remove equipped items from target
void dmwand_takeoneitem(object oEquip)
{
   if (GetIsObjectValid(oEquip) != 0)
   {
      AssignCommand(oMySpeaker, ActionTakeItem(oEquip, oMyTarget));
   }
}

// Take all equipped items off of target
void dmwand_takeallequipped()
{
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_ARMS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_ARROWS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BELT, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BOLTS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BOOTS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BULLETS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_CHEST, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_CLOAK, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_HEAD, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_NECK, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oMyTarget));
}

// take all items from target
void dmwand_takeallunequipped()
{
   object oEquip = GetFirstItemInInventory(oMyTarget);
   while(GetIsObjectValid(oEquip))
   {
      dmwand_takeoneitem(oEquip);
      oEquip = GetNextItemInInventory(oMyTarget);
   }
}

// destroy target object/creature/item
void dmwand_destroytarget()
{
   effect eDestroy = EffectVisualEffect(VFX_IMP_SUNSTRIKE);

   DestroyObject(oMyTarget);
   ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDestroy, lMyLoc);
}

// destroy the first object we find nearby to the current location
void dmwand_destroynearbytarget()
{
   effect eDestroy = EffectVisualEffect(VFX_IMP_SUNSTRIKE);

   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   while(GetIsObjectValid(oMyTest) && GetIsPC(oMyTest))
   {
      object oMyTest = GetNextObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   }

   if(GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)))
   {
      DestroyObject(oMyTest);
      ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDestroy, lMyLoc);
   }
}

//Kick out the target PC
void dmwand_kickdapc()
{
   // Lightning Strike by Jhenne. 06/29/02

   // tell the DM object to create a Lightning visual effect at targetted location
   AssignCommand( oMySpeaker, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), lMyLoc));
   // tell the DM object to play a thunderclap
   AssignCommand ( oMySpeaker, PlaySound ("as_wt_thundercl3"));
   // create a scorch mark where the lightning hit
   object oScorch = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_weathmark", lMyLoc, FALSE);
   object oTargetArea = GetArea(oMySpeaker);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 5; nCount++)
   {
      nXPos = Random(10) - 5;
      nYPos = Random(10) - 5;

      vector vNewVector = GetPositionFromLocation(lMyLoc);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lNewLoc = Location(oTargetArea, vNewVector, 0.0);
      AssignCommand( oMySpeaker, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_S), lNewLoc));
   }
   DelayCommand ( 20.0, DestroyObject ( oScorch));
   BootPC(oMyTarget);
}

//Kill the target, forcing it to leave a corpse behind
//taken from Bioware's KillAndReplace()
void dmwand_killandreplace()
{
   SetPlotFlag(oMyTarget, FALSE);
   AssignCommand(oMyTarget, SetIsDestroyable(FALSE, FALSE));
   AssignCommand(oMyTarget, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oMyTarget));
}

//Kill the target, no corpse
void dmwand_kill()
{
   SetPlotFlag(oMyTarget, FALSE);
   AssignCommand(oMyTarget, SetIsDestroyable(TRUE, FALSE, FALSE));
   AssignCommand(oMyTarget, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oMyTarget));
}

// Toad..err..penguin the player
// I would rather a chicken, but it seems that's not a valid polymorph type :(
void dmwand_toad()
{
   effect ePenguin = EffectPolymorph(POLYMORPH_TYPE_PENGUIN);
   effect eParalyze = EffectParalyze();
   SendMessageToPC(oMySpeaker, "Penguin?  Don't you mean toad?");

   AssignCommand(oMyTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenguin, oMyTarget));
   AssignCommand(oMyTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, oMyTarget));
   SetLocalInt(oMyTarget, "toaded", 1);
}

// Unpenguin the player
void dmwand_untoad()
{
   effect eMyEffect = GetFirstEffect(oMyTarget);
   while(GetIsEffectValid(eMyEffect))
   {
      if(GetEffectType(eMyEffect) == EFFECT_TYPE_POLYMORPH ||
         GetEffectType(eMyEffect) == EFFECT_TYPE_PARALYZE)
      {
         RemoveEffect(oMyTarget, eMyEffect);
      }
      eMyEffect = GetNextEffect(oMyTarget);
   }
}

// Jhenne's autofollow functions
void dmwand_followtarget()
{
      AssignCommand ( oMySpeaker, ActionForceFollowObject(oMyTarget));
}

// Jhenne's autofollow functions
void dmwand_followme()
{
   AssignCommand ( oMyTarget, ActionForceFollowObject( oMySpeaker));
   DelayCommand ( 10.0, AssignCommand ( oMyTarget, ClearAllActions()));
   if ( GetIsPC ( oMyTarget) != TRUE)
   {
      DelayCommand ( 12.0, ExecuteScript ( "nw_c2_default9", oMyTarget));
   }
}

void dmwand_resumedefault()
{
   ExecuteScript ( "nw_c2_default9", oMyTarget);
}

// Ability Roll Funtion by Jhenne, 07/09/02
void dmwand_abilitycheck(int nAbility, string sAbility, int nSecret = TRUE)
{
   int nRoll=d20();
   int nRank=GetAbilityModifier (nAbility, oMyTarget);
   int nResult=nRoll+nRank;
   string sRoll=IntToString(nRoll);
   string sRank=IntToString(nRank);
   string sResult=IntToString(nResult);

   SendMessageToPC(oMySpeaker, GetName(oMyTarget)+"'s "+sAbility+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult);

   if (!nSecret)
   {
      AssignCommand( oMyTarget, SpeakString(sAbility+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult));
   }
}

// Skill Roll Funtion by Jhenne, 07/09/02
void dmwand_skillcheck(int nSkill, string sSkill, int nSecret = TRUE)
{
   int nRoll=d20();
   int nRank=GetSkillRank (nSkill, oMyTarget);
   int nResult=nRoll+nRank;
   string sRoll=IntToString(nRoll);
   string sRank=IntToString(nRank);
   string sResult=IntToString(nResult);

   SendMessageToPC(oMySpeaker, GetName(oMyTarget)+"'s "+sSkill+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult);

   if (!nSecret)
   {
      AssignCommand( oMyTarget, SpeakString(sSkill+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult));
   }
}

//Turn placeable on/off by Dopple
void dmwand_turnoff(object oMyPlaceable)
{
   AssignCommand(oMyPlaceable, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
   DelayCommand(0.4,SetPlaceableIllumination(oMyPlaceable, FALSE));
   DelayCommand(0.5,RecomputeStaticLighting(GetArea(oMyPlaceable)));
}

void dmwand_turnon(object oMyPlaceable)
{
   AssignCommand(oMyPlaceable, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
   DelayCommand(0.4,SetPlaceableIllumination(oMyPlaceable, TRUE));
   DelayCommand(0.5,RecomputeStaticLighting(GetArea(oMyPlaceable)));
}

void dmwand_turntargeton()
{
   dmwand_turnon(oMyTarget);
}

void dmwand_turntargetoff()
{
   dmwand_turnoff(oMyTarget);
}

void dmwand_turnnearon()
{
   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   while(GetIsObjectValid(oMyTest) && GetIsPC(oMyTest))
   {
      object oMyTest = GetNextObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   }

   if(GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)))
   {
      dmwand_turnon(oMyTest);
   }
}

void dmwand_turnnearoff()
{
   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   while(GetIsObjectValid(oMyTest) && GetIsPC(oMyTest))
   {
      object oMyTest = GetNextObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   }

   if(GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)))
   {
      dmwand_turnoff(oMyTest);
   }


}

