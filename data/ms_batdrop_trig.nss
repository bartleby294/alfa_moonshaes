#include "_btb_util"

void main()
{
    object oPC = GetEnteringObject();
    location loc = GetLocation(oPC);
    batScatter(loc, 500.0);
}
