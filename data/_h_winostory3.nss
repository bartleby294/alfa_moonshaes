void main()
{
    //this is the script that governs winos third story its not very complicated just long

    object Bard1 = GetObjectByTag("Wino");
    object boy1 = GetObjectByTag("_Boy1");
    object boy2 = GetObjectByTag("_Boy2");
    object boy3 = GetObjectByTag("_Boy3");


    object boy1obj = GetObjectByTag("_boy1_invis");
    object boy2obj = GetObjectByTag("_boy2_invis");
    object boy3obj = GetObjectByTag("_boy3_invis");

    object woman = GetObjectByTag("Annita");

    object exitWP = GetObjectByTag("EE02");
    object Chair =  GetObjectByTag("_WinoChair1");

    DelayCommand(0.01, AssignCommand(Bard1, ActionSpeakString("Tempus went out of the north disguised as a youth and came in the evening to a giant called Hymir. Thor stayed there that night. At daybreak Hymir got up and dressed and prepared to go sea-fishing in a rowboat.")));
    DelayCommand(15.01, AssignCommand(Bard1, ActionSpeakString("Tempus sprang up and asked Hymir to let him go rowing with him.  Hymir said that he would not be much help, as he was such a scrap of a young fellow: You'll catch cold if I sit as long and as far out to sea as I usually do. ")));
    DelayCommand(30.01, AssignCommand(Bard1, ActionSpeakString("Tempus, however, said he would be able to row a long way out from the shore, and that it wasn't certain that he would be the first to demand to be rowed back. He became so angry with the giant that he was ready to set the hammer ringing on his head. He controlled himself, however, as he intended to try his strength in another place. ")));
    DelayCommand(45.01, AssignCommand(Bard1, ActionSpeakString("He asked Hymir what they were to take as bait, but Hymir told him to get his own. Then Tempus turned away to where he saw a herd of oxen belonging to Hymir. He selected the biggest ox, one called Sky-Bellower, and struck off its head. ")));
    DelayCommand(60.01, AssignCommand(Bard1, ActionSpeakString("Tempus took the ox-head on board, sat down in the stern, and rowed. Hymir thought they made rapid progress from his rowing. Hymir sat in the bow, and together they rowed until they came to the place where Hymir was accustomed to sit and catch flat fish. Tempus said he wanted row much farther out, and they had another bout of fast rowing. Then Hymir said that they had come so far out that it would be dangerous to sit there on account of the Seawolf Serpent. ")));
    DelayCommand(75.01, AssignCommand(Bard1, ActionSpeakString("Tempus, however, declared his intention of rowing for a bit yet, and did so, and Hymir was not at all pleased at that. When Tempus shipped his oars, he made ready a very strong line and a large hook. He baited the hook with the ox-head and flung it overboard. ")));
    DelayCommand(90.01, AssignCommand(Bard1, ActionSpeakString("The Seawolf Serpent snapped at the ox-head, and the hook stuck fast in the roof of its mouth. It jerked away so hard that both Tempus' fists knocked against the gunwale. Then Tempus grew angry and, exerting all his divine strength, dug in his heels so hard that both legs went through the boat until he was digging his heels in on the sea bottom. ")));
    DelayCommand(105.01, AssignCommand(Bard1, ActionSpeakString("He drew the serpent up on board, staring straight at it. The serpent glared back, belching poison. The giant Hymir turned pale with fear when he saw the serpent and the sea trembling in and out of the vessel too. At the very moment that Tempus gripped his hammer and raised it aloft, the giant fumbled for his bait knife and cut Tempus' line off at the gunwale.")));
    DelayCommand(120.01, AssignCommand(Bard1, ActionSpeakString("The serpent sank back into the sea. Tempus flung his hammer after it and people say that this struck its head off in the waves; but the truth is that the Seawolf Serpent is still alive and is lying in the ocean. ")));
    DelayCommand(135.01, AssignCommand(Bard1, ActionSpeakString("Tempus clenched his fist and gave Hymir a box on the ear so that he fell overboard head first, but Tempus himself waded ashore. ")));
    DelayCommand(140.01, AssignCommand(Bard1, ActionSpeakString("And that is the tail of Tempus and the Seawolf Serpent!")));

    DelayCommand(144.01, AssignCommand(woman, SpeakString("**smiles claps lightly**  Thank you Wino.")));
    DelayCommand(146.01, AssignCommand(woman, SpeakString("Alright boys time for bed.")));

    DelayCommand(147.02, AssignCommand(boy1, ClearAllActions()));
    DelayCommand(147.03, AssignCommand(boy2, ClearAllActions()));
    DelayCommand(148.04, AssignCommand(boy3, ClearAllActions()));
    DelayCommand(149.05, AssignCommand(woman, ClearAllActions()));

    //DelayCommand(145.02, AssignCommand(boy1obj, DestroyObject(boy1, 0.0)));
    //DelayCommand(145.04, AssignCommand(boy1obj, DestroyObject(boy2, 0.0)));
    //DelayCommand(145.06, AssignCommand(boy1obj, DestroyObject(boy3, 0.0)));

    DelayCommand(150.05, AssignCommand(boy1, ActionMoveToObject(exitWP, FALSE, 1.0)));
    DelayCommand(150.06, AssignCommand(boy2, ActionMoveToObject(exitWP, FALSE, 1.0)));
    DelayCommand(150.07, AssignCommand(boy3, ActionMoveToObject(exitWP, FALSE, 1.0)));
    DelayCommand(150.08, AssignCommand(woman, ActionMoveToObject(exitWP, FALSE, 1.0)));

    DelayCommand(160.08, DestroyObject(boy1, 0.0));
    DelayCommand(160.09, DestroyObject(boy2, 0.0));
    DelayCommand(160.10, DestroyObject(boy3, 0.0));
    DelayCommand(160.11, DestroyObject(woman, 0.0));

    DelayCommand(162.08, AssignCommand(Bard1, ActionMoveToObject(Chair, FALSE, 1.0)));
    DelayCommand(170.11, AssignCommand(Bard1,  ActionInteractObject(Chair)));
    DelayCommand(171.11, SetLocalInt(Bard1, "poststory", 1));

}
