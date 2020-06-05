#include "omega_include"
void main()
{
int Math = GetLocalInt(oDM, "F_AM_D");
int Math2 =GetLocalInt(oDM, "F_AM_N");


   if (Math >= 201)
   {
SetLocalInt(oDM, "F_AM_D", 200);
SetCustomToken(6992, IntToString(200));
      }
   else if (Math <= -1)
   {
   SetLocalInt(oDM, "F_AM_D", 0);
    SetCustomToken(6992, IntToString(0));
    }
   if (Math2 >= 201)
   {
   SetLocalInt(oDM, "F_AM_N", 200);
    SetCustomToken(6993, IntToString(200));
      }
   else if (Math2 <= -1)
   {
   SetLocalInt(oDM, "F_AM_N", 0);
   SetCustomToken(6992, IntToString(0));
   }
 }
