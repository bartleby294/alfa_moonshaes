#include "nw_i0_2q4luskan"


//this script will destroy a PC stool and allow a pc to pick it up to inventory.
void main()
{
    object oItem = OBJECT_SELF;
    location oItemLoc = GetLocation(oItem);

    CreateObjectVoid(OBJECT_TYPE_ITEM , "smuseabletenti", oItemLoc, FALSE);


}
