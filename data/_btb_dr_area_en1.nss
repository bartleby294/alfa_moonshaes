void main()
{
    object spawnWP = GetObjectByTag("moonwell_hb_spawn_loc_1");
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", spawnWP);

    //WriteTimestampedLogEntry("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    //WriteTimestampedLogEntry("HB Object UUID: " + GetObjectUUID(obHbObj));
    if(obHbObj == OBJECT_INVALID) {
        WriteTimestampedLogEntry("_btb_dr_area_en1 - WARN: obHbObj == OBJECT_INVALID" );
    }

    if(obHbObj == OBJECT_INVALID
        || GetArea(obHbObj) != GetArea(OBJECT_SELF)) {
        CreateObject(OBJECT_TYPE_PLACEABLE, "moonwell01onhbob",
                        GetLocation(spawnWP));
        //WriteTimestampedLogEntry("Create moonwell rock.");
    }

    ExecuteScript("ms_on_area_enter");

}
