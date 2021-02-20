  // this script creates a pentagram (star in pentagon), which

// fades after 6 seconds, leaving behind five glowing obelisks

// with the portal placeables glowing at their feet.

// note that you have to edit copy them from the standard

// palette into non-static ones for this to work.


#include "omega_include"
#include "inc_draw"

void main()

{

   location lPos = GetLocation(OBJECT_SELF);



   BeamPentacle(DURATION_TYPE_TEMPORARY, VFX_BEAM_MIND, lPos, 10.0, 6.0, "pillars009", 1.0, 0.0, 0.0,

      "z", DURATION_TYPE_PERMANENT, VFX_DUR_PARALYZED);

   BeamPolygon(DURATION_TYPE_TEMPORARY, VFX_BEAM_MIND, lPos, 10.0, 5, 6.0, "portalsnw002", 1.0, 0.0);

}
