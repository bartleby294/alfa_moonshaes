 // this script will draw a star-in-star pattern


#include "omega_include"
#include "inc_draw"

void main()

{

   location lPos = GetLocation(OBJECT_SELF);



   PlacePentacle("lighting030", lPos, 5.0, 60, 1.0, 12.0, 36.0);

   BeamPentacle(DURATION_TYPE_PERMANENT, VFX_BEAM_COLD, lPos, 2.0);

}
