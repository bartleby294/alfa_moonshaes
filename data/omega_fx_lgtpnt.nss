// this script demonstrates the use of the nVFX2 parameters.

// the spiral will be drawn and a lightning bolt cast on each

// of the vertices three seconds after the beams after applied


#include "omega_include"
#include "inc_draw"

void main()

{

   location lPos = GetLocation(OBJECT_SELF);



   BeamPentaclicSpiral(DURATION_TYPE_PERMANENT, VFX_BEAM_SILENT_LIGHTNING, lPos,

      0.0, 10.0, 0.0, "invisobj", 10.0, 12.0, 0.0, "z",

      DURATION_TYPE_INSTANT, VFX_IMP_LIGHTNING_M, 0.0, 3.0);
 }
