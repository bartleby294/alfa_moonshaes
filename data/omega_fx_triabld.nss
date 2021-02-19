 #include "omega_include"
 #include "inc_draw"

void main()

{

   location lPos = GetLocation(OBJECT_SELF);



   // create the splatter

   DrawPolygonalSpiral(DURATION_TYPE_INSTANT, VFX_IMP_DESTRUCTION, lPos, 10.0, 0.0, 3, 0.0, 180, 5.0, 12.0);

   PlacePolygonalSpiral("plc_bloodstain", lPos, 10.0, 0.0, 3, 180, 5.0);
}
