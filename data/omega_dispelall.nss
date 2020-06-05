#include "subraces"

void main()
{
    object oMyTarget = GetLocalObject(GetLastSpeaker(), "OMWandTarget");
    Subraces_SafeRemoveEffects(oMyTarget);
}
