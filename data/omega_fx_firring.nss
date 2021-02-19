// this creates a torispiral that gets spiraled into

// itself, quite like the symbolic cockatrice rooster-

// head-eat-snake-tail circle.


#include "omega_include"
#include "inc_draw"

void main()

{

   // define a location 6.0m above caller

   vector vPos = GetPosition(OBJECT_SELF) + Vector(0.0, 0.0, 6.0);

   location lPos = Location(GetArea(OBJECT_SELF), vPos, 0.0);



   // create the torispiral, note how fRev has been set to 1.2

   // while the effective starting radius and ending radius are

   // both 5.0m ((6.5+3.5)/2 = 5.0). This means the end of the

   // spiral will penetrate into its own large opening end.

   PlaceToroidalSpiral("lighting032", lPos, 6.5, 3.5, 5.0, 5.0, 180, 18.0, 1.2, 12.0, 0.0, "x");

}
