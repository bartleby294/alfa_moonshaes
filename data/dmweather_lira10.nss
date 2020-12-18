#include "alfa_weather_inc"

void main()
{
    object oArea = GetArea(GetPCSpeaker());
    SetLocalInt(oArea, LI_RAIN_CHANCE, GetLocalInt(oArea, LI_RAIN_CHANCE) + 10);
    UpdateAreaWeather(oArea);
}
