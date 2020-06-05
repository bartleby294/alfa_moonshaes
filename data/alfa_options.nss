/******************************************************************
 * Name: alfa_options
 * Type: ACR Include File
 * ---
 * Author: Cereborn
 * Date: 11/11/03
 *
 * ---
 * Contains option flags used for ALFA.  Users may configure optional
 * components of the ACR by changing flag values in this file.
 *
 ******************************************************************/

#include "alfa_constants"
#include "x2_inc_switches"

// Global Weather System
//
// Set to TRUE if you want this system on
const int gALFA_USE_GLOBAL_WEATHER = FALSE;

// Global Skies System
//
// Set to TRUE if you want this system on
const int gALFA_USE_GLOBAL_SKIES = FALSE;

// Danmar's Puppet Master
//
// Set to TRUE if you want to use the puppet master functionality
const int gALFA_USE_PUPPET_MASTER = TRUE;


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
