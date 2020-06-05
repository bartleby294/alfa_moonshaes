#include "alfa_weather_inc"

void main()
{
    object oArea = GetArea(GetPCSpeaker());
    SetLocalInt(oArea, LI_STORM_CHANCE, GetLocalInt(oArea, LI_STORM_CHANCE) - 10);
    UpdateAreaWeather(oArea);
}
