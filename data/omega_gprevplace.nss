void main()
{
    object oPC = GetPCSpeaker();
    location origLoc = GetLocalLocation(oPC, "OMOrigLocation");
    int index = GetLocalInt(oPC, "OMPIndex");

    index--;

    if(index<1)
        index=1;

    SetLocalObject( oPC, "OMWandTarget", GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, origLoc, index) );
    SetLocalInt( oPC, "OMPIndex", index);
}
