void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
         SetLocalInt(oPC,"cmk_sleep",FALSE);
    }

}
