// this draws an expanding horizontal pentaclic spring from 2.0m above

// the caller to 5.0m northwards, the radius increasing from 1.0m to 5.0m


#include "omega_include"
#include "inc_draw"

void main()

{

   vector vPos = GetPosition(OBJECT_SELF) + Vector(0.0, 0.0, 2.0); // define the vector location 2.0m above caller

   location lPos = Location(GetArea(OBJECT_SELF), vPos, 0.0); // create the location



   // draw the spring

   DrawPentaclicSpring(DURATION_TYPE_INSTANT, VFX_IMP_HEAD_FIRE, lPos, 1.0, 5.0, 0.0, 5.0, 0.0, 360, -10.0, 12.0, 0.0, "x");

}
