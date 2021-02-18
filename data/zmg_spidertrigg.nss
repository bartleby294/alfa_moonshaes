void main()
{
    object oPC = GetEnteringObject();
    object warning = GetNearestObjectByTag("spiderwarning1");
    if (GetLocalInt(OBJECT_SELF, "triggered2") == 0)
    {
        AssignCommand(warning, SpeakString("*Waggles its fangs at you menacingly*"));
        SetLocalInt(OBJECT_SELF, "triggered2", 1);
    }
}
