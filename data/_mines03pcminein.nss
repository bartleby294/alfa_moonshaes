#include "nw_i0_2q4luskan"

void main()
{
//mining script

//This script is to be run after a rock is destroyed.
//It randomly chooses the contents of a broken rock and places it where the rock was.
//It will also keep track of the number of rocks a pc has broken for xp purposes

  object rock = OBJECT_SELF;
  object oPC = GetLastAttacker(rock);
  int rocksbashed = GetLocalInt(oPC, "rocksbashed");
  int rocksbashed2 = rocksbashed+1;


    //Sets local int PC that will be used to do XP later
  SetLocalInt(oPC, "rocksbashed", rocksbashed2);

  object mark1 = GetObjectByTag("Mines03RandRock1");
  object mark2 = GetObjectByTag("Mines03RandRock2");
  object mark3 = GetObjectByTag("Mines03RandRock3");
  object mark4 = GetObjectByTag("Mines03RandRock4");

             object mark5 = GetObjectByTag("Mines03RandRock5");
              object mark6 = GetObjectByTag("Mines03RandRock6");
               object mark7 = GetObjectByTag("Mines03RandRock7");
                object mark8 = GetObjectByTag("Mines03RandRock8");


  location rockwas = GetLocation(rock);
  location mark1Loc = GetLocation(mark1);
  location mark2Loc = GetLocation(mark2);
  location mark3Loc = GetLocation(mark3);
  location mark4Loc = GetLocation(mark4);

  location mark5Loc = GetLocation(mark5);
  location mark6Loc = GetLocation(mark6);
  location mark7Loc = GetLocation(mark7);
  location mark8Loc = GetLocation(mark8);

  effect hurtPC = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);

//determines if a pc gets hurt
int hurtchance = d20(1) + d20(1);

if(hurtchance == 40)
{
  if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_NONE,OBJECT_SELF))
  {
    AssignCommand(oPC, ActionSpeakString("*Dodges falling rock.*"));
  }
  else
  {
    AssignCommand(oPC, ActionSpeakString("*Fails to avoid a falling rock.*"));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, hurtPC, oPC, 0.0);
  }

}

  int randomnum = d100(1) + d100(1) + d100(1)+ d100(1)+ d100(1)+ d100(1)+ d100(1)+ d100(1)+ d100(1)+ d100(1);
  //+ d100(1)+d100(1)+ d100(1)+ d100(1)+ d100(1)+ d100(1)+ d100(1)+ d100(1)+ d100(1)+ d100(1);

// controls rocks 1-4
if(rockwas == mark1Loc || rockwas == mark2Loc || rockwas == mark3Loc || rockwas == mark4Loc)
 {
    // find out where rock was change the rockstate var to indicate that the marker is empty.
    if(rockwas == mark1Loc)
    {
        SetLocalInt(mark1, "rockstate", 0);

    }

    if(rockwas == mark2Loc)
    {
        SetLocalInt(mark2, "rockstate", 0);

    }

    if(rockwas == mark3Loc)
    {
        SetLocalInt(mark3, "rockstate", 0);

    }

    if(rockwas == mark4Loc)
    {
        SetLocalInt(mark4, "rockstate", 0);

    }


  //mithril 1 out of 2000
  if(randomnum == 1000)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "arockwithtraceam", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock", rockwas, FALSE);
    return;
  }
  //diamond out of 2000
  if(randomnum < 1000 && randomnum > 997)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "asmallroughdiamo", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock", rockwas, FALSE);
     return;

  }
  //gold 5 out of 2000
  if(randomnum < 998 && randomnum > 992 )
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "smallgoldennugge", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock", rockwas, FALSE);
    return;
  }
  //garnet 10 out of 2000
  if(randomnum < 993 && randomnum > 982)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "asmallpeiceofgar", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock", rockwas, FALSE);
    return;
  }
  //silver 20 out of 2000
  if(randomnum < 983 && randomnum > 962)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "arockwithastreak", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock", rockwas, FALSE);
    return;
  }
  //quartz 30 out of 2000
  if(randomnum < 963 && randomnum > 932)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "apeiceofquartz", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock", rockwas, FALSE);
    return;
  }

  //1932 out of 2000 worthless rock
  CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock", rockwas, FALSE);

 }



// for rocks 5 and 6

if(rockwas == mark5Loc || rockwas == mark6Loc)
 {
    // find out where rock was change the rockstate var to indicate that the marker is empty.
    if(rockwas == mark6Loc)
    {
        SetLocalInt(mark5, "rockstate", 0);

    }

    if(rockwas == mark6Loc)
    {
        SetLocalInt(mark6, "rockstate", 0);

    }


  //mithril 1 out of 2000
  if(randomnum == 1000)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "arockwithtraceam", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock2", rockwas, FALSE);
    return;
  }
  //diamond out of 2000
  if(randomnum < 1000 && randomnum > 997)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "asmallroughdiamo", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock2", rockwas, FALSE);
     return;

  }
  //gold 5 out of 2000
  if(randomnum < 998 && randomnum > 992 )
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "smallgoldennugge", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock2", rockwas, FALSE);
    return;
  }
  //garnet 10 out of 2000
  if(randomnum < 993 && randomnum > 982)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "asmallpeiceofgar", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock2", rockwas, FALSE);
    return;
  }
  //silver 20 out of 2000
  if(randomnum < 983 && randomnum > 962)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "arockwithastreak", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock2", rockwas, FALSE);
    return;
  }
  //quartz 30 out of 2000
  if(randomnum < 963 && randomnum > 1932)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "apeiceofquartz", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock2", rockwas, FALSE);
    return;
  }

  //1932 out of 2000 worthless rock
  CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock2", rockwas, FALSE);

 }




 // controls 7 8
if(rockwas == mark7Loc || rockwas == mark8Loc)
 {
    // find out where rock was change the rockstate var to indicate that the marker is empty.
    if(rockwas == mark7Loc)
    {
        SetLocalInt(mark7, "rockstate", 0);

    }

    if(rockwas == mark8Loc)
    {
        SetLocalInt(mark8, "rockstate", 0);

    }


  //mithril 1 out of 2000
  if(randomnum == 1000)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "arockwithtraceam", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock3", rockwas, FALSE);
    return;
  }
  //diamond out of 2000
  if(randomnum < 1000 && randomnum > 1997)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "asmallroughdiamo", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock3", rockwas, FALSE);
     return;

  }
  //gold 5 out of 2000
  if(randomnum < 998 && randomnum > 992 )
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "smallgoldennugge", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock3", rockwas, FALSE);
    return;
  }
  //garnet 10 out of 2000
  if(randomnum < 993 && randomnum > 982)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "asmallpeiceofgar", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock3", rockwas, FALSE);
    return;
  }
  //silver 20 out of 2000
  if(randomnum < 983 && randomnum > 962)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "arockwithastreak", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock3", rockwas, FALSE);
    return;
  }
  //quartz 30 out of 2000
  if(randomnum < 963 && randomnum > 932)
  {
    CreateObjectVoid(OBJECT_TYPE_ITEM , "apeiceofquartz", rockwas, FALSE);
    CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock3", rockwas, FALSE);
    return;
  }

  //1932 out of 2000 worthless rock
  CreateObjectVoid(OBJECT_TYPE_ITEM , "worthlessrock3", rockwas, FALSE);

 }


}
