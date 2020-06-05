//void main(){}//::///////////////////////////////
//:: Name: XES: EXTREME ENVIRONMENTS SYSTEM v1.2
//:: FileName: uc_xenvironment
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Extreme Environments
    ============================

    Create equippable items with the prefix "_XHT" (extreme hot), "_XCD"
    (extreme cold), or "_XUW" (underwater) in order to make them into protective
    gear against the extreme environments the PC is in and prevents environmental
    damage. Near the top of the Constants section are string constants,
    ALT_PROT_FLAG_HEAT, ALT_PROT_FLAG_COLD, and ALT_PROT_FLAG_UNDERWATER, which
    can have their values changes to meet your module's needs by providing a way
    to tap into cutom (alternative) tag modifiers you may already be using for
    protective items in your module. Both the script's default tag modiers and
    the alternative tag modifiers will be checked to see if the PC has the
    appropriate protective gear equipped in an extreme environment.

    The vanilla script supports the following Alternative Tag Modifiers:
        "_cool" (extreme hot environment protection tag modifier)
        "_warm" (extreme cold environment protection tag modifier)
        "_underwater" (extreme underwater environment protection tag modifier)

    In Extreme Hot Environments protective wear, such as clothing, will only
    protect you so much while in the middle of a desert, thus while protective
    wear will slightly reduce the amount of heat damage, together with a
    waterskin or like item (a full waterskin has 50 charges; each failed extreme
    heat check slightly reduces heat damage and decrements the charges by 1)
    will keep heat damage to nothing or a minimal amount. To make an item a water
    containing item to count againt heat damage add to its tag the tag modifier
    "_XWater". Don't forget to add a specified amount of charges and added weight
    to your custom water containing item. A Waterskin (50 charges; weight of 3.5)
    item is provided with XES under "Paint Items\Custom\Special\Custom 1".

    For Underwater environment protective items with a "_XUW" or alternative tag
    modifier there is a visual air bubble looking effect that encompasses a PC
    if this is equipped when they are underwater; an item so tagged will provide
    breathable air and protect them from decompression.

    Change the value of line 55 (XENVIRO_NONE) for the DEFAULT_XENVIRO constant
    with one of the constants listed in line 42-45 (ie. XENVIRO_NONE, XENVIRO_HOT,
    XENVIRO_COLD, or XENVIRO_UNDERWATER) to make one of them a defacto default
    environment to apply to all areas that refer to this script or drop an
    appropriate waypoint with one of the following tags into each of your areas
    that best suits them (the script's default environment will be overridden
    by the waypoint specified environment (if it exists) for a particular area):

        WP_XENVIRO_HOT (extreme hot environment)
        WP_XENVIRO_COLD (extreme cold environment)
        WP_XENVIRO_UW (underwater environment)

    Two thoughts about protective gear:

    1) You can have (equippable or non-equippable) protective items that are
    magical in nature and thus all you need to do is give them fire or cold
    damage immunity or resistance or whatever, which can be added via the item
    properties. These items will help protect their possessor vs all type of
    fire or cold damage, whether magical, or environmental, etc. Falling into
    this group of items are underwater items (these as magical in nature and
    equippable only - ie. Necklace of Adaptation), that depend on the XES script
    for their functionality since this is for a custom extreme environment.

    2) Environmental protective gear (equippable gear) (and water containing
    items like Waterskins for the extreme hot environments), that aide in
    protecting one from the natural elements of the wilds, are most typically
    clothing  that will protect one from the ravages of  nature, but would offer
    no protection from the like of the actual damaging effects of fire or ice
    whether magical or non-magical (like from a spell effect, or a trap, etc.).
    These are the type of items that I have scripted as part of the XES
    (underwater items being an exception to the protective items scripted as
    these are magical items; see 1) above).

    Extreme Altitude
    ============================

    Change the value of line XX (XALTITUDE_NORMAL) for the DEFAULT_XALTITUDE
    constant with one of the constants XALTITUDE_NORMAL, XALTITUDE_MODERATE,
    XALTITUDE_HIGH, XALTITUDE_VERYHIGH, or XALTITUDE_EXTREME to make one of them
    a defacto default altitude to apply to all areas that refer to this script
    or drop appropriate multiple waypoints with one of the following tags into
    each of your areas that best suits them:

        WP_XALTITUDE_NORMAL
        WP_XALTITUDE_MODERATE
        WP_XALTITUDE_HIGH
        WP_XALTITUDE_VERYHIGH
        WP_XALTITUDE_EXTREME

    Make ALFA Animal Companions or any other custom creatures underwater-based
    natural inhabitants by adding "_UW" to their Tag; these do not suffer from
    lack of oxygen or slow movement as do their surface counterparts.

    In creating Underwater areas change the area Visual properties of Ambient
    Color, Diffuse Color, Fog Color, etc. to a variety of turqoise and blues.
    Also, bring Fog ammount to Max and you may want to play with the Wind Power
    setting (personally, wind power above min doesn't look as realistic).
*/
//:://////////////////////////////////////////////
//:: Created By: Shawn (U'lias) Marcil for ALFA
//:: Created On: Oct. 25, 2003
//:: Inspired By: Extreme Cold script by Georage
//::
//:: Last Modified By: Shawn (U'lias) Marcil
//:: Last Modified On: November 14, 2003
//:://////////////////////////////////////////////

/******************************************************************************/
/* Constants                                                                  */
/******************************************************************************/

/** You may alter the following constant **/

const int XENVIROS_DEBUG = FALSE;
// Alternative Tag modifiers (flags) that can also exist in item tags beyond this
// script's build-in default flags for extreme environment protection.
// Note: you can change these following 3 string constant values to tag modifiers
// that suit your needs (ie. you may already have items with tags that use
// specific flags different from this default script).
const string ALT_PROT_FLAG_HEAT = "_cool";
const string ALT_PROT_FLAG_COLD = "_warm";
const string ALT_PROT_FLAG_UNDERWATER = "_underwater";
const string ALT_PROT_FLAG_CRUSHING_DEPTH = "_deepwater";

const int SHOW_XENVIROS_SAVE_ROLLS = FALSE;
// Shows message to PC that they have acclimated to a certain environment
const int SHOW_XENVIROS_ACCLIMATION_MSG = TRUE;
// Time to delay between Extreme Environment checks in seconds
const float CHECK_DELAY = 15.0;
// Base DC (Difficulty Challenge) vs Fortitude for PC to make a saving throw
// against suffering from extreme environmental and/or altitude effects
const int DC_BASE = 40;
// Extra fire damage during daytime (peak) hours in Extreme Hot Environment
const int DAMAGE_DAY_HEAT = 2;
// Base fire damage during nighttime hours in Extreme Hot Environment;
// Deserts should not incur heat damage at night so default value is "0", but
// environments like volcanic areas and any planes of hell are always hot so
// adjust as desired.
const int DAMAGE_NIGHT_HEAT = 0;
// Base cold damage during daytime hours in Extreme Cold Environment
const int DAMAGE_DAY_COLD = 1;
// Extra cold damage during nighttime (peak) hours in Extreme Cold Environment
const int DAMAGE_NIGHT_COLD = 2;
// Base per cent drowning/suffocation damage (based on PC's max HPs) during
// off-peak hours in Extreme Underwater Environment; can apply to environments
// without oxygen
const int DAMAGE_SUFFOCATE_PERCENT = 5;

// Extra environmental damage increments when in peak season for Extreme
// Environment; the season leading up to the peak season will do 1 damage and
// the peak season damage will do twice that value (unless its "0")
const int DAMAGE_EXTRA_SEASONAL = 1;
// Extreme Altitude DC modifiers according to the current altitude the PC is at;
// these modify the PC's chance to save vs altitude sickness at the various altitudes
const int DC_MOD_XALTITUDE_MODERATE = 4;
const int DC_MOD_XALTITUDE_HIGH = 8;
const int DC_MOD_XALTITUDE_VERY_HIGH = 16;
const int DC_MOD_XALTITUDE_EXTREME = 32;

/** Do not alter the following constants **/

// Extreme Environment types
const int XENVIRO_NONE = 0;
const int XENVIRO_HOT = 1;
const int XENVIRO_COLD = 2;
const int XENVIRO_UNDERWATER = 3;
const int XENVIRO_CRUSHING_DEPTH = 4;
// Seasons
const int SEASON_WINTER = 0;
const int SEASON_SPRING = 1;
const int SEASON_SUMMER = 2;
const int SEASON_FALL = 3;
// Extreme Altitude types
const int XALTITUDE_NORMAL = 0;
const int XALTITUDE_MODERATE = 1;
const int XALTITUDE_HIGH = 2;
const int XALTITUDE_VERY_HIGH = 3;
const int XALTITUDE_EXTREME = 4;
// Default Extreme Altitude Z position if an XAltitude Waypoint is not detected
const float XALTITUDE_RANGE_NONE = 99999.0;
// Altitude sickness types
const int SICKNESS_MILD = 1;
const int SICKNESS_MODERATE = 2;
const int SICKNESS_ACUTE = 3;

/** You may alter the following constant **/

// the default extreme environment when an extreme environment flag cannot be found;
const int DEFAULT_XENVIRO = XENVIRO_NONE;
const int DEFAULT_XALTITUDE = XALTITUDE_NORMAL;

/******************************************************************************/
/* Function Definitions                                                       */
/******************************************************************************/

// oTarget makes a fortitude save vs nDC.
// * Return value depends on how badly oTarget fails the save
// - SICKNESS_ACUTE if oTarget fails by 10 or more
// - SICKNESS_MODERATE if oTarget fails by 5 or more
// - SICKNESS_MILD if oTarget fails
// - 0 if oTarget makes the save
//int ExposureSave(object oTarget, int nDC);

/******************************************************************************/
/* NWScript Implementation                                                    */
/******************************************************************************/

string XENVIROS_LocToString(location lLocation)
{
    string      sAreaTag = GetTag(GetAreaFromLocation(lLocation));
    vector      vPosition = GetPositionFromLocation(lLocation);
    float       fFacing = GetFacingFromLocation(lLocation);
    string      sLocString;

    sLocString = "!Area!" + sAreaTag +
        "!Pos_x!" + FloatToString(vPosition.x) +
        "!Pos_y!" + FloatToString(vPosition.y) +
        "!Pos_z!" + FloatToString(vPosition.z) +
        "!Orientation!" + FloatToString(fFacing) + "!";

    return sLocString;
}

int XENV_GetXEnvironmentType(object oArea)
{
    object oWaypoint = GetFirstObjectInArea(oArea);
    string sWPPrefix = "WP_XENVIRO";
    string sWaypointTag;
    int nXEnvironmentType;

    while(GetIsObjectValid(oWaypoint))
    {
        sWaypointTag = GetStringUpperCase(GetTag(oWaypoint));
        if (    (GetObjectType(oWaypoint) == OBJECT_TYPE_WAYPOINT) &&
                (GetStringLeft(sWaypointTag, 10) == sWPPrefix)  )
            break;
        oWaypoint = GetNextObjectInArea(oArea);
    }

    if (FindSubString(sWaypointTag, "_HOT") > 0)
        nXEnvironmentType = XENVIRO_HOT;
    else if (FindSubString(sWaypointTag, "_COLD") > 0)
        nXEnvironmentType = XENVIRO_COLD;
    else if (FindSubString(sWaypointTag, "_UW") > 0)
        nXEnvironmentType = XENVIRO_UNDERWATER;
    else if (FindSubString(sWaypointTag, "_CRUW") > 0)
        nXEnvironmentType = XENVIRO_CRUSHING_DEPTH;
    else if (DEFAULT_XENVIRO != XENVIRO_NONE)
        nXEnvironmentType = DEFAULT_XENVIRO;
    else nXEnvironmentType = XENVIRO_NONE;

    if (XENVIROS_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "sWaypointTag = " + sWaypointTag);
        SendMessageToPC(GetFirstPC(), "nXEnvironmentType = " +
            IntToString(nXEnvironmentType));
    }

    return nXEnvironmentType;
}

string XENV_GetXEnviroSuffix(int nXEnvironmentType)
{
    string sXEnviroSuffix;

    if (nXEnvironmentType == XENVIRO_HOT) sXEnviroSuffix = "_XHT";
    else if (nXEnvironmentType == XENVIRO_COLD) sXEnviroSuffix = "_XCD";
    else if (nXEnvironmentType == XENVIRO_UNDERWATER) sXEnviroSuffix = "_XUW";
    else if (nXEnvironmentType == XENVIRO_CRUSHING_DEPTH) sXEnviroSuffix = "_XCRUW";

    if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "sXEnviroSuffix = " + sXEnviroSuffix);

    return sXEnviroSuffix;
}

string XENV_GetXEnviroSuffixAlt(int nXEnvironmentType)
{
    string sXEnviroSuffixAlt;

    if (nXEnvironmentType == XENVIRO_HOT) sXEnviroSuffixAlt = ALT_PROT_FLAG_HEAT;
    else if (nXEnvironmentType == XENVIRO_COLD) sXEnviroSuffixAlt = ALT_PROT_FLAG_COLD;
    else if (nXEnvironmentType == XENVIRO_UNDERWATER) sXEnviroSuffixAlt = ALT_PROT_FLAG_UNDERWATER;
    else if (nXEnvironmentType == XENVIRO_CRUSHING_DEPTH) sXEnviroSuffixAlt = ALT_PROT_FLAG_CRUSHING_DEPTH;

    if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "sXEnviroSuffixAlt = " + sXEnviroSuffixAlt);

    return sXEnviroSuffixAlt;
}

int XENV_HasProtectiveItemEquipped(object oPC, int nXEnvironmentType)
{
    object oItem;
    string sXEnviroSuffix = XENV_GetXEnviroSuffix(nXEnvironmentType);
    string sXEnviroSuffixAlt = XENV_GetXEnviroSuffixAlt(nXEnvironmentType);
    int bHasProtItemEquipped = FALSE;
    int nSlot = 0;

    while (nSlot <= 10)
    {
        switch (nSlot)
        {
            case 0: oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC); break;
            case 1: oItem = GetItemInSlot(INVENTORY_SLOT_BELT, oPC); break;
            case 2: oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC); break;
            case 3: oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC); break;
            case 4: oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC); break;
            case 5: oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC); break;
            case 6: oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC); break;
            case 7: oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC); break;
            case 8: oItem = GetItemInSlot(INVENTORY_SLOT_NECK, oPC); break;
            case 9: oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC); break;
            case 10: oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC); break;
        }

        if (    (GetIsObjectValid(oItem)) &&
                (   (FindSubString(GetStringUpperCase(GetTag(oItem)), sXEnviroSuffix) > 0) ||
                    (FindSubString(GetTag(oItem), sXEnviroSuffixAlt) > 0)  )   )
        {
            bHasProtItemEquipped = TRUE;
            break;
        }

        nSlot++;
    }

    if (XENVIROS_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "nSlot = " + IntToString(nSlot));
        SendMessageToPC(GetFirstPC(), "bHasProtItemEquipped = " +
            IntToString(bHasProtItemEquipped));
    }

    return bHasProtItemEquipped;
}

int XENV_HasWaterInInventory(object oPC)
{
    object oItem = GetFirstItemInInventory(oPC);
    object oContainerInvItem;
    string sWaterSuffix = "_XWater";
    string sItemTag;
    int bHasWaterInInventory = FALSE;
    int nCharges;

    while (GetIsObjectValid(oItem))
    {
        sItemTag = GetTag(oItem);
        if (FindSubString(sItemTag, sWaterSuffix) > 0)
        {
            bHasWaterInInventory = TRUE;
            break;
        }
        if (GetHasInventory(oItem))
        {
            oContainerInvItem = GetFirstItemInInventory(oItem);
            while (GetIsObjectValid(oContainerInvItem))
            {
                sItemTag = GetTag(oContainerInvItem);
                if (FindSubString(sItemTag, sWaterSuffix) > 0)
                {
                    bHasWaterInInventory = TRUE;
                    break;
                }
                oContainerInvItem = GetNextItemInInventory(oItem);
            }
        }
        if (bHasWaterInInventory == TRUE) break;
        oItem = GetNextItemInInventory(oPC);
    }

    if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "bHasWaterInInventory = " + IntToString(bHasWaterInInventory));

    if (bHasWaterInInventory == TRUE)
    {
        oItem = GetItemPossessedBy(oPC, sItemTag);
        nCharges = GetItemCharges(oItem);

        if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "nCharges = " + IntToString(nCharges));

        if (nCharges > 1)
        {
            nCharges = nCharges - 1;
            SetItemCharges(oItem, nCharges);

            if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "nCharges2 = " + IntToString(nCharges));
        }
        else DestroyObject(oItem);
    }

    return bHasWaterInInventory;
}

int XENV_GetCurrentSeason(int nCurrentMonth)
{
    int nCurrentSeason;

    switch(nCurrentSeason)
    {
        case 12: case 1: case 2: nCurrentSeason = SEASON_WINTER; break;
        case 3: case 4: case 5: nCurrentSeason = SEASON_SPRING; break;
        case 6: case 7: case 8: nCurrentSeason = SEASON_SUMMER; break;
        case 9: case 10: case 11: nCurrentSeason = SEASON_FALL; break;
    }

    if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "nCurrentSeason = " + IntToString(nCurrentSeason));

    return nCurrentSeason;
}

int XENV_GetExtraSeasonalDamage(int nXEnvironmentType)
{
     // get the module's current calender month
    int nCurrentMonth = GetCalendarMonth();
    int nCurrentSeason = XENV_GetCurrentSeason(nCurrentMonth);
    int nExtraSeasonalDamage = 0;

    if (nXEnvironmentType == XENVIRO_HOT)
    {
        if (nCurrentSeason == SEASON_SPRING)
        {
            nExtraSeasonalDamage = DAMAGE_EXTRA_SEASONAL;
            if (nExtraSeasonalDamage <= 0) nExtraSeasonalDamage = 0;
        }
        else if (nCurrentSeason == SEASON_SUMMER)
        {
            nExtraSeasonalDamage = DAMAGE_EXTRA_SEASONAL * 2;
            if (nExtraSeasonalDamage <= 0) nExtraSeasonalDamage = 0;
        }
    }
    else if (nXEnvironmentType == XENVIRO_COLD)
    {
        if (nCurrentSeason == SEASON_FALL)
        {
            nExtraSeasonalDamage = DAMAGE_EXTRA_SEASONAL;
            if (nExtraSeasonalDamage <= 0) nExtraSeasonalDamage = 0;
        }
        else if (nCurrentSeason == SEASON_WINTER)
        {
            nExtraSeasonalDamage = DAMAGE_EXTRA_SEASONAL * 2;
            if (nExtraSeasonalDamage <= 0) nExtraSeasonalDamage = 0;
        }
    }

    if (XENVIROS_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "nCurrentMonth = " + IntToString(nCurrentMonth));
        SendMessageToPC(GetFirstPC(), "nExtraSeasonalDamage = " + IntToString(nExtraSeasonalDamage));
    }

    return nExtraSeasonalDamage;
}

void XENV_CheckXEnvironmentEffects(object oArea, object oPC, int nXEnvironmentType)
{
    string sXEnviroMessage;
    int nDC = DC_BASE;
    int nPCMaxHp = GetMaxHitPoints(oPC);
    int nConMod = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
    int nBaseSave = GetFortitudeSavingThrow(oPC) + nConMod;
    int bSavingThrowFailed = FALSE;
    int nSavingThrowType, nSeasonalDamage, nBaseDamage, nDamage, nDamageType;
    int nRoll, nSaveResult;
    effect eEffectDamage, eVis;

    if (nXEnvironmentType == XENVIRO_HOT)
    {
        sXEnviroMessage = "Heat damage!";
        nSavingThrowType = SAVING_THROW_TYPE_FIRE;
        nSeasonalDamage = XENV_GetExtraSeasonalDamage(nXEnvironmentType);

        if (GetIsDay()) nBaseDamage = DAMAGE_DAY_HEAT;
        else nBaseDamage = DAMAGE_NIGHT_HEAT;

        nDamage = nBaseDamage + nSeasonalDamage;

        nDamageType = DAMAGE_TYPE_FIRE;
        eVis = EffectVisualEffect(VFX_IMP_FLAME_S);

        if (XENV_HasProtectiveItemEquipped(oPC, nXEnvironmentType))
        {
            nDamage = nDamage - 2;
            if (nDamage <= 0) nDamage = 0;
            if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "PC is has appropriate protective item equipped.");
        }

        if (nDamage > 0)
        {
            if (XENV_HasWaterInInventory(oPC)) nDamage = nDamage - 2;
            if (nDamage <= 0) nDamage = 0;
        }
    }
    else if (nXEnvironmentType == XENVIRO_COLD)
    {
        sXEnviroMessage = "Cold damage!";
        nSavingThrowType = SAVING_THROW_TYPE_COLD;
        nSeasonalDamage = XENV_GetExtraSeasonalDamage(nXEnvironmentType);

        if (GetIsNight()) nBaseDamage = DAMAGE_NIGHT_COLD;
        else nBaseDamage = DAMAGE_DAY_COLD;

        nDamage = nBaseDamage + nSeasonalDamage;

        nDamageType = DAMAGE_TYPE_COLD;
        eVis = EffectVisualEffect(VFX_IMP_FROST_S);

        if (XENV_HasProtectiveItemEquipped(oPC, nXEnvironmentType))
        {
            nDamage = 0;
            if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "PC is has appropriate protective item equipped.");
        }
    }
    else if (nXEnvironmentType == XENVIRO_UNDERWATER)
    {
        sXEnviroMessage = "Drowning damage!";
        nBaseDamage = (DAMAGE_SUFFOCATE_PERCENT * nPCMaxHp) / 100;
        nDamageType = DAMAGE_TYPE_DIVINE;
        eVis = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
        nDamage = d2(); //lowered from 5% to d2 nBaseDamage;
        nRoll = d20(1);
        nSaveResult = nRoll + nBaseSave;

        if (XENV_HasProtectiveItemEquipped(oPC, nXEnvironmentType))
        {
            nDamage = 0;
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BUBBLES), oPC, CHECK_DELAY);
            if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "*A bubble of breathable air forms around your head*");
        }
    }

    else if (nXEnvironmentType == XENVIRO_CRUSHING_DEPTH)
    {
        sXEnviroMessage = "Crushing and Drowning damage!";
        nBaseDamage = (DAMAGE_SUFFOCATE_PERCENT * nPCMaxHp) / 100;
        nDamageType = DAMAGE_TYPE_DIVINE;
        eVis = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
        effect eCrush = EffectDamage(d6(), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_ENERGY);
        eVis = EffectLinkEffects(eVis, eCrush);
        nDamage = nBaseDamage;
        nRoll = d20(1);
        nSaveResult = nRoll + nBaseSave;

        if (XENV_HasProtectiveItemEquipped(oPC, nXEnvironmentType))
        {
            nDamage = 0;
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BUBBLES), oPC, CHECK_DELAY);
            if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "*A bubble of breathable air forms around your head*");
        }
    }

    if (XENVIROS_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "nSavingThrowType = " + IntToString(nSavingThrowType));
        SendMessageToPC(GetFirstPC(), "nDamageType = " + IntToString(nDamageType));
        SendMessageToPC(GetFirstPC(), "nBaseDamage = " + IntToString(nBaseDamage));
        SendMessageToPC(GetFirstPC(), "nDamage = " + IntToString(nDamage));
    }

    //if (    (nBaseDamage <= 0) || (nDamage <= 0)  )
    if (nDamage <= 0)
    {
        if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "No Extreme Environmental Damage!");
        return;
    }

    if (    (nXEnvironmentType == XENVIRO_HOT) ||
            (nXEnvironmentType == XENVIRO_COLD)    )
    {
        if (!FortitudeSave(oPC, nDC, nSavingThrowType))
        {
            bSavingThrowFailed = TRUE;
        }
    }
    else if (nXEnvironmentType == XENVIRO_UNDERWATER || nXEnvironmentType == XENVIRO_CRUSHING_DEPTH)
    {
        if (nRoll == 20) // automatic success
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Suffocation: *automatic success* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
        }
        else if (nRoll == 1) // automatic failure
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Suffocation: *automatic failure* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
            bSavingThrowFailed = TRUE;
        }
        else if (nSaveResult < nDC) // failure
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Suffocation: *failure* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
            bSavingThrowFailed = TRUE;
        }
        else
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Suffocation: *success* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
        }
    }

    if (bSavingThrowFailed == TRUE)
    {
        FloatingTextStringOnCreature(sXEnviroMessage, oPC, FALSE);

        if (  (GetCurrentHitPoints(oPC) == 1) && (nDamage == 1)    )
            nDamage = nDamage + 1;

        eEffectDamage = EffectDamage(nDamage, nDamageType, DAMAGE_POWER_ENERGY);
        //Apply the VFX impact and damage effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffectDamage, oPC);
        AssignCommand(oPC, ClearAllActions(TRUE));
    }
}

string XALT_GetWPSuffix(int nXAltitudeType)
{
    string sWPSuffix;

    if (nXAltitudeType == XALTITUDE_NORMAL)
        sWPSuffix = "_NORMAL";
    else if (nXAltitudeType == XALTITUDE_MODERATE)
        sWPSuffix = "_MODERATE";
    else if (nXAltitudeType == XALTITUDE_HIGH)
        sWPSuffix = "_HIGH";
    else if (nXAltitudeType == XALTITUDE_VERY_HIGH)
        sWPSuffix = "_VERYHIGH";
    else if (nXAltitudeType == XALTITUDE_EXTREME)
        sWPSuffix = "_EXTREME";

    if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "sWPSuffix = " + sWPSuffix);

    return sWPSuffix;
}

float XALT_GetXAltitude(object oWaypoint)
{
    location lLocation = GetLocation(oWaypoint);
    vector vPosition = GetPositionFromLocation(lLocation);
    float fPosZ = vPosition.z;

    if (XENVIROS_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "Location of Waypoint" + XENVIROS_LocToString(lLocation));
        SendMessageToPC(GetFirstPC(), "fPosZ of Waypoint" + FloatToString(fPosZ));
    }

    return fPosZ;
}

object XALT_GetWaypoint(object oArea, int nXAltitudeType)
{
    object oWaypoint = GetFirstObjectInArea(oArea);
    string sWPPrefix = "WP_XALTITUDE";
    string sWPSuffix = XALT_GetWPSuffix(nXAltitudeType);
    string sWPTag;

    while (GetIsObjectValid(oWaypoint))
    {
        sWPTag = GetTag(oWaypoint);

        // Check if nearest waypoint object is an Altitude Waypoint and
        // in the same area as the PC
        if (    (GetObjectType(oWaypoint) == OBJECT_TYPE_WAYPOINT) &&
                (GetStringLeft(sWPTag, 12) == sWPPrefix)  &&
                (FindSubString(sWPTag, sWPSuffix) > 0)    )
        {
            if (XENVIROS_DEBUG)
            {
                SendMessageToPC(GetFirstPC(), "Waypoint Name = " + GetName(oWaypoint));
            }
            break;
        }
        oWaypoint = GetNextObjectInArea(oArea);
    }

    return oWaypoint;
}

float XALT_GetMaxZRange(object oArea, int nXAltitudeType)
{
    object oWaypoint = XALT_GetWaypoint(oArea, nXAltitudeType);
    float fMaxRange;

    if (GetIsObjectValid(oWaypoint)) fMaxRange = XALT_GetXAltitude(oWaypoint);
    else fMaxRange = XALTITUDE_RANGE_NONE;

    if (XENVIROS_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "fMaxRange = " + FloatToString(fMaxRange));
    }

    return fMaxRange;
}

int XALT_GetXAltitudeDCModifier(int nXAltitudeType)
{
    int nXAltitudeDCMofifier;

    if (nXAltitudeType == XALTITUDE_NORMAL)
        nXAltitudeDCMofifier = 0;
    else if (nXAltitudeType == XALTITUDE_MODERATE)
        nXAltitudeDCMofifier = DC_MOD_XALTITUDE_MODERATE;
    else if (nXAltitudeType == XALTITUDE_HIGH)
        nXAltitudeDCMofifier = DC_MOD_XALTITUDE_HIGH;
    else if (nXAltitudeType == XALTITUDE_VERY_HIGH)
        nXAltitudeDCMofifier = DC_MOD_XALTITUDE_VERY_HIGH;
    else if (nXAltitudeType == XALTITUDE_EXTREME)
        nXAltitudeDCMofifier = DC_MOD_XALTITUDE_EXTREME;

    if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "nXAltitudeDCMofifier = " + IntToString(nXAltitudeDCMofifier));

    return nXAltitudeDCMofifier;
}

int XALT_ExposureSave(object oPC, int nDC, int nXEnvironmentType)
{
    int nRoll, nSaveResult, nSicknessType;
    int nConMod = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
    int nBaseSave = GetFortitudeSavingThrow(oPC) + nConMod;

    nRoll = d20(1);
    nSaveResult = nRoll + nBaseSave;

    if (nRoll == 20)
    {
        nSicknessType = 0; // automatic success

        if (nXEnvironmentType != XENVIRO_UNDERWATER && nXEnvironmentType != XENVIRO_CRUSHING_DEPTH)
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Altitude Sickness: *automatic success* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
        }
        else
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Decompression Sickness: *automatic success* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
        }
    }
    else if (nRoll == 1)
    {
        nSicknessType = SICKNESS_ACUTE; // automatic failure

        if (nXEnvironmentType != XENVIRO_UNDERWATER && nXEnvironmentType != XENVIRO_CRUSHING_DEPTH)
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Altitude Sickness: *automatic failure* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
            FloatingTextStringOnCreature("Acute Altitude sickness!", oPC, FALSE);
        }
        else
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude vs Decompression Sickness: *automatic failure*: (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
            FloatingTextStringOnCreature("Acute Decompression sickness!", oPC, FALSE);
        }
    }
    else if (nSaveResult < nDC)
    {
        if (nXEnvironmentType != XENVIRO_UNDERWATER && nXEnvironmentType != XENVIRO_CRUSHING_DEPTH)
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Altitude Sickness: *failure* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
        }
        else
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Decompression Sickness: *failure* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
        }
        if (nRoll  < (nDC - 10))
        {
            nSicknessType = SICKNESS_ACUTE;
            if (nXEnvironmentType != XENVIRO_UNDERWATER && nXEnvironmentType != XENVIRO_CRUSHING_DEPTH)
                FloatingTextStringOnCreature("Acute Altitude sickness!", oPC, FALSE);
            else FloatingTextStringOnCreature("Acute Decompression sickness!", oPC, FALSE);
        }
        else if (nRoll < (nDC - 5))
        {
            nSicknessType = SICKNESS_MODERATE;
        if (nXEnvironmentType != XENVIRO_UNDERWATER && nXEnvironmentType != XENVIRO_CRUSHING_DEPTH)
                FloatingTextStringOnCreature("Moderate Altitude sickness!", oPC, FALSE);
            else FloatingTextStringOnCreature("Moderate Decompression sickness!", oPC, FALSE);

        }
        else
        {
            nSicknessType = SICKNESS_MILD;
            if (nXEnvironmentType != XENVIRO_UNDERWATER && nXEnvironmentType != XENVIRO_CRUSHING_DEPTH)
                FloatingTextStringOnCreature("Mild Altitude sickness!", oPC, FALSE);
            else FloatingTextStringOnCreature("Mild Decompression sickness!", oPC, FALSE);
        }
    }
    else
    {
        nSicknessType = 0;
        if (nXEnvironmentType != XENVIRO_UNDERWATER && nXEnvironmentType != XENVIRO_CRUSHING_DEPTH)
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Altitude Sickness: *success* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
        }
        else
        {
            if (SHOW_XENVIROS_SAVE_ROLLS)
            {
                SendMessageToPC(oPC, "Fortitude Save vs Decompression Sickness: *success* : (" +
                    IntToString(nRoll) + " + " + IntToString(nBaseSave) +
                    " = " + IntToString(nSaveResult) + " vs DC " +
                    IntToString(nDC) + ")");
            }
        }
    }

    if (XENVIROS_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "nBaseSave = " + IntToString(nBaseSave));
        SendMessageToPC(GetFirstPC(), "nRoll = " + IntToString(nRoll));
        SendMessageToPC(GetFirstPC(), "nSicknessType = " + IntToString(nSicknessType));
    }

    return nSicknessType;
}

void XALT_CheckXAltitudeEffects(object oPC, int nXAltitudeType, int nXEnvironmentType)
{
    int nExposure = GetLocalInt(oPC, "nXAltExposure");
    int nSicknessType = 0;
    int bIsPCAcclimated = TRUE;
    int bCheckXAltitudeEffect = TRUE;
    int nCurrentPCXAlt, nXAltitudeDCMofifier, nDC;
    effect eWeak, eDaze1, eDaze2, eFatigued, eDazed, eKnockDown;
    effect eDam = EffectDamage(nXAltitudeType, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_ENERGY);
    effect eLink;

    if (nXEnvironmentType != XENVIRO_UNDERWATER && nXEnvironmentType != XENVIRO_CRUSHING_DEPTH)
    {
        nCurrentPCXAlt = GetCampaignInt("XES", "nCurrentXAltitude", oPC);
        if (nXAltitudeType == XALTITUDE_NORMAL)
        {
            bCheckXAltitudeEffect = FALSE;
            SetCampaignInt("XES", "nCurrentXAltitude", XALTITUDE_NORMAL, oPC);
            if (nCurrentPCXAlt >= XALTITUDE_MODERATE)
            {
                // give new altitude warning
                FloatingTextStringOnCreature("You are now at a Normal Altitude. The air is at normal richness.", oPC, FALSE);
            }
        }
        else if (nXAltitudeType == XALTITUDE_MODERATE)
        {
            SetCampaignInt("XES", "nCurrentXAltitude", XALTITUDE_MODERATE, oPC);
            if (nCurrentPCXAlt == XALTITUDE_NORMAL)
            {
                bCheckXAltitudeEffect = FALSE; // new altitude
                // give new altitude warning
                FloatingTextStringOnCreature("You are now at a Moderate Altitude. The air has gotten thinner.", oPC, FALSE);
            }
            else if (nCurrentPCXAlt == XALTITUDE_HIGH)
            {
                bCheckXAltitudeEffect = FALSE; // new altitude
                // give new altitude warning
                FloatingTextStringOnCreature("You are now at a Moderate Altitude. The air is getting richer.", oPC, FALSE);
            }
        }
        else if (nXAltitudeType == XALTITUDE_HIGH)
        {
            SetCampaignInt("XES", "nCurrentXAltitude", XALTITUDE_HIGH, oPC);
            if (nCurrentPCXAlt == XALTITUDE_MODERATE)
            {
                bCheckXAltitudeEffect = FALSE; // new altitude
                // give new altitude warning
                FloatingTextStringOnCreature("You are now at a High Altitude. The air has gotten thinner.", oPC, FALSE);
            }
            else if (nCurrentPCXAlt == XALTITUDE_VERY_HIGH)
            {
                bCheckXAltitudeEffect = FALSE; // new altitude
                // give new altitude warning
                FloatingTextStringOnCreature("You are now at a High Altitude. The air is getting richer.", oPC, FALSE);
            }
        }
        else if (nXAltitudeType == XALTITUDE_VERY_HIGH)
        {
            SetCampaignInt("XES", "nCurrentXAltitude", XALTITUDE_VERY_HIGH, oPC);
            if (nCurrentPCXAlt == XALTITUDE_HIGH)
            {
                bCheckXAltitudeEffect = FALSE; // new altitude
                // give new altitude warning
                FloatingTextStringOnCreature("You are now at a Very High Altitude. The air has gotten thinner.", oPC, FALSE);
            }
            else if (nCurrentPCXAlt == XALTITUDE_EXTREME)
            {
                bCheckXAltitudeEffect = FALSE; // new altitude
                // give new altitude warning
                FloatingTextStringOnCreature("You are now at a Very High Altitude. The air is getting richer.", oPC, FALSE);
            }
        }
        else if (nXAltitudeType == XALTITUDE_EXTREME)
        {
            SetCampaignInt("XES", "nCurrentXAltitude", XALTITUDE_VERY_HIGH, oPC);
            if (nCurrentPCXAlt == XALTITUDE_VERY_HIGH)
            {
                bCheckXAltitudeEffect = FALSE; // new altitude
                // give new altitude warning
                FloatingTextStringOnCreature("You are now at an Extreme Altitude. The air has gotten thinner.", oPC, FALSE);
            }
        }
    }

    if (bCheckXAltitudeEffect == FALSE) nExposure = 0; // start PC exposure at new altitude

    // Get XES database value for whether or not the PC continues to suffer
    // from altitude sickness (TRUE or FALSE)
    if (nXAltitudeType == XALTITUDE_MODERATE)
    {
        bIsPCAcclimated = GetCampaignInt("XES", "bIsPCAcclimatedMod", oPC);
    }
    else if (nXAltitudeType == XALTITUDE_HIGH)
    {
        bIsPCAcclimated = GetCampaignInt("XES", "bIsPCAcclimatedHi", oPC);
    }
    else if (nXAltitudeType == XALTITUDE_VERY_HIGH)
    {
        bIsPCAcclimated = GetCampaignInt("XES", "bIsPCAcclimatedVHi", oPC);
    }
    else if (nXAltitudeType == XALTITUDE_EXTREME)
    {
        bIsPCAcclimated = GetCampaignInt("XES", "bIsPCAcclimatedEx", oPC);
    }

    if (XENVIROS_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "nExposure = " + IntToString(nExposure));
        SendMessageToPC(GetFirstPC(), "bIsPCAcclimated = " + IntToString(bIsPCAcclimated));
    }

    // check for XAlt effects if the PC is not acclimated and bCheckXAltitudeEffect
    // is TRUE (PC is at normal altitude or is detected at new Extreme Altitude)
    if (    (bIsPCAcclimated != TRUE) && (bCheckXAltitudeEffect == TRUE)    )
    {
        // Determine if PC will be affected, and how badly
        nXAltitudeDCMofifier = XALT_GetXAltitudeDCModifier(nXAltitudeType);
        nDC = 10 + nExposure + nXAltitudeDCMofifier;
        nSicknessType = XALT_ExposureSave(oPC, nDC, nXEnvironmentType);

        if (XENVIROS_DEBUG)
        {
            SendMessageToPC(GetFirstPC(), "nDC = " + IntToString(nDC));
            SendMessageToPC(GetFirstPC(), "nSicknessType = " + IntToString(nSicknessType));
        }

        if (nSicknessType != 0)
        {
            switch (nSicknessType)
            {
                case SICKNESS_MILD:  // Mild altitude sickness
                    eLink = EffectAbilityDecrease(ABILITY_STRENGTH, 1);
                    break;
                case SICKNESS_MODERATE:  // Moderate altitude sickness
                    eWeak = EffectAbilityDecrease(ABILITY_STRENGTH, 3);
                    eDaze1 = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 1);
                    eDaze2 = EffectAbilityDecrease(ABILITY_WISDOM, 1);
                    eFatigued = EffectMovementSpeedDecrease(10);
                    eLink = EffectLinkEffects(eWeak, eDaze1);
                    eLink = EffectLinkEffects(eLink, eDaze2);
                    eLink = EffectLinkEffects(eLink, eFatigued);
                    AssignCommand(oPC, ActionDoCommand(ClearAllActions(TRUE)));
                    break;
                case SICKNESS_ACUTE:  // Acute altitude sickness
                    eWeak = EffectAbilityDecrease(ABILITY_STRENGTH, 6);
                    eDaze1 = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 4);
                    eDaze2 = EffectAbilityDecrease(ABILITY_WISDOM, 4);
                    eFatigued = EffectMovementSpeedDecrease(50);
                    eDazed = EffectDazed();
                    eKnockDown = EffectKnockdown();
                    eLink = EffectLinkEffects(eWeak, eDaze1);
                    eLink = EffectLinkEffects(eLink, eDaze2);
                    eLink = EffectLinkEffects(eLink, eFatigued);
                    eLink = EffectLinkEffects(eLink, eDazed);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC);
                    AssignCommand(oPC, ActionDoCommand(ClearAllActions(TRUE)));
                    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockDown, oPC, 4.0));
                    break;
                default: break;
            }
            //Apply the effects
            AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, CHECK_DELAY));
        }
        else // they succeeded sickness check
        {
            // Set XES database value to TRUE so that PC does not continue to
            // suffer from altitude sickness for a particular altitude as they
            // have acclimatized

            if (nXAltitudeType == XALTITUDE_MODERATE)
            {
                SetCampaignInt("XES", "bIsPCAcclimatedMod", TRUE, oPC);
                if (SHOW_XENVIROS_ACCLIMATION_MSG) SendMessageToPC(oPC, "You have become acclimated to a Moderate Altitude.");
            }
            else if (nXAltitudeType == XALTITUDE_HIGH)
            {
                SetCampaignInt("XES", "bIsPCAcclimatedMod", TRUE, oPC);
                SetCampaignInt("XES", "bIsPCAcclimatedHi", TRUE, oPC);
                if (SHOW_XENVIROS_ACCLIMATION_MSG) SendMessageToPC(oPC, "You have become acclimated to a High Altitude.");
            }
            else if (nXAltitudeType == XALTITUDE_VERY_HIGH)
            {
                SetCampaignInt("XES", "bIsPCAcclimatedMod", TRUE, oPC);
                SetCampaignInt("XES", "bIsPCAcclimatedHi", TRUE, oPC);
                SetCampaignInt("XES", "bIsPCAcclimatedVHi", TRUE, oPC);
                if (SHOW_XENVIROS_ACCLIMATION_MSG) SendMessageToPC(oPC, "You have become acclimated to a Very High Altitude.");
            }
            else if (nXAltitudeType == XALTITUDE_EXTREME)
            {
                SetCampaignInt("XES", "bIsPCAcclimatedMod", TRUE, oPC);
                SetCampaignInt("XES", "bIsPCAcclimatedHi", TRUE, oPC);
                SetCampaignInt("XES", "bIsPCAcclimatedVHi", TRUE, oPC);
                SetCampaignInt("XES", "bIsPCAcclimatedEx", TRUE, oPC);
                if (SHOW_XENVIROS_ACCLIMATION_MSG) SendMessageToPC(oPC, "You have become acclimated to an Extreme Altitude.");
            }
        }

    }
    else if (bCheckXAltitudeEffect == FALSE)
    {
        // skip Extreme Altitude checking this time
    }

    //Increment how long a PC has been in the area at an above normal altitude
    SetLocalInt(oPC, "nXAltExposure", nExposure + 1);
}

int XALT_XAltWaypointErrorChecking(object oPC, float fNormalMax, float fModerateMax, float fHighMax, float fVeryHighMax)
{
    int bHasAltWPError = FALSE;
    object oArea = GetArea(oPC);

    // Cease XAltitude checking if the Normal XAltitude Waypoint is
    // not present and the Moderate XAltitude Waypoint is
    if (    (fNormalMax == 99999.0) && (fModerateMax != 99999.0)  )
    {
        if (XENVIROS_DEBUG) SendMessageToPC(oPC, "Missing the Normal XAltitude Waypoint.");
        WriteTimestampedLogEntry("Extreme Environments ERROR detected -- area " +
            GetName(oArea) + " (" + GetTag(oArea) +
            ") is missing the Normal XAltitude Waypoint.");
        bHasAltWPError = TRUE;
    }
    // Cease XAltitude checking if the Moderate XAltitude Waypoint is
    // not present and the High XAltitude Waypoint is
    if (    (fModerateMax == 99999.0) && (fHighMax != 99999.0)  )
    {
        if (XENVIROS_DEBUG) SendMessageToPC(oPC, "Missing the Moderate XAltitude Waypoint.");
        WriteTimestampedLogEntry("Extreme Environments ERROR detected -- area " +
            GetName(oArea) + " (" + GetTag(oArea) +
            ") is missing the Moderate XAltitude Waypoint.");
        bHasAltWPError = TRUE;
    }

    // Cease XAltitude checking if the High XAltitude Waypoint is
    // not present and the Very High XAltitude Waypoint is
    if (    (fHighMax == 99999.0) && (fVeryHighMax != 99999.0)  )
    {
        if (XENVIROS_DEBUG) SendMessageToPC(oPC, "Missing the High XAltitude Waypoint.");
        WriteTimestampedLogEntry("Extreme Environments ERROR detected -- area " +
            GetName(oArea) + " (" + GetTag(oArea) +
            ") is missing the High XAltitude Waypoint.");
        bHasAltWPError = TRUE;
    }

    return bHasAltWPError;
}

void XALT_CheckPCXAltitude(object oArea, object oPC, int nXEnvironmentType)
{
    int bHasAltWPError = FALSE;
    location lLocation = GetLocation(oPC);
    vector vPosition = GetPositionFromLocation(lLocation);
    float fPCPosZ = vPosition.z;
    float fNormalMax, fModerateMax, fHighMax, fVeryHighMax;

    if (XENVIROS_DEBUG)
    {
        SendMessageToPC(oPC, "oPC Name = " + GetName(oPC));
        SendMessageToPC(oPC, "Location of PC" + XENVIROS_LocToString(lLocation));
        SendMessageToPC(oPC, "fPCPosZ of PC" + FloatToString(fPCPosZ));
    }

    // The upper (max) Z (height) position of the Normal XAltitude Waypoint
    fNormalMax = XALT_GetMaxZRange(oArea, XALTITUDE_NORMAL);
    // The upper (max) Z (height) position of the Moderate XAltitude Waypoint
    fModerateMax = XALT_GetMaxZRange(oArea, XALTITUDE_MODERATE);
    // The upper (max) Z (height) position of the High XAltitude Waypoint
    fHighMax = XALT_GetMaxZRange(oArea, XALTITUDE_HIGH);
    // The upper (max) Z (height) position of the Very High XAltitude Waypoint
    fVeryHighMax = XALT_GetMaxZRange(oArea, XALTITUDE_VERY_HIGH);

    // check for XAlt waypoint placement error
    bHasAltWPError = XALT_XAltWaypointErrorChecking(oPC, fNormalMax, fModerateMax, fHighMax, fVeryHighMax);

    //exit altitude checking if a XAlt waypoint placement error was found
    if (bHasAltWPError == TRUE) return;

    if (nXEnvironmentType != XENVIRO_UNDERWATER && nXEnvironmentType != XENVIRO_CRUSHING_DEPTH)
    {
        // Check if the PC's Z position falls into any of the XAltitude Z position
        // ranges
        //if (    (fPCPosZ >= 0.0) && (fPCPosZ <= fNormalMax)   )
        if (fPCPosZ <= fNormalMax)
        {
             // PC is at a Normal Altitude
            if (XENVIROS_DEBUG) SendMessageToPC(oPC, "PC at Normal Altitude");
            // PC does not have a potential for altitude sickness;
            // Reset PC's exposure duration
            SetLocalInt(oPC, "nXAltExposure", 0);
            return;
        }
        else if (fPCPosZ <= fModerateMax) // PC is at an Moderate Altitude
        {
            if (XENVIROS_DEBUG) SendMessageToPC(oPC, "PC at Moderate Altitude");
            // PC has a potential for altitude sickness
            XALT_CheckXAltitudeEffects(oPC, XALTITUDE_MODERATE, XENVIRO_NONE);
        }
        else if (fPCPosZ <= fHighMax) // PC is at a High Altitude
        {
            if (XENVIROS_DEBUG) SendMessageToPC(oPC, "PC at High Altitude");
            // PC has a potential for altitude sickness
            XALT_CheckXAltitudeEffects(oPC, XALTITUDE_HIGH, XENVIRO_NONE);
        }
        else if (fPCPosZ <= fVeryHighMax) // PC is at a Very High Altitude
        {
            if (XENVIROS_DEBUG) SendMessageToPC(oPC, "PC at Very High Altitude");
            // PC has a potential for altitude sickness
            XALT_CheckXAltitudeEffects(oPC, XALTITUDE_VERY_HIGH, XENVIRO_NONE);
        }
        else if (fPCPosZ > fVeryHighMax) // PC is at an Extreme Altitude
        {
            if (XENVIROS_DEBUG) SendMessageToPC(oPC, "PC at Extreme Altitude");
            // PC has a potential for altitude sickness
            XALT_CheckXAltitudeEffects(oPC, XALTITUDE_EXTREME, XENVIRO_NONE);
        }
    }
    else
    {
        // Check if the PC's Z position falls into any of the XAltitude Z position
        // ranges
        if (fPCPosZ >= fNormalMax) // PC is at a Normal Depth
        {
            if (XENVIROS_DEBUG) SendMessageToPC(oPC, "PC at Normal Depth");
            // PC does not have a potential for pressure sickness;
            // Reset PC's exposure duration
            SetLocalInt(oPC, "nXAltExposure", 0);
            return;
        }
        else if (fPCPosZ >= fModerateMax) // PC is at an Moderate Depth
        {
            if (XENVIROS_DEBUG) SendMessageToPC(oPC, "PC at Moderate Depth");
            // If PC does not have protective Underwater gear
            if (!XENV_HasProtectiveItemEquipped(oPC, nXEnvironmentType))
            {
                // PC has a potential for pressure sickness
                XALT_CheckXAltitudeEffects(oPC, XALTITUDE_MODERATE, XENVIRO_UNDERWATER);
            }
        }
        else if (fPCPosZ >= fHighMax) // PC is at a Low Depth
        {
            if (XENVIROS_DEBUG) SendMessageToPC(oPC, "PC at Low Depth");
            // If PC does not have protective Underwater gear
            if (!XENV_HasProtectiveItemEquipped(oPC, nXEnvironmentType))
            {
                // PC has a potential for pressure sickness
                XALT_CheckXAltitudeEffects(oPC, XALTITUDE_HIGH, XENVIRO_UNDERWATER);
            }
        }
        else if (fPCPosZ > fVeryHighMax) // PC is at a Very Low Depth
        {
            if (XENVIROS_DEBUG) SendMessageToPC(oPC, "PC at Very Low Depth");
            // If PC does not have protective Underwater gear
            if (!XENV_HasProtectiveItemEquipped(oPC, nXEnvironmentType))
            {
                // PC has a potential for pressure sickness
                XALT_CheckXAltitudeEffects(oPC, XALTITUDE_VERY_HIGH, XENVIRO_UNDERWATER);
            }
        }
        else if (fPCPosZ <= fVeryHighMax) // PC is at an Extreme Depth
        {
            if (XENVIROS_DEBUG) SendMessageToPC(oPC, "PC at Extreme Depth");
            // If PC does not have protective Underwater gear
            if (!XENV_HasProtectiveItemEquipped(oPC, nXEnvironmentType))
            {
                // PC has a potential for pressure sickness
                XALT_CheckXAltitudeEffects(oPC, XALTITUDE_EXTREME, XENVIRO_UNDERWATER);
            }
        }
    }
}

int XENVIROS_HasFreedomOfMovement(object oCreature)
{
    object oItem;
    int bHasFreedomOfMovement = FALSE;
    int nSlot = 0;

    if (GetHasSpellEffect(SPELL_FREEDOM_OF_MOVEMENT, oCreature))
        bHasFreedomOfMovement = TRUE;
    else
    {
        while (nSlot <= 10)
        {
            switch (nSlot)
            {
                case 0: oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oCreature); break;
                case 1: oItem = GetItemInSlot(INVENTORY_SLOT_BELT, oCreature); break;
                case 2: oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oCreature); break;
                case 3: oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oCreature); break;
                case 4: oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oCreature); break;
                case 5: oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature); break;
                case 6: oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature); break;
                case 7: oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oCreature); break;
                case 8: oItem = GetItemInSlot(INVENTORY_SLOT_NECK, oCreature); break;
                case 9: oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCreature); break;
                case 10: oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oCreature); break;
            }

            if (    (GetIsObjectValid(oItem)) &&
                    (GetItemHasItemProperty(oItem, ITEM_PROPERTY_FREEDOM_OF_MOVEMENT))   )
            {
                bHasFreedomOfMovement = TRUE;
                break;
            }
            nSlot++;
        }
    }

    if (XENVIROS_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "bHasFreedomOfMovement = " +
            IntToString(bHasFreedomOfMovement));
    }

    return bHasFreedomOfMovement;
}

int XENVIROS_IsUnderwaterCreature(object oCreature)
{
    int bIsUnderwaterCreature = FALSE;

    if (FindSubString(GetTag(oCreature), "_UW") > 0)
        bIsUnderwaterCreature = TRUE;

    return bIsUnderwaterCreature;
}

void XENVIROS_CheckUnderwaterMovement(object oCreature)
{
    int bHasFreedomOfMovement = XENVIROS_HasFreedomOfMovement(oCreature);

    //Cloak of the Manta Ray
    int bManta = FindSubString(GetTag(GetItemInSlot(INVENTORY_SLOT_CLOAK)), "manta");
    if(bManta > 1)
        {
            bHasFreedomOfMovement = TRUE;
            effect eManta = EffectModifyAttacks(1);
            eManta = EffectLinkEffects(eManta,EffectMovementSpeedIncrease(75));
            eManta = EffectLinkEffects(eManta, EffectACIncrease(3, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eManta, oCreature, CHECK_DELAY);
        }

    //Swim check
    else if(GetIsSkillSuccessful(oCreature, SKILL_SWIM, 20))
        bHasFreedomOfMovement = TRUE;

    //Slow the PC
    else if  (bHasFreedomOfMovement == FALSE)
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectMovementSpeedDecrease(75), oCreature, CHECK_DELAY);
}

void XENVIROS_NPCUnderwaterMovement(object oArea)
{
    object oCreature = GetFirstObjectInArea(oArea);

    while (GetIsObjectValid(oCreature))
    {
        if (    (GetObjectType(oCreature) == OBJECT_TYPE_CREATURE) &&
                (   (!GetIsPC(oCreature)) ||
                    (!GetIsDM(oCreature))   ) &&
                (!XENVIROS_IsUnderwaterCreature(oCreature)) )
        {
             XENVIROS_CheckUnderwaterMovement(oCreature);
        }
        oCreature = GetNextObjectInArea(oArea);
    }
}

void XENVIROS_RemoveAssociates(object oPC)
{
    object oAssociate;

    // Remove ALFA Animal Companion
    oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
    if (    (GetIsObjectValid(oAssociate)) &&
            (   (GetLevelByClass(CLASS_TYPE_ANIMAL, oAssociate)) ||
                (GetLevelByClass(CLASS_TYPE_BEAST, oAssociate)) ||
                (GetLevelByClass(CLASS_TYPE_VERMIN, oAssociate))  ) &&
            (XENVIROS_IsUnderwaterCreature(oAssociate) == FALSE)   )
    {
        if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "Removed Henchman " + GetName(oAssociate) + ".");
        RemoveHenchman(oPC, oAssociate);
        DestroyObject(oAssociate);
        SendMessageToPC(oPC, "Your animal companion " + GetName(oAssociate) + " refuses to remainUnderwater.");
    }
    // Remove Animal Companion
    oAssociate = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    if (    (GetIsObjectValid(oAssociate)) &&
            (XENVIROS_IsUnderwaterCreature(oAssociate) == FALSE)   )
    {
    if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "Removed Animal Companion " + GetName(oAssociate) + ".");
        RemoveSummonedAssociate(oPC, oAssociate);
        DestroyObject(oAssociate);
        SendMessageToPC(oPC, "Your animal companion " + GetName(oAssociate) + " refuses to remain Underwater.");
    }

    // Remove Familiar
    oAssociate = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    if (    (GetIsObjectValid(oAssociate)) &&
            (XENVIROS_IsUnderwaterCreature(oAssociate) == FALSE)  )
    {
        if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "Removed Familiar " + GetName(oAssociate) + ".");
        RemoveSummonedAssociate(oPC, oAssociate);
        DestroyObject(oAssociate);
        SendMessageToPC(oPC, "Your familiar " + GetName(oAssociate) + " refuses to remain Underwater.");
    }

    // Remove Summoned Creature
    oAssociate = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    if (    (GetIsObjectValid(oAssociate))  &&
            (XENVIROS_IsUnderwaterCreature(oAssociate) == FALSE)   )
    {
        if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "Removed Summoned Creature " + GetName(oAssociate) + ".");
        RemoveSummonedAssociate(oPC, oAssociate);
        DestroyObject(oAssociate);
        SendMessageToPC(oPC, "Your summoned creature " + GetName(oAssociate) + " refuses to remain Underwater.");
    }

}

void XENVIRO_CheckMovementEffect(object oCreature)
{
    effect eEffect = GetFirstEffect(oCreature);

    while (GetIsEffectValid(eEffect))
    {
        if (GetEffectType(eEffect) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
        {
            RemoveEffect(oCreature, eEffect);
            break;
        }
        eEffect = GetNextEffect(oCreature);
    }
   if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "Has Movement Decrease effect = " + IntToString(GetIsEffectValid(eEffect)));
}

void XENVIROS_Main(object oArea)
{
    int nNumPCs = GetLocalInt(oArea, "nNumPCs");

    if (nNumPCs == 0) return;

    object oPC = GetFirstPC();
    object oItem;
    int nXEnvironmentType = XENV_GetXEnvironmentType(oArea);
    int nXAltitudeType;

    while(GetIsObjectValid(oPC))
    {
        if (    (GetArea(oPC) == GetArea(oArea)) &&
                (GetIsPC(oPC)) && (!GetIsDM(oPC))   )
        {
            // Check if the PC is in an Extreme Underwater Environment or not
            if (nXEnvironmentType == XENVIRO_UNDERWATER)
            {
                if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "Checking Extreme Depth Effects for a Underwater Environment.");
                XENVIROS_RemoveAssociates(oPC);
                XALT_CheckPCXAltitude(oArea, oPC, XENVIRO_UNDERWATER);
            }
            else
            {
                if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "Checking Extreme Altitude Effects for a non-Underwater Environment.");
                XALT_CheckPCXAltitude(oArea, oPC, XENVIRO_NONE);
            }

            if (nXEnvironmentType != XENVIRO_NONE)
            {
                if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "This area has an Extreme Environment!");

                if (XENV_GetXEnvironmentType(oArea) == XENVIRO_UNDERWATER)
                    XENVIROS_CheckUnderwaterMovement(oPC);

                if (XENVIROS_DEBUG)
                {
                    SendMessageToPC(GetFirstPC(), "Checking Extreme Environment Effects");
                }
                XENV_CheckXEnvironmentEffects(oArea, oPC, nXEnvironmentType);
            }
            else
            {
                if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "No need to check for Extreme Environment Effects.");
            }
        }
        oPC = GetNextPC();
    }
    if (XENV_GetXEnvironmentType(oArea) == XENVIRO_UNDERWATER)
        XENVIROS_NPCUnderwaterMovement(oArea);

    DelayCommand(CHECK_DELAY, XENVIROS_Main(oArea));
    if (XENVIROS_DEBUG)
    {
        DelayCommand(CHECK_DELAY, SendMessageToPC(GetFirstPC(), "Delayed Extreme Environment Check..."));
    }
}

void XENVIROS_AreaOnEnter(object oEnteringObject, object oArea, int bIsVFSInstalled)
{
    object oWP;
    location lLocation;

    int nNumPCs = GetLocalInt(oArea, "nNumPCs");

    if (bIsVFSInstalled == FALSE)
    {
        // Increment the number of PCs in the area by 1 for each PC entering the area
        if (    (GetIsPC(oEnteringObject)) && (!GetIsDM(oEnteringObject)) &&
            (!GetIsDMPossessed(oEnteringObject))  )
        {
            nNumPCs = nNumPCs + 1;
            SetLocalInt(oArea, "nNumPCs", nNumPCs);
        }
    }

    if (nNumPCs == 1)
    {
        SetLocalInt(oArea, "XEnvironmentCheck", TRUE);
        if (    (GetIsPC(oEnteringObject)) && (!GetIsDM(oEnteringObject)) &&
            (!GetIsDMPossessed(oEnteringObject))  )
        {
            // If the area is an Underwater Extreme Environment
            if (XENV_GetXEnvironmentType(oArea) == XENVIRO_UNDERWATER)
            {
                // Removes all Summoned Creatures, Familars, Animal Companions,
                // and animal/vermin/beast type Henchmen
                XENVIROS_RemoveAssociates(oEnteringObject);
                // Apply slow movement to PC to mimic water motion if applicable
                XENVIROS_CheckUnderwaterMovement(oEnteringObject);
            }
            DelayCommand(CHECK_DELAY, XENVIROS_Main(oArea));
        }
        else
        {   if (XENV_GetXEnvironmentType(oArea) == XENVIRO_UNDERWATER)
            {
                // Apply slow movement to NPCs to mimic water motion if applicable
                XENVIROS_NPCUnderwaterMovement(oArea);
            }
        }
    }

    if (XENVIROS_DEBUG) SendMessageToPC(oEnteringObject, "Entering nNumPCs = " + IntToString(nNumPCs));
}

void XENVIROS_AreaOnExit(object oExitingObject, object oArea, int bIsVFSInstalled)
{
    int nNumPCs = GetLocalInt(oArea, "nNumPCs");

    if (bIsVFSInstalled == FALSE)
    {
        // Decrement the number of PCs in the area by 1 for each PC exiting the area
        if (    (GetIsPC(oExitingObject)) && (!GetIsDM(oExitingObject))
            && (!GetIsDMPossessed(oExitingObject))    )
        {
            nNumPCs = nNumPCs - 1;
            SetLocalInt(oArea, "nNumPCs", nNumPCs);
        }
    }

    // PC no longer in a higher altitude area, delete the local variable
    // that tracks how long PC has been exposed to high altitudes
    DeleteLocalInt(oExitingObject, "nXAltExposure");
    // Remove the Decrease Movement effect if exiting object was underwater if
    // applicable
    if (XENV_GetXEnvironmentType(oArea) == XENVIRO_UNDERWATER)
    {
        if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "Exited area " + GetName(oArea) + "... Removing Underwater movement effect.");
        XENVIRO_CheckMovementEffect(oExitingObject);
    }

   if (nNumPCs == 0)
   {
        DeleteLocalInt(oArea, "XEnvironmentCheck");
        if (XENVIROS_DEBUG) SendMessageToPC(GetFirstPC(), "No need to check for Extreme Altitude Effects in area " + GetName(oArea) + ".");
   }

   if (XENVIROS_DEBUG) SendMessageToPC(oExitingObject, "Exiting nNumPCs = " + IntToString(nNumPCs));
}
