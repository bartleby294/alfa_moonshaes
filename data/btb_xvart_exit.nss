void main()
{
    object enterObj = GetEnteringObject();
    if(GetTag(enterObj) == "xvart_raider") {
        AssignCommand(enterObj, ActionSpeakString("*Runs into the forest.*"));
        DestroyObject(enterObj, 2.0);
    }
}
