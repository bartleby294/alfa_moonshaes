#include "ms_corking_wagco"

int StartingConditional()
{
    object wagon = GetObjectByTag("mstradewagon1");
    if(GetLocalInt(wagon, WAGON_ESCORT_STATE) == WAGON_STATE_AVAILABLE) {
        return TRUE;
    }

    return FALSE;
}
