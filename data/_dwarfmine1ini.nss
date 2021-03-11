#include "nw_i0_henchman"
#include "nw_i0_2q4luskan"
#include "alfa_include"
#include "ms_xp_util"

void main()
{
   ALFA_OnAreaEnter();
  //rocks dwarves are mining
  object Rock1 = GetObjectByTag("DwarfMineRock1");
   object Rock2 = GetObjectByTag("DwarfMineRock2");
    object Rock3 = GetObjectByTag("DwarfMineRock3");
     object Rock4 = GetObjectByTag("DwarfMineRock4");
      object Rock5 = GetObjectByTag("DwarfMineRock5");
       object Rock6 = GetObjectByTag("DwarfMineRock6");
        object Rock7 = GetObjectByTag("DwarfMineRock7");
         object Rock8 = GetObjectByTag("DwarfMineRock8");
          object Rock9 = GetObjectByTag("DwarfMineRock9");

  //mineing dwarves
  object Dwarf1 = GetObjectByTag("Dwarfminer1");
   object Dwarf2 = GetObjectByTag("Dwarfminer2");
    object Dwarf3 = GetObjectByTag("Dwarfminer3");
     object Dwarf4 = GetObjectByTag("Dwarfminer4");
      object Dwarf5 = GetObjectByTag("Dwarfminer5");
       object Dwarf6 = GetObjectByTag("Dwarfminer6");
        object Dwarf7 = GetObjectByTag("Dwarfminer7");
         object Dwarf8 = GetObjectByTag("Dwarfminer8");
          object Dwarf9 = GetObjectByTag("Dwarfminer9");

          //mineable rocks
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

  //lower cpu usage
  SetAILevel(Dwarf1, AI_LEVEL_VERY_LOW);
   SetAILevel(Dwarf2, AI_LEVEL_VERY_LOW);
    SetAILevel(Dwarf3, AI_LEVEL_VERY_LOW);
     SetAILevel(Dwarf4, AI_LEVEL_VERY_LOW);
      SetAILevel(Dwarf5, AI_LEVEL_VERY_LOW);
       SetAILevel(Dwarf6, AI_LEVEL_VERY_LOW);
        SetAILevel(Dwarf7, AI_LEVEL_VERY_LOW);
         SetAILevel(Dwarf8, AI_LEVEL_VERY_LOW);
          SetAILevel(Dwarf9, AI_LEVEL_VERY_LOW);

  //start dwarves mining
  DelayCommand(0.2,AssignCommand(Dwarf1, DoPlaceableObjectAction(Rock1, PLACEABLE_ACTION_BASH)));
   DelayCommand(1.0,AssignCommand(Dwarf2, DoPlaceableObjectAction(Rock2, PLACEABLE_ACTION_BASH)));
    DelayCommand(1.1,AssignCommand(Dwarf3, DoPlaceableObjectAction(Rock3, PLACEABLE_ACTION_BASH)));
     DelayCommand(2.2,AssignCommand(Dwarf4, DoPlaceableObjectAction(Rock4, PLACEABLE_ACTION_BASH)));
      DelayCommand(0.4,AssignCommand(Dwarf5, DoPlaceableObjectAction(Rock5, PLACEABLE_ACTION_BASH)));
       DelayCommand(0.6,AssignCommand(Dwarf6, DoPlaceableObjectAction(Rock6, PLACEABLE_ACTION_BASH)));
        DelayCommand(0.2,AssignCommand(Dwarf7, DoPlaceableObjectAction(Rock7, PLACEABLE_ACTION_BASH)));
         DelayCommand(0.1,AssignCommand(Dwarf8, DoPlaceableObjectAction(Rock8, PLACEABLE_ACTION_BASH)));
          DelayCommand(2.0,AssignCommand(Dwarf9, DoPlaceableObjectAction(Rock9, PLACEABLE_ACTION_BASH)));


      //makes sure at least one mineable rock is spawned
      if( GetLocalInt(RockSpawn1, "rockstate") == 0 && GetLocalInt(RockSpawn2, "rockstate") == 0 && GetLocalInt(RockSpawn3, "rockstate") == 0 && GetLocalInt(RockSpawn4, "rockstate") == 0)
      {
         int randnum = d4(1);

            if(randnum == 1)
            {
                CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn1Loc, FALSE);
                SetLocalInt(RockSpawn1, "rockstate", 1);
            }

            if(randnum == 2)
            {
              CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn2Loc, FALSE);
              SetLocalInt(RockSpawn2, "rockstate", 1);
            }

            if(randnum == 3)
            {
              CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn3Loc, FALSE);
              SetLocalInt(RockSpawn3, "rockstate", 1);
            }

            if(randnum == 4)
            {
              CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn4Loc, FALSE);
              SetLocalInt(RockSpawn4, "rockstate", 1);
            }
      }

      if( GetLocalInt(RockSpawn5, "rockstate") == 0 && GetLocalInt(RockSpawn6, "rockstate") == 0)
      {
        int randnum = d2(1);

            if(randnum == 1)
            {
                CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn5Loc, FALSE);
                SetLocalInt(RockSpawn5, "rockstate", 1);
            }

            if(randnum == 2)
            {
              CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn6Loc, FALSE);
              SetLocalInt(RockSpawn6, "rockstate", 1);
            }
      }

      if( GetLocalInt(RockSpawn7, "rockstate") == 0 && GetLocalInt(RockSpawn8, "rockstate") == 0)
      {
        int randnum = d2(1);

            if(randnum == 1)
            {
                CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn7Loc, FALSE);
                SetLocalInt(RockSpawn7, "rockstate", 1);
            }

            if(randnum == 2)
            {
              CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "alargerock", RockSpawn8Loc, FALSE);
              SetLocalInt(RockSpawn8, "rockstate", 1);
            }
      }
}
