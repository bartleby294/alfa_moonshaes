void main()
{
    object oPC = GetEnteringObject();
    if (GetLocalInt(OBJECT_SELF, "triggered2") == 0)
        {
            object warning = GetNearestObjectByTag("spiderwarning");
            AssignCommand(warning, SpeakString("*Through the gloom of the tunnel flash glints of light reflecting off of eight large eyes...*"));
            SetLocalInt(OBJECT_SELF, "triggered2", 1);
        }
}
