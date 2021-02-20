// this script will create a solid star in circle pattern


#include "omega_include"
#include "inc_draw"

void main()

{

   location lPos = GetLocation(OBJECT_SELF);



   PlacePentaclicSpiral("plc_bloodstain", lPos, 5.0, 1.0, 180, 5.0);

   PlaceCircle("plc_bloodstain", lPos, 5.0);
}
