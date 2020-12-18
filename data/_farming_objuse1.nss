void main()
{
    object Farmer = GetLastUsedBy();

    if(GetTag(Farmer) != "farmer")
    {
        return;
    }

    int RandNum = d6(1);

    // gives the farmer something to do randomly
    if(RandNum == 1)
    {
        AssignCommand(Farmer, ActionInteractObject(GetNearestObjectByTag("farmer_attack_obj")));
    }
    if(RandNum == 2)
    {
        AssignCommand(Farmer, ActionAttack(OBJECT_SELF));
    }
    if(RandNum == 3)
    {
       AssignCommand(Farmer, ActionInteractObject(GetNearestObjectByTag("farmer_attack_obj", Farmer, 2)));
    }
    if(RandNum == 4)
    {
       AssignCommand(Farmer, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
    }
    if(RandNum == 5)
    {
       AssignCommand(Farmer, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 2.0));
    }
    if(RandNum == 6)
    {
       AssignCommand(Farmer, PlayAnimation(ANIMATION_LOOPING_PAUSE, 1.0, 2.0));
    }
}
