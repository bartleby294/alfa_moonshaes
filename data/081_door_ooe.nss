void CloseMe ()
{
    if (GetIsOpen(OBJECT_SELF))
    {
        ActionCloseDoor(OBJECT_SELF);
        int nDoorAction = d4();
        switch (nDoorAction)
        {
        case 1:
            SpeakString("A draft closes this door.");
            break;
        case 2:
            SpeakString("The door swings to a close.");
            break;
        case 3:
            SpeakString("You hear a squeeking noise as the door swings to a close.");
            break;
        case 4:
            SpeakString("The door closes.");
            break;
        default: break;
        }
    }
}


void main()
{
    DelayCommand(15.0, CloseMe());
}
