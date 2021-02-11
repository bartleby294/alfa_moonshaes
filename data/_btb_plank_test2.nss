#include "nwnx_visibility"

void main()
{
    string plankTag = "test_plank_002";
    object oPlank = GetNearestObjectByTag(plankTag, OBJECT_SELF);
    float rotateStart = GetLocalFloat(oPlank, "rotateStart");
    float rotateInc = rotateStart + 10.0;
    SetLocalFloat(oPlank, "rotateStart", rotateInc);
    AssignCommand(OBJECT_SELF, SpeakString(FloatToString(rotateInc)));

    SetObjectVisualTransform(oPlank,
                                 OBJECT_VISUAL_TRANSFORM_ROTATE_Y, rotateInc);
}
