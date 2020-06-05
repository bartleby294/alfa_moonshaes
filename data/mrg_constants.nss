/******************************************************************
 * Name: mrg_constants
 * Type: Morgue Constants Include File
 * ---
 * Author: Modal
 * Date: 07/14/02
 * ---
 * Contains ALFA Morgue constants.
 ******************************************************************/

/* Morgue On/Off - Default on startup, can still be toggled in-game */
int   ALFA_MORGUE_ENABLED      = TRUE;

/* Constants */
int   ALFA_FLAG_PC_ALIVE       = 0;
int   ALFA_FLAG_PC_BLEEDING    = 1;
int   ALFA_FLAG_PC_DEAD        = 2;
int   ALFA_FLAG_PC_RESURRECTED = 3;
int   ALFA_FLAG_PC_RAISED      = 4;

/* Decay time, in hours */
int   ALFA_MORGUE_DECAY_TIME   = 168; // 7 days

/* Area Tags */
string ALFA_AREA_MORGUE_TAG     = "ALFA_Morgue";

/* Object Blueprint ResRefs */
string ALFA_PC_CORPSE_PLAC_REF  = "alfa_pc_corpse";
string ALFA_PC_CORPSE_TOKEN_REF = "alfa_corpsetoken";
string ALFA_OBJ_UNDERTAKER_REF  = "alfa_deathchest";

/* Waypoint Tags */
string ALFA_WAYPT_MORGUE_TAG          = "ALFA_MORGUE_WAYPT";
string ALFA_WAYPT_UNDERTAKER_TAG      = "ALFA_UNDERTAKER_WAYPT";

/* Object Tags */
string ALFA_OBJ_MORGUE_RECORD_TAG     = "ALFA_MorgueRecord";
string ALFA_OBJ_PC_CORPSE_TOKEN_TAG   = "ALFA_PC_CorpseToken";
string ALFA_OBJ_PC_FAKE_CORPSE_TAG    = "ALFA_PC_Corpse";
string ALFA_OBJ_MORGUE_RESURRECT_TAG  = "ALFA_ResurrectionScroll";
string ALFA_OBJ_MORGUE_RAISE_TAG      = "ALFA_RaiseDeadScroll";

/* Variable Names */
string ALFA_CORPSE_LOOK        = "ALFA_CORPSE_LOOK";
string ALFA_CORPSE_TALKING     = "ALFA_CORPSE_TALKING";
string ALFA_PC_CORPSE_CNTR     = "ALFA_PC_CORPSE_CNTR";
string ALFA_PC_DEATH_LOC       = "ALFA_PC_DEATH_LOC";
string ALFA_PC_TOD_YEAR        = "ALFA_PC_TOD_YEAR";
string ALFA_PC_TOD_MONTH       = "ALFA_PC_TOD_MONTH";
string ALFA_PC_TOD_DAY         = "ALFA_PC_TOD_DAY";
string ALFA_PC_TOD_HOUR        = "ALFA_PC_TOD_HOUR";
string ALFA_PC_SPEC_TARGET     = "ALFA_PC_SPEC_TARGET";
string ALFA_PC_UNDERTAKER      = "ALFA_PC_UNDERTAKER";
string ALFA_PC_CORPSE_ID       = "ALFA_PC_CORPSE_ID";
string ALFA_WAS_EQUIPPED_BY    = "ALFA_WAS_EQUIPPED_BY";
string ALFA_WAS_EQUIPPED_IN    = "ALFA_WAS_EQUIPPED_IN";
string ALFA_MORGUE_DISABLED    = "ALFA_MORGUE_DISABLED";
string ALFA_MORGUE_LIST_SIZE   = "ALFA_MORGUE_LIST_SIZE";
string ALFA_MORGUE_ARR_PREFIX  = "ALFA_MORGUE_INDEX_PREFIX_";
string ALFA_MORGUE_LIST_OFFSET = "ALFA_MORGUE_LIST_OFFSET";
string ALFA_MORGUE_TOK_PREFIX  = "ALFA_MORGUE_TOK_PREFIX_";
string ALFA_MORGUE_CLEANUP     = "ALFA_MORGUE_CLEANUP";
string ALFA_MORGUE_CORPSE_     = "ALFA_MORGUE_CORPSE_";
string ALFA_MORGUE_CORRECT_HP  = "ALFA_MORGUE_CORRECT_HP";
string ALFA_MORGUE_GOLD        = "ALFA_MORGUE_GOLD";
string ALFA_OBJ_OWNER          = "ALFA_OBJ_OWNER";
