void main()
{
    object victem = OBJECT_SELF;
    object Attacker = GetLastAttacker(victem );

    object victem1 = GetObjectByTag("_TortureVictem01");
    object victem2 = GetObjectByTag("_TortureVictem02");
    object victem3 = GetObjectByTag("_TortureVictem03");

    int roll = d4(1);

     if(victem==victem1)
     {
       PlaySound("as_pl_paincryf1");
     }

     if(victem==victem2)
     {
        PlaySound("as_pl_paincrym3");
     }

     if(victem==victem3)
     {
       PlaySound("as_pl_paincrym1");
     }

    if(roll == 1)
    {
        AssignCommand(victem, SpeakString("AHHHH!!!"));
    }
    if(roll == 2)
    {
        AssignCommand(victem, SpeakString("Please Please Stop!!"));
    }
    if(roll == 3)
    {
        AssignCommand(victem, SpeakString("I wont do it again i swear!"));
    }
    if(roll == 4)
    {
        AssignCommand(victem, SpeakString("Ill kill you! Ill kill you!"));
    }
}
