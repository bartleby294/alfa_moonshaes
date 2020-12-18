void main()
{
    object oPC = GetEnteringObject();
    int checkdoor = GetLocalInt(oPC, "htowerdoorstat");

    if(checkdoor != 1)
    {
        SetLocalInt(oPC, "htowerdoorstat", 1);
        SendMessageToPC(oPC, "It doesnt look like the towers new resedents have been able to get this door open");
    }
}
