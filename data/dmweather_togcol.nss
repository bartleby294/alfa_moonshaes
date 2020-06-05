#include "alfa_weather_inc"

void main()
{
    object oArea = GetArea(GetPCSpeaker());
    int flags = GetLocalInt(oArea, "LI_AREA_WEATHER_FLAGS");

    SetLocalInt(oArea, "LI_AREA_WEATHER_FLAGS", flags ^ AREA_WEATHER_FLAG_FOG_COLOR);
}
