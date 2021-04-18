const string MS_TAVERN_INITALIZED = "ms_tavern_initalized";

// Tags
const string MS_TAVERN_DOOR_TAG = "tavern_door";
const string MS_TAVERN_WALK_WP_TAG = "tavern_walk_wp";
const string MS_TAVERN_CHAIR_TAG = "alfa_chair";
const string MS_TAVERN_PATRON_TAG = "ms_tavern_patron";
const string MS_TAVERN_BAR_TAG = "ms_tavern_bar_wp";
const string MS_TAVERN_STAND_TAG = "ms_tavern_stand_wp";
const string MS_TAVERN_NPC_SEATING_TRIGGER_TAG = "npc_seating";

// Arrays
const string MS_TAVERN_DOOR_ARRAY = "ms_tavern_door_array";
const string MS_TAVERN_WALK_WP_ARRAY = "ms_tavern_walk_wp_array";
const string MS_TAVERN_CHAIR_ARRAY = "ms_tavern_chair_array";
const string MS_TAVERN_BAR_ARRAY = "ms_tavern_bar_array";
const string MS_TAVERN_STAND_ARRAY = "ms_tavern_stand_array";

// Controller References
const string MS_TAVERN_DOOR_COUNT = "ms_tavern_door_count";
const string MS_TAVERN_CHAIR_COUNT = "ms_tavern_chair_count";
const string MS_TAVERN_BAR_COUNT = "ms_tavern_bar_count";
const string MS_TAVERN_STAND_COUNT = "ms_tavern_stand_count";
const string MS_TAVERN_WALK_WP_COUNT = "ms_tavern_walk_wp_count";
const string MS_TAVERN_PATRON_COUNT = "ms_tavern_patron_count";
const string MS_TAVERN_CONTROLLER_OBJECT = "ms_tavern_controller_object";

// Patron References
const string MS_TAVERN_CHAIR_IN_USE = "ms_tavern_chair_in_use";
const string MS_TAVERN_PATRONS_CHAIR = "ms_tavern_patrons_chair";
const string MS_TAVERN_PATRONS_STAND = "ms_tavern_patrons_stand";
const string MS_TAVERN_PATRONS_BAR = "ms_tavern_patrons_bar";
const string MS_TAVERN_PATRONS_WP = "ms_tavern_patron_wp";
const string MS_TAVERN_PATRON_STATE = "ms_tavern_patron_state";
const string MS_TAVERN_PATRON_SITTING_TURNS = "ms_tavern_patron_sitting_turns";
const string MS_TAVERN_PATRON_MAX_SITTING_TURNS = "ms_tavern_patron_max_sitting_turns";
const string MS_TAVERN_PATRON_TURNS_TRYING_TO_SIT = "ms_tavern_patron_turns_trying_to_sit";
const string MS_TAVERN_PATRON_STAND_TURNS = "ms_tavern_patron_stand_turns";
const string MS_TAVERN_PATRON_MAX_STAND_TURNS = "ms_tavern_patron_max_stand_turns";
const string MS_TAVERN_PATRONS_EXIT = "ms_tavern_patron_exit";
const string MS_TAVERN_PATRONS_LAST_LOC = "ms_tavern_patrons_last_loc";
const string MS_TAVERN_PATRONS_LAST_PC_SEEN = "ms_tavern_patrons_last_pc_seen";

/*
 * Possible state transitions
 * 1) just arived -> moving to wp
 * 2) move to wp -> move to chair
 * 3) move to wp -> move to bar
 * 4) move to wp -> move to exit
 * 5) move to chair -> sitting
 * 6) sitting -> move to wp
 * 7) move to bar -> move to wp
 */

// Patron States
const int MS_TAVERN_PATRON_JUST_ARRIVED = 1;
const int MS_TAVERN_PATRON_MOVE_TO_WP = 2;
const int MS_TAVERN_PATRON_MOVE_TO_CHAIR = 3;
const int MS_TAVERN_PATRON_SITTING = 4;
const int MS_TAVERN_PATRON_MOVE_TO_BAR = 5;
const int MS_TAVERN_PATRON_MOVE_TO_STAND = 6;
const int MS_TAVERN_PATRON_STAND = 7;
const int MS_TAVERN_PATRON_MOVE_TO_EXIT = 8;

const int MS_TAVERN_DESTORY_DELAY_SECONDS = 240;
