#include "alfa_weather_inc"

/*
Current weather status:
Weather roll: <CUSTOM9901>
Temperature roll: <CUSTOM9902>
Values usually range from 1 to 100. The lower number is considered more severe, and colder.

Chance of different weather types: Module / Area
Overcast: <CUSTOM9903>% / <CUSTOM9907>%
Precipitation: <CUSTOM9904>% / <CUSTOM9908>%
Storm: <CUSTOM9905>% / <CUSTOM9909>%
Snow (instead of rain): <CUSTOM9906>% / <CUSTOM9910>%

Status of different weather options: Module / Area
Weather changes: <CUSTOM9911> / <CUSTOM9915>
Skybox changes: <CUSTOM9912> / <CUSTOM9916>
Fog color changes: <CUSTOM9913> / <CUSTOM9917>
Fog amount changes: <CUSTOM9914> / <CUSTOM9918>

Would you like to change weather globally, or only in this area?
*/

string SwitchToString(int bool, int enabled = 1) {
    if(!enabled)
        return "Disabled";
    if(bool)
        return "Off";
        else return "On";
}

int StartingConditional()
{
    object oModule = GetModule();
    object oArea = GetArea(GetPCSpeaker());

    //SetCustomToken(9900, SwitchToString(GetLocalInt(oModule, LI_AREA_WEATHER_FLAGS) & AREA_WEATHER_FLAG_MASTER));

    SetCustomToken(9901, IntToString(GetLocalInt(oModule, LI_CURRENT_WEATHER_ROLL)));
    SetCustomToken(9902, IntToString(GetLocalInt(oModule, LI_CURRENT_SNOW_ROLL)));

    SetCustomToken(9903, IntToString(ALFA_WEATHER_CHANCE_OVERCAST));
    SetCustomToken(9904, IntToString(ALFA_WEATHER_CHANCE_RAINY));
    SetCustomToken(9905, IntToString(ALFA_WEATHER_CHANCE_STORMY));
    SetCustomToken(9906, IntToString(ALFA_WEATHER_CHANCE_SNOW));

    SetCustomToken(9907, IntToString(ALFA_WEATHER_CHANCE_OVERCAST + GetLocalInt(oArea, LI_OVERCAST_CHANCE)));
    SetCustomToken(9908, IntToString(ALFA_WEATHER_CHANCE_RAINY + GetLocalInt(oArea, LI_RAIN_CHANCE)));
    SetCustomToken(9909, IntToString(ALFA_WEATHER_CHANCE_STORMY + GetLocalInt(oArea, LI_STORM_CHANCE)));
    SetCustomToken(9910, IntToString(ALFA_WEATHER_CHANCE_SNOW + GetLocalInt(oArea, LI_SNOW_CHANCE)));

    SetCustomToken(9911, SwitchToString(GetLocalInt(oModule, LI_AREA_WEATHER_FLAGS) & AREA_WEATHER_FLAG_MASTER));
    SetCustomToken(9912, SwitchToString(GetLocalInt(oModule, LI_AREA_WEATHER_FLAGS) & AREA_WEATHER_FLAG_SKYBOX));
    SetCustomToken(9913, SwitchToString(GetLocalInt(oModule, LI_AREA_WEATHER_FLAGS) & AREA_WEATHER_FLAG_FOG_COLOR));
    SetCustomToken(9914, SwitchToString(GetLocalInt(oModule, LI_AREA_WEATHER_FLAGS) & AREA_WEATHER_FLAG_FOG_AMOUNT));

    SetCustomToken(9915, SwitchToString(GetLocalInt(oArea, LI_AREA_WEATHER_FLAGS) & AREA_WEATHER_FLAG_MASTER));
    SetCustomToken(9916, SwitchToString(GetLocalInt(oArea, LI_AREA_WEATHER_FLAGS) & AREA_WEATHER_FLAG_SKYBOX));
    SetCustomToken(9917, SwitchToString(GetLocalInt(oArea, LI_AREA_WEATHER_FLAGS) & AREA_WEATHER_FLAG_FOG_COLOR));
    SetCustomToken(9918, SwitchToString(GetLocalInt(oArea, LI_AREA_WEATHER_FLAGS) & AREA_WEATHER_FLAG_FOG_AMOUNT));

    return gALFA_USE_GLOBAL_WEATHER;
}
