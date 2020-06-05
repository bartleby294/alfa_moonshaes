int StartingConditional()
{
    return ( GetObjectType(GetLocalObject(GetPCSpeaker(), "OMWandTarget")) == OBJECT_TYPE_CREATURE );
}
