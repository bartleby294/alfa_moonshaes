void main()
{
    object oPC = GetPCSpeaker();
    location origLoc = GetLocalLocation(oPC, "OMOrigLocation");
    int index = GetLocalInt(oPC, "OMPIndex");

    index++;

    object oResult = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, origLoc, index);

    if(GetIsObjectValid(oResult)) {
        SetLocalObject( oPC, "OMWandTarget", oResult );
        SetLocalInt( oPC, "OMPIndex", index);
    }
}
