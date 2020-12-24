#include "nwnx_area"

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    int oAreaPlayerNumber = NWNX_Area_GetNumberOfPlayersInArea(oArea);

    if(oAreaPlayerNumber == 0) {
        DestroyObject(GetObjectByTag("clav"));
        DestroyObject(GetObjectByTag("jart"));
        DestroyObject(GetObjectByTag("rolling"));
        DestroyObject(GetObjectByTag("mitchan"));
    }
}
