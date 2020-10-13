/******************************************************************
 * Name: alfa_constants
 * Type: Constants Include File
 * ---
 * Author: Modal
 * Date: 09/22/02
 * ---
 * Contains ALFA constants.
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/

/* User-Defined Event Constants (Module) */

int ALFA_EVENT_MODULE_ON_ACQUIRE   = 16001;
int ALFA_EVENT_MODULE_ON_ACTIVATE  = 16002;
int ALFA_EVENT_MODULE_ON_DEATH     = 16003;
int ALFA_EVENT_MODULE_ON_DYING     = 16004;
int ALFA_EVENT_MODULE_ON_ENTER     = 16005;
int ALFA_EVENT_MODULE_ON_HEARTBEAT = 16006;
int ALFA_EVENT_MODULE_ON_LEAVE     = 16007;
int ALFA_EVENT_MODULE_ON_LEVEL_UP  = 16008;
int ALFA_EVENT_MODULE_ON_LOAD      = 16009;
int ALFA_EVENT_MODULE_ON_RESPAWN   = 16010;
int ALFA_EVENT_MODULE_ON_REST      = 16011;
int ALFA_EVENT_MODULE_ON_UNACQUIRE = 16012;

/* Safety Net Level */
int ALFA_SAFETY_NET_LEVEL          = 1;

/* Variables Names */
string ALFA_NUM_PLAYER_DEATHS      = "ALFA_NUM_PLAYER_DEATHS";

/* Misc. Constants */
string LOGINMESSAGE = "Welcome to ALFA - Using ACR v1.18";

/* Animal Companion Environment types */
const int AC_ENVIRO_NONE = 0;
const int AC_ENVIRO_UNDERDARK = 1;
const int AC_ENVIRO_FOREST = 2;
const int AC_ENVIRO_ARCTIC = 3;
const int AC_ENVIRO_DESERT = 4;
const int AC_ENVIRO_PLAINS = 5;
const int AC_ENVIRO_JUNGLE = 6;
const int AC_ENVIRO_MOUNTAINS = 7;
const int AC_ENVIRO_AQUATIC = 8;
const int AC_ENVIRO_SWAMP = 9;

/* Sets up Use limitation check for Gender */

const int ITEM_PROPERTY_USE_LIMITATION_GENDER = 150;

