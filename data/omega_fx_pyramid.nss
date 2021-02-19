 // this script will create a series of pyramids within pyramids

// around the caller


#include "omega_include"
#include "inc_draw"

void main()

{

   location lPos = GetLocation(OBJECT_SELF);



   // creates four pyramidal forms, one within another, rotated along normal

   BeamPolygonalSpring(DURATION_TYPE_PERMANENT, VFX_BEAM_SILENT_FIRE, lPos, 2.5, 0.0, 0.0, 2.5, 4, 0.0, "invisobj", 2.5, 6.0, -45.0);

   BeamPolygonalSpring(DURATION_TYPE_PERMANENT, VFX_BEAM_SILENT_COLD, lPos, 5.0);

   BeamPolygonalSpring(DURATION_TYPE_PERMANENT, VFX_BEAM_SILENT_EVIL, lPos, 7.5, 0.0, 0.0, 7.5, 4, 0.0, "invisobj", 7.5, 6.0, 45.0);

   BeamPolygonalSpring(DURATION_TYPE_PERMANENT, VFX_BEAM_SILENT_HOLY, lPos, 10.0, 0.0, 0.0, 10.0, 4, 0.0, "invisobj", 10.0, 6.0, 90.0);

}
