void main()
{
    object oPC = GetLastDisarmed();

    if(GetIsPC(oPC) == TRUE) {
        FloatingTextStringOnCreature("*Handles a hiding spider.*", oPC);
    }
}
