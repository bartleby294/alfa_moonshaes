 // cast a custom spell and setup a psychedelic display?

// this custom spell script will create an eight-pointed star shape pattern

// around the caller. The ratio used here is 8/5, a screenshot of which is

// included in the page for DrawHypocycloid


#include "omega_include"
#include "inc_draw"

void main()

{

   // define a new location slightly below ground level

   // this is so that the placeables created don't get into the way of the walkmeshes

   vector vPos = GetPosition(OBJECT_SELF) - Vector(0.0, 0.0, 0.3);

   location lPos = Location(GetArea(OBJECT_SELF), vPos, 0.0);



   // rest of spell script here



   // create the floor pattern

   // note how fRadius/fRoulette = 8.0/5.0 = 8/5, and therefore fRev, taking the

   // the value of the denominator, should also be 5 (or more) if we want complete

   // closed forms.

   PlaceHypocycloid("plc_haybundle", lPos,

                    8.0, 5.0, 200, 5.0, 18.0, 0.0, "z",

                    DURATION_TYPE_PERMANENT, VFX_DUR_BLUR, 0.0, 2.0, 60.0);
}
