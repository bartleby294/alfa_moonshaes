//////////////////////////////////
/// Script: omega_include
/// Purpose: This serves as a way to define functions that
/////////////Are used over and over. Once out of beta, this
/////////////will provide an open script in which to to
/////////////handle rappers.
/// Original Author: LP (ALFA name Lord Psycho)
/// Heavily edited / rewriten by Ronan
//////////////////////////////////
// Global Functions

#include "alfa_wealth_inc"
#include "subraces"
#include "csm_include"
#include "omega_token_hand"
#include "omega_const"

object oDM = GetLastSpeaker();
object oMyTarget = GetLocalObject(oDM, "OMWandTarget");
location lTargetLoc = GetLocalLocation(oDM, "OMWandLoc");
location lDMLoc = GetLocation (oDM);
int nRandom;
float fRandom;
effect eEffect;
object oCaster;

const string OMW_DEITY_MASTER_LO = "OMW_DEITY_MASTER";

string GetBaseItemTypeAsString(int type) {

    string sBaseType;

    switch(type)
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
        default: sBaseType ="Unknown item type!";break;
    }
    return sBaseType;
}

string GetInventory(object oEntity, int valueMinimum = 0)
{
   //Loop through the objects inventory and return a string value of entire
   // inventory !
   //edited:1/4 by Ronan

   string sBaseType;
   string sReturnString;

   object  oItem = GetFirstItemInInventory(oEntity);

   while(oItem != OBJECT_INVALID)
   {
      int itemValue = GetItemValue(oItem);
      sBaseType = GetBaseItemTypeAsString(GetBaseItemType(oItem));

      if (sBaseType != "Gold" && itemValue >= valueMinimum )
      {
         // If more than one item (stacked)
         if (GetNumStackedItems(oItem) > 1 )
         {
            sReturnString= sReturnString + "\n\n  (" + IntToString(GetNumStackedItems(oItem)) + ") "+ GetName(oItem) + "\nType: " + sBaseType + "\nTag:" + GetTag(oItem) + "\nResRef: " + GetResRef(oItem);
         }
         else
         {
            // Build remainder of output string
            sReturnString= sReturnString + "\n\n  " + GetName(oItem) + "\nType: " + sBaseType + "\nTag:" + GetTag(oItem) + "\nResRef: " + GetResRef(oItem);
         }

         sReturnString = sReturnString + "\nValue: " + IntToString(itemValue);
      }

      oItem = GetNextItemInInventory(oEntity);

   };   // While loop

   return sReturnString;
   }
void deadrapper()
{

}

string GetObjectTypeAsString(int type) {
    switch(type) {
        case OBJECT_TYPE_AREA_OF_EFFECT:
            return "Area of Effect";
        case OBJECT_TYPE_CREATURE:
            return "Creature";
        case OBJECT_TYPE_DOOR:
            return "Door";
        case OBJECT_TYPE_ENCOUNTER:
            return "Encounter";
        case OBJECT_TYPE_ITEM:
            return "Item";
        case OBJECT_TYPE_PLACEABLE:
            return "Placable";
        case OBJECT_TYPE_STORE:
            return "Store";
        case OBJECT_TYPE_TRIGGER:
            return "Trigger";
        case OBJECT_TYPE_WAYPOINT:
            return "Waypoint";
    }
    return "Object Type Error!";
}

void ListPCs(int startingToken) {
    object oPC = GetFirstPC();
    int i;
    int end = startingToken + 32;

    for(i=startingToken; i<end; i++) {
        if(GetIsObjectValid(oPC))
            SetCustomToken(i, GetName(oPC) + " (" + GetPCPlayerName(oPC) + ")");
            else SetCustomToken(i, "None");
        oPC = GetNextPC();
    }
}

object GetPCByIndex(int index) {
    object oPC = GetFirstPC();
    int i;

    for(i=0; i<index; i++) {
        if(!GetIsObjectValid(oPC))
            return OBJECT_INVALID;
        oPC = GetNextPC();
    }
    return oPC;
}

void DoDamageToTarget(int damageType=DAMAGE_TYPE_DIVINE)
{
  object oPC = GetPCSpeaker();
  object oTarget = GetLocalObject( oPC, "OMWandTarget" );
  int nValue = GetLocalInt( oPC, "DM_WAND_DAMAGE_VALUE" );
  string sMessage;

  if ( oTarget == OBJECT_INVALID )
  {
    SendMessageToPC( oPC, "Your target has logged out." );
    return;
  }

  if (nValue == 0)
  {
    SendMessageToPC( oPC, "No damage amount indicated - none done." );
    return;
  }


  if (nValue == 1)
  {
    sMessage = "Doing 1 point of damage to " + GetName(oTarget) + ".";
  }

  else
  {
    sMessage = "Doing " + IntToString( nValue ) + " points of damage to " +
       GetName(oTarget) + ".";
  }

  effect eDamage = EffectDamage(nValue, damageType);
  ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oTarget);

  SendMessageToPC( oPC, sMessage );
}

int BGRToInt(int B, int G, int R) {
    int nReturn;
    B = B << 16;
    G = G << 8;
    nReturn = B | G | R;
    return nReturn;
}
int IntToBGRBlue(int nColour)
{
return (nColour & 16711680) >> 16;
}

int IntToBGRGreen(int nColour)
{
return (nColour & 65280) >> 8;
}

int IntToBGRRed(int nColour)
{
return (nColour & 255);
}
struct BGR{
int Blue, Green, Red;
};

struct BGR IntToBGR(int nColour)
{
struct BGR strResult;
strResult.Blue=(nColour & 16711680) >> 16;
strResult.Green=(nColour & 65280) >> 8;
strResult.Red=(nColour & 255);

return strResult;
}

void GetFogColorWeel(int nMath)
{

         if (nMath == 1){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_BLACK);
        SetLocalString(oDM, "STR_COLOR", "Black");}
    else if (nMath == 2){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_BLUE);
        SetLocalString(oDM, "STR_COLOR", "Blue"); }
    else if (nMath == 3){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_BLUE_DARK);
        SetLocalString(oDM, "STR_COLOR", "Dark Blue");}
    else if (nMath == 4){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_BROWN);
        SetLocalString(oDM, "STR_COLOR", "Brown");}
    else if (nMath == 5){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_BROWN_DARK);
        SetLocalString(oDM, "STR_COLOR", "Dark Brown");}
    else if (nMath == 6){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_CYAN);
        SetLocalString(oDM, "STR_COLOR", "Turqoise");}
    else if (nMath == 7){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_GREEN);
        SetLocalString(oDM, "STR_COLOR", "Green");}
    else if (nMath == 8){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_GREEN_DARK);
        SetLocalString(oDM, "STR_COLOR", "Green Dark");}
    else if (nMath == 9){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_GREY);
        SetLocalString(oDM, "STR_COLOR", "Gray");}
    else if (nMath == 10){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_MAGENTA);
        SetLocalString(oDM, "STR_COLOR", "Magenta");}
    else if (nMath == 11){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_ORANGE);
        SetLocalString(oDM, "STR_COLOR", "Orange");}
    else if (nMath == 12){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_ORANGE_DARK);
        SetLocalString(oDM, "STR_COLOR", "Dark Orange");}
    else if (nMath == 13){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_RED);
        SetLocalString(oDM, "STR_COLOR", "Red");}
    else if (nMath == 14){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_RED_DARK);
        SetLocalString(oDM, "STR_COLOR", "Red Dark");}
    else if (nMath == 15){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_WHITE);
        SetLocalString(oDM, "STR_COLOR", "White");}
    else if (nMath == 16){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_YELLOW);
        SetLocalString(oDM, "STR_COLOR", "Yellow");}
    else if (nMath == 17){
        SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_YELLOW_DARK);
        SetLocalString(oDM, "STR_COLOR", "Dark Yellow");
        }

}

void GetHexDayCode(int nColor)
{
{
int nColour = nColor;
struct BGR strBGR = IntToBGR(nColour);

SetCustomToken(6978,IntToString(strBGR.Red));
SetLocalInt(oDM, "FOG_D_RED",strBGR.Red );
SetCustomToken(6979,IntToString(strBGR.Green) );
SetLocalInt(oDM, "FOG_D_GREEN", strBGR.Green);
SetCustomToken(6980, IntToString(strBGR.Blue) );
SetLocalInt(oDM, "FOG_D_BLUE", strBGR.Blue);
}
}
void GetHexNightCode(int nColor2)
{
{
int nColour = nColor2;
struct BGR strBGR = IntToBGR(nColour);

SetCustomToken(6981,IntToString(strBGR.Red) );
SetLocalInt(oDM, "FOG_N_RED", strBGR.Red);
SetCustomToken(6982,IntToString(strBGR.Green) );
SetLocalInt(oDM, "FOG_N_GREEN", strBGR.Green);
SetCustomToken(6983, IntToString(strBGR.Blue) );
SetLocalInt(oDM, "FOG_N_BLUE", strBGR.Blue);
}
}

void FogAdvancedMath(int nAdd, string sVarable)
{
int nMath = GetLocalInt(oDM, sVarable);

    nMath += nAdd;
   if (nMath >= 251){
      nMath == 250; }
   if (nMath <= -1){
      nMath == 0; }
//SendMessageToPC(oDM, "Setting " + sVarable + " to" + IntToString(nMath) + " + " + IntToString(nAdd));
//SendMessageToPC(oDM, IntToString(nMath));


SetLocalInt(oDM, sVarable, nMath);
//SendMessageToPC(oDM, "I set " + sVarable + " to " + IntToString(nMath));

//Simple check to set both 'day and night' couldn't
//figure out any other way to do it (though it is 5am)
int nTiredLP = GetLocalInt(oDM, "FOG_TIME_CONST");
string sConstruct = GetSubString(sVarable, 6,5);
//SendMessageToAllDMs(sConstruct);
  if (nTiredLP == FOG_TYPE_ALL)
  {
    SetLocalInt(oDM, "FOG_D_" + sConstruct, nMath);
     SetLocalInt(oDM, "FOG_N_" + sConstruct, nMath);
  }

AdvancedTokenSetup();
}

void SaveLoadDecoder(string sString)
{
int sLength = GetStringLength(sString);
int nDay = FindSubString(sString, "D");
int nNight = FindSubString(sString, "N");
nDay += 2;
string sLeft = GetStringLeft(sString, nDay);
int nCount = sLength - nDay;
string sSubNight = GetSubString(sString, nDay, nCount);
nNight -= 1;
string sSubDay = GetStringLeft(sString, nNight);
GetHexDayCode(StringToInt(sSubDay));
GetHexNightCode(StringToInt(sSubNight));
}


void SetFogDenceMath(string sVarable, int nAdd)
{
int nVarable = GetLocalInt(oDM, sVarable);
SendMessageToPC(oDM, IntToString(nVarable) + " + " + IntToString(nAdd));
int ntwant = 200;
int nzero = 0;
nVarable += nAdd;
   if (nVarable >= 201)
   {
      nVarable == ntwant;
      }
   else if (nVarable <= -1)
   {
      nVarable == nzero;
      }

    SendMessageToPC(oDM, "set varable to: " + IntToString(nVarable));
int nCheck = GetLocalInt(oDM, "FOG_TIME_CONST");
if (nCheck == FOG_TYPE_SUN)
    {
        SetLocalInt(oDM, "F_AM_D", nVarable);
        SetCustomToken(6994, "Day");
        SetCustomToken(6992, IntToString(nVarable));
SendMessageToPC(oDM, "set Varable and token to: " + IntToString(nVarable));

        }

    else if (nCheck == FOG_TYPE_MOON)
    {
        SetLocalInt(oDM, "F_AM_N", nVarable);
        SetCustomToken(6994, "Night");
        SetCustomToken(6993, IntToString(nVarable));
        SendMessageToPC(oDM, "set Varable and token to: " + IntToString(nVarable));

        }
    else if (nCheck == FOG_TYPE_ALL)
     {
      SetLocalInt(oDM, "F_AM_D", nVarable);
    SetLocalInt(oDM, "F_AM_N", nVarable);
     SetCustomToken(6994, "Day and Night");
     SetCustomToken(6992, IntToString(nVarable));
     SetCustomToken(6993, IntToString(nVarable));
     }
}
/* Thanks to Hypervx for idea's on this one */
void GetSecondToMinute(int nSecond)
{
int nMinute = 0;
while(nSecond > 60)
{
nSecond -= 60;
nMinute++;
}
SetCustomToken( 6971, IntToString(nMinute) + " Minutes & " + IntToString(nSecond) + " Seconds");
}

void PetrifyAdvanced(object oTarget, effect eVisEffect)
{
    effect eFreeze = EffectCutsceneParalyze();
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ODD);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oTarget);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVisEffect, oTarget);
}
void OmegaEffectToObject(effect eEffect) {
    object oDM = GetLastSpeaker();
    int nDuration = GetLocalInt(oDM, "DURATION_TYPE");
    float fTime = GetLocalFloat(oDM, "DURATION_TIME");
    object oMyTarget = GetLocalObject(oDM, "OMWandTarget");

    AssignCommand (oDM , ApplyEffectToObject (nDuration, eEffect, oMyTarget, fTime));
}

void OmegaEffectAtLocation(effect eEffect) {
    object oDM = GetLastSpeaker();
    int nDuration = GetLocalInt(oDM, "DURATION_TYPE");
    float fTime = GetLocalFloat(oDM, "DURATION_TIME");
    location lLocation = GetLocalLocation(oDM, "OMWandLoc");

    AssignCommand (oDM , ApplyEffectAtLocation(nDuration, eEffect, lLocation, fTime));
}

void OmegaVisualEffectToObject(int nEffect)
{
    OmegaEffectToObject(EffectVisualEffect(nEffect));
}
void OmegaVisualEffectAtLocation(int nEffect)
{
    OmegaEffectAtLocation(EffectVisualEffect(nEffect));
}

void ApplyOmegaVisualEffect(int nEffect) {
    object oDM = GetLastSpeaker();
    object oMyTarget = GetLocalObject(oDM, "OMWandTarget");
    location lLocation = GetLocalLocation(oDM, "OMWandLoc");

    if(GetIsObjectValid(oMyTarget))
        OmegaVisualEffectToObject(nEffect);
        else OmegaVisualEffectAtLocation(nEffect);
}
