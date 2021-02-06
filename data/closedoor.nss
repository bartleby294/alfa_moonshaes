void main()
{
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
    SetLocked(oDoor, 1);
    AssignCommand(oDoor, ActionCloseDoor(oDoor));
}
