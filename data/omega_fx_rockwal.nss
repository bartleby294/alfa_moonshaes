  // this script will create a rocket-like tower of bread


#include "omega_include"
#include "inc_draw"

void main()

{

   location lPos = GetLocation(OBJECT_SELF);



   // create the tower

   PlacePolygonalHemisphere("miscnw502", lPos, 5.0, 0.0, 0.0, 10.0, 3, 180, 10.0, 12.0);
}
