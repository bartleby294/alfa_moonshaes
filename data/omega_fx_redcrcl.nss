  // This will draw the "Charmed" (as in the TV-series)

// symbol around the caller


#include "omega_include"
#include "inc_draw"

void main()

{

   int i;

   float f;

   location lPos = GetLocation(OBJECT_SELF);

   vector vPos = GetPosition(OBJECT_SELF);

   vector vLoc;

   location lLoc;

   object oArea = GetArea(OBJECT_SELF);



   for (i=0; i<3; i++)
   {
      f = IntToFloat(i);
      vLoc = vPos + 5.0*AngleToVector(f*120.0);
      lLoc = Location(oArea, vLoc, 0.0);
      DrawEllipse(0, 91, lLoc, 9.0, 4.0, 0.0, 60, 2.0, 6.0, f*120.0);
   }

   DrawCircle(0, 91, lPos, 6.0, 0.0, 60, 2.0);
}
