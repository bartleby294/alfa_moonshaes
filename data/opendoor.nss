void main()
{
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
    SetLocked(oDoor, 0);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));
}
