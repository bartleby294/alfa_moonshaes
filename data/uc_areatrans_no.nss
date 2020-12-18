
// This Scripts displays a string in floating text above a PC
// when the trigger is activated. You can do this by adding
// this script to the OnClick and/or OnEnter of the trigger
//
// The text to display depends on the last three digits of the triggers TAG
// For instance, a trigger with tag: TR_forest_reject_002
// Would display string in case 002 above the PC's head

void main()
{
    string sTag = GetStringRight(GetTag(OBJECT_SELF), 3);
    string sString;
    int nTag = StringToInt(sTag);
    object oPC = GetEnteringObject();
    if (oPC == OBJECT_INVALID)  oPC = GetClickingObject();

    switch (nTag) {
    case 001:
        sString = "The Mountains are too rugged and steep to climb.";
        break;
    case 002:
        sString = "Densely grouped trees and abundant undergrowth hinder further movement in this direction.";
        break;
    case 003:
        sString = "Endless plains of grass and shrubs stretch as far as the eye can see. You decide to turn back.";
        break;
    case 004:
        sString = "The everstretching expanse of the sky is before you. A step further in this direction would surely lead to your death.";
        break;
    default:
        "WARNING: No TAG found " + sTag;
        break;
    }
    FloatingTextStringOnCreature(sString, oPC, FALSE);
}

