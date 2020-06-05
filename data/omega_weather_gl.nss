#include "omega_include"
void main()
{
object oArea = GetArea(GetPCSpeaker());
object oModule = GetModule();
int nWeather = GetLocalInt(oDM,"WEATHER_TYPE");
int nWSkybox = GetLocalInt(oDM,"SKYBOX_TYPE");
int nSkybox = GetLocalInt(oDM,"WEATHER_SKYBOX");
       if (nSkybox == TRUE)
       {
       SetWeather(oModule, nWeather);
       SetSkyBox(nWSkybox, oModule);
       }
       else if (nSkybox == FALSE)
       {
        SetWeather(oModule, nWeather);
       }
}
