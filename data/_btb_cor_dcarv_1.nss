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
    if(tag == "caravel_destroy") {
        CaravelDestroy();
    }
}
