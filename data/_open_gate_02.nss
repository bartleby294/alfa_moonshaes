#include "nw_i0_2q4luskan"

void main()
{  // modify these constants to fit the function to other placables.
    float radius = -0.51;
    float dispAngle = 33.3;


    object OpenGate = OBJECT_SELF;
    object oArea = GetArea(OpenGate);
    object oPC =  GetLastUsedBy();

    vector OldVector = Vector(GetLocalFloat(OpenGate, "IniX"), GetLocalFloat(OpenGate, "IniY"), GetLocalFloat(OpenGate, "IniZ"));

    location NewLocation = Location(oArea, OldVector, GetLocalFloat(OpenGate, "IniFace"));

    DestroyObject(OpenGate, 0.0);

    CreateObjectVoid(OBJECT_TYPE_PLACEABLE , "_opening_halfgat", NewLocation , FALSE);

    //AssignCommand(oPC, ActionSpeakString(FloatToString(NewVector.x)));
    //AssignCommand(oPC, ActionSpeakString(FloatToString(NewVector.y)));

    //AssignCommand(oPC, ActionSpeakString(FloatToString(deltaX)));
    //AssignCommand(oPC, ActionSpeakString(FloatToString(deltaY)));

    PlaySound("as_dr_metllgop1");
}
