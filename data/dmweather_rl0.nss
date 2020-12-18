#include "alfa_weather_inc"

void main()
{
    object oArea = GetArea(GetPCSpeaker());
    SetLocalInt(oArea, LI_OVERCAST_CHANCE, 0);
    SetLocalInt(oArea, LI_RAIN_CHANCE, 0);
    SetLocalInt(oArea, LI_STORM_CHANCE, 0);
    SetLocalInt(oArea, LI_SNOW_CHANCE, 0);
    UpdateAreaWeather(oArea);
}
