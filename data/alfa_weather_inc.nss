/*
    Writen by: Ronan
    Last updated: 11/12/05

    HOW TO USE ALFA WEATHER 2:
        First, make sure you have version 1.19 of the ACR.
        Next, read this guide.

    QUICK START GUIDE:
        1. Scroll down, and edit the constants after the line:
            // USER EDITS GO HERE:
           These define the weather options for the server. For details on what
           these do, read below.
        2. Rebuild all scripts in the module.
        3. Run module.

    Know problem:
        Storms and overcast are not really represented other than different fog
        settings. BW did not give us a way to modify the amount of wind, rain
        and lightning in an area. Lightning can be done by moving the lightning
        slider in each area, as this only has an effect when it is raining or
        snowing. The wind slider has constant effects under all weather
        conditions.

    This weather system has completely rewriten from ALFA's original.
    It should be compatible with the old version, with some changes:

        Global skies are disabled, as they were not in use by any server when this
        was writen.

    ALFA's weather waypoints now work correctly. A snow waypoint causes snow in
    that area any time it would be raining. A rain waypoint keeps that area from
    ever snowing. A clear WP keeps any weather effects from happening.

    However, new builders may want to consider the additional options added,
    see below.

    The following lines need to be added as constants (by default they are
    pasted below):

        const int ALFA_WEATHER_MINIMUM_DURATION = 1;
        const int ALFA_WEATHER_RANDOM_DURATION = 7;
        These values effect how often the weather changes. With the values
        listed above, weather would last 1 + d7 hours.

        const int ALFA_WEATHER_CHANCE_OVERCAST = 30;
        const int ALFA_WEATHER_CHANCE_RAINY = 15;
        const int ALFA_WEATHER_CHANCE_STORMY = 2;
        These are the chances for each type of weather, set the values however
        you wish, from 0 to 100. 0 indicates that type of weather will never occur,
        and 100 indicates it always will. The values should decrease from overcast
        to stormy, as per the example above.

        const int ALFA_WEATHER_CHANCE_SNOW = 0;
        Set this to whatever you want, from 0 to 100. This indicates the chance of
        all rain in areas without weather waypoints to become snow.

        These constants effect all outdoor areas on the server that do not have
        weather waypoints. However, individual areas do not have to use these
        constants (see below).

        ALFA_WEATHER_CLEAR_SKYBOX = -1;
        ALFA_WEATHER_RAIN_SKYBOX = -1;
        ALFA_WEATHER_SNOW_SKYBOX = -1;
        ALFA_WEATHER_OVERCAST_SKYBOX = -1;
        ALFA_WEATHER_STORM_SKYBOX = -1;
        This defines the default skyboxes used in different conditions. Leave
        these set to -1 if you want to keep the default skyboxes in your areas.
        Example: You could have the clear skybox set to -1, and the others set
        to 2 (Grass_Storm). This would only use the stormy skybox in cloudy,
        rainy or stormy conditions. Skybox 0 would be no skybox at all.

        const int ALFA_WEATHER_OVERWRITE_SKYBOX = 0;
        If this variable is set to 1, the weather system will overwrite any
        existing skyboxes with its own.

        const int ALFA_WEATHER_USE_FOG_AMOUNT = 0;
        If this variable is set to 1, fog amount will be changed
        based on the weather severity (clear, overcast, rainy or stormy).

        const int ALFA_WEATHER_USE_FOG_COLOR = 0;
        If this variable is set to 1, fog color will be changed based on the
        weather type (clear, overcast, rainy or snowy).

        const int ALFA_USE_RAIN_PLACEABLES = 0;
        const int ALFA_USE_SNOW_PLACEABLES = 0;
        These features are not yet implemented, but will allow placables
        (patches of snow, puddles, etc) to be added to areas that will only
        appear during certain weather conditions.

        const int ALFA_WEATHER_FOG_SUN_CLEAR_COLOR = -1;
        const int ALFA_WEATHER_FOG_SUN_RAIN_COLOR = 0xdddddd;
        const int ALFA_WEATHER_FOG_SUN_SNOW_COLOR = 0xeeeeee;
        const int ALFA_WEATHER_FOG_SUN_OVERCAST_COLOR = 0xdddddd;
        const int ALFA_WEATHER_FOG_MOON_CLEAR_COLOR = -1;
        const int ALFA_WEATHER_FOG_MOON_RAIN_COLOR = 0xbbbbbb;
        const int ALFA_WEATHER_FOG_MOON_SNOW_COLOR = 0xdddddd;
        const int ALFA_WEATHER_FOG_MOON_OVERCAST_COLOR = 0xbbbbbb;
        These constants effect the color of the fog during the different weather
        conditions and day/night shifts. If set to -1, that area's
        default fog color will be used.
        The format of a hex specified color would be 0xFFEEDD where
        FF would represent the amount of red in the color
        EE would represent the amount of green in the color
        DD would represent the amount of blue in the color.

        const int ALFA_WEATHER_FOG_SUN_CLEAR_AMOUNT = 1;
        const int ALFA_WEATHER_FOG_SUN_OVERCAST_AMOUNT = 10;
        const int ALFA_WEATHER_FOG_SUN_RAIN_AMOUNT = 30;
        const int ALFA_WEATHER_FOG_SUN_STORM_AMOUNT = 40;
        const int ALFA_WEATHER_FOG_MOON_CLEAR_AMOUNT = 1;
        const int ALFA_WEATHER_FOG_MOON_OVERCAST_AMOUNT = 10;
        const int ALFA_WEATHER_FOG_MOON_RAIN_AMOUNT = 30;
        const int ALFA_WEATHER_FOG_MOON_STORM_AMOUNT = 40;
        These constants effect the amount of fog in the air for different
        weather conditions. Note the amount of fog is NOT fog distance. Set
        these values to -1 if you want the default values to be used.

    This local variable should be placed on areas to turn off certain
    options:
        LI_AREA_WEATHER_FLAGS
        It is read in a bitwise fashion, each bit being a flag to turn something
        off. Add the values of of these constants to turn of the desired
        effects. ie, set this to 14 (4 + 8 + 2) to turn off all fog and skybox
        options.
        1   turns off this weather system altogether.
        2   turns off the skybox portion of this weather system.
        4   turns off different fog colors.
        8   turns off different fog amounts.

    By adding locals variables to an area itself, the alfa_options constants
    can be overwriten. Therefore, these are totally optional:

        LI_OVERCAST_CHANCE
        LI_RAIN_CHANCE
        LI_STORM_CHANCE
        LI_SNOW_CHANCE
        These variables are added to the global constants, and but only on the
        area they are placed on. For example, LI_SNOW_CHANCE could be increased
        as elevation increases, representing a drop in tempurature increasing
        the chance of snowfall. The end result would be snow at higher
        elevations, and rain at lower. ie, if LI_SNOW_CHANCE on an area is 30,
        and ALFA_WEATHER_CHANCE_SNOW is 20, that area will have a 50% chance
        to see snow whenever there is precipitation (20 + 30 = 50).

        LI_CLEAR_SKYBOX
        LI_OVERCAST_SKYBOX
        LI_STORM_SKYBOX
        LI_RAIN_SKYBOX
        LI_SNOW_SKYBOX
        These variables function the same as the global skybox constants, but
        effect the area they are placed on.

    Other features that could be added:
        Weather "groups", ie groups of areas that share the same weather patterns.
        Currently the whole server opperates as one group.

        Placable puddles and patches of snow that appear and disapear with
        rain/snow. I started to add this, but then realized we did not have
        good enough placables to make it worthwhile.

        Interpolate weather conditions, so the fog effects gradually change
        with the weather.

        Make the current weather conditions weighted, so they change more
        gradually.

    Updates:
        11/12/05:
            A DM weather tool added to change area and module weather.
            Other minor changes to decrease execution time.
        5/03/06:
            Weather tool moved to Omega Wand 2. Options moved from alfa_options
            to this file.
*/

#include "alfa_include"

// ALFA Gobal Weather variables:
// USER EDITS GO HERE:
//    const int ALFA_WEATHER_CHANCE_OVERCAST = 20;
//    const int ALFA_WEATHER_CHANCE_RAINY = 10;
//    const int ALFA_WEATHER_CHANCE_STORMY = 2;
//    const int ALFA_WEATHER_CHANCE_SNOW = 50;

//    const int ALFA_WEATHER_CLEAR_SKYBOX = -1;
//    const int ALFA_WEATHER_RAIN_SKYBOX = -1;
//    const int ALFA_WEATHER_OVERCAST_SKYBOX = -1;
//    const int ALFA_WEATHER_STORM_SKYBOX = -1;
    const int ALFA_WEATHER_OVERWRITE_SKYBOX = 0;

    const int ALFA_WEATHER_FOG_SUN_CLEAR_COLOR = -1;
    const int ALFA_WEATHER_FOG_SUN_RAIN_COLOR = 0xbbbbbb;
    const int ALFA_WEATHER_FOG_SUN_SNOW_COLOR = 0xeeeeee;
    const int ALFA_WEATHER_FOG_SUN_OVERCAST_COLOR = -1;

    const int ALFA_WEATHER_FOG_MOON_CLEAR_COLOR = -1;
    const int ALFA_WEATHER_FOG_MOON_RAIN_COLOR = 0x666666;
    const int ALFA_WEATHER_FOG_MOON_SNOW_COLOR = 0xdddddd;
    const int ALFA_WEATHER_FOG_MOON_OVERCAST_COLOR = -1;

    const int ALFA_WEATHER_FOG_SUN_CLEAR_AMOUNT = 0;
    const int ALFA_WEATHER_FOG_SUN_OVERCAST_AMOUNT = 5;
    const int ALFA_WEATHER_FOG_SUN_RAIN_AMOUNT = 20;
    const int ALFA_WEATHER_FOG_SUN_STORM_AMOUNT = 60;

    const int ALFA_WEATHER_FOG_MOON_CLEAR_AMOUNT = 0;
    const int ALFA_WEATHER_FOG_MOON_OVERCAST_AMOUNT = 5;
    const int ALFA_WEATHER_FOG_MOON_RAIN_AMOUNT = 20;
    const int ALFA_WEATHER_FOG_MOON_STORM_AMOUNT = 60;

    const int ALFA_WEATHER_USE_FOG_AMOUNT = 0;
    const int ALFA_WEATHER_USE_FOG_COLOR = 0;
    const int ALFA_USE_RAIN_PLACEABLES = 0;
    const int ALFA_USE_SNOW_PLACEABLES = 0;

    const int ALFA_WEATHER_MINIMUM_DURATION = 1;
    const int ALFA_WEATHER_RANDOM_DURATION = 7;

    const string ALFA_WEATHER_CLEAR_WP_TAG = "alfa_cl_wea_only";
    const string ALFA_WEATHER_SNOW_WP_TAG = "alfa_snow_area";
    const string ALFA_WEATHER_RAIN_WP_TAG = "alfa_rn_wea_only";
    const string ALFA_WEATHER_STORM_WP_TAG = "alfa_st_wea_only";

    const string LI_CLEAR_SKYBOX = "LI_CLEAR_SKYBOX";
    const string LI_OVERCAST_SKYBOX = "LI_OVERCAST_SKYBOX";
    const string LI_STORM_SKYBOX = "LI_STORM_SKYBOX";
    const string LI_RAIN_SKYBOX = "LI_RAIN_SKYBOX";
    const string LI_DEFAULT_SKYBOX = "LI_DEFAULT_SKYBOX";

    const string LI_CURRENT_WEATHER_ROLL = "CurrentWeather";
    const string LI_CURRENT_SNOW_ROLL = "CurrentSnow";
    const string LI_CURRENT_DEFAULT_WEATHER_ROLL = "CurrentDefaultWeather";
    const string LI_LAST_WEATHER_ROLL = "LastWeather";
    const string LI_LAST_SNOW_ROLL = "LastSnow";
    const string LI_LAST_DEFAULT_WEATHER_ROLL = "LastDefaultWeather";

    const string LI_OVERCAST_CHANCE = "LI_OVERCAST_CHANCE";
    const string LI_RAIN_CHANCE = "LI_RAIN_CHANCE";
    const string LI_STORM_CHANCE = "LI_STORM_CHANCE";
    const string LI_SNOW_CHANCE = "LI_SNOW_CHANCE";

    const int ALFA_WEATHER_OVERCAST = 1;
    const int ALFA_WEATHER_RAIN = 2;
    const int ALFA_WEATHER_STORM = 4;
    const int ALFA_WEATHER_SNOW = 8;

    const string ALFA_WEATHER_RAIN_PLACEABLE_TAG = "alfa_weatp_rain";
    const string ALFA_WEATHER_SNOW_PLACEABLE_TAG = "alfa_weatp_snow";
    const string LS_WEATHER_PLACABLE_RESREF = "LS_WP_RESREF";

    const string LI_AREA_WEATHER_INITIALIZED_TAG = "LI_AW_INIT";
    const string LI_AREA_PLACEABLE_STATUS = "LI_AW_PS";
    const string LI_WEATHER_STATUS = "LI_AW_STATUS";

    const string LI_DEFAULT_FOG_SUN_AMOUNT = "LI_AW_FSA";
    const string LI_DEFAULT_FOG_MOON_AMOUNT = "LI_AW_FMA";
    const string LI_DEFAULT_FOG_SUN_COLOR = "LI_AW_FSC";
    const string LI_DEFAULT_FOG_MOON_COLOR = "LI_AW_FMC";

    const string LI_AREA_WEATHER_FLAGS = "LI_AREA_WEATHER_FLAGS";
    const int AREA_WEATHER_FLAG_MASTER = 0x0001;
    const int AREA_WEATHER_FLAG_SKYBOX = 0x0010;
    const int AREA_WEATHER_FLAG_FOG_COLOR = 0x0100;
    const int AREA_WEATHER_FLAG_FOG_AMOUNT = 0x1000;
// END USER EDITS

//int currentGlobalWeatherStatus;
//int currentWeatherRoll, currentSnowRoll, currentDefaultWeatherRoll;
//int lastWeatherRoll, lastSnowRoll, lastDefaultWeatherRoll;

void SetGlobalWeather(int currentWeatherRoll, int currentSnowRoll, int defaultWeatherRoll);
void ChangeGlobalWeather();
void ShowWeatherPlacables(object oPC, string tag);
void HideWeatherPlacables(object oPC, string tag);
int GetWeatherForModule();
int GetWeatherForArea(object oArea, int currentWeatherRoll, int snowRoll, int defaultRoll);
void ConfigureSkybox(object oArea, int globalSkybox, string localSkyboxVarString);
void SetAreaWeather(object oArea, int weatherStatus);
void UpdateWeatherForPC(object oPC);
void UpdateWeatherForPCs();
int UpdateAreaWeather(object oArea);
void SetModuleWeather(int weatherStatus);

void UpdateModuleWeather() {
    SetModuleWeather(GetWeatherForModule());
    UpdateWeatherForPCs();
}

void GenerateGlobalWeather() {

    object mod = GetModule();

    int weatherDuration = ALFA_WEATHER_MINIMUM_DURATION + Random(ALFA_WEATHER_RANDOM_DURATION);
    DelayCommand(HoursToSeconds(weatherDuration), GenerateGlobalWeather());

    if(GetLocalInt(mod, LI_AREA_WEATHER_FLAGS) & AREA_WEATHER_FLAG_MASTER)
        return;

    SetLocalInt(mod, LI_CURRENT_WEATHER_ROLL, d100());
    SetLocalInt(mod, LI_CURRENT_SNOW_ROLL, d100());
    SetLocalInt(mod, LI_CURRENT_DEFAULT_WEATHER_ROLL, d100());

    UpdateModuleWeather();
}

void ShowWeatherPlacables(object oPC, string tag) {
    int i;
    object obj;

    for(i=0; GetIsObjectValid(obj = GetNearestObjectByTag(tag, oPC, i)); i++) {
        string resref = GetLocalString(obj, LS_WEATHER_PLACABLE_RESREF);
        CreateObject(OBJECT_TYPE_PLACEABLE, resref, GetLocation(obj), FALSE, resref);
    }
}

void HideWeatherPlacables(object oPC, string tag) {
    int i;
    object obj;

    for(i=0; GetIsObjectValid(obj = GetNearestObjectByTag(tag, oPC, i)); i++) {
        //SendMessageToPC(oPC, "Destroying weather placable " + GetName(obj));
        DestroyObject(GetNearestObjectByTag(GetLocalString(obj, LS_WEATHER_PLACABLE_RESREF), obj));
    }
}

void UpdateWeatherPlacables(object oPC, int weatherStatus) {
    object oArea = GetArea(oPC);
    int areaStatus = GetLocalInt(oArea, LI_AREA_PLACEABLE_STATUS);
    int changes = areaStatus ^ weatherStatus;
    //SetLocalInt(oArea, LI_AREA_PLACEABLE_STATUS, weatherPlacableStatus);

    if(!changes)
        return;

    if(changes & ALFA_WEATHER_RAIN)
        if(weatherStatus & ALFA_WEATHER_RAIN)
            if(!(weatherStatus & ALFA_WEATHER_SNOW)) {
            ShowWeatherPlacables(oPC, ALFA_WEATHER_RAIN_PLACEABLE_TAG);
            } else HideWeatherPlacables(oPC, ALFA_WEATHER_RAIN_PLACEABLE_TAG);

    if(changes & ALFA_WEATHER_SNOW)
        if(weatherStatus & ALFA_WEATHER_SNOW) {
            if(weatherStatus & ALFA_WEATHER_RAIN)
                ShowWeatherPlacables(oPC, ALFA_WEATHER_SNOW_PLACEABLE_TAG);
            } else HideWeatherPlacables(oPC, ALFA_WEATHER_SNOW_PLACEABLE_TAG);
}

int GetHasWeatherWaypoint(object oArea, string tag) {
    object obj = GetFirstObjectInArea(oArea);

    return ( GetIsObjectValid(obj) && (GetTag(obj) == tag || GetIsObjectValid(GetNearestObjectByTag(tag, obj))) );
}

int GetWeatherForModule() {
    object mod = GetModule();
    int currentWeatherRoll = GetLocalInt(mod, LI_CURRENT_WEATHER_ROLL);
    int currentSnowRoll = GetLocalInt(mod, LI_CURRENT_SNOW_ROLL);
    int currentDefaultWeatherRoll = GetLocalInt(mod, LI_CURRENT_DEFAULT_WEATHER_ROLL);

    return  ( ((currentWeatherRoll <= ALFA_WEATHER_CHANCE_OVERCAST) * ALFA_WEATHER_OVERCAST) |
            ((currentWeatherRoll <= ALFA_WEATHER_CHANCE_RAINY) * ALFA_WEATHER_RAIN) |
            ((currentWeatherRoll <= ALFA_WEATHER_CHANCE_STORMY) * ALFA_WEATHER_STORM) |
            ((currentSnowRoll <= ALFA_WEATHER_CHANCE_SNOW) * ALFA_WEATHER_SNOW) );
}

int GetWeatherForArea(object oArea, int currentWeatherRoll, int snowRoll, int defaultRoll) {
    int overcastChance = ALFA_WEATHER_CHANCE_OVERCAST + GetLocalInt(oArea, LI_OVERCAST_CHANCE);
    int rainChance = ALFA_WEATHER_CHANCE_RAINY + GetLocalInt(oArea, LI_RAIN_CHANCE);
    int stormChance = ALFA_WEATHER_CHANCE_STORMY + GetLocalInt(oArea, LI_STORM_CHANCE);
    int snowChance = ALFA_WEATHER_CHANCE_SNOW + GetLocalInt(oArea, LI_SNOW_CHANCE);

    return  ( ((!GetHasWeatherWaypoint(oArea, ALFA_WEATHER_CLEAR_WP_TAG) && (currentWeatherRoll <= overcastChance)) * ALFA_WEATHER_OVERCAST) |
            ((!GetHasWeatherWaypoint(oArea, ALFA_WEATHER_CLEAR_WP_TAG) && (currentWeatherRoll <= rainChance)) * ALFA_WEATHER_RAIN) |
            ((!GetHasWeatherWaypoint(oArea, ALFA_WEATHER_CLEAR_WP_TAG) && (currentWeatherRoll <= stormChance)) * ALFA_WEATHER_STORM) |
            ((!GetHasWeatherWaypoint(oArea, ALFA_WEATHER_RAIN_WP_TAG) && ((snowRoll <= snowChance) || GetHasWeatherWaypoint(oArea, ALFA_WEATHER_SNOW_WP_TAG))) * ALFA_WEATHER_SNOW) );
}

void ConfigureSkybox(object oArea, int globalSkybox, string localSkyboxVarString) {
    int defaultSkybox = GetLocalInt(oArea, LI_DEFAULT_SKYBOX);
    int skybox;

    if(defaultSkybox && !ALFA_WEATHER_OVERWRITE_SKYBOX)
        return;

    int localSkybox = GetLocalInt(oArea, localSkyboxVarString);

    if(localSkybox == 0)
        localSkybox = globalSkybox;

    if(localSkybox == -1)
        skybox = 0;
        else skybox = localSkybox;

    if(GetSkyBox(oArea) != skybox)
        SetSkyBox(skybox, oArea);

    //SendMessageToAllDMs("Setting Weather: " + IntToString(localSkybox));
}


void SetModuleWeather(int weatherStatus) {

    if(weatherStatus & ALFA_WEATHER_STORM) {
        if(weatherStatus & ALFA_WEATHER_SNOW) {
            SetWeather(GetModule(), WEATHER_SNOW);
        } else {
            SetWeather(GetModule(), WEATHER_RAIN);
        }
    } else if(weatherStatus & ALFA_WEATHER_RAIN) {
        if(weatherStatus & ALFA_WEATHER_SNOW) {
            SetWeather(GetModule(), WEATHER_SNOW);
        } else {
            SetWeather(GetModule(), WEATHER_RAIN);
        }
    } else if(weatherStatus & ALFA_WEATHER_OVERCAST) {
        SetWeather(GetModule(), WEATHER_CLEAR);
    } else {
        SetWeather(GetModule(), WEATHER_CLEAR);
    }
}

int GetIsSnowPossible(object oArea) {
    int currentSnowRoll = GetLocalInt(GetModule(), LI_CURRENT_SNOW_ROLL);
    return ( currentSnowRoll <= (ALFA_WEATHER_CHANCE_SNOW + GetLocalInt(oArea, LI_SNOW_CHANCE)) );
}

void SetAreaWeather(object oArea, int weatherStatus) {

    int areaFlags = GetLocalInt(oArea, LI_AREA_WEATHER_FLAGS);

    if(areaFlags & AREA_WEATHER_FLAG_MASTER) {
        SetWeather(oArea, WEATHER_USE_AREA_SETTINGS);
        return;
    }

    if(!GetLocalInt(oArea, LI_AREA_WEATHER_INITIALIZED_TAG)) {
        SetLocalInt(oArea, LI_DEFAULT_SKYBOX, GetSkyBox(oArea));

        if(ALFA_WEATHER_USE_FOG_AMOUNT) {
            SetLocalInt(oArea, LI_DEFAULT_FOG_SUN_AMOUNT, GetFogAmount(FOG_TYPE_MOON, oArea));
            SetLocalInt(oArea, LI_DEFAULT_FOG_MOON_AMOUNT, GetFogAmount(FOG_TYPE_MOON, oArea));
        }

        if(ALFA_WEATHER_USE_FOG_COLOR) {
            SetLocalInt(oArea, LI_DEFAULT_FOG_SUN_COLOR, GetFogColor(FOG_TYPE_SUN, oArea));
            SetLocalInt(oArea, LI_DEFAULT_FOG_MOON_COLOR, GetFogColor(FOG_TYPE_MOON, oArea));
        }

        SetLocalInt(oArea, LI_AREA_WEATHER_INITIALIZED_TAG, 1);
    }

    /*SendMessageToAllDMs("weatherStatus " + IntToString(weatherStatus));
    SendMessageToAllDMs("ALFA_WEATHER_STORM " + IntToString(weatherStatus & ALFA_WEATHER_STORM));
    SendMessageToAllDMs("ALFA_WEATHER_RAIN " + IntToString(weatherStatus & ALFA_WEATHER_RAIN));
    SendMessageToAllDMs("ALFA_WEATHER_OVERCAST " + IntToString(weatherStatus & ALFA_WEATHER_OVERCAST));
    SendMessageToAllDMs("ALFA_WEATHER_SNOW " + IntToString(weatherStatus & ALFA_WEATHER_SNOW));
    SendMessageToAllDMs("Sun fog amount: " + IntToString(GetFogAmount(FOG_TYPE_SUN, oArea)));
    SendMessageToAllDMs("Moon fog amount: " + IntToString(GetFogAmount(FOG_TYPE_MOON, oArea)));
    SendMessageToAllDMs("Sun fog color: " + IntToHexString(GetFogColor(FOG_TYPE_SUN, oArea)));
    SendMessageToAllDMs("Moon fog color: " + IntToHexString(GetFogColor(FOG_TYPE_MOON, oArea)));*/

    int newWeatherType, globalSkybox, sunFogColor, moonFogColor, sunFogAmount, moonFogAmount;
    string localSkyboxVarString;

    if(weatherStatus & ALFA_WEATHER_STORM) {
        if(weatherStatus & ALFA_WEATHER_SNOW) {
            SetWeather(oArea, WEATHER_CLEAR);   // Added for lightning bug mentioned in Lexicon.
            newWeatherType = WEATHER_SNOW;
            sunFogColor = ALFA_WEATHER_FOG_SUN_SNOW_COLOR;
            moonFogColor = ALFA_WEATHER_FOG_MOON_SNOW_COLOR;
        } else {
            newWeatherType = WEATHER_RAIN;
            sunFogColor = ALFA_WEATHER_FOG_SUN_RAIN_COLOR;
            moonFogColor = ALFA_WEATHER_FOG_MOON_RAIN_COLOR;
        }
        globalSkybox = ALFA_WEATHER_STORM_SKYBOX;
        localSkyboxVarString = LI_STORM_SKYBOX;
        sunFogAmount = ALFA_WEATHER_FOG_SUN_STORM_AMOUNT;
        moonFogAmount = ALFA_WEATHER_FOG_MOON_STORM_AMOUNT;
    } else if(weatherStatus & ALFA_WEATHER_RAIN) {
        if(weatherStatus & ALFA_WEATHER_SNOW) {
            SetWeather(oArea, WEATHER_CLEAR);   // Added for lightning bug mentioned in Lexicon.
            newWeatherType = WEATHER_SNOW;
            sunFogColor = ALFA_WEATHER_FOG_SUN_SNOW_COLOR;
            moonFogColor = ALFA_WEATHER_FOG_MOON_SNOW_COLOR;
        } else {
            newWeatherType = WEATHER_RAIN;
            sunFogColor = ALFA_WEATHER_FOG_SUN_RAIN_COLOR;
            moonFogColor = ALFA_WEATHER_FOG_MOON_RAIN_COLOR;
        }
        globalSkybox = ALFA_WEATHER_RAIN_SKYBOX;
        localSkyboxVarString = LI_RAIN_SKYBOX;
        sunFogAmount = ALFA_WEATHER_FOG_SUN_RAIN_AMOUNT;
        moonFogAmount = ALFA_WEATHER_FOG_MOON_RAIN_AMOUNT;
    } else if(weatherStatus & ALFA_WEATHER_OVERCAST) {
        newWeatherType = WEATHER_CLEAR;
        globalSkybox = ALFA_WEATHER_OVERCAST_SKYBOX;
        localSkyboxVarString = LI_OVERCAST_SKYBOX;
        sunFogColor = ALFA_WEATHER_FOG_SUN_OVERCAST_COLOR;
        moonFogColor = ALFA_WEATHER_FOG_MOON_OVERCAST_COLOR;
        sunFogAmount = ALFA_WEATHER_FOG_SUN_OVERCAST_AMOUNT;
        moonFogAmount = ALFA_WEATHER_FOG_MOON_OVERCAST_AMOUNT;
    } else {
        newWeatherType = WEATHER_CLEAR;
        globalSkybox = ALFA_WEATHER_CLEAR_SKYBOX;
        localSkyboxVarString = LI_CLEAR_SKYBOX;
        sunFogColor = ALFA_WEATHER_FOG_SUN_CLEAR_COLOR;
        moonFogColor = ALFA_WEATHER_FOG_MOON_CLEAR_COLOR;
        sunFogAmount = ALFA_WEATHER_FOG_SUN_CLEAR_AMOUNT;
        moonFogAmount = ALFA_WEATHER_FOG_MOON_CLEAR_AMOUNT;
    }

    if(GetWeather(oArea) != newWeatherType)
        SetWeather(oArea, newWeatherType);

    if(!(areaFlags & AREA_WEATHER_FLAG_SKYBOX))
        ConfigureSkybox(oArea, globalSkybox, localSkyboxVarString);

    if(ALFA_WEATHER_USE_FOG_AMOUNT && !(areaFlags & AREA_WEATHER_FLAG_FOG_AMOUNT)) {
        if(sunFogAmount >= 0)
            SetFogAmount(FOG_TYPE_SUN, sunFogAmount, oArea);
            else SetFogAmount(FOG_TYPE_SUN, GetLocalInt(oArea, LI_DEFAULT_FOG_SUN_AMOUNT), oArea);
        if(moonFogAmount >= 0)
            SetFogAmount(FOG_TYPE_MOON, moonFogAmount, oArea);
            else SetFogAmount(FOG_TYPE_MOON, GetLocalInt(oArea, LI_DEFAULT_FOG_MOON_AMOUNT), oArea);
    }

    if(ALFA_WEATHER_USE_FOG_COLOR && !(areaFlags & AREA_WEATHER_FLAG_FOG_COLOR)) {
        if(sunFogColor >= 0)
            SetFogColor(FOG_TYPE_SUN, sunFogColor, oArea);
            else SetFogColor(FOG_TYPE_SUN, GetLocalInt(oArea, LI_DEFAULT_FOG_SUN_COLOR), oArea);
        if(moonFogColor >= 0)
            SetFogColor(FOG_TYPE_MOON, moonFogColor, oArea);
            else SetFogColor(FOG_TYPE_MOON, GetLocalInt(oArea, LI_DEFAULT_FOG_MOON_COLOR), oArea);
    }
}

int UpdateAreaWeather(object oArea) {
    object module = GetModule();
    int weatherStatus = GetWeatherForArea(oArea, GetLocalInt(module, LI_CURRENT_WEATHER_ROLL), GetLocalInt(module, LI_CURRENT_SNOW_ROLL), GetLocalInt(module, LI_CURRENT_DEFAULT_WEATHER_ROLL));
    SetAreaWeather(oArea, weatherStatus);
    return weatherStatus;
}

void UpdateWeatherForPC(object oPC) {
    object oArea = GetArea(oPC);

    if(!GetIsAreaAboveGround(oArea) || GetIsAreaInterior(oArea) || !GetIsPC(oPC))
        return;

    int weatherStatus = UpdateAreaWeather(GetArea(oPC));
    //UpdateWeatherPlacables(oPC, weatherStatus);
}

void UpdateWeatherForPCs() {
    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID) {
        UpdateWeatherForPC(oPC);
        oPC = GetNextPC();
    }
}

void WeatherEventAreaEnter(object oPC) {
    if(gALFA_USE_GLOBAL_WEATHER)
        UpdateWeatherForPC(oPC);
}

void WeatherEventOnLoad() {
    if(gALFA_USE_GLOBAL_WEATHER) {
        GenerateGlobalWeather();
        ALFA_RegisterItem("dmweather_tag", "dmweather_onact", "", "", TRUE, TRUE, FALSE, FALSE);
    }
}

void WeatherEventOnClientEnter(object oPC) {

    if(gALFA_USE_GLOBAL_WEATHER) {

        if(!GetIsObjectValid(GetArea(oPC)))
            DelayCommand(5.0, WeatherEventOnClientEnter(oPC));

        UpdateWeatherForPC(GetEnteringObject());
    }
}
