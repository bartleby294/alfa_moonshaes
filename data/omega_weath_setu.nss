#include "omega_include"
void main()
{
object oArea = GetArea(GetPCSpeaker());
int nWeather = GetWeather(oArea);
SetLocalInt(oDM, "WEATHER_TYPE", nWeather);
    if (nWeather == 0)
    {
    SetCustomToken(6997, "Clear");
    }
        else if(nWeather == 1)
        {
         SetCustomToken(6997, "Rainy");
        }
            else if(nWeather == 2)
            {
             SetCustomToken(6997, "Snowy");
            }
    SetLocalInt(oDM, "WEATHER_SKYBOX", FALSE);
    SetCustomToken(6998, "Off");
}
