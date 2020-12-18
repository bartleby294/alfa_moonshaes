#include "nw_i0_2q4luskan"


//this script will allow a destroyed candle to be picked up by a pc to inv
void main()
{
    object oItem = OBJECT_SELF;
    location oItemLoc = GetLocation(oItem);

    CreateObjectVoid(OBJECT_TYPE_ITEM , "placecandle01i", oItemLoc, FALSE);

}
