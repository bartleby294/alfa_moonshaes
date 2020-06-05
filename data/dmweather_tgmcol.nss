#include "alfa_weather_inc"

void main()
{
    object oModule = GetModule();
    int flags = GetLocalInt(oModule, LI_AREA_WEATHER_FLAGS);

    SetLocalInt(oModule, LI_AREA_WEATHER_FLAGS, flags ^ AREA_WEATHER_FLAG_FOG_COLOR);
}
