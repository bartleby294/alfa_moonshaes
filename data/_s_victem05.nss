void main()
{
    object victem1 = GetObjectByTag("TortureVictem04");
    object victem2 = GetObjectByTag("TortureVictem05");
    object victem3 = GetObjectByTag("TortureVictem06");

    int randnum = d3(1);

    if( randnum == 1)
    {
       AssignCommand(victem1, SpeakString("Please ... Please help me ..."));
    }
    if( randnum == 2)
    {
      AssignCommand(victem2, SpeakString("Let me go just let me go ..."));
    }
    if( randnum == 3)
    {
        AssignCommand(victem3, SpeakString("Come closer ... just a little closer ..."));
    }

}
