#include "omega_include"
void main()
{
int nSkybox = GetLocalInt(oDM,"WEATHER_SKYBOX");
       if (nSkybox == TRUE)
       {
       SetLocalInt(oDM, "WEATHER_SKYBOX", FALSE);
       SetCustomToken(6998, "Off");
       }
       else if (nSkybox == FALSE)
       {
       SetLocalInt(oDM, "WEATHER_SKYBOX", TRUE);
       SetCustomToken(6998, "On");
        }


}
