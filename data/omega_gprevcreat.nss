void main()
{
    object oPC = GetPCSpeaker();
    location origLoc = GetLocalLocation(oPC, "OMOrigLocation");
    int index = GetLocalInt(oPC, "OMCIndex");

    index--;

    if(index<1)
        index=1;

    SetLocalObject( oPC, "OMWandTarget", GetNearestObjectToLocation(OBJECT_TYPE_CREATURE, origLoc, index) );
    SetLocalInt( oPC, "OMCIndex", index);
}
