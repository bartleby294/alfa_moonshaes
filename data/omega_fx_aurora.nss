 // this is the script the creates the Aurora exhibit in

// the demonstration module. Take note of how fRev is set

// to 0.5 to reduce the curviness of the spiraling.


#include "omega_include"
#include "inc_draw"

void main()

{

   location lLoc = GetLocation(OBJECT_SELF);



   PlaceSpring("plc_magicblue", lLoc, 6.0, 0.0, 1.5, 0.0, 10, 0.5, 12.0, 90.0);
   PlaceSpring("plc_magiccyan", lLoc, 6.0, 0.0, 1.5, 0.0, 10, 0.5, 12.0, 270.0);
   PlaceSpring("plc_magicpurple", lLoc, 6.0, 0.0, 1.5, 0.0, 10, 0.5, 12.0);
   PlaceSpring("plc_magicwhite", lLoc, 6.0, 0.0, 1.5, 0.0, 10, 0.5, 12.0, 180.0);
   PlaceSpring("plc_magicred", lLoc, 6.0, 0.0, 1.5, 0.0, 10, 0.5, 12.0, 45.0);
   PlaceSpring("plc_magicyellow", lLoc, 6.0, 0.0, 1.5, 0.0, 10, 0.5, 12.0, 135.0);
   PlaceSpring("plc_magicorange", lLoc, 6.0, 0.0, 1.5, 0.0, 10, 0.5, 12.0, 315.0);
   PlaceSpring("plc_magicgreen", lLoc, 6.0, 0.0, 1.5, 0.0, 10, 0.5, 12.0, 225.0);
}
