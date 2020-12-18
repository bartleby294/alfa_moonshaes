//Hardcore Death Info
//Archaegeo 2002 Jun 24
//Updated 26 Jun to support modular design

// This script contains default values for PlayerState and is included in
// any file where PlayerState must be checked.  Other PlayerState's could
// be added here

    int PWS_PLAYER_STATE_ALIVE = 0;
    int PWS_PLAYER_STATE_DYING = 1;
    int PWS_PLAYER_STATE_DEAD = 2;
    int PWS_PLAYER_STATE_STABLE = 3;
    int PWS_PLAYER_STATE_DISABLED = 4;
    int PWS_PLAYER_STATE_RECOVERY = 5;
    int PWS_PLAYER_STATE_STABLEHEAL = 6;
    int PWS_PLAYER_STATE_SUBDUED = 7;
    int PWS_PLAYER_STATE_STAGGERED = 8;

    // Set DMRESERVE to a number of players you want to be online, then when you
    // start your server, set the max number of players to a number higher than
    // DMRESERVE and you will always be able to log on.  This defaults to disabled.
    int DMRESERVE=0;

    // Setting BLEEDSYSTEM to 0 will remove the bleed to death system.
    int BLEEDSYSTEM=1;

    // Setting RESTSYSTEM to 0 will remove rest restrictions from play.
    // (You may also just not put hc_resting in OnPlayerResting
    int RESTSYSTEM=1;

    // Setting BEDROLLSYSTEM to 0 will turn off the functioning of bedrolls and
    // the requirement to have them to rest.
    int BEDROLLSYSTEM=1;

    // Setting LIMITEDRESTHEAL to 0 will allow full healing on each rest (but
    // then why need clerics?
    int LIMITEDRESTHEAL=1;

    // Setting BURNTORCH to 0 will restore torch durations to normal BW settings.
    // Otherwise torches will last 1 hour per BURNTORCH) PER PHB pg 144
    int BURNTORCH=1;

    // RESTBREAK - Controls how long between rests if RESTSYSTEM is used
    int RESTBREAK=8;

    // GIVELEVEL - Sets the level that players start at in your world.
    int GIVELEVEL=1;

    object oMod=GetModule();


    int GPS(object oPC)
    {
      return GetLocalInt(oMod,"PlayerState"+GetName(oPC)+GetPCPublicCDKey(oPC));
    }

    void SPS(object oPC, int nPS)
    {
      SetLocalInt(oMod,"PlayerState"+GetName(oPC)+GetPCPublicCDKey(oPC), nPS);
    }

// HC Items

string ALFA_OBJ_LANTERN = "hc_lantern";
string ALFA_OBJ_MEDBAG = "hc_healkit";
string ALFA_OBJ_HEALKIT = "alfa_healkit";
string ALFA_OBJ_BANDAGES = "alfa_bandages";
string ALFA_OBJ_ACIDFLASK = "hc_acidflask";
string ALFA_OBJ_ALCHFIRE = "hc_alchfire";
string ALFA_OBJ_HOLYWATER = "hc_holywater";
string ALFA_OBJ_TANGLE = "hc_tangle";
string ALFA_OBJ_THUNDER = "hc_thunder";
string ALFA_OBJ_OILFLASK = "hc_oilflask";
string ALFA_OBJ_CLW_POTION = "PotionOfCLW";
string ALFA_OBJ_CMW_POTION =  "PotionOfCMW";
string ALFA_OBJ_CSW_POTION =  "PotionOfCSW";
string ALFA_OBJ_CCW_POTION =  "PotionOfCCW";

