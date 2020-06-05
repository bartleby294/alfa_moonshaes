#include "omega_include"
void main()
{
object oArea = GetArea(GetPCSpeaker());
int nWeather = GetLocalInt(oDM,"WEATHER_TYPE");
int nWSkybox = GetLocalInt(oDM,"SKYBOX_TYPE");
int nSkybox = GetLocalInt(oDM,"WEATHER_SKYBOX");
       if (nSkybox == TRUE)
       {
       SetWeather(oArea, nWeather);
       SetSkyBox(nWSkybox, oArea);
       }
       else if (nSkybox == FALSE)
       {
        SetWeather(oArea, nWeather);
       }
}
