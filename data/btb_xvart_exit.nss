void main()
{
    object enterObj = GetEnteringObject();
    if(GetTag(enterObj) == "xvart_raider") {
        AssignCommand(enterObj, ActionSpeakString("*Jumps over hedge*"));
        DestroyObject(enterObj, 2.0);
    }
}
