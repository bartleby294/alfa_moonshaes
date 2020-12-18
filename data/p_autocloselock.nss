void main()
{
   DelayCommand(99.0, ActionCloseDoor(OBJECT_SELF));
   SetLocked(OBJECT_SELF,TRUE);
}
