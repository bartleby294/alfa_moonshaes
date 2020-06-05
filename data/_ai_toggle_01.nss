void main()
{
    AssignCommand(OBJECT_SELF, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE, 1.0, 1.0));
     if(GetLocalInt(OBJECT_SELF, "AIState") !=1)
     {
        SetLocalInt(OBJECT_SELF, "AIState", 1);
        AssignCommand(OBJECT_SELF, SpeakString("AI Off"));
        return;
     }

     SetLocalInt(OBJECT_SELF, "AIState", 0);
     AssignCommand(OBJECT_SELF, SpeakString("AI On"));
}
