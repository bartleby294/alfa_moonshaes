/******************************************************************
 * Name: alfa_undrtakr_hb
 * Type: OnHeartbeat
 * ---
 * Author: Cereborn
 * Date: 04/05/03
 * ---
 * This script goes in the heartbeat slot of the undertaker
 * (Placeables->Custom->Special->Custom 1->Death Chest) 
 *
 * It attracts intelligent mobs to the player's corpse and gradually
 * hands out his/her belongings to those mobs that come close enough
 ******************************************************************/

 #include "mrg_constants"


// ** Forward Declarations
void debug(string sString);
object GetMostValuableLootItem();
void DestroyItem(object obj);
int IsInNoLootingArea(object oCorpse);
void ClericChatter(object oCleric);
int LootingSuppressed(object oMob);

// ** Constants

// Set this to FALSE to make clerics not loot
int MOB_LOOT_CLERICS_LOOT = TRUE;

// If your clerics loot, this controls whether or not they chatter
int MOB_LOOT_CLERICS_CHATTER = TRUE;

// Turn debugging stmts on/off
int MOB_LOOT_DEBUG = FALSE;

// If a MOB isn't at least to smart, it won't figure out that it can
// take loot off the player
int MOB_LOOT_MIN_INTELLIGENCE = 7;

// Each heartbeat, if a MOB is within MOB_LOOT_DISTANCE, it has
// MOB_LOOT_CHANCE_TO_LOOT percentage chance to take something.
// MOB_LOOT_CHANCE_FOR_ITEM specifies the chance that the mob takes
// the best item the player has.  If it doesn't take an item it takes a
// random amount of gold.  By setting this to 0 you can make the mobs loot
// gold only; by setting to 100, items only.
float MOB_LOOT_DISTANCE = 3.0;
int MOB_LOOT_CHANCE_TO_LOOT = 20;
int MOB_LOOT_CHANCE_FOR_ITEM = 80;

// Each heartbeat, if a MOB is within MOB_LOOT_NOTICE_DISTANCE but not within
// MOB_LOOT_DISTANCE, it has a MOB_LOOT_CHANCE_TO_NOTICE percentage chance to
// notice the corpse and wander over to it.
float MOB_LOOT_NOTICE_DISTANCE = 35.0;
int MOB_LOOT_CHANCE_TO_NOTICE = 10;

// This percentage of the time, the mob will run to the corpse
int MOB_LOOT_CHANCE_TO_RUN = 25;

// If a waypoint with this tag is in the area, the corpse will not be
// looted.
string MOB_LOOT_NO_LOOT_TAG = "NO_LOOTING";

// If an object with this tag is placed on a creature, it will not
// loot.
string MOB_LOOT_CREATURE_SUPPRESS_TAG = "CreatureLootSuppress";

void main()
{
    string sCorpseID;
    object oCorpse;
    location lCorpseLocation;
    object oCorpseArea;
    object oRecord;
    object oItem;
    int nGold;
    int nGoldGiven;
    object oMob;
    int bRun;
    int nCreatureInt;
    int bCleric;

    // If we have nothing left, just kick out
    oItem = GetFirstItemInInventory();
    nGold = GetLocalInt(OBJECT_SELF, ALFA_MORGUE_GOLD);

    if (oItem == OBJECT_INVALID && nGold == 0)
    {
        debug("nothing left to loot...");
        return;
    }

    // Get the morgue record
    oRecord = GetObjectByTag(ALFA_OBJ_MORGUE_RECORD_TAG);

    if (oRecord == OBJECT_INVALID)
    {
        debug("No morgue record found");
        return;
    }

    // Get the corpse ID of the corpse associated with this undertaker
    sCorpseID = GetLocalString(OBJECT_SELF, ALFA_PC_CORPSE_ID);

    if (sCorpseID == "")
    {
        debug("Corpse ID NULL");
        return;
    }

    oCorpse = GetLocalObject(oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID);

    if (oCorpse == OBJECT_INVALID)
    {
        debug("No corpse found for corpse ID " + sCorpseID);
        return;
    }

    if (IsInNoLootingArea(oCorpse))
    {
        debug("Corpse in no looting area");
        return;
    }

    // look for mobs within MOB_LOOT_NOTICE_DISTANCE of tbe corpse; if any
    // (and not within MOB_LOOT_DISTANCE), we may call them over to us
    lCorpseLocation = GetLocation(oCorpse);
    oMob = GetFirstObjectInShape(SHAPE_CUBE, MOB_LOOT_NOTICE_DISTANCE,
        lCorpseLocation, TRUE, OBJECT_TYPE_CREATURE);

    while (oMob != OBJECT_INVALID)
    {
        // Make sure we ignore PCs, familiars, and mobs in combat
        bCleric = (GetIsPlayableRacialType(oMob) &&
            GetLevelByClass(CLASS_TYPE_CLERIC, oMob) > 0);

        debug("mob is " + (bCleric ? "a cleric" : "not a cleric"));

        if (LootingSuppressed(oMob))
        {
            debug("looting suppressed");
            oMob = GetNextObjectInShape(SHAPE_CUBE, MOB_LOOT_NOTICE_DISTANCE,
                lCorpseLocation, TRUE, OBJECT_TYPE_CREATURE);
            continue;
        }

        if (GetIsPC(oMob) || GetIsPC(GetMaster(oMob)) || GetIsInCombat(oMob) ||
           (bCleric && ! MOB_LOOT_CLERICS_LOOT))
        {
            debug("looting inappropriate");
            oMob = GetNextObjectInShape(SHAPE_CUBE, MOB_LOOT_NOTICE_DISTANCE,
                lCorpseLocation, TRUE, OBJECT_TYPE_CREATURE);
            continue;
        }

        nCreatureInt = GetAbilityScore(oMob, ABILITY_INTELLIGENCE);
        if (nCreatureInt >= MOB_LOOT_MIN_INTELLIGENCE)
        {
            // If it's outside the mob loot range, see if it notices the corpse
            if (GetDistanceBetween(oMob, oCorpse) > MOB_LOOT_DISTANCE)
            {
                if (d100() <= MOB_LOOT_CHANCE_TO_NOTICE)
                {
                    debug("loot is calling to " + GetName(oMob));
                    bRun = d100() <= MOB_LOOT_CHANCE_TO_RUN;
                    AssignCommand(oMob, ClearAllActions());
                    AssignCommand(oMob, ActionMoveToObject(oCorpse, bRun,
                        MOB_LOOT_DISTANCE - 0.25));
                }
            }

            else  // In loot range
            {
                if (d100() <= MOB_LOOT_CHANCE_TO_LOOT)
                {
                    // Give it a goody. Item or gold?
                    if (d100() <= MOB_LOOT_CHANCE_FOR_ITEM)
                    {
                        oItem = GetMostValuableLootItem();
                        if (oItem != OBJECT_INVALID)
                        {
                            debug("looting item named " + GetName(oItem));
                            AssignCommand(oMob, ClearAllActions());
                            AssignCommand(oMob, ActionDoCommand(SetFacingPoint(
                               GetPosition(oCorpse))));
                            AssignCommand(oMob, ActionPlayAnimation(
                               ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));

                            if (bCleric && MOB_LOOT_CLERICS_CHATTER)
                            {
                                debug("chatter");
                                ClericChatter(oMob);
                            }

                            CopyObject(oItem, GetLocation(oMob), oMob);
                            DestroyItem(oItem);

                            // only one creature gets to loot in a given
                            // heartbeat.  This gives the POS engine time to
                            // figure out that the item looted is no longer in
                            // our inventory
                            return;
                        }
                    }

                    else
                    {
                        if (nGold > 0)
                        {
                            debug("we have " + IntToString(nGold) + " gold");
                            nGoldGiven = FloatToInt(IntToFloat(nGold) *
                               IntToFloat(d100()) / 100.);
                            // Always give at least one GP
                            if (nGoldGiven == 0)
                            {
                                nGoldGiven = 1;
                            }
                            debug("looting " + IntToString(nGoldGiven) + " gold pieces");
                            AssignCommand(oMob, ClearAllActions());
                            AssignCommand(oMob, ActionDoCommand(SetFacingPoint(
                               GetPosition(oCorpse))));
                            AssignCommand(oMob, ActionPlayAnimation(
                               ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));

                            if (bCleric && MOB_LOOT_CLERICS_CHATTER)
                            {
                                debug("chatter");
                                ClericChatter(oMob);
                            }

                            GiveGoldToCreature(oMob, nGoldGiven);
                            nGold = nGold - nGoldGiven;
                            SetLocalInt(OBJECT_SELF, ALFA_MORGUE_GOLD, nGold);
                            return;
                        }
                    }
                }
            }
        }
        else
        {
            debug(GetName(oMob) + " too dumb to loot");
        }

        oMob = GetNextObjectInShape(SHAPE_CUBE, MOB_LOOT_NOTICE_DISTANCE,
            lCorpseLocation, TRUE, OBJECT_TYPE_CREATURE);

    }

}

// Searches inventory for item with highest gold value
object GetMostValuableLootItem()
{
    object oMostValuable;
    object oCurrentItem;
    int nCurrentValue;
    int nHighestValue = -1;

    oCurrentItem = GetFirstItemInInventory();
    oMostValuable = oCurrentItem;

    while(oCurrentItem != OBJECT_INVALID)
    {
        nCurrentValue = GetGoldPieceValue(oCurrentItem);
        if (nCurrentValue > nHighestValue)
        {
            nHighestValue = nCurrentValue;
            oMostValuable = oCurrentItem;
        }
        oCurrentItem = GetNextItemInInventory();
    }
    debug("value: " + IntToString(nHighestValue));
    return oMostValuable;
}

void debug(string sString)
{
    if (MOB_LOOT_DEBUG)
    {
        SendMessageToAllDMs("ldbg: " + sString);
        WriteTimestampedLogEntry("ldbg: " + sString);
    }
}

void DestroyItem(object obj)
{
   // if this is not a container, just destroy it and we're done
   if (GetHasInventory(obj) == FALSE)
   {
      AssignCommand(obj, SetIsDestroyable(TRUE, FALSE, FALSE));
      DestroyObject(obj);
   }
   else
   {
      object oItem = GetFirstItemInInventory(obj);
      // destroy everything in the inventory first
      while (oItem != OBJECT_INVALID)
      {
         DestroyItem(oItem);
         oItem = GetNextItemInInventory(obj);
      }
      // destroy the container itself
      AssignCommand(obj, SetIsDestroyable(TRUE, FALSE, FALSE));
      DestroyObject(obj);
   }
}

int IsInNoLootingArea(object oCorpse)
{
    object oAreaObject;
    object oCorpseArea;

    oCorpseArea = GetArea(oCorpse);
    oAreaObject = GetFirstObjectInArea(oCorpseArea);
    while(oAreaObject != OBJECT_INVALID)
    {
        if (GetTag(oAreaObject) == MOB_LOOT_NO_LOOT_TAG)
        {
            return TRUE;
        }
        oAreaObject = GetNextObjectInArea(oCorpseArea); 
    }

    return FALSE;
}

void ClericChatter(object oCleric)
{
    string sChatter;
    int nChoice;
    int nLastChoice = GetLocalInt(OBJECT_SELF, "LastClericPhrase");


    // time to gossip; pick a scurrilous remark
    while ((nChoice = d8()) == nLastChoice)
    {
    }

    switch(nChoice)
    {
    case 1:
       sChatter = "Bless you for your generous donation to the church.";
       break;
    case 2:
       sChatter = "Ahhh, we shall sing praise to you this week!";
       break;
    case 3:
       sChatter = "I shall make sure the funds go to the local orphanage.";
       break;
    case 4:
       sChatter = "Salvation is assured! Though you lay in a heap before me, your goods do good even after your passing, yea verily, amen.";
       break;
    case 5:
       sChatter = "I'll need a larger alms plate for this one Brother Henri!";
       break;
    case 6:
       sChatter = "A regular tithe would have been more efficient, my child.";
       break;
    case 7:
       sChatter = "The gods be praised! We can order another barrel of sacramental wine!";
       break;
    case 8:
       sChatter = "Would you look at that? These are all the items he said the church should administer in the event of something untimely.";
       break;
    }
    SetLocalInt(OBJECT_SELF, "LastClericPhrase", nChoice);
    AssignCommand(oCleric, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,
       1.0, 3.0));
    AssignCommand(oCleric, ActionSpeakString(sChatter));
}

int LootingSuppressed(object oMob)
{
    if (GetIsObjectValid(GetItemPossessedBy(oMob,
        MOB_LOOT_CREATURE_SUPPRESS_TAG)))
    {
        return TRUE;
    }

    if (GetLocalInt(oMob, "DoNotLoot"))
    {
        return TRUE;
    }

    return FALSE;
}








