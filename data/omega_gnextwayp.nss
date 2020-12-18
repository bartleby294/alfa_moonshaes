void main()
{
    object oPC = GetPCSpeaker();
    location origLoc = GetLocalLocation(oPC, "OMOrigLocation");
    int index = GetLocalInt(oPC, "OMCIndex");

    index++;

    object oResult = GetNearestObjectToLocation(OBJECT_TYPE_WAYPOINT, origLoc, index);

    if(GetIsObjectValid(oResult)) {
        SetLocalObject( oPC, "OMWandTarget", oResult );
        SetLocalInt( oPC, "OMCIndex", index);
    }
}
