void main()
{
    ExecuteScript("ms_on_area_enter");
    object spawnWP = GetObjectByTag("moonwell_hb_spawn_loc_1");
    object druidHBObj = GetNearestObjectByTag("moonwell01onhbob", spawnWP);

    if(druidHBObj == OBJECT_INVALID
        || GetArea(druidHBObj) != GetArea(OBJECT_SELF)) {
        CreateObject(OBJECT_TYPE_PLACEABLE, "moonwell01onhbob",
                        GetLocation(spawnWP));
    }
}
