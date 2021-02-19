 // this is a slightly more complicated approach to create

// spheres using BeamPolygonalHemisphere functions.

// This is the "Luna" display from the demonstration module,

// but I'll explain a little more here.

// This will create a sphere with a more gentle swirl, like

// Chupa Chups's ice-cream flavored lollipop.


#include "omega_include"
#include "inc_draw"

void main()

{

   int i;

   float f;

   location lLoc = GetLocation(OBJECT_SELF);



   // in total, 10 polygonal hemispheres are created, five on top, five below.

   for (i=0; i<5; i++)
   {
      f = IntToFloat(i);



      // note how fRotate gets increased
      BeamPolygonalHemisphere(2, 311, lLoc, 3.0, 0.0, 0.0, 3.0, 9, 0.0, "", -1.0, 6.0, f*72.0);
      BeamPolygonalHemisphere(2, 311, lLoc, 3.0, 0.0, 0.0, -3.0, 9, 0.0, "", 1.0, 6.0, f*72.0);
   }
}
