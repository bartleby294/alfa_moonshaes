void main()
{
    object trigger = OBJECT_SELF;
    object Preacher = GetObjectByTag("Mines02_Moradin_Preacher01");

    if(GetLocalInt(trigger, "state") == 0)
    {
     SetLocalInt(trigger, "state", 1);
     DelayCommand(1.0, AssignCommand(Preacher, ActionSpeakString("Moradin is the father and creator of the dwarven race. Honor him by emulating his principles and workmanship in smithing, stoneworking, and other tasks.")));
     DelayCommand(20.0, AssignCommand(Preacher, ActionSpeakString("Wisdom is derived from life and tempered with experience. Advance the dwarven race in all areas of life. Innovate with new processes and skills. ") ));
     DelayCommand(49.0, AssignCommand(Preacher, ActionSpeakString("Found new kingdoms and clan lands, defending the existing ones from all threats. Lead the dwarves in the traditions laid down by the Soul Forger. Honor your clan leaders as you honor Moradin.") ));

     DelayCommand(120.0, SetLocalInt(trigger, "state", 0));
    }


}
