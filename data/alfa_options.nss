/******************************************************************
 * Name: alfa_options
 * Type: ACR Include File
 * ---
 * Author: Cereborn
 * Date: 11/11/03
 *
 * Updates: Murky Majare
 * Date: 08/10/04
 *
 * ---
 * Contains option flags used for ALFA.  Users may configure optional
 * components of the ACR by changing flag values in this file.
 *
 ******************************************************************/

#include "alfa_constants"
#include "x2_inc_switches"

// Destroy loot on mobs when EL > CR is too high
// Set to TRUE if you want this to happen
// Currently the admins want this set to FALSE
const int gALFA_DESTROY_LOOT_ON_HIGH_EL = FALSE;

// Weapon Breakage system
// Set to TRUE if you want this to happen
// Currently the admins want this set to FALSE
const int gALFA_WEAPON_BREAKAGE = FALSE;

// Global Weather System
//
// Set to TRUE if you want this system on
const int gALFA_USE_GLOBAL_WEATHER = TRUE;

// Global Skies System
//
// Set to TRUE if you want this system on
const int gALFA_USE_GLOBAL_SKIES = FALSE;

// Danmar's Puppet Master
//
// Set to TRUE if you want to use the puppet master functionality
const int gALFA_USE_PUPPET_MASTER = TRUE;

// Familiar persistency
//
// - 0: The player need only rest to be able to
//      summon their familiar again
// - 1: The player must advance a level of wizard
//      or sorcerer to be able to summon their
//      familiar again
// - 2: The player requires Dungeonmaster
//      intervention to ever be able to summon
//      their familiar again.
// Default is set to 1. Do not change this uness allowed by the Admins
const int PFP_PERMANENT_DEATH = 1;

// Persistent Location System Constants
//
// Auto Char Location Save On or Off
const int gALFA_LOCATION_SAVE_TIMER = TRUE;

// Auto Char Location Save Interval (seconds)
const float gALFA_LOCATION_SAVE_INTERVAL  = 45.0;

// Display text to the PC that their location has been saved.
const int gALFA_LOCATION_SAVE_DISPLAYTEXT = FALSE;

const int gALFA_SAVE_DM_LOC = FALSE;

const int gALFA_MODULE_HAS_UNIQUE_AREA_TAGS = FALSE;

  // Development Setting that will automatically bypass all of the Central Auth code
  //      regardless of the individual switch settings.
  //      Effectively setting this to true makes the following switch changes...
  //      SOS_PLAYER_AUTOCREATE = TRUE
  //      SOS_ALLOW_MULTIPLE_CHARACTERS = TRUE
const int gALFA_TEST_MODE = TRUE;

// The default environment when an environment flag cannot be found;
// AC_ENVIRO_NONE will result in no animal companions being summoned if there
// is not an environment flag found.  Other options can be found in
// alfa_constants
const int gAC_DEFAULT_ENVIRONMENT = AC_ENVIRO_NONE;

// Option for setting persistent time on the server. Auto is set
// to FALSE. Also included are three constants for setting the
// inital time. This is only important on first time useage of
// this system

const int gALFA_PERSISTENT_TIME = FALSE;

const int gALFA_TIME_DAY = 1;
const int gALFA_TIME_MONTH = 6;
const int gALFA_TIME_YEAR = 1373;

 // ALFA Gobal Weather variables
const int ALFA_WEATHER_CHANCE_AREA_DEFAULT = 0;
const int ALFA_WEATHER_CHANCE_OVERCAST = 20;
const int ALFA_WEATHER_CHANCE_RAINY = 50;
const int ALFA_WEATHER_CHANCE_STORMY = 10;
const int ALFA_WEATHER_CHANCE_SNOW = 80;
const int ALFA_WEATHER_CLEAR_SKYBOX = SKYBOX_WINTER_CLEAR;
const int ALFA_WEATHER_RAIN_SKYBOX = SKYBOX_GRASS_STORM;
const int ALFA_WEATHER_SNOW_SKYBOX = SKYBOX_GRASS_STORM;
const int ALFA_WEATHER_OVERCAST_SKYBOX = SKYBOX_ICY;
const int ALFA_WEATHER_STORM_SKYBOX = SKYBOX_GRASS_STORM;
const int ALFA_WEATHER_AREA_DEFAULT_SKYBOX = SKYBOX_WINTER_CLEAR;
