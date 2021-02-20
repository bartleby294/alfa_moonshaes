 // this script will draw a pandora box above the caller

// the resultant form will be a 5X5X5 cube with spiraling

// pattern on its surfaces


#include "omega_include"
#include "inc_draw"

void main()

{

   location lBase = GetLocation(OBJECT_SELF);

   vector vBase = GetPosition(OBJECT_SELF);

   object oArea = GetArea(OBJECT_SELF);



   // define the vector of the geometric center

   vector vCenter = vBase + Vector(0.0, 0.0, 2.5);



   // define the location of the rest of the faces

   location lTop = Location(oArea, vBase+Vector(0.0, 0.0, 5.0), 0.0);

   location lLeft = Location(oArea, vCenter+Vector(2.5), 0.0);

   location lRight = Location(oArea, vCenter-Vector(2.5), 0.0);

   location lFront = Location(oArea, vCenter+Vector(0.0, 2.5), 0.0);

   location lBack = Location(oArea, vCenter-Vector(0.0, 2.5), 0.0);



   // create the box

   BeamPolygonalSpiral(DURATION_TYPE_PERMANENT, VFX_BEAM_FIRE_W, lBase, 5.0, 0.0, 4, 0.0, "invisobj", 5.0, 6.0, 45.0);

   BeamPolygonalSpiral(DURATION_TYPE_PERMANENT, VFX_BEAM_FIRE_W, lTop, 5.0, 0.0, 4, 0.0, "invisobj", 5.0, 6.0, 45.0);

   BeamPolygonalSpiral(DURATION_TYPE_PERMANENT, VFX_BEAM_FIRE_W, lLeft, 5.0, 0.0, 4, 0.0, "invisobj", 5.0, 6.0, 45.0, "y");

   BeamPolygonalSpiral(DURATION_TYPE_PERMANENT, VFX_BEAM_FIRE_W, lRight, 5.0, 0.0, 4, 0.0, "invisobj", 5.0, 6.0, 45.0, "y");

   BeamPolygonalSpiral(DURATION_TYPE_PERMANENT, VFX_BEAM_FIRE_W, lFront, 5.0, 0.0, 4, 0.0, "invisobj", 5.0, 6.0, 45.0, "x");

   BeamPolygonalSpiral(DURATION_TYPE_PERMANENT, VFX_BEAM_FIRE_W, lBack, 5.0, 0.0, 4, 0.0, "invisobj", 5.0, 6.0, 45.0, "x");

}
