  /* Auto-close door */
void main()
{
DelayCommand(30.0f,ActionCloseDoor(OBJECT_SELF));
DelayCommand(2.0f,SetLocked(OBJECT_SELF,TRUE));
}
