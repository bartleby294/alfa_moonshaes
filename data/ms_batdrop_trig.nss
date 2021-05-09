#include "_btb_util"

void main()
{
    object oPC = GetEnteringObject();
    location loc = GetLocation(oPC);
    batScatter(loc, 50.0, 1);
    DestroyObject(OBJECT_SELF);
}
