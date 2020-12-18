#include "x0_i0_position"

void main()
{
  object Dwarf1 = GetObjectByTag("DwarfAndOrc01");
   object Dwarf2 = GetObjectByTag("DwarfAndOrc02");
    object Dwarf3 = GetObjectByTag("DwarfAndOrc03");

     object Dwarf4 = GetObjectByTag("DwarfAndOrc04");
      object Dwarf5 = GetObjectByTag("DwarfAndOrc05");
       object Dwarf6 = GetObjectByTag("DwarfAndOrc06");
        object Dwarf7 = GetObjectByTag("DwarfAndOrc07");
         object Dwarf8 = GetObjectByTag("DwarfAndOrc08");

          object Dwarf9 = GetObjectByTag("DwarfAndOrc09");
           object Dwarf10 = GetObjectByTag("DwarfAndOrc10");
            object Dwarf11 = GetObjectByTag("DwarfAndOrc11");
             object Dwarf12 = GetObjectByTag("DwarfAndOrc12");

              object DwarfLead = GetObjectByTag("LeadDwarfAndOrc");
              object DwarfSecond = GetObjectByTag("DwarfandOrcSecond");
              object DwarfBarTender = GetObjectByTag("DwarvenMineBartender01");

              object VarStore1 = GetObjectByTag("Dwarven_Mines02_var_store1");
              object oArea = GetArea(VarStore1);

object LeadMove = GetObjectByTag("DnOLeadMove");
object SecondMove = GetObjectByTag("DnOSecondMove");
object LeadINI = GetObjectByTag("DnOLeadIniPos");
object SecondINI = GetObjectByTag("DnOSecondIniPos");

object MainFace = GetObjectByTag("Dwarfsongmainface");
object Bob = GetObjectByTag("bob");

object stool1 = GetObjectByTag("DwarfMineStool01");
object stool2 = GetObjectByTag("DwarfMineStool02");
object stool3 = GetObjectByTag("DwarfMineStool03");
object stool4 = GetObjectByTag("DwarfMineStool04");
object stool5 = GetObjectByTag("DwarfMineStool05");
object stool6 = GetObjectByTag("DwarfMineStool06");
object stool7 = GetObjectByTag("DwarfMineStool07");
object stool8 = GetObjectByTag("DwarfMineStool08");
object stool9 = GetObjectByTag("DwarfMineStool09");
object stool10 = GetObjectByTag("DwarfMineStool10");
object stool11 = GetObjectByTag("DwarfMineStool11");
object stool12 = GetObjectByTag("DwarfMineStool12");

object lyre = GetObjectByTag("lyre02");

  int DwarfSongState = GetLocalInt(VarStore1, "SongState");


if(DwarfSongState != 1)
{

   int DayTrack = MusicBackgroundGetDayTrack(oArea);
    int NightTrack = MusicBackgroundGetNightTrack(oArea);
//start Dwarf and Orc Sequence

//Dwarf lead gets up and rouses the croud
SetLocalInt(VarStore1, "SongState", 1);
TurnToFaceObject( LeadMove, DwarfLead);
DelayCommand(0.2, AssignCommand(DwarfLead, ActionMoveToObject(LeadMove, FALSE, 0.0)));
DelayCommand(1.0, AssignCommand(DwarfLead, ActionSpeakString("We gonna let him get away with talk like that lads?")));

//dwarf 3 calls for "Dwarf and Orc"
DelayCommand(3.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(3.1, AssignCommand(Dwarf3, ActionSpeakString("Dwarf and Orc!") ));

//call is seconded and thrided
DelayCommand(4.0, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(4.2, TurnToFaceObject(LeadMove, Dwarf5));
DelayCommand(4.4, AssignCommand(Dwarf5, ActionSpeakString("Here Here!") ));

DelayCommand(5.5, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(5.6, TurnToFaceObject(stool3, Dwarf1));
DelayCommand(5.8, AssignCommand(Dwarf1, ActionSpeakString("Here Here! *pounds table") ));
DelayCommand(5.9, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 2.0) ));


//Second Lead Sarts in
DelayCommand(6.3, TurnToFaceObject( SecondMove, DwarfSecond));
DelayCommand(6.5, AssignCommand(DwarfSecond, ActionMoveToObject(SecondMove, FALSE, 0.0)));
DelayCommand(6.6, AssignCommand(DwarfSecond, ActionSpeakString("Here we go lads!")));

//dwarves start to sing
    if(GetIsDay())
    {
        SetLocalInt(VarStore1, "Siningon", 1);
        DelayCommand(7.0, MusicBackgroundChangeNight(oArea, DayTrack));
        AssignCommand(Bob, ActionSpeakString("Music Started its day"));
        DelayCommand(7.0, MusicBackgroundChangeDay(oArea, NightTrack));

        DelayCommand(251.0, SetLocalInt(VarStore1, "Siningon", 0));
        DelayCommand(251.0, MusicBackgroundChangeDay(oArea, DayTrack));
        DelayCommand(251.0, MusicBackgroundChangeNight(oArea, NightTrack));

    }

        if(GetIsDawn())
    {
        SetLocalInt(VarStore1, "Siningon", 1);
        DelayCommand(7.0, MusicBackgroundChangeNight(oArea, DayTrack));
        AssignCommand(Bob, ActionSpeakString("Music Started its dawn"));
        DelayCommand(7.0, MusicBackgroundChangeDay(oArea, NightTrack));

        DelayCommand(251.0, SetLocalInt(VarStore1, "Siningon", 0));
        DelayCommand(251.0, MusicBackgroundChangeDay(oArea, DayTrack));
        DelayCommand(251.0, MusicBackgroundChangeNight(oArea, NightTrack));

    }

    if(GetIsNight())
    {
        SetLocalInt(VarStore1, "Siningon", 1);
        DelayCommand(7.0, MusicBackgroundChangeNight(oArea, DayTrack));
        AssignCommand(Bob, ActionSpeakString("Music Started its Night"));
        DelayCommand(7.0, MusicBackgroundChangeDay(oArea, NightTrack));

        DelayCommand(251.0, SetLocalInt(VarStore1, "Siningon", 0));
        DelayCommand(251.0, MusicBackgroundChangeDay(oArea, DayTrack));
        DelayCommand(251.0, MusicBackgroundChangeNight(oArea, NightTrack));
    }

        if(GetIsDusk())
    {
        SetLocalInt(VarStore1, "Siningon", 1);
        DelayCommand(7.0, MusicBackgroundChangeNight(oArea, DayTrack));
        AssignCommand(Bob, ActionSpeakString("Music Started its dusk"));
        DelayCommand(7.0, MusicBackgroundChangeDay(oArea, NightTrack));

        DelayCommand(251.0, SetLocalInt(VarStore1, "Siningon", 0));
        DelayCommand(251.0, MusicBackgroundChangeDay(oArea, DayTrack));
        DelayCommand(251.0, MusicBackgroundChangeNight(oArea, NightTrack));
    }



//Dwarf Lead's line
DelayCommand(8.0, AssignCommand(DwarfLead, ActionSpeakString("Its time for Dwarf and Orc!")));
DelayCommand(8.1, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 2.0) ));

//Dwarf Seconds's line more dwarves get up to sing
DelayCommand(12.0, AssignCommand(DwarfSecond, ActionSpeakString("You all know this!")));
DelayCommand(12.1, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 2.0) ));

//more dwarves get up to sing
DelayCommand(14.8, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(14.9, TurnToFaceObject( MainFace, Dwarf6));
DelayCommand(15.0, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 6.0) ));

DelayCommand(15.2, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(15.3, TurnToFaceObject( MainFace, Dwarf7));
DelayCommand(15.4, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 7.0) ));

DelayCommand(16.0, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(16.1, TurnToFaceObject( MainFace, Dwarf2));
DelayCommand(16.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 2.0) ));

DelayCommand(16.1, TurnToFaceObject(SecondINI, Dwarf3));
DelayCommand(16.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 4.0) ));

// Dwarf 8 "Oh gods its that song"
DelayCommand(24.8, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(24.9, TurnToFaceObject(LeadINI , Dwarf8));
DelayCommand(25.0, AssignCommand(Dwarf8, ActionSpeakString("Oh gods its that song")));
DelayCommand(25.7, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(25.9, AssignCommand(Dwarf6, ActionSpeakString("*Takes out Lyre, starts to play.*")));
DelayCommand(26.0, AssignCommand(Dwarf6, ActionEquipItem(lyre, INVENTORY_SLOT_RIGHTHAND)));


DelayCommand(27.8, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(28.1, AssignCommand(Dwarf2, ActionSpeakString("*Pounds on table*")));

DelayCommand(28.8, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(29.0, AssignCommand(Dwarf1, ActionSpeakString("*Claps a rythem*")));


// The song starts
DelayCommand(43.2, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 20.0) ));
DelayCommand(30.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 23.0) ));
DelayCommand(41.0, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 25.0) ));
DelayCommand(46.2, AssignCommand(Dwarf5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 27.0) ));
DelayCommand(30.2, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));
DelayCommand(47.2, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 24.0) ));
DelayCommand(25.2, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 30.0) ));

//first verse
DelayCommand(45.0, AssignCommand(DwarfLead, ActionSpeakString("Orc was crouched on the cavern floor.  And kept an eye on the oaken door.  For many a night he'd watched it close.  To see who might appear.")));
DelayCommand(45.0, AssignCommand(DwarfSecond, ActionSpeakString("Orc was crouched on the cavern floor.  And kept an eye on the oaken door.  For many a night he'd watched it close.  To see who might appear.")));

DelayCommand(45.1, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));
DelayCommand(45.1, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));

DelayCommand(53.8, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(54.0, AssignCommand(Dwarf1, ActionSpeakString("Oh dear! See him leer? He's clutching a mighty spear!")));
DelayCommand(54.1, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(53.8, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(54.1, AssignCommand(Dwarf2, ActionSpeakString("Oh dear! See him leer? He's clutching a mighty spear!")));
DelayCommand(54.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(53.8, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(54.1, AssignCommand(Dwarf3, ActionSpeakString("Oh dear! See him leer? He's clutching a mighty spear!")));
DelayCommand(54.2, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(53.8, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(54.0, AssignCommand(Dwarf5, ActionSpeakString("Oh dear! See him leer? He's clutching a mighty spear!")));
DelayCommand(54.2, AssignCommand(Dwarf5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(53.9, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(54.3, AssignCommand(Dwarf6, ActionSpeakString("Oh dear! See him leer? He's clutching a mighty spear!")));
DelayCommand(54.4, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(53.9, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(54.3, AssignCommand(Dwarf7, ActionSpeakString("Oh dear! See him leer? He's clutching a mighty spear!")));
DelayCommand(54.4, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(53.9, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(54.0, AssignCommand(Dwarf8, ActionSpeakString("Oh dear! See him leer? He's clutching a mighty spear!")));
DelayCommand(54.2, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

//bartender anoyed
DelayCommand(55.9, AssignCommand(DwarfBarTender, ClearAllActions() ));
DelayCommand(56.0, AssignCommand(DwarfBarTender, ActionSpeakString("Bah! Theyre singen again ... ")));
DelayCommand(56.2, AssignCommand(DwarfBarTender, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 2.0) ));


//second verse

DelayCommand(62.2, AssignCommand(DwarfLead, ClearAllActions() ));
DelayCommand(62.2, AssignCommand(DwarfSecond, ClearAllActions() ));

DelayCommand(62.3, AssignCommand(DwarfLead, ActionSpeakString("Orc was guarding a mighty stash.  And any who'd come he'd have to slash.  For stacked on high in the cavern behind.  Were kegs of goblin beer!")));
DelayCommand(62.3, AssignCommand(DwarfSecond, ActionSpeakString("Orc was guarding a mighty stash.  And any who'd come he'd have to slash.  For stacked on high in the cavern behind.  Were kegs of goblin beer!")));

DelayCommand(62.4, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));
DelayCommand(62.4, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));

DelayCommand(72.0, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(72.1, AssignCommand(Dwarf1, ActionSpeakString("Oh dear! To his rear The Goblin King kept all his beer! ")));
DelayCommand(72.3, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(72.0, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(72.1, AssignCommand(Dwarf2, ActionSpeakString("Oh dear! To his rear The Goblin King kept all his beer! ")));
DelayCommand(72.3, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(72.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(72.1, AssignCommand(Dwarf3, ActionSpeakString("Oh dear! To his rear The Goblin King kept all his beer! ")));
DelayCommand(72.3, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(72.0, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(72.1, AssignCommand(Dwarf5, ActionSpeakString("Oh dear! To his rear The Goblin King kept all his beer! ")));
DelayCommand(72.3, AssignCommand(Dwarf5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(72.0, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(72.1, AssignCommand(Dwarf6, ActionSpeakString("Oh dear! To his rear The Goblin King kept all his beer! ")));
DelayCommand(72.3, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(72.0, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(72.1, AssignCommand(Dwarf7, ActionSpeakString("Oh dear! To his rear The Goblin King kept all his beer! ")));
DelayCommand(72.3, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(72.0, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(72.1, AssignCommand(Dwarf8, ActionSpeakString("Oh dear! To his rear The Goblin King kept all his beer! ")));
DelayCommand(72.3, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

//third verse
DelayCommand(79.0, AssignCommand(DwarfLead, ClearAllActions() ));
DelayCommand(79.0, AssignCommand(DwarfSecond, ClearAllActions() ));

DelayCommand(79.1, AssignCommand(DwarfLead, ActionSpeakString("Dwarf was thirsty as he crawled To the oaken door on the cliff face wall.  His nose had caught the scent of ale.  Oh what a sweet sensation. ")));
DelayCommand(79.1, AssignCommand(DwarfSecond, ActionSpeakString("Dwarf was thirsty as he crawled To the oaken door on the cliff face wall.  His nose had caught the scent of ale.  Oh what a sweet sensation. ")));

DelayCommand(79.2, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));
DelayCommand(79.2, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));



DelayCommand(89.0, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(89.1, AssignCommand(Dwarf1, ActionSpeakString("Elation! Fixation! He's found the Goblin's libation. ")));
DelayCommand(89.2, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(89.0, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(89.1, AssignCommand(Dwarf2, ActionSpeakString("Elation! Fixation! He's found the Goblin's libation. ")));
DelayCommand(89.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(89.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(89.1, AssignCommand(Dwarf3, ActionSpeakString("Elation! Fixation! He's found the Goblin's libation. ")));
DelayCommand(89.2, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(89.0, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(89.1, AssignCommand(Dwarf5, ActionSpeakString("Elation! Fixation! He's found the Goblin's libation. ")));
DelayCommand(89.2, AssignCommand(Dwarf5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(89.0, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(89.1, AssignCommand(Dwarf6, ActionSpeakString("Elation! Fixation! He's found the Goblin's libation. ")));
DelayCommand(89.2, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(89.0, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(89.1, AssignCommand(Dwarf7, ActionSpeakString("Elation! Fixation! He's found the Goblin's libation. ")));
DelayCommand(89.2, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(89.0, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(89.1, AssignCommand(Dwarf8, ActionSpeakString("Elation! Fixation! He's found the Goblin's libation. ")));
DelayCommand(89.2, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

// everybody
DelayCommand(95.0, AssignCommand(DwarfSecond, ClearAllActions() ));
DelayCommand(95.1, AssignCommand(DwarfSecond, ActionSpeakString("Alright everybody!")));
DelayCommand(95.2, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 20.0) ));

//refrain

DelayCommand(96.0, AssignCommand(DwarfLead, ClearAllActions() ));
DelayCommand(96.0, AssignCommand(DwarfSecond, ClearAllActions() ));

DelayCommand(96.1, AssignCommand(DwarfLead, ActionSpeakString("Dwarf and Orc, A battle not worth telling . Spear or cork With which should ye be assailing . Just pop a dwarf on the head with a cork  And see if his axe don't sing!  Just take that axe upon yer skull  And see if yer head don't ring!")));
DelayCommand(96.1, AssignCommand(DwarfSecond, ActionSpeakString("Dwarf and Orc, A battle not worth telling . Spear or cork With which should ye be assailing . Just pop a dwarf on the head with a cork  And see if his axe don't sing!  Just take that axe upon yer skull  And see if yer head don't ring!")));

DelayCommand(96.2, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));
DelayCommand(96.2, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));



DelayCommand(96.0, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(96.1, AssignCommand(Dwarf1, ActionSpeakString("Dwarf and Orc, A battle not worth telling . Spear or cork With which should ye be assailing . Just pop a dwarf on the head with a cork  And see if his axe don't sing!  Just take that axe upon yer skull  And see if yer head don't ring!")));
DelayCommand(96.2, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 30.0) ));

DelayCommand(96.0, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(96.1, AssignCommand(Dwarf2, ActionSpeakString("Dwarf and Orc, A battle not worth telling . Spear or cork With which should ye be assailing . Just pop a dwarf on the head with a cork  And see if his axe don't sing!  Just take that axe upon yer skull  And see if yer head don't ring!")));
DelayCommand(96.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 30.0) ));

DelayCommand(96.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(96.1, AssignCommand(Dwarf3, ActionSpeakString("Dwarf and Orc, A battle not worth telling . Spear or cork With which should ye be assailing . Just pop a dwarf on the head with a cork  And see if his axe don't sing!  Just take that axe upon yer skull  And see if yer head don't ring!")));
DelayCommand(96.2, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 30.0) ));

DelayCommand(96.0, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(96.1, AssignCommand(Dwarf5, ActionSpeakString("Dwarf and Orc, A battle not worth telling . Spear or cork With which should ye be assailing . Just pop a dwarf on the head with a cork  And see if his axe don't sing!  Just take that axe upon yer skull  And see if yer head don't ring!")));
DelayCommand(96.2, AssignCommand(Dwarf5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 30.0) ));

DelayCommand(96.0, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(96.1, AssignCommand(Dwarf6, ActionSpeakString("Dwarf and Orc, A battle not worth telling . Spear or cork With which should ye be assailing . Just pop a dwarf on the head with a cork  And see if his axe don't sing!  Just take that axe upon yer skull  And see if yer head don't ring!")));
DelayCommand(96.2, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 30.0) ));

DelayCommand(96.0, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(96.1, AssignCommand(Dwarf7, ActionSpeakString("Dwarf and Orc, A battle not worth telling . Spear or cork With which should ye be assailing . Just pop a dwarf on the head with a cork  And see if his axe don't sing!  Just take that axe upon yer skull  And see if yer head don't ring!")));
DelayCommand(96.2, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 30.0) ));

DelayCommand(96.0, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(96.1, AssignCommand(Dwarf8, ActionSpeakString("Dwarf and Orc, A battle not worth telling . Spear or cork With which should ye be assailing . Just pop a dwarf on the head with a cork  And see if his axe don't sing!  Just take that axe upon yer skull  And see if yer head don't ring!")));
DelayCommand(96.2, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 30.0) ));

//banter between verses "Dwalin"
DelayCommand(118.0, AssignCommand(DwarfLead, ClearAllActions() ));
DelayCommand(118.1, AssignCommand(DwarfLead, ActionSpeakString("Now we need somebody for the next verse.")));

DelayCommand(119.0, AssignCommand(DwarfSecond, ClearAllActions() ));
DelayCommand(120.1, AssignCommand(DwarfSecond, ActionSpeakString("Dwalin there stand up!")));

DelayCommand(121.0, AssignCommand(Dwarf4, ClearAllActions() ));

DelayCommand(129.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(129.1, AssignCommand(Dwarf3, ActionSpeakString("SHHH....") ));

DelayCommand(130.0, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(130.3, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(130.4, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(130.2, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(130.5, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(130.7, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(130.9, AssignCommand(Dwarf8, ClearAllActions() ));

DelayCommand(136.9, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(137.0, TurnToFaceObject(Dwarf4, Dwarf7));
DelayCommand(137.1, AssignCommand(Dwarf7, ActionSpeakString("Make us proud!")));

DelayCommand(139.1, AssignCommand(Dwarf4, ActionSpeakString("With his axe he smote the place But no surprise on the Goblin's face Whilst guarding he'd just helped himself  And drank all the Goblin King's brew ")));
DelayCommand(139.2, AssignCommand(Dwarf4, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

//corus
DelayCommand(148.0, AssignCommand(DwarfLead, ClearAllActions() ));
DelayCommand(148.0, AssignCommand(DwarfSecond, ClearAllActions() ));

DelayCommand(148.1, AssignCommand(DwarfLead, ActionSpeakString("Oh boo! What to do? He's got himself into a stew! ")));
DelayCommand(148.1, AssignCommand(DwarfSecond, ActionSpeakString("Oh boo! What to do? He's got himself into a stew! ")));

DelayCommand(148.2, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));
DelayCommand(148.2, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));



DelayCommand(148.0, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(148.1, AssignCommand(Dwarf1, ActionSpeakString("Oh boo! What to do? He's got himself into a stew! ")));
DelayCommand(148.2, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(148.0, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(148.1, AssignCommand(Dwarf2, ActionSpeakString("Oh boo! What to do? He's got himself into a stew! ")));
DelayCommand(148.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(148.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(148.1, AssignCommand(Dwarf3, ActionSpeakString("Oh boo! What to do? He's got himself into a stew! ")));
DelayCommand(148.2, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(148.0, AssignCommand(Dwarf4, ClearAllActions() ));
DelayCommand(148.1, AssignCommand(Dwarf4, ActionSpeakString("Oh boo! What to do? He's got himself into a stew! ")));
DelayCommand(148.2, AssignCommand(Dwarf4, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(148.0, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(148.1, AssignCommand(Dwarf5, ActionSpeakString("Oh boo! What to do? He's got himself into a stew! ")));
DelayCommand(148.2, AssignCommand(Dwarf5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(148.0, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(148.1, AssignCommand(Dwarf6, ActionSpeakString("Oh boo! What to do? He's got himself into a stew! ")));
DelayCommand(148.2, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(148.0, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(148.1, AssignCommand(Dwarf7, ActionSpeakString("Oh boo! What to do? He's got himself into a stew! ")));
DelayCommand(148.2, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(148.0, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(148.1, AssignCommand(Dwarf8, ActionSpeakString("Oh boo! What to do? He's got himself into a stew! ")));
DelayCommand(148.2, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

//Fith verse

DelayCommand(157.0, AssignCommand(DwarfLead, ClearAllActions() ));
DelayCommand(157.0, AssignCommand(DwarfSecond, ClearAllActions() ));

DelayCommand(157.1, AssignCommand(DwarfLead, ActionSpeakString("The door came crashing in on Orc Who'd traded his spear for a beer to uncork His drunken smile was soon replaced As Dwarven axe did cleave that face!")));
DelayCommand(157.1, AssignCommand(DwarfSecond, ActionSpeakString("The door came crashing in on Orc Who'd traded his spear for a beer to uncork His drunken smile was soon replaced As Dwarven axe did cleave that face!")));

DelayCommand(157.2, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));
DelayCommand(157.2, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));



DelayCommand(165.0, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(165.1, AssignCommand(Dwarf1, ActionSpeakString("What a case - of disgrace.  The dwarf was king of the place! ")));
DelayCommand(165.2, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(165.0, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(165.1, AssignCommand(Dwarf2, ActionSpeakString("What a case - of disgrace.  The dwarf was king of the place! ")));
DelayCommand(165.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(165.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(165.1, AssignCommand(Dwarf3, ActionSpeakString("What a case - of disgrace.  The dwarf was king of the place! ")));
DelayCommand(165.2, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(165.0, AssignCommand(Dwarf4, ClearAllActions() ));
DelayCommand(165.1, AssignCommand(Dwarf4, ActionSpeakString("What a case - of disgrace.  The dwarf was king of the place! ")));
DelayCommand(165.2, AssignCommand(Dwarf4, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(165.0, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(165.1, AssignCommand(Dwarf5, ActionSpeakString("What a case - of disgrace.  The dwarf was king of the place! ")));
DelayCommand(165.2, AssignCommand(Dwarf5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(165.0, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(165.1, AssignCommand(Dwarf6, ActionSpeakString("What a case - of disgrace.  The dwarf was king of the place! ")));
DelayCommand(165.2, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(165.0, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(165.1, AssignCommand(Dwarf7, ActionSpeakString("What a case - of disgrace.  The dwarf was king of the place! ")));
DelayCommand(165.2, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(165.0, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(165.1, AssignCommand(Dwarf8, ActionSpeakString("What a case - of disgrace.  The dwarf was king of the place! ")));
DelayCommand(165.2, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

//sixth verse

DelayCommand(173.0, AssignCommand(DwarfLead, ClearAllActions() ));
DelayCommand(173.0, AssignCommand(DwarfSecond, ClearAllActions() ));

DelayCommand(173.1, AssignCommand(DwarfLead, ActionSpeakString("So in the dark he felt around.  But nothing intact was to be found.  The bottles smashed, the kegs all dry.  The Orc had drunk the lot")));
DelayCommand(173.1, AssignCommand(DwarfSecond, ActionSpeakString("So in the dark he felt around.  But nothing intact was to be found.  The bottles smashed, the kegs all dry.  The Orc had drunk the lot")));

DelayCommand(173.2, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));
DelayCommand(173.2, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));



DelayCommand(182.0, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(182.1, AssignCommand(Dwarf1, ActionSpeakString("Found it not! Such a sot!  And deserving of what he had got! ")));
DelayCommand(182.2, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(182.0, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(182.1, AssignCommand(Dwarf2, ActionSpeakString("Found it not! Such a sot!  And deserving of what he had got! ")));
DelayCommand(182.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(182.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(182.1, AssignCommand(Dwarf3, ActionSpeakString("Found it not! Such a sot!  And deserving of what he had got! ")));
DelayCommand(182.2, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(182.0, AssignCommand(Dwarf4, ClearAllActions() ));
DelayCommand(182.1, AssignCommand(Dwarf4, ActionSpeakString("Found it not! Such a sot!  And deserving of what he had got! ")));
DelayCommand(182.2, AssignCommand(Dwarf4, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(182.0, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(182.1, AssignCommand(Dwarf5, ActionSpeakString("Found it not! Such a sot!  And deserving of what he had got! ")));
DelayCommand(182.2, AssignCommand(Dwarf5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(182.0, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(182.1, AssignCommand(Dwarf6, ActionSpeakString("Found it not! Such a sot!  And deserving of what he had got! ")));
DelayCommand(182.2, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(182.0, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(182.1, AssignCommand(Dwarf7, ActionSpeakString("Found it not! Such a sot!  And deserving of what he had got! ")));
DelayCommand(182.2, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(182.0, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(182.1, AssignCommand(Dwarf8, ActionSpeakString("Found it not! Such a sot!  And deserving of what he had got! ")));
DelayCommand(182.2, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

// refrain

DelayCommand(190.0, AssignCommand(DwarfLead, ClearAllActions() ));
DelayCommand(190.0, AssignCommand(DwarfSecond, ClearAllActions() ));

DelayCommand(190.1, AssignCommand(DwarfLead, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(190.1, AssignCommand(DwarfSecond, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));

DelayCommand(190.2, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));
DelayCommand(190.2, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));

DelayCommand(190.0, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(190.1, AssignCommand(Dwarf1, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(190.2, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(190.0, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(190.1, AssignCommand(Dwarf2, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(190.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(190.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(190.1, AssignCommand(Dwarf3, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(190.2, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(190.0, AssignCommand(Dwarf4, ClearAllActions() ));
DelayCommand(190.1, AssignCommand(Dwarf4, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(190.2, AssignCommand(Dwarf4, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(190.0, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(190.1, AssignCommand(Dwarf5, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(190.2, AssignCommand(Dwarf5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(190.0, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(190.1, AssignCommand(Dwarf6, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(190.2, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(190.0, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(190.1, AssignCommand(Dwarf7, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(190.2, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(190.0, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(190.1, AssignCommand(Dwarf8, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(190.2, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

// refrain last

DelayCommand(209.0, AssignCommand(DwarfLead, ClearAllActions() ));
DelayCommand(209.0, AssignCommand(DwarfSecond, ClearAllActions() ));

DelayCommand(209.1, AssignCommand(DwarfLead, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(209.1, AssignCommand(DwarfSecond, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));

DelayCommand(209.2, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));
DelayCommand(209.2, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0) ));

DelayCommand(209.0, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(209.1, AssignCommand(Dwarf1, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(209.2, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(209.0, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(209.1, AssignCommand(Dwarf2, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(209.2, AssignCommand(Dwarf2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(209.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(209.1, AssignCommand(Dwarf3, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(209.2, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(209.0, AssignCommand(Dwarf4, ClearAllActions() ));
DelayCommand(209.1, AssignCommand(Dwarf4, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(209.2, AssignCommand(Dwarf4, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(209.0, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(209.1, AssignCommand(Dwarf5, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(209.2, AssignCommand(Dwarf5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(209.0, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(209.1, AssignCommand(Dwarf6, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(209.2, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

DelayCommand(209.0, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(209.1, AssignCommand(Dwarf7, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(209.2, AssignCommand(Dwarf7, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(209.0, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(209.1, AssignCommand(Dwarf8, ActionSpeakString("Dwarf and Orc. A battle not worth telling . Spear or cork. With which should ye be assailing. Just pop a dwarf on the head with a cork And see if his axe don't sing! Just take that axe upon yer skull And see if yer head don't ring!")));
DelayCommand(209.2, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0) ));

// aftermath .. chears and such

DelayCommand(231.0, AssignCommand(Dwarf8, ClearAllActions() ));
DelayCommand(231.1, AssignCommand(Dwarf8, ActionSpeakString("HA HA!")));
DelayCommand(231.2, AssignCommand(Dwarf8, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(232.0, AssignCommand(Dwarf7, ClearAllActions() ));
DelayCommand(232.1, AssignCommand(Dwarf7, ActionSpeakString("*Pounds on table*")));


DelayCommand(232.0, AssignCommand(Dwarf6, ClearAllActions() ));
DelayCommand(232.1, AssignCommand(Dwarf6, ActionSpeakString("*Claps*")));
DelayCommand(232.2, AssignCommand(Dwarf6, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(232.0, AssignCommand(Dwarf5, ClearAllActions() ));
DelayCommand(232.1, AssignCommand(Dwarf5, ActionSpeakString("*Wistles*")));

DelayCommand(233.0, AssignCommand(Dwarf4, ClearAllActions() ));
DelayCommand(233.1, AssignCommand(Dwarf4, ActionSpeakString("*Claps*")));
DelayCommand(233.2, AssignCommand(Dwarf4, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(232.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(232.1, AssignCommand(Dwarf3, ActionSpeakString("*Claps*")));
DelayCommand(232.2, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(232.4, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(232.5, AssignCommand(Dwarf3, ActionSpeakString("*Claps*")));
DelayCommand(232.6, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(233.0, AssignCommand(Dwarf2, ClearAllActions() ));
DelayCommand(233.0, AssignCommand(Dwarf2, ActionSpeakString("*Wistles*")));

DelayCommand(232.0, AssignCommand(Dwarf1, ClearAllActions() ));
DelayCommand(232.1, AssignCommand(Dwarf1, ActionSpeakString("*Pounds on table*")));
DelayCommand(232.2, AssignCommand(Dwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0) ));

DelayCommand(231.0, AssignCommand(DwarfLead, ClearAllActions() ));
DelayCommand(231.0, AssignCommand(DwarfSecond, ClearAllActions() ));

DelayCommand(231.1, AssignCommand(DwarfLead, ActionSpeakString("*Claps")));
DelayCommand(231.1, AssignCommand(DwarfSecond, ActionSpeakString("*Claps")));

DelayCommand(231.2, AssignCommand(DwarfLead, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 20.0) ));
DelayCommand(231.2, AssignCommand(DwarfSecond, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 20.0) ));

DelayCommand(249.0, AssignCommand(Dwarf3, ClearAllActions() ));
DelayCommand(249.1, AssignCommand(Dwarf3, ActionSpeakString("Ill buy the next round!")));
DelayCommand(249.2, AssignCommand(Dwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 1.0) ));

DelayCommand(249.2, AssignCommand(Dwarf6, ActionUnequipItem(lyre)));

//reset the world

        DelayCommand(251.1, AssignCommand(Dwarf1, ClearAllActions()) );
        DelayCommand(251.4, AssignCommand(Dwarf2, ClearAllActions()) );
        DelayCommand(251.4, AssignCommand(Dwarf3, ClearAllActions()) );
        DelayCommand(251.1, AssignCommand(Dwarf4, ClearAllActions()) );
        DelayCommand(251.6, AssignCommand(Dwarf5, ClearAllActions()) );
        DelayCommand(251.4, AssignCommand(Dwarf6, ClearAllActions()) );
        DelayCommand(251.2, AssignCommand(Dwarf7, ClearAllActions()) );
        DelayCommand(251.6, AssignCommand(Dwarf8, ClearAllActions()) );



        DelayCommand(252.1, AssignCommand(Dwarf1, ActionInteractObject(stool1)) );
        DelayCommand(252.4, AssignCommand(Dwarf2, ActionInteractObject(stool2)) );
        DelayCommand(252.4, AssignCommand(Dwarf3, ActionInteractObject(stool3)) );
        DelayCommand(253.1, AssignCommand(Dwarf4, ActionInteractObject(stool4)) );
        DelayCommand(252.6, AssignCommand(Dwarf5, ActionInteractObject(stool5)) );
        DelayCommand(252.4, AssignCommand(Dwarf6, ActionInteractObject(stool6)) );
        DelayCommand(252.2, AssignCommand(Dwarf7, ActionInteractObject(stool7)) );
        DelayCommand(252.6, AssignCommand(Dwarf8, ActionInteractObject(stool8)) );


DelayCommand(251.0, TurnToFaceObject(LeadINI, DwarfLead) );
DelayCommand(251.1, AssignCommand(DwarfLead, ActionMoveToObject(LeadINI, FALSE, 0.0)));

DelayCommand(252.0, TurnToFaceObject(SecondINI, DwarfSecond) );
DelayCommand(252.1, AssignCommand(DwarfSecond, ActionMoveToObject(SecondINI, FALSE, 0.0)));

DelayCommand(255.1, SetLocalInt(VarStore1, "SongState", 0) );

}



}
