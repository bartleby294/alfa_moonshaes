// this creates a pair of interlocking rings. The torus forms

// are more solid in feel than the plain circles and springs.

// If you do this using two interlocking circles, the impact

// would be less. The torus can be considered as thick rings.


#include "omega_include"
#include "inc_draw"

void main()

{

   object oArea = GetArea(OBJECT_SELF);



   // define a location 6.0m above caller

   vector vPos1 = GetPosition(OBJECT_SELF) + Vector(0.0, 0.0, 6.0);

   location lPos1 = Location(oArea, vPos1, 0.0);



   // define a location for the second ring 5.0m to the east

   vector vPos2 = vPos1 + Vector(5.0);

   location lPos2 = Location(oArea, vPos2, 0.0);



   // create the two rings. The second ring has a smaller fLoopsPerRev,

   // resulting in a looser looking ring. The first ring is parallel

   // to the ground while the second is vertial.

   PlaceTorus("lighting028", lPos1, 6.5, 3.5, 360);
   PlaceTorus("lighting039", lPos2, 6.5, 3.5, 180, 18.0, 1.0, 12.0, 0.0, "x");
}
