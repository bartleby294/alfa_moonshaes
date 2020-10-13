/******************************************************************
 * Name: alfa_combat
 * Type: ACR Include File
 * ---
 * Authors: Georage, Cereborn
 * Date: 4/03
 *       9/19/03
 * ---
 * Contains miscellaneous combat related functions used for ALFA
 *
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/

//-----------------------WEAPON BREAKAGE SCRIPT--------------------------

// Here are the basics:
//
// This should be part of your nw_c2_default5 script
// Just cut and paste this code BEFORE the last curly brace
// in that script and compile
//
// Weapons are broken down into 4 "quality" levels
//
// Cat1 weapons are defined as being worth 0-100 gp
//    and have a base 1 in 500 chance of  breaking per battle per creature
//
// Cat2 weapons are defined as being worth 101-1,000 gp
//    and have a base 1 in 650 chance of  breaking per battle per creature
//
// Cat3 weapons are defined as being worth 1,001-10,000 gp
//    and have a base 1 in 800 chance of  breaking per battle per creature
//
// Cat4 weapons are defined as being worth more than 10,000 gp
//    and have a base 1 in 1000 chance of  breaking per battle per creature
//
// Placing an item with the tag/resref "golem_token" in a creature's inventory
// doubles the chance a weapon will be broken
//
// Placing this script on the OnDamage event of a placeable
// will double the base chance a weapon will be broken
// NOTE: The script will fire every time the object is damaged
//
// Broken normal weapons have a 1 in 100 chance of damaging the wielder (d4 damage)
//
// Broken magic weapons have a 1 in 100 chance of damaging the wielder (d20 damage)
//
// Broken magic weapons will be moved to the "dm_blacksmith" creature
//    and a "broken weapon" will be placed  in the player's inventory
//    so that the player can have it potentially repaired
//
// NOTE: Only items with the following properties are considered MAGIC WEAPONS
// Enhancement Bonus
// Enhancement Bonus vs Alignment Group
// Enhancement Bonus vs Racial Group
// Enhancement Bonus vs Alignment Group
// Attack Bonus
// Attack Bonus vs Alignment Group
// Attack Bonus vs Racial Group
// Attack Bonus vs Specific Alignment
// AC Bonus
//:://////////////////////////////////////////////


#include "nw_o0_itemmaker" // for HasItem() and GetIsMagical()
#include "alfa_options"

void bkSetupBehavior(int nInt);
object GetNearestPerceivedEnemy(object oSource=OBJECT_SELF, int nNth = 1,
   int nCriteriaType=1000, int nCriteriaValue=1000);

void ALFA_CheckWeaponBreakage()
{
  {
    if (gALFA_WEAPON_BREAKAGE)
    {
    //Set to 1 to damage the player on weapon breaking
    //or Set to 0 to not damage the player on weapon breaking
    int iDoDamage = 1; //default to do damage

    // the PC
    object oPC = GetLastAttacker();

    // the player's enemy
    object oNPC = OBJECT_SELF;

    // the age of the PC
    int iAge = GetAge(oPC);

    // the weapon being used by the player
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);

    // check to see if this is a new attacker
    int iFight;
    //int a = GetLocalInt(oNPC,"iFight");
    //SendMessageToPC(oPC, IntToString(a));
    int iDoOnce = GetLocalInt(oNPC, "iFight");
    if (iDoOnce == 0)
      {
        // only PCs with weapons can break their weapons (prevents unarmed combat glitches)
        if (GetIsPC(GetLastAttacker()) && (oWeapon != OBJECT_INVALID) && (iAge != 0))
          {

            // set local variable on monster so script
            // only runs once per attacker
            SetLocalInt(oNPC, "iFight", 1);
            //int a = GetLocalInt(oPC,"iFight");
            //SendMessageToPC(oPC, IntToString(a));

            // the golem token (optional)
            string sGolemToken = "golem_token";

            // determine value of weapon
            int iWeaponValue = GetGoldPieceValue(oWeapon);

            // declarations we need later
            int iBreak;
            int i_NEW_MWeaponValue;
            int i_NEW_NWeaponValue;

            // the denominator (determined by weapon value)

            // Cat1  (from 0 - 100 gp)
            if (iWeaponValue < 101) iBreak = 500;  // base rate of breakage

            // Cat2  (from 101-1000 gp)
            if (iWeaponValue > 100) iBreak = 650;

            // Cat3  (from 1001-10000 gp)
            if (iWeaponValue > 1000) iBreak = 800;

            // Cat4  (greater than 10000 gp)
            if (iWeaponValue > 10000) iBreak = 1000;

            // a golem token in the creature's inventory doubles the chance of breakage
            if(HasItem(OBJECT_SELF, sGolemToken)) iBreak = iBreak / 2;

            // placing this script on a placeable's OnDamaged event
            // doubles the base chance of weapon breakage
            if(GetObjectType(oNPC) != OBJECT_TYPE_CREATURE) iBreak = iBreak / 2;

            // roll the dice
            int iMightBreak = Random(iBreak);
            //if  (iMightBreak < iBreak) // uncomment this conditional to test the script
            if  (iMightBreak == 0) // BUT comment this out to test the script
              {
                // define and find the NPC blacksmith and his location for copyobject
                object oDMblacksmith = GetObjectByTag("dm_blacksmith");
                location lDMblacksmith = GetLocation(oDMblacksmith);
                object oDMblacksmithchest = GetObjectByTag("dm_blacksmith_chest");
                location lDMblacksmithchest = GetLocation(oDMblacksmithchest);

                // put the weapon we are going to destroy in the inventory of the NPC blacksmith
                //CreateItemOnObject(GetResRef(oWeapon), oDMblacksmith, 1);
                CopyObject(oWeapon, lDMblacksmithchest, oDMblacksmithchest);

                // create "broken weapon" in player inventory
                CreateItemOnObject("broken_weapon", oPC, 1);

                // print message to tell player the bad news
                FloatingTextStringOnCreature("Your weapon broke", oPC, FALSE);

                // destroy weapon
                DestroyObject(oWeapon);

                //----------------
                // magical weapons
                //----------------
                if (GetIsMagical(oWeapon))
                  {
                    // keep track of how many magic weapons are broken
                    int iMWeaponBroke = GetLocalInt(oDMblacksmith, "iMagicWeaponBroke");
                    iMWeaponBroke++;
                    SetLocalInt(oDMblacksmith, "iMagicWeaponBroke", iMWeaponBroke);

                    // keep track of how much broken magic weapons are worth
                    int iMWeaponValue = GetLocalInt(oDMblacksmith, "iMagicWeaponValue");
                    i_NEW_MWeaponValue = iMWeaponValue + iWeaponValue;
                    SetLocalInt(oDMblacksmith, "iMagicWeaponValue", i_NEW_MWeaponValue);

                    // weapon breakage info
                    string sW = (IntToString(iMWeaponBroke));
                    string sPCname = GetName(oPC);
                    string sMonsterName = GetName(OBJECT_SELF);
                    string sArea = GetTag(GetArea(OBJECT_SELF));
                    string sWeaponTag = GetTag(oWeapon);
                    string sWeaponName = GetName(oWeapon);
                    SetLocalArrayString(oDMblacksmith, sW, 1, sW);
                    SetLocalArrayString(oDMblacksmith, sW, 2, sPCname);
                    SetLocalArrayString(oDMblacksmith, sW, 3, sMonsterName);
                    SetLocalArrayString(oDMblacksmith, sW, 4, sArea);
                    SetLocalArrayString(oDMblacksmith, sW, 5, sWeaponTag);
                    SetLocalArrayString(oDMblacksmith, sW, 6, sWeaponName);
                    PrintString("MAGIC WEAPON BROKEN: It was bad day for "+sPCname
                      +" when his "+sWeaponName +"("+sWeaponTag+") shattered on "+sMonsterName +" in "+sArea);

                    //Create visual effect
                    effect eDur = EffectVisualEffect(VFX_IMP_FROST_L);
                    //Apply the effect
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDur, oPC);

                    // roll for damage
                    int iDamage = Random(100);
                    if ((iDamage == 0) && (iDoDamage == 1))
                      {
                        // tell player his own weapon attacked him
                        FloatingTextStringOnCreature("... and injured you", oPC, FALSE);

                        // roll d20 to determine extent of damage
                        int iOuch = d20();

                        // define "damage" effect
                        effect dmgEffect = EffectDamage(iOuch,DAMAGE_TYPE_PIERCING,DAMAGE_POWER_NORMAL);

                        // damage player
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,dmgEffect,oPC);
                      }
                  }

                //----------------
                // normal weapons
                //----------------
                if (!GetIsMagical(oWeapon))
                  {

                    // keep track of how many normal weapons are broken
                    int iNWeaponBroke = GetLocalInt(oDMblacksmith, "iWeaponBroke");
                    iNWeaponBroke++;
                    SetLocalInt(oDMblacksmith, "iWeaponBroke", iNWeaponBroke);

                    // keep track of the value of broken normal weapons
                    int iNWeaponValue = GetLocalInt(oDMblacksmith, "iWeaponValue");
                    i_NEW_NWeaponValue = iNWeaponValue + iWeaponValue;
                    SetLocalInt(oDMblacksmith, "iWeaponValue", i_NEW_NWeaponValue);

                    // roll for damage
                    int iDamage = Random(100);
                    if ((iDamage == 0) && (iDoDamage == 1))
                      {
                        // message to tell player his own weapon injured him
                        FloatingTextStringOnCreature("... and injured you", oPC, FALSE);

                        // roll d4 to determine extent of damage
                        int iOuch = d4();

                        // define "damage" effect
                        effect dmgEffect = EffectDamage(iOuch,DAMAGE_TYPE_PIERCING,DAMAGE_POWER_NORMAL);

                        // damage player
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,dmgEffect,oPC);
                      }
                  }
              }
          }
      }
    }
   }
}

void ALFA_CheckClearCombat()
{

  // george added to  clear iFight variable for weapon breakage

  if(GetAttemptedAttackTarget() == OBJECT_INVALID &&
     GetAttemptedSpellTarget() == OBJECT_INVALID)
  {
    if(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
        OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN) ==
        OBJECT_INVALID)
    {
      object oNPC = OBJECT_SELF;
      int iFight;

      SetLocalInt(oNPC, "iFight", 0);
    }
  }
}

// Stolen and modified from x0_inc_generic

object ALFA_ChooseDifferentTarget(object oAttacker, object oCurrentTarget)
{
    int nHatedClass = GetLocalInt(oAttacker, "NW_L_BEHAVIOUR1") - 1;

    // * if the object has no hated class, then assign it
    // * a random one.
    // * NOTE: Classes are off-by-one
    if (nHatedClass == -1)
    {
        bkSetupBehavior(1);
        nHatedClass = GetLocalInt(oAttacker, "NW_L_BEHAVIOUR1") - 1;
    }

    // * First try to attack the class you hate the most.  If the nearest hated
    // enemy is not the current target, we're done.

    object oTarget = GetNearestPerceivedEnemy(oAttacker, 1,
                                              CREATURE_TYPE_CLASS,
                                              nHatedClass);

    if (GetIsObjectValid(oTarget) && (oTarget != oCurrentTarget))
    {
      return oTarget;
    }

    // Otherwise, get the next one and return it (if any)
    oTarget = GetNearestPerceivedEnemy(oAttacker, 2, CREATURE_TYPE_CLASS,
      nHatedClass);

    if (GetIsObjectValid(oTarget))
    {
        return oTarget;
    }

    // There was no hated enemy (or the current target was the only one.
    // Use the same logic to find the closest enemy that's not the current
    // target (or if none, OBJECT_INVALID will be returned

    oTarget = GetNearestPerceivedEnemy();

    if (GetIsObjectValid(oTarget) && (oTarget != oCurrentTarget))
    {
        return oTarget;
    }

    oTarget = GetNearestPerceivedEnemy(oAttacker, 2);
    return oTarget;
}

int ALFA_CheckForUnconsciousTarget(object oAttacker, object oTarget,
   int nSubdualOnly=FALSE)
{
  if (!GetIsObjectValid(oTarget))
  {
    return FALSE;
  }

  if (!GetIsDead(oTarget))
  {
    return FALSE;
  }

  if (nSubdualOnly)
  {
    // See if attacker is in subdual mode
    int nSubdualMode = GetLocalInt(oAttacker, "SubdualMode");
    if (nSubdualMode)
    {
      return TRUE;
    }

    // If the subdualOnly flag was true, then the caller wants to be told about
    // unconscious targets if they've been subdued.  Since the attacker is not
    // in subdual mode, we return false (even though the target *is* unconscious).
    return FALSE;
  }

  return TRUE;
}


