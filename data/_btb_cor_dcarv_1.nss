#include "_btb_corwellship"

void main() {
    SpeakString("Activated");
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    //CaravelInbound();

    string tag = GetTag(OBJECT_SELF);

    if(tag == "caravel_create") {
        //CaravelInboundCreate();
        ShipInboundCreate(CARAVEL_INBOUND_TAG, CARAVEL_INBOUND_WAYPOINT_TAG,
                          Vector(85.4, 145.0, 0.0), 90.0, CARAVEL_INBOUND_RES);
    }
    if(tag == "caravel_activate") {
        //CaravelActivate();
        ShipActivate(CARAVEL_INBOUND_TAG, CARAVEL_INBOUND_WAYPOINT_TAG,
                     CARAVEL_INBOUND_PLANK_TAG, CARAVEL_INBOUND_BLOCKER_TAG,
                     Vector(0.0, 4.5, 0.0), 90.0);
    }
    if(tag == "caravel_deactivate") {
        //CaravelDeactivate();
        ShipDeactivate(CARAVEL_INBOUND_TAG);
    }
    if(tag == "caravel_destroy") {
        //CaravelDestroy();
        ShipDestroy(CARAVEL_INBOUND_TAG, CARAVEL_INBOUND_WAYPOINT_TAG,
                    CARAVEL_INBOUND_BLOCKER_TAG, CARAVEL_INBOUND_BLOCKER_RES,
                    CARAVEL_INBOUND_PLANK_TAG);
    }

    if(tag == "city_ship_create") {
        ShipInboundCreate(CITY_SHIP_INBOUND_TAG, CITY_SHIP_INBOUND_WAYPOINT_TAG,
                          Vector(85.0, 175.0, 0.0), 90.0, CITY_SHIP_INBOUND_RES);
    }
    if(tag == "city_ship_activate") {
        ShipActivate(CITY_SHIP_INBOUND_TAG, CITY_SHIP_INBOUND_WAYPOINT_TAG,
                     CITY_SHIP_INBOUND_PLANK_TAG, CITY_SHIP_INBOUND_BLOCKER_TAG,
                     Vector(0.3, 3.13, 0.0), 90.0);
    }
    if(tag == "city_ship_deactivate") {
        ShipDeactivate(CARAVEL_INBOUND_TAG);
    }
    if(tag == "city_ship_destroy") {
        ShipDestroy(CITY_SHIP_INBOUND_TAG, CITY_SHIP_INBOUND_WAYPOINT_TAG,
                    CITY_SHIP_INBOUND_BLOCKER_TAG, CITY_SHIP_INBOUND_BLOCKER_RES,
                    CITY_SHIP_INBOUND_PLANK_TAG);
    }
}
