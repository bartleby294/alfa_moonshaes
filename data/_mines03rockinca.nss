#include "nw_i0_2q4luskan"

void main()
{
    object oItem;
    string sItem = "WorthlessRock";
    string sItem2 = "worthlessrock2";
    string sItem3 = "worthlessrock3";
    object cart = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int cartRockLvl = GetLocalInt(cart, "cartRockLvl");
    int newcartRockLvl = cartRockLvl +1;

          object RockSpawn1 = GetObjectByTag("Mines03RandRock1");
           object RockSpawn2 = GetObjectByTag("Mines03RandRock2");
            object RockSpawn3 = GetObjectByTag("Mines03RandRock3");
             object RockSpawn4 = GetObjectByTag("Mines03RandRock4");

             object RockSpawn5 = GetObjectByTag("Mines03RandRock5");
              object RockSpawn6 = GetObjectByTag("Mines03RandRock6");
               object RockSpawn7 = GetObjectByTag("Mines03RandRock7");
                object RockSpawn8 = GetObjectByTag("Mines03RandRock8");

             location RockSpawn1Loc = GetLocation(RockSpawn1);
              location RockSpawn2Loc = GetLocation(RockSpawn2);
               location RockSpawn3Loc = GetLocation(RockSpawn3);
                location RockSpawn4Loc = GetLocation(RockSpawn4);

                 location RockSpawn5Loc = GetLocation(RockSpawn5);
                  location RockSpawn6Loc = GetLocation(RockSpawn6);
                   location RockSpawn7Loc = GetLocation(RockSpawn7);
                    location RockSpawn8Loc = GetLocation(RockSpawn8);

 int randnum = d4(1);
 int randnum2 = d2(1);


// look for first possible rock

        oItem = GetFirstItemInInventory(oPC);

        while (!(oItem == OBJECT_INVALID))
        {
            if (GetTag(oItem) == sItem)
            {
              ActionTakeItem(oItem, oPC);
              DestroyObject(oItem, 0.0);
              SetLocalInt(cart, "cartRockLvl", newcartRockLvl);




                        if(randnum == 1)
                        {
                         CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn1Loc, FALSE);
                        //SetLocalInt(RockSpawn1, "rockstate", 1);
                         return;
                         }

                         if(randnum == 2)
                         {
                             CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn2Loc, FALSE);
                             SetLocalInt(RockSpawn2, "rockstate", 1);
                             return;
                         }

                         if(randnum == 3)
                         {
                             CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn3Loc, FALSE);
                             //SetLocalInt(RockSpawn3, "rockstate", 1);
                             return;
                         }

                         if(randnum == 4)
                         {
                             CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn4Loc, FALSE);
                             //SetLocalInt(RockSpawn4, "rockstate", 1);
                             return;
                         }
             }




            oItem = GetNextItemInInventory(oPC);
         }

//look for second possible rock

    oItem = GetFirstItemInInventory(oPC);

        while (!(oItem == OBJECT_INVALID))
        {
            if (GetTag(oItem) == sItem2)
            {
              ActionTakeItem(oItem, oPC);
              DestroyObject(oItem, 0.0);
              SetLocalInt(cart, "cartRockLvl", newcartRockLvl);




                        if(randnum2 == 1)
                        {
                         CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn5Loc, FALSE);
                         //SetLocalInt(RockSpawn5, "rockstate", 1);
                         return;
                         }

                         if(randnum2 == 2)
                         {
                             CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn6Loc, FALSE);
                             //SetLocalInt(RockSpawn6, "rockstate", 1);
                             return;
                         }

            }




            oItem = GetNextItemInInventory(oPC);
         }

    //LOOKING FOR rock option 3

    oItem = GetFirstItemInInventory(oPC);

        while (!(oItem == OBJECT_INVALID))
        {
            if (GetTag(oItem) == sItem3)
            {
              ActionTakeItem(oItem, oPC);
              DestroyObject(oItem, 0.0);
              //SetLocalInt(cart, "cartRockLvl", newcartRockLvl);




                        if(randnum2 == 1)
                        {
                         CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn7Loc, FALSE);
                         //SetLocalInt(RockSpawn7, "rockstate", 1);
                         return;
                         }

                         if(randnum2 == 2)
                         {
                             CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn8Loc, FALSE);
                            // SetLocalInt(RockSpawn8, "rockstate", 1);
                             return;
                         }

            }




            oItem = GetNextItemInInventory(oPC);
         }


        AssignCommand(oPC, ActionSpeakString("*Looks around for a rock.*"));



}
