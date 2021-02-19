 // This will create a colorful band of sparks, most suitable

// for a magical forest setting.


#include "omega_include"
#include "inc_draw"

void main()

{

   location lPos = GetLocation(OBJECT_SELF);



   PlaceEllipse("plc_magicgreen", lPos, 3.0, 5.0, 30, 1.0, 4.0);
   PlaceEllipse("plc_magicorange", lPos, 3.5, 5.5, 30, -1.0, 4.0);
   PlaceEllipse("plc_magicblue", lPos, 4.0, 6.0, 30, 1.0, 4.0);
   PlaceEllipse("plc_magicpurple", lPos, 4.5, 6.5, 30, -1.0, 4.0);

}
