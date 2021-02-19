// this draws a star-in-circle a la Rick Burton's Twilight pattern around the caller.


#include "omega_include"
#include "inc_draw"

void main()

{

   location lLoc = GetLocation(OBJECT_SELF); // gets the location of the caller



   // draw the shapes in a 10m radius. Notice that the pentacle has fRev 2.0 while

   // the circle has fRev 4.0 - this is because for every revolution the pentacle

   // completes, the circle has to complete two revolutions to match the speed.

   DrawPentacle(DURATION_TYPE_TEMPORARY, VFX_DUR_ENTANGLE, lLoc, 10.0, 12.0, 180, 2.0, 12.0);
   DrawCircle(DURATION_TYPE_TEMPORARY, VFX_DUR_ENTANGLE, lLoc, 10.0, 12.0, 180, 4.0, 12.0);
}
