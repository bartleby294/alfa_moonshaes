#include "alfa_weather_inc"

void main()
{
    int value = GetLocalInt(GetModule(), LI_CURRENT_SNOW_ROLL);
    SetLocalInt(GetModule(), LI_CURRENT_SNOW_ROLL, value - 10);
    UpdateWeatherForPCs();
}
