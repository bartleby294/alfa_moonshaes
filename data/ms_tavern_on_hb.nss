#include "nwnx_data"
#include "nwnx_object"
#include "ms_tavern_const"

void main()
{
    object oPatron = OBJECT_SELF;
    object oArea = GetArea(oPatron);
    object oControler = GetLocalObject(oArea, MS_TAVERN_CONTROLLER_OBJECT);
    int doorCnt = GetLocalInt(oControler, MS_TAVERN_DOOR_COUNT);
    int chairCnt = GetLocalInt(oControler, MS_TAVERN_CHAIR_COUNT);

    // Something is out of sync abort for now hope is syncs back up.
    if(oControler == OBJECT_INVALID) {
        return;
    }



}
