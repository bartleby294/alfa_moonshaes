int isObjectInArea(string objTag) {
    int objectFound = 0;
    object obj = GetFirstObjectInArea();
    while(GetIsObjectValid(obj) && objectFound == 0){
        if(GetTag(obj) == objTag){
            objectFound = 1;
        }
        obj = GetNextObjectInArea();
    }
    return objectFound;
}

void createRaidingParty(object xvartRaidSpawnWP) {

    float firstCornDist = -1.0;
    float secondCornDist = -1.0;
    float thirdCornDist = -1.0;
    float fourthCornDist = -1.0;
    float fifthCornDist = -1.0;

    object firstCorn = OBJECT_INVALID;
    object secondCorn = OBJECT_INVALID;
    object thirdCorn = OBJECT_INVALID;
    object fouthCorn = OBJECT_INVALID;
    object fifthCorn = OBJECT_INVALID;

    // loop thorugh all obejct in area get the 5 closest corns.
    object obj = GetFirstObjectInArea();
    while(GetIsObjectValid(obj)){
        // if its a corn check if its closer than what we have saved
        if (TestStringAgainstPattern("hlf_f1_corn_obj_*n", GetTag(obj))) {
            AssignCommand(OBJECT_SELF, ActionSpeakString("-----------"));
            AssignCommand(OBJECT_SELF, ActionSpeakString("++++++++"));
            AssignCommand(OBJECT_SELF, ActionSpeakString("Cur obj:"));
            AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(obj)));
            AssignCommand(OBJECT_SELF, ActionSpeakString("++++++++"));
            float curDist = GetDistanceBetween(obj, xvartRaidSpawnWP);
            if(firstCornDist == -1.0 || curDist < firstCornDist){
                secondCornDist = firstCornDist;
                thirdCornDist = secondCornDist;
                fourthCornDist = thirdCornDist;
                fifthCornDist = fourthCornDist;
                firstCornDist = curDist;

                secondCorn = firstCorn;
                thirdCorn = secondCorn;
                fouthCorn = thirdCorn;
                fifthCorn = fouthCorn;
                firstCorn = obj;

               AssignCommand(OBJECT_SELF, ActionSpeakString("First Corn:"));
               AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(firstCorn)));
            }
            else {
                if(secondCornDist == -1.0 || curDist < secondCornDist){
                    thirdCornDist = secondCornDist;
                    fourthCornDist = thirdCornDist;
                    fifthCornDist = fourthCornDist;
                    secondCornDist = curDist;

                    thirdCorn = secondCorn;
                    fouthCorn = thirdCorn;
                    fifthCorn = fouthCorn;
                    secondCorn = obj;

                    AssignCommand(OBJECT_SELF, ActionSpeakString("Second Corn:"));
                    AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(secondCorn)));
                }
                else {
                    if(thirdCornDist == -1.0 || curDist < thirdCornDist){
                        fourthCornDist = thirdCornDist;
                        fifthCornDist = fourthCornDist;
                        thirdCornDist = curDist;

                        fouthCorn = thirdCorn;
                        fifthCorn = fouthCorn;
                        thirdCorn = obj;

                        AssignCommand(OBJECT_SELF, ActionSpeakString("Third Corn:"));
                        AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(thirdCorn)));
                    }
                    else {
                        if(fourthCornDist == -1.0 || curDist < fourthCornDist){
                            fifthCornDist = fourthCornDist;
                            fourthCornDist = curDist;

                            fifthCorn = fouthCorn;
                            fouthCorn = obj;

                            AssignCommand(OBJECT_SELF, ActionSpeakString("Fourth Corn:"));
                            AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(fouthCorn)));
                        }
                        else {
                            if(fifthCornDist == -1.0 || curDist < fifthCornDist){
                                fifthCornDist = curDist;

                                fifthCorn = obj;

                                AssignCommand(OBJECT_SELF, ActionSpeakString("Fifth Corn:"));
                                AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(fifthCorn)));
                           }
                        }
                    }
                }
            }

            AssignCommand(OBJECT_SELF, ActionSpeakString("-----------"));
        }
        obj = GetNextObjectInArea();
    }
    AssignCommand(OBJECT_SELF, ActionSpeakString("###############"));
    AssignCommand(OBJECT_SELF, ActionSpeakString("First Corn:"));
    AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(firstCorn)));
    AssignCommand(OBJECT_SELF, ActionSpeakString("Second Corn:"));
    AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(secondCorn)));
    AssignCommand(OBJECT_SELF, ActionSpeakString("Third Corn:"));
    AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(thirdCorn)));
    AssignCommand(OBJECT_SELF, ActionSpeakString("Fourth Corn:"));
    AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(fouthCorn)));
    AssignCommand(OBJECT_SELF, ActionSpeakString("Fifth Corn:"));
    AssignCommand(OBJECT_SELF, ActionSpeakString(GetTag(fifthCorn)));

    // Now create 1d5 xvart raiders at the wp and set each to use the above corn
    int rand_1d5_xvarts = Random(4) + 2;
    int curXvartCnt = 1;

    for(curXvartCnt = 1; curXvartCnt <= rand_1d5_xvarts; ++curXvartCnt) {
        object curXvart = CreateObject(OBJECT_TYPE_CREATURE, "sw_goblin_01",
            GetLocation(GetObjectByTag("hlf1_xvart_1")), TRUE, "xvart_raider");

        // Note that if there are less than 5 corn left in the area xvart will
        // not attack any more corn but at this point leave the pcs a chance.
        if(curXvartCnt == 1 && firstCorn != OBJECT_INVALID) {
            AssignCommand(curXvart, ActionAttack(firstCorn, FALSE));
        }
        else if(curXvartCnt == 2 && secondCorn != OBJECT_INVALID) {
            AssignCommand(curXvart, ActionAttack(secondCorn, FALSE));
        }
        else if(curXvartCnt == 3 && thirdCorn != OBJECT_INVALID) {
            AssignCommand(curXvart, ActionAttack(thirdCorn, FALSE));

        }
        else if(curXvartCnt == 4 && fouthCorn != OBJECT_INVALID) {
            AssignCommand(curXvart, ActionAttack(fouthCorn, FALSE));
        }
        else if(curXvartCnt == 5 && fifthCorn != OBJECT_INVALID) {
            AssignCommand(curXvart, ActionAttack(fifthCorn, FALSE));
        }
    }
}

void startRaid() {
    AssignCommand(OBJECT_SELF, ActionSpeakString("Starting Xvart Raid"));

    string BASE_WP_TAG = "hlf_f1_corn_";
    string BASE_OBJ_TAG = "hlf_f1_corn_obj_";
    string CORN_RESREF = "alfa_produce014";

    // do 1d5 + 10 total raids
    int numberOfRaids = Random(5) + 11;

    // Start the raid and then set a time out of 30 minutes.
    SetLocalInt(OBJECT_SELF, "xvart_raids_in_progress", 1);
    SetLocalInt(OBJECT_SELF, "xvart_raids_remaining", numberOfRaids);
    DelayCommand(1800.0, SetLocalInt(OBJECT_SELF, "xvart_raids_in_progress", 0));

    object curXvartRaidWP = GetWaypointByTag("hlf1_xvart_1");
    createRaidingParty(curXvartRaidWP);

    //int i;
    //for(i=1; i<9; ++i) {
    //    string waypointTag = BASE_WP_TAG + IntToString(i);
    //    string objTag = BASE_OBJ_TAG + IntToString(i);
    //    object wp = GetWaypointByTag(waypointTag);
    //
    //    int objectFound = isObjectInArea(objTag);
    //    if(objectFound == 0) {
    //        AssignCommand(OBJECT_SELF, ActionSpeakString("Created Object: " + objTag));
    //        CreateObject(OBJECT_TYPE_PLACEABLE, CORN_RESREF, GetLocation(wp), FALSE, objTag);
    //    } else {
    //        AssignCommand(OBJECT_SELF, ActionSpeakString("Did not create Object: " + objTag));
    //    }
    //}
}

void main()
{
    // If there isnt a raid going on start one.
    if(GetLocalInt(OBJECT_SELF, "xvart_raids_in_progress") == 0) {
         startRaid();
    }
}
