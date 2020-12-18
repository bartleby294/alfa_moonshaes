void main()
{
     //this is the script that governs winos fourth story its not very complicated just long

    object Bard1 = GetObjectByTag("Wino");
    object boy1 = GetObjectByTag("_Boy4");
    object boy2 = GetObjectByTag("_Boy2");
    object boy3 = GetObjectByTag("_Boy3");


    object boy1obj = GetObjectByTag("_Boy1_invis");
    object boy2obj = GetObjectByTag("_Boy2_invis");
    object boy3obj = GetObjectByTag("_Boy3_invis");

    object woman = GetObjectByTag("Annita");

    object exitWP = GetObjectByTag("EE02");
    object Chair =  GetObjectByTag("_WinoChair1");

    DelayCommand(0.01, AssignCommand(Bard1, SpeakString("This song is called The challenge of Tempus.")));
    DelayCommand(2.01, AssignCommand(Bard1, SpeakString("*sings in a loud clear booming voice*")));
    DelayCommand(4.01, AssignCommand(Bard1, SpeakString("I AM the God Tempus,    I am the War God,  I am the Thunderer! Here in my Northland,  My fastness and fortress,  Reign I forever! ")));
    DelayCommand(18.01, AssignCommand(Bard1, SpeakString("*sings in a loud clear booming voice*")));
    DelayCommand(20.01, AssignCommand(Bard1, SpeakString("Here amid straights  Rule I the nations;   This is my axe,  Battle Prowess;  Giants and sorcerers  Cannot withstand it! ")));
    DelayCommand(22.01, AssignCommand(Bard1, SpeakString("*sings in a loud clear booming voice*")));
    DelayCommand(30.01, AssignCommand(Bard1, SpeakString("These are the gauntlets   Wherewith I wield it,   And hurl it afar off;  This is my girdle;   Whenever I brace it,  Strength is redoubled! ")));
    DelayCommand(32.01, AssignCommand(Bard1, SpeakString("*sings in a loud clear booming voice*")));
    DelayCommand(48.01, AssignCommand(Bard1, SpeakString("The light thou beholdest   Stream through the heavens,  In flashes of crimson,  Is but my red beard  Blown by the night-wind,  Affrighting the nations!  Istisha is my brother;  Mine eyes are the lightning;  The sails of my ship  Are full in the thunder,  The blows of my axe  Ring in the earthquake! ")));
    DelayCommand(50.01, AssignCommand(Bard1, SpeakString("*sings in a loud clear booming voice*")));
    DelayCommand(58.01, AssignCommand(Bard1, SpeakString("Force rules the world still,   Has ruled it, shall rule it;  Meekness is weakness,  Strength is triumphant,  Over the whole earth /n  Still is it Tempus'-Day! ")));
    DelayCommand(52.01, AssignCommand(Bard1, SpeakString("*sings in a loud clear booming voice*")));
    DelayCommand(60.01, AssignCommand(Bard1, SpeakString("Thou art a God too,  O Jannath!  And thus singled-handed  Unto the combat,  Gauntlet or Gospel,  Here I defy thee!")));

    DelayCommand(64.01, AssignCommand(woman, SpeakString("**smiles claps lightly**  Thank you Wino.")));
    DelayCommand(64.01, AssignCommand(woman, SpeakString("Alright boys time for bed.")));

    DelayCommand(67.02, AssignCommand(boy1, ClearAllActions()));
    DelayCommand(67.03, AssignCommand(boy2, ClearAllActions()));
    DelayCommand(67.04, AssignCommand(boy3, ClearAllActions()));
    DelayCommand(67.05, AssignCommand(woman, ClearAllActions()));

    //DelayCommand(65.02, AssignCommand(boy1obj, DestroyObject(boy1, 0.0)));
    //DelayCommand(65.04, AssignCommand(boy1obj, DestroyObject(boy2, 0.0)));
    //DelayCommand(65.06, AssignCommand(boy1obj, DestroyObject(boy3, 0.0)));

    DelayCommand(68.05, AssignCommand(boy1, ActionMoveToObject(exitWP, FALSE, 1.0)));
    DelayCommand(68.06, AssignCommand(boy2, ActionMoveToObject(exitWP, FALSE, 1.0)));
    DelayCommand(68.07, AssignCommand(boy3, ActionMoveToObject(exitWP, FALSE, 1.0)));
    DelayCommand(68.08, AssignCommand(woman, ActionMoveToObject(exitWP, FALSE, 1.0)));

    DelayCommand(74.08, DestroyObject(boy1, 0.0));
    DelayCommand(74.09, DestroyObject(boy2, 0.0));
    DelayCommand(74.10, DestroyObject(boy3, 0.0));
    DelayCommand(74.11, DestroyObject(woman, 0.0));

    DelayCommand(75.08, AssignCommand(Bard1, ActionMoveToObject(Chair, FALSE, 1.0)));
    DelayCommand(83.11, AssignCommand(Bard1,  ActionInteractObject(Chair)));
    DelayCommand(84.11, SetLocalInt(Bard1, "poststory", 1));









}
