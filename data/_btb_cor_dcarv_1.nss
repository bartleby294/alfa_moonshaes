#include "_btb_corwellship"

void main() {
    SpeakString("Activated");
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    //CaravelInbound();

    string tag = GetTag(OBJECT_SELF);

    if(tag == "caravel_create") {
        CaravelInboundCreate();
    }
    if(tag == "caravel_activate") {
        CaravelActivate();
    }
    if(tag == "caravel_deactivate") {
        CaravelDeactivate();
    }
    if(tag == "caravel_open") {
        CaravelOpen();
    }
    if(tag == "caravel_close") {
        CaravelClose();
    }
    if(tag == "caravel_destroy") {
        CaravelDestroy();
    }
    if(tag == "caravel_minus") {
        CaravelMinus();
    }
    if(tag == "caravel_serial") {
        CaravelSerial();
    }
    if(tag == "caravel_serial_destroy") {
        CaravelSerialDestroy();
    }
    if(tag == "caravel_serial_create") {
        CaravelSerialCreate();
    }
    if(tag == "caravel_serial_plus") {
        CaravelSerialPlus();
    }
    if(tag == "caravel_serial_minus") {
        CaravelSerialMinus();
    }


}
