#include "nw_i0_2q4luskan"

void main()
{  // modify these constants to fit the function to other placables.
    float radius = 0.51;
    float dispAngle = 33.3;


    object Gate = OBJECT_SELF;
    object oArea = GetArea(Gate);
    object oPC =  GetLastUsedBy();
    location GateLoc = GetLocation(Gate);

    vector GateVec = GetPositionFromLocation(GateLoc);

    float Xcomp = GateVec.x;
    float Ycomp = GateVec.y;
    //AssignCommand(oPC, ActionSpeakString(FloatToString(Xcomp)));

    float iniAngle = GetFacingFromLocation(GateLoc)-180;
    float NewAngle = iniAngle + dispAngle;

    float deltaY = sin(NewAngle) * radius;
    float deltaX = cos(NewAngle) * radius;

    float resultantX = GateVec.x + deltaX;
    float resultantY = GateVec.y + deltaY;

    vector NewVector = Vector(resultantX, resultantY, GateVec.z);
    float NewFacing =  iniAngle + 260.0;

    location NewLocation = Location(oArea, NewVector, NewFacing);

    DestroyObject(Gate, 0.0);

    object OpenGate = CreateObject(OBJECT_TYPE_PLACEABLE , "_opening_halfga2", NewLocation , FALSE);

    //AssignCommand(oPC, ActionSpeakString(FloatToString(NewVector.x)));
    //AssignCommand(oPC, ActionSpeakString(FloatToString(NewVector.y)));

    //AssignCommand(oPC, ActionSpeakString(FloatToString(deltaX)));
    //AssignCommand(oPC, ActionSpeakString(FloatToString(deltaY)));

    SetLocalFloat(OpenGate, "IniX", Xcomp);
    SetLocalFloat(OpenGate, "IniY", Ycomp);
    SetLocalFloat(OpenGate, "IniZ", GateVec.z);
    SetLocalFloat(OpenGate, "IniFace", GetFacingFromLocation(GateLoc));

    PlaySound("as_dr_metllgop1");
}
