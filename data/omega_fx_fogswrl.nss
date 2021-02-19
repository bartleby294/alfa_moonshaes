 // This is the code that creates the complex-looking

// outburst effect in the demonstration module.


#include "omega_include"
#include "inc_draw"

void main()

{

   int i;

   float f;

   location lPos = GetLocation(OBJECT_SELF);



   for (i=0; i<5; i++)
   {
      f = IntToFloat(i);
      DelayCommand(f, DrawEllipticalSpiral(0, 250, lPos, 0.0, 0.0, 5.0, 8.0, 0.0, 60, 3.0, 3.0, f*72.0));
   }

}
