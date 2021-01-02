void mainOld()
{
    object oPC = GetExitingObject();

    object HighDruidStandWP = GetNearestObjectByTag("High_Druid_Stand01");
    object HighDruidSpawnWP = GetNearestObjectByTag("High_Druid_Spawn01");

    object Druid01StandWP = GetNearestObjectByTag("Druid01_Stand01");
    object Druid01SpawnWP = GetNearestObjectByTag("Druid01_Spawn01");

    object Druid02StandWP = GetNearestObjectByTag("Druid02_Stand01");
    object Druid02SpawnWP = GetNearestObjectByTag("Druid02_Spawn01");

    object Druid03StandWP = GetNearestObjectByTag("Druid03_Stand01");
    object Druid04StandWP = GetNearestObjectByTag("Druid04_Stand01");

    object DruidLight = GetNearestObjectByTag("Druid_Light_WP1");
    object OnHBObj = GetNearestObjectByTag("Moonwell01OnHBObj");
    // if moonwelltrigger == 0 then start the sceen ... This Var is stored on the on heartbeat rock
    if(GetLocalInt(OnHBObj, "Moonwell01Trigger01") == 0)
    {
        //Setting the timer on the stone or other object in the area with the apropriate tag
        //This object will run an on heart beat script that will tell the player they only have
        //a certain amount of time to step into the light.  If they take too long they will be
        //attacked
        //The on heartbeat script will also serve to reset the timmer for the event
        //The condition of the event taking place is time related not PC related.
        SetLocalInt(OnHBObj, "Moonwell01HBTimer", 1);
        SetLocalInt(OnHBObj, "Moonwell01Trigger01", 1);
        SetLocalInt(OnHBObj, "Moonwell01Trigger02", 0);
        SetLocalObject(OnHBObj, "PlayerEnteringGrove", oPC);

        //Spawns the druids in
        object HighDruid = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid", GetLocation(HighDruidSpawnWP));
        object Druid01 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid001", GetLocation(Druid01SpawnWP));
        object Druid02 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid002", GetLocation(Druid02SpawnWP));
        object Druid03 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid003", GetLocation(Druid03StandWP));
        object Druid04 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid004", GetLocation(Druid04StandWP));
        //Tells them to start walking
        AssignCommand(HighDruid, ActionMoveToObject(HighDruidStandWP, FALSE, 1.0));
        AssignCommand(Druid01, ActionMoveToObject(Druid01StandWP, FALSE, 1.0));
        AssignCommand(Druid02, ActionMoveToObject(Druid02StandWP, FALSE, 1.0));

        //This goes through to see if there is a druid in the party
        //If there is the High druid will address the druid of the party
        //It will also check to see if he knows the druid or other char if he does then another convo will trigger.
        // convo state = 0 -> no instructions
        // convo state = 1 -> theres a druid convo
        // convo state = 2 -> theres a druid i know convo
        // convo state = 3 -> theres someone that isnt a druid and i dont know them.
        object PartyMember = GetFactionLeader(oPC);
        while(PartyMember != OBJECT_INVALID)
        {
             if(GetClassByPosition(1, PartyMember) == CLASS_TYPE_DRUID)
            {
                if(GetLocalInt(PartyMember, "Moonwell01Known") == 1)
                {
                   //Execute I know you Druid Hello
                   //BeginConversation("_moonpool01con02", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 2);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con02", FALSE, FALSE));
                    return;
                }
                //Execute Druid Hello
                //BeginConversation("_moonpool01con03", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 1);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con03", FALSE, FALSE));
                return;
            }
             if(GetClassByPosition(2, PartyMember) == CLASS_TYPE_DRUID)
            {
                if(GetLocalInt(PartyMember, "Moonwell01Known") == 1)
                {
                  //Execute I know you Druid Hello
                  //BeginConversation("_moonpool01con02", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 2);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con02", FALSE, FALSE));
                  return;
                }
                //Execute Druid Hello
                //BeginConversation("_moonpool01con03", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 1);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con03", FALSE, FALSE));
                return;
            }
             if(GetClassByPosition(3, PartyMember) == CLASS_TYPE_DRUID)
            {
                if(GetLocalInt(PartyMember, "Moonwell01Known") == 1)
                {
                  //Execute I know you Druid Hello
                  //BeginConversation("_moonpool01con02", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 2);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con02", FALSE, FALSE));
                  return;
                }
                //Execute Druid Hello
                //BeginConversation("_moonpool01con03", PartyMember);
                    SetLocalInt(OnHBObj, "StateStorageVar", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar2", 0);
                    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
                    SetLocalInt(OnHBObj, "StateStorageVar3", 0);
                    SetLocalInt(HighDruid, "ConvoState", 1);
                    SetLocalObject(HighDruid, "TalkTo", PartyMember);
                    AssignCommand(HighDruid, ClearAllActions());
                    effect Walk = EffectMovementSpeedDecrease(50);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
                    AssignCommand(HighDruid, ActionStartConversation(PartyMember, "_moonpool01con03", FALSE, FALSE));
                return;
            }


         PartyMember = GetNextFactionMember( PartyMember,TRUE);
        }

       //Create shaft of light and store the object to the stone for deletion later
       object Light = CreateObject(OBJECT_TYPE_PLACEABLE, "alfa_shaftligt6", GetLocation(DruidLight));
       SetLocalObject(OnHBObj, "lightobject", Light);

        AssignCommand(HighDruid, DelayCommand(12.0, SpeakString("Step Into The Light!")));
        return;


    }
}

float floatAbs(float val) {
    if(val < 0.0) {
        return val * -1.0;
    }
    return  val;
}

float getFacing(vector campfireVector, vector possibleStructureVector) {

    vector direction = Vector(possibleStructureVector.x - campfireVector.x,
                              possibleStructureVector.y - campfireVector.y,
                              0.0);
    return VectorToAngle(direction);
}

/**
    Return a location some units of distance away on a straight line.
 */
location pickSpawnLoc(object oPC, object point, float offset, float rotation) {

    vector pointVector = GetPosition(point);
    vector pcVector = GetPosition(oPC);

    float x1 = pcVector.x - pointVector.x;
    float y1 = pcVector.y - pointVector.y;

    float angle = VectorToAngle(Vector(x1,  y1, 0.0));
    float x = offset * cos(angle + rotation);
    float y = offset * sin(angle + rotation);

    location loc = Location(GetArea(oPC),
        Vector(pointVector.x + x, pointVector.y+ y, 0.0), 0.0);
    float z = GetGroundHeight(loc);

    loc = Location(GetArea(oPC),
        Vector(pointVector.x + x, pointVector.y + y, z),
            getFacing(pointVector, GetPositionFromLocation(loc)));

    return loc;
}

/**
    Return a location some units of distance away on a straight line.
 */
location pickSpawnLoc2(object oPC, object point, float offset, float rotation) {

    vector pointVector = GetPosition(point);
    vector pcVector = GetPosition(oPC);

    //float x = floatAbs(pcVector.x - pointVector.x);
    //float y = floatAbs(pcVector.y - pointVector.y);
    float x = pcVector.x - pointVector.x;
    float y = pcVector.y - pointVector.y;
    x = cos(rotation) * x - sin(rotation) * y;
    y = sin(rotation) * x + cos(rotation) * y;

    vector norm = VectorNormalize(Vector(x, y, 0.0));
    float spawnX = pointVector.x + (offset * norm.x);
    float spawnY = pointVector.y + (offset * norm.y);
    float spawnZ = GetGroundHeight(Location(GetArea(oPC),
                                    Vector(spawnX, spawnY, 0.0), 0.0));
    return Location(GetArea(oPC), Vector(spawnX, spawnY, spawnZ), 0.0);
}

void logLocation(location loc, string str){
    str = str + "Location area: " + GetTag(GetAreaFromLocation(loc));
    str = str + " x: " + FloatToString(GetPositionFromLocation(loc).x);
    str = str + " y: " + FloatToString(GetPositionFromLocation(loc).y);
    str = str + " z: " + FloatToString(GetPositionFromLocation(loc).z);
    WriteTimestampedLogEntry(str);
}

void main() {

    object moonwell = GetObjectByTag("ABoomingVoice2");
    object oPC = GetExitingObject();

    location HighDruidSpawnLoc = pickSpawnLoc(oPC, moonwell, 15.0, 180.0);
    location Druid01SpawnLoc = pickSpawnLoc(oPC, moonwell, 15.0, 90.0);
    location Druid02SpawnLoc = pickSpawnLoc(oPC, moonwell, 15.0, 270.0);
    location Druid03SpawnLoc = pickSpawnLoc(oPC, moonwell, 15.0, 0.0);
    location Druid04SpawnLoc = pickSpawnLoc(oPC, moonwell, 15.0, 0.0);

    logLocation(GetLocation(oPC), "oPCLoc: ");
    logLocation(GetLocation(moonwell), "moonwellLoc: ");
    logLocation(HighDruidSpawnLoc, "HighDruidSpawnLoc: ");
    logLocation(Druid01SpawnLoc, "Druid01SpawnLoc: ");
    logLocation(Druid02SpawnLoc, "Druid02SpawnLoc: ");

    object HighDruid = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid",
                                    HighDruidSpawnLoc,
                                    FALSE, "moonwelldruid");
    object Druid01 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid001",
                                    Druid01SpawnLoc, FALSE, "moonwelldruid001");
    object Druid02 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid002",
                                    Druid02SpawnLoc, FALSE, "moonwelldruid002");
    //object Druid03 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid003",
    //                                pickSpawnLoc(oPC, moonwell, 6.0, 225.0),
    //                                FALSE, "moonwelldruid003");
    //object Druid04 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid004",
    //                                pickSpawnLoc(oPC, moonwell, 6.0, 135.0),
    //                                FALSE, "moonwelldruid004");

}
