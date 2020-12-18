// part of the door scripts
void main()
{
    ActionWait(1500.0);   //wait 1500 seconds, then close and relock the door.
    ActionCloseDoor(OBJECT_SELF);
    //SetLocked(OBJECT_SELF, TRUE);
}
