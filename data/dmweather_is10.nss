#include "alfa_weather_inc"

void main()
{
    int value = GetLocalInt(GetModule(), LI_CURRENT_WEATHER_ROLL);
    SetLocalInt(GetModule(), LI_CURRENT_WEATHER_ROLL, value + 10);
    UpdateWeatherForPCs();
}
