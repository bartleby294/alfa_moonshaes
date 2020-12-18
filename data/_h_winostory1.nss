void main()
{
    //this is the script that governs winos first story its not very complicated just long

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

    DelayCommand(0.01, AssignCommand(Bard1, ActionSpeakString("There was once a farmer who had three sons. He was badly off. and old and feeble, and his sons wouldn't turn their hands to a thing. ")));

    DelayCommand(10.0, AssignCommand(Bard1, ActionSpeakString("To the farm belonged a large, good forest, and there the father wanted the boys to chop wood and see about paying off some of the debt. ")));

    DelayCommand(20.0, AssignCommand(Bard1, ActionSpeakString("At last he got them around to his way of thinking, and the eldest was to go out chipping first. When he had made his way into the forest, and had started chopping a shaggy firtree, a big, burly Troll came up to him. If you're chopping in my forest, I'm going to kill you! said the Troll.")));

    DelayCommand(40.0, AssignCommand(Bard1, ActionSpeakString("When the boy heard that, he flung aside the ax and headed for home again as best he could. He got home clean out of breath, and told them what had happened to him.")));

    DelayCommand(55.0, AssignCommand(Bard1, ActionSpeakString("But his father said he was chicken-hearted. The Trolls had never scared him from chopping wood when he was young, he said. On the next day the second son was to set out, and he fared just like the first. ")));

    DelayCommand(70.0, AssignCommand(Bard1, ActionSpeakString("When he had struck the fir tree a few blows with his ax, the Troll came up to him, too, and said, If you're chopping in my forest, I'm going to kill you!")));

    DelayCommand(85.0, AssignCommand(Bard1, ActionSpeakString("The boy hardly dared look at him. He flung aside the ax and took to his heels just like his brother, and just as fast. When he came home again, his father became angry and said that the Trolls had never scared him when he was young.")));

    DelayCommand(100.0, AssignCommand(Bard1, ActionSpeakString("On the third day the Ash Lad wanted to set out. You? said the two eldest. You'll certainly manage it - you who've never been beyond the front door! He didn't say much to that, the Ash Lad didn't, but just asked for a big a lunch as possible to take with him.")));

    DelayCommand(115.0, AssignCommand(Bard1, ActionSpeakString("His mother had no curds, so she hung the cauldron over the fire to curdle a little cheese for him. This he put in his knapsack, and set out on his way. ")));

    DelayCommand(130.0, AssignCommand(Bard1, ActionSpeakString("When he had been chopping for a little while, the Troll came to him and said: If you're chopping in my forest, I'm going to kill you! But the boy wasn't slow.")));

    DelayCommand(145.0, AssignCommand(Bard1, ActionSpeakString("He ran over to the knapsack to get the cheese, and squeezed it till the whey spurted. If you don't hold your tongue, he shrieked to the Troll, I'll squeeze you the way I'm squeezing the water out of this white stone!")));

    DelayCommand(160.0, AssignCommand(Bard1, ActionSpeakString("Nay, dear fellow! Spare me! said the Troll. I'll help you to chop! Well, on that condition the boy would spare him, and the Troll was clever at chopping, so they managed to fell and cut many cords of wood during the day.")));

    DelayCommand(176.0, AssignCommand(Bard1, ActionSpeakString("As evening was drawing night, the Troll said, Now you can come home with me. My house is closer than yours. Well, the boy went along, and when they came to the Troll's home, he was to make up the fire in the hearth, while the boy was to fetch water for the porridge pot.")));

    DelayCommand(190.0, AssignCommand(Bard1, ActionSpeakString("But the two iron buckets were so big and heavy that he couldn't so much as budge them. So the boy said, It's not worth taking along these thimbles. I'm going after the whole well, I am! ")));

    DelayCommand(205.0, AssignCommand(Bard1, ActionSpeakString("Nay, my dear fellow, said the Troll. I can't lose my well. You make the fire and I'll go after the water. When he came back with the water, they cooked up a huge pot of porridge.")));

    DelayCommand(220.0, AssignCommand(Bard1, ActionSpeakString("If it's the same to you, said the boy, let's have an eating match! Oh, yes! Replied the Troll, for at that he felt he could always hold his own.")));

    DelayCommand(235.0, AssignCommand(Bard1, ActionSpeakString("Well, they sat down at the table, but the boy stole over and took the knapsack and tied it in the front of him, and he scooped more into the knapsack than he ate himself. When the knapsack was full, he took up his knife and ripped a gash in it.")));

    DelayCommand(250.0, AssignCommand(Bard1, ActionSpeakString("The Troll looked at him, but didn't say anything. When they had eaten a good while longer, the Troll put down his spoon. Nay! Now I can't manage any more! he said You must eat! said the boy. I'm barely half full yet.")));

    DelayCommand(265.0, AssignCommand(Bard1, ActionSpeakString("Do as I did and cut a hole in your stomach, then you can eat as much as you wish! But doesn't that hurt dreadfully? asked the Troll. Oh, nothing to speak of, replied the boy.")));

    DelayCommand(280.0, AssignCommand(Bard1, ActionSpeakString("So the Troll did as the boy said, and then, you might know, that was the end of him. But the boy took all the silver and gold to be found in the mountain, and went home with it. With that he could at least pay off some of the debt.")));

    DelayCommand(295.0, AssignCommand(Bard1, ActionSpeakString("*Grins Slyly.*")));


    DelayCommand(295.01, AssignCommand(woman, SpeakString("**smiles claps lightly**  Thank you Wino.")));
    DelayCommand(297.01, AssignCommand(woman, SpeakString("Alright boys time for bed.")));

    DelayCommand(300.02, AssignCommand(boy1, ClearAllActions()));
    DelayCommand(300.03, AssignCommand(boy2, ClearAllActions()));
    DelayCommand(300.04, AssignCommand(boy3, ClearAllActions()));

    DelayCommand(300.05, AssignCommand(woman, ClearAllActions()));

    DelayCommand(301.00, AssignCommand(boy1, ActionMoveToObject(exitWP, FALSE, 0.0)));
    DelayCommand(302.06, AssignCommand(boy2, ActionMoveToObject(exitWP, FALSE, 0.0)));
    DelayCommand(301.07, AssignCommand(boy3, ActionMoveToObject(exitWP, FALSE, 0.0)));

    DelayCommand(303.08, AssignCommand(woman, ActionMoveToObject(exitWP, FALSE, 1.0)));

    DestroyObject(boy1, 316.08);
    DestroyObject(boy2, 316.09);
    DestroyObject(boy3, 316.10);

    DestroyObject(woman, 316.11);

    DelayCommand(318.08, AssignCommand(Bard1, ActionMoveToObject(Chair, FALSE, 1.0)));
    DelayCommand(328.11, AssignCommand(Bard1,  ActionInteractObject(Chair)));
    DelayCommand(329.11, SetLocalInt(Bard1, "poststory", 1));




}
