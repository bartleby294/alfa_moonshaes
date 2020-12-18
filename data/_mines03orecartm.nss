void main()
{
    object oPC = GetLastUsedBy();

    object Move1 = GetObjectByTag("OreCartMove1");
    object Move2 = GetObjectByTag("OreCartMove2");
    object Move3 = GetObjectByTag("OreCartMove3");
    object Move4 = GetObjectByTag("OreCartMove4");
    object Move5 = GetObjectByTag("OreCartMove5");
    object Move6 = GetObjectByTag("OreCartMove6");
    object Move7 = GetObjectByTag("OreCartMove7");

    object OreCartStorage = GetObjectByTag("Mines03OreCartJumpTo");
    object OreCartInitial = GetObjectByTag("Mines03OreCartJumpTo");

    object cart = GetObjectByTag("Mines03OreCart");
    object cart2 = GetObjectByTag("Mies03OrcCartIniPos");

    int cartRockLvl = GetLocalInt(cart, "cartRockLvl");

   if(cartRockLvl > 14)
   {

        if(GetLocalInt(cart, "position") == 0)
        {
            AssignCommand(cart, JumpToObject(OreCartStorage, TRUE));
            AssignCommand(cart2, JumpToObject(Move1, TRUE));
            SetLocalInt(cart, "position", 1);
        }

        if(GetLocalInt(cart, "position") == 1)
        {
            AssignCommand(cart2, JumpToObject(Move2, TRUE));
            SetLocalInt(cart, "position", 2);
        }

        if(GetLocalInt(cart, "position") == 2)
        {
            AssignCommand(cart2, JumpToObject(Move3, TRUE));
            SetLocalInt(cart, "position", 3);
        }

        if(GetLocalInt(cart, "position") == 3)
        {
            AssignCommand(cart2, JumpToObject(Move4, TRUE));
            SetLocalInt(cart, "position", 4);
        }

        if(GetLocalInt(cart, "position") == 4)
        {
            AssignCommand(cart2, JumpToObject(Move5, TRUE));
            SetLocalInt(cart, "position", 5);
        }

        if(GetLocalInt(cart, "position") == 5)
        {
            AssignCommand(cart2, JumpToObject(Move6, TRUE));
            SetLocalInt(cart, "position", 6);
        }

        if(GetLocalInt(cart, "position") == 6)
        {
            AssignCommand(cart2, JumpToObject(Move7, TRUE));
            SetLocalInt(cart, "position", 7);
        }
        //empties cart
        if(GetLocalInt(cart, "position") == 7)
        {
            AssignCommand(oPC, ActionSpeakString("*Empties Cart.*"));
            SetLocalInt(cart, "cartRockLvl", 0);
            SetLocalInt(cart, "position", 8);
        }




    }

    if(cartRockLvl < 15)
    {

        if(GetLocalInt(cart, "position") == 8)
        {
            AssignCommand(cart2, JumpToObject(Move6, TRUE));
            SetLocalInt(cart, "position", 6);
        }
        if(GetLocalInt(cart, "position") == 6)
        {
            AssignCommand(cart2, JumpToObject(Move5, TRUE));
            SetLocalInt(cart, "position", 5);
        }

        if(GetLocalInt(cart, "position") == 5)
        {
            AssignCommand(cart2, JumpToObject(Move4, TRUE));
            SetLocalInt(cart, "position", 4);
        }

        if(GetLocalInt(cart, "position") == 4)
        {
            AssignCommand(cart2, JumpToObject(Move3, TRUE));
            SetLocalInt(cart, "position", 3);
        }

        if(GetLocalInt(cart, "position") == 3)
        {
            AssignCommand(cart2, JumpToObject(Move2, TRUE));
            SetLocalInt(cart, "position", 2);
        }

        if(GetLocalInt(cart, "position") == 2)
        {
            AssignCommand(cart2, JumpToObject(Move1, TRUE));
            SetLocalInt(cart, "position", 1);
        }
        //jump cart back to original state
        if(GetLocalInt(cart, "position") == 1)
        {
            AssignCommand(cart2, JumpToObject(OreCartStorage, TRUE));
            AssignCommand(cart, JumpToObject(OreCartInitial, TRUE));
            SetLocalInt(cart, "position", 0);
        }



    }


}
