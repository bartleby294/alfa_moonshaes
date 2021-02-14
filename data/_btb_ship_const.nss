/*
 * Some notes
 *
 * 1) Tags can be changed at will
 * 2) RES tie to resrefs so changing those will need toolset updates.
 * 3) The way point tags shouldnt be changed without updating in toolset.
 */

int DEFAULT_SHIP_WAIT_TIME = 10000;
int WAIT_TIME_THRESHOLD = 9990;
string DM_SHIP_OVERRIDE = "dmShipOverried";

string CITY_SHIP_INBOUND_TAG = "corwell_anim_sm_ship_1";
string CITY_SHIP_INBOUND_RES = "cor_city_in_ship";
string CITY_SHIP_INBOUND_PLANK_TAG = "corwell_anim_sm_ship_1_plank";
string CITY_SHIP_INBOUND_PLANK_RES = "city_ship_gangpl";
string CITY_SHIP_INBOUND_BLOCKER_TAG = "corwell_city_ship_blocker_1_tag";
string CITY_SHIP_INBOUND_BLOCKER_RES  = "gangplank_block";
string CITY_SHIP_INBOUND_WAYPOINT_TAG = "corwell_city_ship_blocker_1";
string CITY_SHIP_INBOUND_CREATED_TIME = CITY_SHIP_INBOUND_TAG + "created";
string CITY_SHIP_INBOUND_DESTROYED_TIME = CITY_SHIP_INBOUND_TAG + "destroyed";

string CARAVEL_INBOUND_TAG = "corwell_anim_caravel_1";
string CARAVEL_INBOUND_RES = "corwell_car_deac";
string CARAVEL_INBOUND_PLANK_TAG = "corwell_anim_caravel_1_plank";
string CARAVEL_INBOUND_PLANK_RES = "caraveshipstairs";
string CARAVEL_INBOUND_BLOCKER_TAG = "corwell_caravel_blocker_1_tag";
string CARAVEL_INBOUND_BLOCKER_RES = "gangplank_block";
string CARAVEL_INBOUND_WAYPOINT_TAG = "corwell_caravel_blocker_1";
string CARAVEL_INBOUND_CREATED_TIME = CARAVEL_INBOUND_TAG + "created";
string CARAVEL_INBOUND_DESTROYED_TIME = CARAVEL_INBOUND_TAG + "destroyed";

string CITY_SHIP_OUTBOUND_TAG = "corwell_anim_sm_ship_2";
string CITY_SHIP_OUTBOUND_RES = "cor_city_in_ship";
string CITY_SHIP_OUTBOUND_PLANK_TAG = "corwell_anim_sm_ship_2_plank";
string CITY_SHIP_OUTBOUND_PLANK_RES = "city_ship_gangpl";
string CITY_SHIP_OUTBOUND_BLOCKER_TAG = "corwell_city_ship_blocker_2_tag";
string CITY_SHIP_OUTBOUND_BLOCKER_RES = "gangplank_block";
string CITY_SHIP_OUTBOUND_WAYPOINT_TAG = "corwell_city_ship_blocker_2";
string CITY_SHIP_OUTBOUND_TRIGGER_TAG = "cityShipOutTrigger";
string CITY_SHIP_OUTBOUND_CREATED_TIME = CITY_SHIP_OUTBOUND_TAG + "created";
string CITY_SHIP_OUTBOUND_DESTROYED_TIME = CITY_SHIP_OUTBOUND_TAG + "destroyed";

string CARAVEL_OUTBOUND_TAG = "corwell_anim_caravel_2";
string CARAVEL_OUTBOUND_RES = "corwell_car_deac";
string CARAVEL_OUTBOUND_PLANK_TAG = "corwell_anim_caravel_2_plank";
string CARAVEL_OUTBOUND_PLANK_RES = "caraveshipstairs";
string CARAVEL_OUTBOUND_BLOCKER_TAG = "corwell_caravel_blocker_2_tag";
string CARAVEL_OUTBOUND_BLOCKER_RES = "gangplank_block";
string CARAVEL_OUTBOUND_WAYPOINT_TAG = "corwell_caravel_blocker_2";
string CARAVEL_OUTBOUND_TRIGGER_TAG = "caravelOutTrigger";
string CARAVEL_OUTBOUND_CREATED_TIME = CARAVEL_OUTBOUND_TAG + "created";
string CARAVEL_OUTBOUND_DESTROYED_TIME = CARAVEL_OUTBOUND_TAG + "destroyed";
