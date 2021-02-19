//////////////////////////////////
/// Script: omega_include
/// Purpose: This serves as a way to define functions that
/////////////Are used over and over. Once out of beta, this
/////////////will provide an open script in which to to
/////////////handle rappers.
/// Author: LP (ALFA name Lord Psycho)
//////////////////////////////////
// Global Functions



object oDM = GetLastSpeaker();
object oMyTarget = GetLocalObject(oDM, "OMWandTarget");
location lTargetLoc = GetLocalLocation(oDM, "OMWandLoc");
location lDMLoc = GetLocation (oDM);
int nRandom;
float fRandom;
effect eEffect;
object oCaster;
string GetInventory(object oEntity)
{
   //Loop through the objects inventory and return a string value of entire
   // inventory !
   //edited:2/28 by LP

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
            sReturnString= sReturnString + "\n  " + GetName(oItem) + " (" + GetTag(oItem) + ")";
         }
      }

      oItem = GetNextItemInInventory(oEntity);

   };   // While loop

   return sReturnString;
   }
void deadrapper()
{

}
