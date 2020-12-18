//::///////////////////////////////////////////////
//:: an_animal_ai_inc
//:: This is the include file for the animal ai scripts
//:: By Rhox505 @ stuart_heinrich@hotmail.com
//::
//:: Modified : Rahvin Talemon April/May 2004 (rahvint@hotmail.com)
//:://////////////////////////////////////////////
/*
    Rahvin: 5.4  v1.0
    - Bug Fixes and Modifications for ALFA & Elder.
    - Herbivores will actively seek out any placables that are plant based and eat them.
    - Carnivores will hunt in packs, following the strongest male of the group.
    - When creatures flee they will continue fleeing until for a set amount of time before pausing to percieve.
    - Creatures will not fear themselves, thus making them un-huntable to those of the same type.
    - Morale Types (Fearless, Elite, Average, Weak)
    - Fixed the completely bogus feeding system.
    - Redid some of the hunger/starvation values, creatures were able to go 60 days without eating. Yeah. Sure.
    - Instead of OnDeath spawning a corpse, a corpse placable type object will be left. Making it compatable with CNR and ALFA hopefully.
    - Most carnivores will seek out the easiest meal in the area. Dead creatures will attract them before live ones.
    - Pack based creatures will travel through AT's by going to the last place their leader was before it disappeared (through AT)
    - If a pack creature gets seperated from its leader and completely lost and hung up it will transport to its leader.

*/

/* example from size groups
tiny = mouse/chicken/badger
small = birds
medium = canines/cats/deer
large = bears
huge = elephants, etc
*/
#include "x0_i0_position"

//grams that creature could eat after each heartbeat (6 seconds of gametime)
// Elder/ALFA 7 Minute per Game hour. 168 Minutes/1 Game Day. 1680 Heartbeats (Give or take considering the HB system.)
// 453 Grams in a lb.
//calculate: grams a day /24/60/60*6*8 = grams a day/1800
//calculate: pounds a day *454/24/60/60*6*8 = pounds a day*227/900
const float TINY_HUNGER_RATE               =       0.005,         //8 gram of food a day (mouse)
            SMALL_HUNGER_RATE              =       0.042,         //70 gram a food a day (peregrine falcon)
            MEDIUM_HUNGER_RATE             =       5.39,          //20 lbs pounds avg (6.5 for wolf, 10 for deer)
            LARGE_HUNGER_RATE              =      16.17,          //60 pounds of meat a day (grizzly bear)
            HUGE_HUNGER_RATE               =     161.78,          //600 pounds of vegetation a day (elephant)

//grams of edible food contained on each food source
            TINY_CREATURE_MASS             =      50.0,           //50 gram    (large mouse)
            SMALL_CREATURE_MASS            =     500.0,           //500 grams  (peregrine falcon)
            MEDIUM_CREATURE_MASS           =   49940.0,           //135 pounds avg (110 for wolf, 150 for deer)
            LARGE_CREATURE_MASS            =  272400.0,           //600 pounds (grizzly bear)
            HUGE_CREATURE_MASS             = 4546000.0,           //10,000 pounds (elephant)

//creature dies after hunger reaches this many grams
            TINY_CREATURE_STARVE_HUNGER    =      24.0,           // 3 days of not eating (mice)
            SMALL_CREATURE_STARVE_HUNGER   =     700.0,           // 10 days of not eating (falcon)
            MEDIUM_CREATURE_STARVE_HUNGER  =  181200.0,           // 20 days of not eating (dog)
            LARGE_CREATURE_STARVE_HUNGER   =  407700.0,           // 15 days of not eating (Tiger)
            HUGE_CREATURE_STARVE_HUNGER    =  271800.0,           // 7 days  of not eating (Elephant)

//random float constants
            HUNT_TIME                      =      60.0,           //time that a creature will continue to hunt a selected prey before picking a new one
            DEFENSE_TIME                   =      15.0,           //time that a creature will continue to retaliate after attacked once
            GIVE_UP_RETURNING_TO_LAST_FOOD =      25.0,           //time that it takes a creature to give up returning to last food source WARNING: not reset when return to location
            PERCEPTION_RANGE_FORAGE        =      50.0,
            PERCEPTION_RANGE_FLEE          =      50.0,           //RT.4 was 25//distance that creatures will try to keep from animals they are scared of
            RUN_RANGE                      =     150.0,           // RT.4.27.4 Changed to 150
            EXHAUSTION_HUNGER_PERCENT      =       0.75,          //will become exhausted when 75% of the way to starvation
            MIN_EAT_DIST                   =       4.0,
            PC_RATING_VS_ANIMALS           =       2.5,           //increase PC challenge rating in terms of animals being afraid of the PC
            CORPSE_BONES_TIME              =   10800.0,           //seconds it takes for a dead corpse to turn into bones (1 day)
            CORPSE_FADE_TIME               =   75600.0,           //seconds it takes from death for all remnants (bones) to be erased (1 week)
            RESPAWN_SEARCH_DISTANCE        =     150.0,           //distance that will be searched for a parent to respawn at
            TRACKS_FADE_TIME               =      60.0;           //time that it takes animal tracks to fade (1 minute, to avoid high lag)

            // RT4.27.4
            // UNDEAD_RATING_VS_ANIMALS       =      10.0;           // Undead are tough for animals to deal with.

//generic creature constants
const int   EAT_FACTOR                     =     600,             //get hungry enough to decide to eat 3 times a day.(1800 heartbeats in a AN day) mulitply this be a hunger rate to find how many grams of hunger until they will decide to eat / how much they can eat in 1 heartbeat
            EXHAUSTION_SLOW_PERCENT        =      75,             //percent that an animal is slowed when they become exhausted
            HERBIVORE                      =     100,             //reference value
            CARNIVORE                      =     101,             //reference value

            // RT.4.27.4 Packs
            PACK_MAX_SIZE                  =       6,             // The maximum size a pack can possibly be.

            // RT.4.27.4 Morale
            MORALE_FEARLESS                =        4,            // This creature will never flee from combat.
            MORALE_ELITE                   =        3,            // This creature will only flee from combat if at 3/4 Strength
            MORALE_AVERAGE                 =        2,            // This creature will only flee from combat at 1/2 Strength
            MORALE_WEAK                    =        1,            // This creature will flee from combat at first blood.


//random explore constants
            RANDOM_WALK_CHANGE             =      50,             //degrees that angle of walk may change every heartbeat
            RANDOM_WALK_DISTANCE           =      18,             //distance that creature will attempt to walk each heartbeat
            RANDOM_WALK_CHECK_DIST         =       1;             //distance ahead that it checks for a wall

string      ANIMAL_BONES_RESREF            =  "plc_bones",        //resref for bones left by an animal corpse
            ANIMAL_TRACKS_RESREF           =  "tracks",           //resref for tracks left by a medium or larger animal

            //RT.4.27.4 Packs
            PACK_CREATURE                  = "IS_PACK_CREATURE",   // Storage value for the creatures pack mentality.
            PACK_SIZE                      = "SIZE_OF_PACK",         // Storage Value for the current pack size. Stored on Module
            PACK_ALPHA_MALE                = "ALPHA_OBJECT",      // Storage value for local Alpha Male. Stored on Creature.
            PACK_LEADER                    = "IS_PACK_LEADER",    // Storage value for if a creature is a pack leader.
            ALPHA_DESTINATION              = "ALPHA_DESTINATION", // Storage for alpha destination.

            // RT.4.27.4 Morale
            MORALE_TYPE                   = "MORALE_TYPE",        // Storage value for the morale value of the creature.
            I_AM_FLEEING                  = "I_AM_FLEEING",       // Keep track of the chickens.

            // RT.5.4.4 Feeding
            CORPSE_PLACABLE_TAG           = "cnrCorpseSkin";      // Tag to the edible corpse.


//function prototypes
void ActionDieOfStarvation(object oTarget);
void ActionEat(object oSelf, object oFood);
void ActionFleeFrom(object oTarget, object oScary);
void ActionHuntPerceivedFood(object oSelf, object oFood);
void ActionLookForFood(object oTarget);
void ActionRandomExplore(object oTarget);
void ActionTurnAround(object oTarget);
void CreateBones(object oCarcass);
void LeaveAnimalTracks(object oTarget);
void ReSpawn(object oCorpse);

// RT.4.27.4 Start
// Pack Mentality
void RT_ReformPack(object oAlpha);
object RT_DetermineAlphaMale(object oNewCreature, object oCurrent);
int RT_GetPackSize(object oPercievedCreature);
int RT_IsPackCreature(object oPercievedCreature);
void RT_SetPackCreature(int nValue, object oCreature);
void RT_SwitchLeadership(object oOldAlpha, object oNewAlpha);
object RT_GetPackLeader(object oPercievedCreature);
void RT_SetMyPackLeader(object oAlpha, object oFollower);
void RT_RemoveFromPack(object oAlpha);
void RT_ActionFollowPackLeader(object oTarget);
int RT_IsMemberOfPack(object oTarget);
int RT_IsLeaderOfPack(object oTarget);
int RT_IsPackLeader(object oTarget);
void RT_SetDestination(object oAlpha, location locDestination);
location RT_GetDestination(object oAlpha);

// Morale & Combat Related
int RT_GetMoraleType(object oCreature);
void RT_SetMoraleType(int nMoraleType);
//RT.4.27.4 End

void IncreaseHunger(object oTarget, float fRate);
void ReduceFoodLeft(object oCorpse, float fReduce);
void ReduceHunger(object oTarget, float fReduce);
void SetConsumerGroup(object oTarget, int Group);
void SetEating(object oTarget, int bValue);
void SetEatingFood(object oTarget, object oCorpse);
void SetFoodLeft(object oCorpse, float fFoodLeft);
void SetHunger(object oTarget, float fHunger);
void SetHungry(object oTarget, int bValue);
void SetHunting(object oTarget, int bValue);
void SetLastFoodLocation(object oTarget, location locFood);
void SetLocation(object oTarget);
void SetRememberFood(object oTarget, int bValue);

int GetDecideToEat(object oTarget);
int GetDoesRememberFood(object oTarget);
object GetEatingFood(object oTarget);
object GetFarthestParent(object oSelf, float fRange);
float GetFoodLeft(object oCorpse);
float GetFoodOnAnimal(object oAnimal);
float GetHunger(object oTarget);
float GetHungerRate(object oTarget);
int GetIsFacingWall(object oTarget);
int GetIsHungry(object oTarget);
int GetIsHunting(object oTarget);
int GetIsCarnivore(object oTarget);
int GetIsEating(object oTarget);
int GetIsHerbivore(object oTarget);
int GetIsLocationValid(location loc);
int GetIsScaredOf(object oSelf, object oTarget);
int GetIsValidPrey(object oSelf, object oPrey);
int GetIsValidPlant(object oSelf, object oTarget);
location GetLastFoodLocation(object oTarget);
location GetLastLocation(object oTarget);
int GetLevel(object oTarget);
float GetMaxPossibleSpawnHunger(object oTarget);
object GetNearestPlant(object oSelf, float fRange);
object GetNearestPrey(object oSelf, float fRange);
object GetNearestScary(object oSelf, float fRange);
int GetShouldEatCorpse(object oSelf, object oCorpse);
int GetShouldEatPlant(object oSelf, object oPlant);
float GetStarveHunger(object oTarget);



//function definitions

int GetLevel(object oTarget)
//returns total character level of target
{
    return (GetLevelByPosition(1, oTarget) + GetLevelByPosition(2, oTarget) + GetLevelByPosition(3, oTarget));
}

// RT.Elder/ALFA 5.4 Start Mod
void ActionFleeFrom(object oTarget, object oScary)
//makes oTarget flee from oScary
{
    ClearAllActions(TRUE); // Clear combat state and get out of dodge.
    ClearPersonalReputation(oScary, oTarget);
    SetLocalInt(oTarget, I_AM_FLEEING, TRUE);
    AssignCommand(oTarget, ActionMoveAwayFromObject(oScary, TRUE, RUN_RANGE));
} // RT.Elder/ALFA 5.4 End Mod

location GetLastLocation(object oTarget)
//returns the location of target at last heartbeat
{
    return GetLocalLocation(oTarget, "lLast");
}

void SetLocation(object oTarget)
//store the current location on the object
{
    SetLocalLocation(oTarget, "lLast", GetLocation(oTarget));
}

void ActionRandomExplore(object oTarget)
//makes oTarget randomly explore area, turning around when blocked ahead
{
    object oArea = GetArea(oTarget);
    vector vPosition = GetPosition(oTarget);
    location locTarget;
    float fOrientation = GetFacing(oTarget),
          fDistance;

    if (GetIsFacingWall(oTarget))
        ActionTurnAround(oTarget);

    SetLocation(oTarget);

    //set a new destination
    //change orientation by up to 45 degrees
    fOrientation += IntToFloat( (Random(RANDOM_WALK_CHANGE*2)-RANDOM_WALK_CHANGE) );
    fDistance = IntToFloat(RANDOM_WALK_DISTANCE);

    //compute vertical/horizontal change
    vPosition.y += fDistance*sin(fOrientation);
    vPosition.x += fDistance*cos(fOrientation);

    locTarget = Location(oArea, vPosition, fOrientation);

    //SpeakString("Current location is: " + LocationToString(GetLocation(oTarget)));
    //SpeakString("Walking to location: " + LocationToString(locTarget));

    RT_SetDestination(oTarget, locTarget);

    //walk to the new destination
    AssignCommand(oTarget, ActionMoveToLocation(locTarget, FALSE));
}

void ActionTurnAround(object oTarget)
{
    float fOrientation = GetFacing(oTarget);

    fOrientation += 180.0;

    while(fOrientation > 360.0)
        fOrientation -= 360.0;

    AssignCommand(oTarget, SetFacing(fOrientation));
}

int GetIsFacingWall(object oTarget)
//assume facing wall if haven't moved since last heartbeat
{
    location lLast = GetLastLocation(oTarget),
             lNow = GetLocation(oTarget);

    if(GetDistanceBetweenLocations(lLast, lNow) < 1.0)
        return TRUE;
    else
        return FALSE;
}

int GetIsLocationValid(location loc)
{
    object blocker;
    float angle = VectorToAngle(GetPositionFromLocation(loc));
    if (angle > 90.0 || angle < 0.0)
        return FALSE; // only if this is a run time location and was generated off screen.
                      // if an object is referenced that is invalid, the
                      // GetLocation(OBJECT_INVALID) will return 0.0,0.0,0.0 as
                      // the position.
    else if ((blocker = GetFirstObjectInShape(SHAPE_SPHERE,0.5,loc,FALSE,OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE)) != OBJECT_INVALID)
        return FALSE; // there is something here already, a door or
                      // creature or placeable.
    else
    {
        // make a creature object there and check the distance to it once it is made.
        object marker = CreateObject(OBJECT_TYPE_CREATURE,"null_human",loc);
        DestroyObject(marker,0.1);
        if (GetDistanceBetweenLocations(GetLocation(marker),loc) > 0.5)
            return FALSE; // tileset or otherwise caused the location to be shifted.

        return TRUE; // location valid for creation;
    }
}

// RT.5.4 Valid prey is anything living that is scared of the carnivore.
//
int GetIsValidPrey(object oSelf, object oPrey)
{
    int bValid = TRUE;

    //PC's and self are not valid prey, AND creatures of same type. RT.4.30.4
    if (GetIsPC(oPrey) || oPrey == oSelf || GetTag(oSelf) == GetTag(oPrey))
        bValid = FALSE;

    //only creatures who are scared of self are valid prey
    if (!GetIsScaredOf(oPrey, oSelf))
        bValid = FALSE;

    return bValid;
}


// RT.5.4 This needs to be modified for game worlds to determine what sort of
//           tags plants have. This will not currently work for Elder, we use CNR.
// Modify according to the plant systems used.
//
int GetIsValidPlant(object oSelf, object oTarget)
//returns if plant is valid edible
{
    string sTag = GetSubString(GetTag(oTarget), 0, 7);
    int Size = GetCreatureSize(oSelf);
    int bValid;

    if(Size <= CREATURE_SIZE_SMALL) {
        if (sTag=="an_plan")
            bValid = TRUE;
        else
            bValid = FALSE;
    }
    else {
        if (sTag=="an_plan" || sTag=="an_tree")
            bValid = TRUE;
        else
            bValid = FALSE;
    }

    return bValid;
}

//  A creature will prefer dead prey over live prey if it is available.
//  Any edible corpses within range will override any living creatures within
//  range. RT.5.4
object GetNearestPrey(object oSelf, float fRange)
{
    // Declarations
    object oDeadPrey;
    object oLivePrey;
    int nDistanceDeadPrey;
    int nDistanceLivePrey;
    int nCount = 1;

    //Get Nearest dead prey and test to see if it has been percieved.
    oDeadPrey = GetNearestObjectByTag(CORPSE_PLACABLE_TAG, oSelf);
    // PrintString("First dead creature is: " + GetTag(oDeadPrey));
    if (GetIsObjectValid(oDeadPrey) && GetDistanceBetween(oDeadPrey, oSelf) <= PERCEPTION_RANGE_FORAGE)
    {
        // PrintString("Found: " + GetTag(oDeadPrey) + " to be the closest dead prey.");
        return oDeadPrey;
    }

    // Get the nearest, percieved living creature.
    oLivePrey = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, oSelf, nCount, CREATURE_TYPE_IS_ALIVE, TRUE);
    // Check to make sure its a valid prey.
    while(GetIsObjectValid(oLivePrey))
    {
        // PrintString("First living creature is: " + GetTag(oLivePrey));
        nCount++;
        if (GetIsValidPrey(oSelf, oLivePrey))
            break;
        else
            oLivePrey = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, oSelf, nCount, CREATURE_TYPE_IS_ALIVE, TRUE);
    }

    // PrintString("Found: " + GetTag(oLivePrey) + " to be the closest living prey.");
    return oLivePrey;
}

object GetNearestPlant(object oSelf, float fRange)
//returns closest prey that is within PERCEPTION_RANGE, or OBJECT_INVALID if none
{
    location locSelf = GetLocation(oSelf);
    float fShortestDistance = 999.9,
          fDistance;
    object oClosest;

    //select first creature in range
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRange, locSelf, TRUE, OBJECT_TYPE_PLACEABLE);

    //if first creature is valid food, set as closest
    if(GetIsValidPlant(oSelf, oTarget))
    {
        oClosest = oTarget;
        fShortestDistance = GetDistanceBetween(oSelf, oClosest);
    }

    //cycle through all creatures in fRange
    while (GetIsObjectValid(oTarget))
    {
        //select target creature
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRange, locSelf, TRUE, OBJECT_TYPE_PLACEABLE);

        //check to see if creature is valid prey
        if(GetIsValidPlant(oSelf, oTarget))
        {
            //get distance between target and self
            fDistance = GetDistanceBetween(oSelf, oTarget);

            //if closer than previous closest, set as new closest target
            if ( fDistance < fShortestDistance )
            {
                fShortestDistance = fDistance;
                oClosest = oTarget;
            }
        }
    }
    return oClosest;
}

// Some creatures have no sense of fear and will attack prey
// that appears stronger than itself, or if in a pack.
// Undead will always scare an animal.
//
// Also need to take into consideration the current state of their HP's.
//
int GetIsScaredOf(object oSelf, object oTarget)
//creatures are scared of anything with higher challenge rating
{
    int bScared = FALSE;
    int bAutoFlee = FALSE;

    float fSelfRating = GetChallengeRating(oSelf),
          fTargetRating = GetChallengeRating(oTarget);

    if (!GetIsObjectValid(oSelf) || !GetIsObjectValid(oTarget)) //RT.5.2.5
        return FALSE;

    // Take into account creatures in a pack.
    // Just add +1 EL for each creature in the pack.
    // Only applies to carnivores
    // RT.5.4
    if (RT_IsPackCreature(oSelf) && GetIsCarnivore(oSelf))
    {
        float fELBasedOnPack = IntToFloat(RT_GetPackSize(oSelf)) * 1.0;
        fSelfRating = fELBasedOnPack + fSelfRating;
    }

    // RT.5.4
    // Morale values have some effect on whether a creature will fear another.
    // If the creature has less than optimal hps they will no longer fight but always flee.
    int nMoraleType = RT_GetMoraleType(oSelf);
    switch (nMoraleType)
    {
        case 3:
        {
            if (GetCurrentHitPoints(oSelf) >=  GetMaxHitPoints(oSelf)/4)
                fSelfRating = fSelfRating + 1.5;
            else
                bAutoFlee = TRUE;
        }
        break;
        case 2:
        {
            if (GetCurrentHitPoints(oSelf) >=  GetMaxHitPoints(oSelf)/2)
                fSelfRating = fSelfRating + 1.0;
            else
                bAutoFlee = TRUE;
        }
        break;
        case 1:
        {
            if (GetCurrentHitPoints(oSelf) ==  GetMaxHitPoints(oSelf))
                fSelfRating = fSelfRating + 0.5;
            else
                bAutoFlee = TRUE;
        }
        break;
        default: break;
    }

    //animals cannot really rate a PC....they consider all PC's just as scary
    if (GetIsPC(oTarget))
        fTargetRating = fTargetRating + PC_RATING_VS_ANIMALS;

    // Animals traditionally hate undead, and avoid them. They also do not consider them food.
    // if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    //    fTargetRating = fTargetRating + UNDEAD_RATING_VS_ANIMALS;


    // RT.5.2.5 Only herbivores should not be scary. (Deer, rats, crap like that)
    if (!GetIsHerbivore(oTarget))
    {
        if (nMoraleType == MORALE_FEARLESS) //RT.4.27.4 They fear nothing.
            bScared = FALSE;
        else if( GetTag(oTarget) == GetTag(oSelf)) //RT.4.30.4 Creatures will not fear those of their own kind.
            bScared = FALSE;
        else if (bAutoFlee == TRUE)
            bScared = TRUE;
        else if(fSelfRating < fTargetRating)
            bScared = TRUE;
    }

    return bScared;
}

object GetNearestScary(object oSelf, float fRange)
//returns closest dangerous creature within perception range, or OBJECT_INVALID if no dangerous creatures are near
// bPC = scared of PC
{
    location locSelf = GetLocation(oSelf);
    float fShortestDistance = 999.9,
          fDistance;
    object oClosest;

    //select first creature in range
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRange, locSelf, TRUE, OBJECT_TYPE_CREATURE);

    // A valid target is anything that is not yourself or something like you.
    while (GetIsObjectValid(oTarget)) // RT.5.4 Start
    {
        //PrintString("Finding scary creature : Current is: " + GetTag(oTarget));
        if ((oTarget != oSelf) && (GetTag(oSelf) != GetTag(oTarget)))
            break;

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRange, locSelf, TRUE, OBJECT_TYPE_CREATURE);
    } //// RT.4.30.4 end

    //if first creature is scary, set as closest
    if(GetIsScaredOf(oSelf, oTarget))
    {
        oClosest = oTarget;
        fShortestDistance = GetDistanceBetween(oSelf, oClosest);
    }

    //cycle through all creatures in fRange, ignoring self.
    while (GetIsObjectValid(oTarget))
    {
        //select target creature
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRange, locSelf, TRUE, OBJECT_TYPE_CREATURE);

        //check to see if self is scared of target
        // The creature will not be scared of itself or creatures like it. RT.5.4
        if(GetIsScaredOf(oSelf, oTarget) && (oTarget != oSelf) && (GetTag(oSelf) != GetTag(oTarget))) // RT.4.30.4 Put in check for self.
        {
            //check distance between target and self
            fDistance = GetDistanceBetween(oSelf, oTarget);

            //if closer than previous closest, set as new closest target
            if ( fDistance < fShortestDistance )
            {
                fShortestDistance = fDistance;
                oClosest = oTarget;
            }
        }
    }
    return oClosest;
}


int GetIsCarnivore(object oTarget)
{
    if(GetLocalInt(oTarget, "ConsumerGroup")==CARNIVORE)
        return TRUE;
    else
        return FALSE;
}

int GetIsHerbivore(object oTarget)
{
    if(GetLocalInt(oTarget, "ConsumerGroup")==HERBIVORE)
        return TRUE;
    else
        return FALSE;
}

void SetConsumerGroup(object oTarget, int Group)
{
    SetLocalInt(oTarget, "ConsumerGroup", Group);
}

int GetIsEating(object oTarget)
{
    if (GetLocalInt(oTarget, "bEating"))
        return TRUE;
    else
        return FALSE;
}

void SetEating(object oTarget, int bValue)
//sets oTargets eating state to true/false
{
    SetLocalInt(oTarget, "bEating", bValue);
}

int GetIsHunting(object oTarget)
{
    if (GetLocalInt(oTarget, "bHunting"))
        return TRUE;
    else
        return FALSE;
}

void SetHunting(object oTarget, int bValue)
{
    SetLocalInt(oTarget, "bHunting", bValue);
}

float GetHunger(object oTarget)
{
    return GetLocalFloat(oTarget, "fHunger");
}

void IncreaseHunger(object oTarget, float fRate)
{
    float fNewHunger = GetLocalFloat(oTarget, "fHunger") + fRate;
    SetLocalFloat(oTarget, "fHunger", fNewHunger);
}

int GetIsHungry(object oTarget)
//returns true/false where creature has been set to hungry or not; does not check hunger level
{
    return GetLocalInt(oTarget, "bHungry");
}

void SetHunger(object oTarget, float fHunger)
//set how many grams the animal could eat at this time
{
    SetLocalFloat(oTarget, "fHunger", fHunger);
}

void SetHungry(object oTarget, int bValue)
//set if the animal is hungry enough to want to eat
{
    SetLocalInt(oTarget, "bHungry", bValue);
}

void ReduceHunger(object oTarget, float fReduce)
{
    float fNewHunger = GetLocalFloat(oTarget, "fHunger") - fReduce;

    //cannot have negative hunger
    if (fNewHunger < 0.0)
        fNewHunger = 0.0;

    SetLocalFloat(oTarget, "fHunger", fNewHunger);
}

location GetLastFoodLocation(object oTarget)
//returns location that oTarget last found food
{
    return GetLocalLocation(oTarget, "LastFoodLocation");
}

int GetDoesRememberFood(object oTarget)
//returns true if target remembers last place they got food
{
    return GetLocalInt(oTarget, "bRememberFood");
}

void SetRememberFood(object oTarget, int bValue)
{
    SetLocalInt(oTarget, "bRememberFood", bValue);
}

void LeaveAnimalTracks(object oTarget)
{
    location locTracks = GetLocation(oTarget);

    DestroyObject(CreateObject(OBJECT_TYPE_PLACEABLE, ANIMAL_TRACKS_RESREF, locTracks, TRUE), TRACKS_FADE_TIME);
}

float GetFoodOnAnimal(object oAnimal)
//returns the initial amount of edible mass on a creature
{
    float fFood;

    switch(GetCreatureSize(oAnimal))
    {
        case CREATURE_SIZE_TINY :
            fFood = TINY_CREATURE_MASS;
            break;
        case CREATURE_SIZE_SMALL :
            fFood = SMALL_CREATURE_MASS;
            break;
        case CREATURE_SIZE_MEDIUM :
            fFood = MEDIUM_CREATURE_MASS;
            break;
        case CREATURE_SIZE_LARGE :
            fFood = LARGE_CREATURE_MASS;
            break;
        case CREATURE_SIZE_HUGE :
            fFood = HUGE_CREATURE_MASS;
            break;
        case CREATURE_SIZE_INVALID :
            fFood = 0.0;
    }
    return fFood;
}

void SetFoodLeft(object oCorpse, float fFoodLeft)
//sets the initial grams of food on a corpse
{
    SetLocalFloat(oCorpse, "fFoodLeft", fFoodLeft);
}

void ReduceFoodLeft(object oCorpse, float fReduce)
//remove fReduce grams of food from oCorpse
{
    float fNewAmount = GetLocalFloat(oCorpse, "fFoodLeft") - fReduce;
    SetLocalFloat(oCorpse, "fFoodLeft", fNewAmount);
}

float GetFoodLeft(object oCorpse)
//returns how many grams of food are left on the corpse
{
    return GetLocalFloat(oCorpse, "fFoodLeft");
}

float GetStarveHunger(object oTarget)
{
    float fHunger;

    switch(GetCreatureSize(oTarget))
    {
        case CREATURE_SIZE_TINY :
            fHunger = TINY_CREATURE_STARVE_HUNGER;
            break;
        case CREATURE_SIZE_SMALL :
            fHunger = SMALL_CREATURE_STARVE_HUNGER;
            break;
        case CREATURE_SIZE_MEDIUM :
            fHunger = MEDIUM_CREATURE_STARVE_HUNGER;
            break;
        case CREATURE_SIZE_LARGE :
            fHunger = LARGE_CREATURE_STARVE_HUNGER;
            break;
        case CREATURE_SIZE_HUGE :
            fHunger = HUGE_CREATURE_STARVE_HUNGER;
            break;
        case CREATURE_SIZE_INVALID :
            fHunger = 0.0;
    }
    return fHunger;
}

float GetHungerRate(object oTarget)
{
    float fRate;

    switch(GetCreatureSize(oTarget))
    {
        case CREATURE_SIZE_TINY :
            fRate = TINY_HUNGER_RATE;
            break;
        case CREATURE_SIZE_SMALL :
            fRate = SMALL_HUNGER_RATE;
            break;
        case CREATURE_SIZE_MEDIUM :
            fRate = MEDIUM_HUNGER_RATE;
            break;
        case CREATURE_SIZE_LARGE :
            fRate = LARGE_HUNGER_RATE;
            break;
        case CREATURE_SIZE_HUGE :
            fRate = HUGE_HUNGER_RATE;
            break;
        case CREATURE_SIZE_INVALID :
            fRate = 0.0;
    }
    return fRate;
}

void SetEatingFood(object oTarget, object oCorpse)
//sets the corpse/plant being eaten by Target as a local variable so that they can continue to check its food content
{
    SetLocalObject(oTarget, "oCorpse", oCorpse);
}

object GetEatingFood(object oTarget)
//returns the object of the corpse being eaten by Target
{
    return GetLocalObject(oTarget, "oCorpse");
}

void SetLastFoodLocation(object oTarget, location locFood)
{
    SetLocalLocation(oTarget, "LastFoodLocation", locFood);
}

void SetExhaustion(object oTarget, int bValue)
{
    effect eCase;

    if (bValue)
        eCase = EffectMovementSpeedDecrease( EXHAUSTION_SLOW_PERCENT );
    else
        eCase = EffectMovementSpeedIncrease( EXHAUSTION_SLOW_PERCENT );

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCase, oTarget);
}

int GetDecideToEat(object oTarget)
//returns if the target will want to eat (they must reach a certain hunger level in grams)
{
    if(GetHunger(oTarget) > GetHungerRate(oTarget)*EAT_FACTOR)
        return TRUE;
    else
        return FALSE;
}

float GetMaxPossibleSpawnHunger(object oTarget)
//highest amount of hunger that could be incurred upon spawn
{
    return GetHungerRate(oTarget)*EAT_FACTOR;
}

void ActionHuntPerceivedFood(object oSelf, object oFood)
{
    //set self to hunting (won't pick new target) for a max of HUNT_TIME
    SetLocalInt(oSelf, "bHunting", TRUE);
    DelayCommand(HUNT_TIME, SetLocalInt(oSelf, "bHunting", FALSE));
    SetEatingFood(oSelf, oFood); //record hunting object as local variable to self
    ClearAllActions();

    //if herbavore, eat plant
    if(GetIsHerbivore(oSelf))
    {
        AssignCommand(oSelf, ActionMoveToObject(oFood));
    }
    else if(GetIsCarnivore(oSelf))
    {
        if ( GetObjectType(oFood) == OBJECT_TYPE_PLACEABLE )
        {
            int nRandomDistance = 1 + Random(3);
            AssignCommand(oSelf, ActionMoveToObject(oFood, TRUE, IntToFloat(nRandomDistance)));
            //AssignCommand(oSelf, SpeakString("moving up to eat carcass"));
        }
        else
        {
            SetIsTemporaryEnemy(oFood, oSelf, TRUE, HUNT_TIME);
            AssignCommand(oSelf, ActionAttack(oFood));
        }
    }
}

void ActionGoToWhereRememberFood(object oSelf)
{
    location locLastFood;

    // SpeakString("I'm going to where I last remember food");

    //return to last food source
    locLastFood = GetLastFoodLocation(oSelf);
    ActionMoveToLocation(locLastFood, TRUE);

    //stop trying to return to last food source after given time
    DelayCommand(GIVE_UP_RETURNING_TO_LAST_FOOD, SetRememberFood(oSelf, FALSE));
}


void ActionLookForFood(object oSelf)
{
    object oTarget, oCorpse;

    //if herbivore, choose nearest plant as target
    if(GetIsHerbivore(oSelf))
        oTarget = GetNearestPlant(oSelf, PERCEPTION_RANGE_FORAGE);

    //if carnivore, choose nearest prey as target
    if (GetIsCarnivore(oSelf))
    {
        oTarget = GetNearestPrey(oSelf, PERCEPTION_RANGE_FORAGE);
    }

    if (GetIsObjectValid(oTarget))
    {
        ActionHuntPerceivedFood(oSelf, oTarget);
        // AssignCommand(oSelf, SpeakString("found food..."));
    }
    // If part of a pack then follow the pack leader, he will take us to food. Hopefully.
    // RT.5.4
    else if (RT_IsMemberOfPack(oSelf) && !RT_IsLeaderOfPack(oSelf))
    {
        RT_ActionFollowPackLeader(oSelf);
        //AssignCommand(oSelf, SpeakString("following my pack master to food"));
    }
    else
    {
        ActionRandomExplore(oSelf);
        //AssignCommand(oSelf, SpeakString("exploring for food"));
    }
}

void ActionDieOfStarvation(object oTarget)
{
    AssignCommand(oTarget, SpeakString("[gasp]"));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDeath(), oTarget);
}

void ReSpawn(object oCorpse)
//this respawns oCorpse at the farthest living copy within RESPAWN_SEARCH_DISTANCE
{
    object oArea = GetArea(oCorpse);
    location locSpawn = GetLocation(GetFarthestParent(oCorpse, RESPAWN_SEARCH_DISTANCE));

    CreateObject(OBJECT_TYPE_CREATURE, GetResRef(oCorpse), locSpawn );
}

object GetFarthestParent(object oSelf, float fRange)
//returns farthest creature that has the same tag that is within PERCEPTION_RANGE, or OBJECT_INVALID if none
{
    location locSelf = GetLocation(oSelf);
    float fFarthestDistance = 0.0,
          fDistance;
    object oFarthest;

    //select first creature in range
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRange, locSelf, TRUE, OBJECT_TYPE_CREATURE);

    //if first creature is same tag but diff creature
    if(GetTag(oTarget) == GetTag(oSelf) && oTarget != oSelf)
    {
        oFarthest = oTarget;
        fFarthestDistance = GetDistanceBetween(oSelf, oFarthest);
    }

    //cycle through all creatures in fRange
    while (GetIsObjectValid(oTarget))
    {
        //select target creature
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRange, locSelf, TRUE, OBJECT_TYPE_CREATURE);

        //check to see if creature is valid
        if(GetTag(oTarget) == GetTag(oSelf) && oTarget != oSelf)
        {
            //get distance between target and self
            fDistance = GetDistanceBetween(oSelf, oTarget);

            //if closer than previous closest, set as new closest target
            if ( fDistance > fFarthestDistance )
            {
                fFarthestDistance = fDistance;
                oFarthest = oTarget;
            }
        }
    }
    return oFarthest;
}

void ActionEat(object oSelf, object oFood)
{
    float fFoodLeft = GetFoodLeft(oFood),
          fMaxEat = GetHungerRate(oSelf) * EAT_FACTOR;

    vector vFood = GetPosition(oFood);

    //move closer to food
    ClearAllActions();
    ActionMoveToObject(oFood, TRUE, 1.0);
    SetFacingPoint(vFood);

    SetEatingFood(oSelf, oFood);
    SetEating(oSelf, TRUE);
    SetHunting(oSelf, FALSE);
    SetLastFoodLocation(oSelf, GetLocation(oSelf));
    SetRememberFood(oSelf, TRUE);
    SetExhaustion(oSelf, FALSE);

    AssignCommand(oSelf, SpeakString("[munch, munch]"));

    //may not eat more food than is available on corpse - herbivores dont have this problem
    if (!GetIsHerbivore(oSelf)) {
        if(fMaxEat > fFoodLeft)
            fMaxEat = fFoodLeft;
        ReduceFoodLeft(oFood, fMaxEat);
    }

    ReduceHunger(oSelf, fMaxEat);

    // AssignCommand(oSelf, SpeakString("hunger: "+FloatToString(GetHunger(oSelf)) + ", food left: " + FloatToString(GetFoodLeft(oFood))   ));
    // AssignCommand(oSelf, SpeakString("food left: " + FloatToString(GetFoodLeft(oFood)) ));

    //if food is corpse (carnivore), and size is medium or larger, and food is expended, leave bones
    if(GetIsCarnivore(oSelf) && GetFoodLeft(oFood) <= 0.0) {
        if(GetCreatureSize(oFood) >= CREATURE_SIZE_MEDIUM)
            DelayCommand(3.0, DestroyObject(oFood));
        else{
            DelayCommand(3.0, DestroyObject(oFood));
        }
    }

    //set to not eating if no longer hungry or no food left on source
    if( GetHunger(oSelf) <= 0.0 || GetFoodLeft(oFood) <= 0.0)
    {
        DelayCommand(3.0, SetEating(oSelf, FALSE));
        DelayCommand(3.0, SetHungry(oSelf, FALSE));
        DelayCommand(3.0, SetEatingFood(oSelf, OBJECT_INVALID));
    }
    // Cause the creature to back away from the corpse of the prey.
    // This should take care of stalling problems with lots of things eating the
    // same corpse. RT.5.4
    AssignCommand(oSelf, ActionMoveAwayFromLocation(GetLocation(oSelf), FALSE, 6.0));
}

int GetShouldEatCorpse(object oSelf, object oFood)
//if hungry carnivore that has reached a corpse
{
    if(GetIsCarnivore(oSelf) && GetIsHungry(oSelf) && GetIsObjectValid(oFood) /*&& GetIsDead(oFood)*/ && (GetFoodLeft(oFood) > 0.0) && (GetDistanceBetween(oSelf, oFood) <= MIN_EAT_DIST))
        return TRUE;
    else
        return FALSE;
}

int GetShouldEatPlant(object oSelf, object oFood)
//if hungry herbivore that has reached a plant
{
    if (GetIsHerbivore(oSelf) && GetIsHungry(oSelf) && GetIsObjectValid(oFood) && (GetDistanceBetween(oSelf, oFood) <= MIN_EAT_DIST))
        return TRUE;
    else
        return FALSE;
}

// Pack mentality code. RT.5.4
// This function will be called if the current leader dies or is replaced. All
// of the creatures in the pack formally will now follow the new leader.
void RT_ReformPack(object oAlpha)
{
    int nRacialType = GetRacialType(oAlpha);

    int nCount = 1;
    object oNextCreature = GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, nRacialType, oAlpha, nCount);
    while ( GetIsObjectValid(oNextCreature) && (nCount < PACK_MAX_SIZE) )
    {
        // Get a new creature each time through.
        nCount++;

        // Animals have trouble with this as its a broad race, do a check to see if its an animal.
        if (nRacialType == RACIAL_TYPE_ANIMAL)
            // If the creature has the same tag its able to join the pack.
            if ( GetTag(oAlpha) == GetTag(oNextCreature) )
                // Set the current creatures pack leader.
                RT_SetMyPackLeader(oAlpha, oNextCreature);
        // Any other type of pack creature.
        else
            RT_SetMyPackLeader(oAlpha, oNextCreature);

        // Get the nearest creature of the same race.
        oNextCreature = GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, nRacialType, oAlpha, nCount);
    }
}

// This function will be used to determine the alpha male of the pack when it is formed or a new member
// is added. If a new member is added and they're a bigger badder version then the current leader will step down.
// Each creature will store the object variable of their leader on them and attempt to stay within a certain distance
// of the leader.
//
object RT_DetermineAlphaMale(object oNewCreature, object oCurrent)
{
    object oAlphaCreature;

    if ( (GetHitDice(oNewCreature) > GetHitDice(oCurrent))                  ||
         (GetMaxHitPoints(oNewCreature) > GetMaxHitPoints(oCurrent))        ||
         (GetCurrentHitPoints(oNewCreature) > GetCurrentHitPoints(oCurrent)) )
        oAlphaCreature = oNewCreature;
    else
        oAlphaCreature = oCurrent;

    return oAlphaCreature;
}

// This function will check the local variable on the creature and return its leader.

object RT_GetPackLeader(object oPercievedCreature)
{
    object oAlpha;

    if (RT_IsPackLeader(oPercievedCreature))
        oAlpha = oPercievedCreature;
    else
        oAlpha = GetLocalObject(oPercievedCreature, PACK_ALPHA_MALE);

    return oAlpha;
}

// Check to see if the creature is a pack type of creature.
//
int RT_IsPackCreature(object oPercievedCreature)
{
    return GetLocalInt(oPercievedCreature, PACK_CREATURE);
}

// Sets on the creature a local value that designates it as a pack animal.
//
void RT_SetPackCreature(int nValue, object oCreature)
{
    SetLocalInt(oCreature, PACK_CREATURE, nValue);
}

// This function will return the size of the pack the creature is currently a member
// of.
//
int RT_GetPackSize(object oPercievedCreature)
{
    // Get Pack leader of creature.
    object oAlpha = RT_GetPackLeader(oPercievedCreature);

    // If the creature IS the pack leader, then manage it.
    if ( RT_IsPackLeader(oPercievedCreature) )
        oAlpha = oPercievedCreature;

    return GetLocalInt(oAlpha, PACK_SIZE);;
}

// Will revoke the leadership of one creature and give it to another.
// Deletes the pack size from the old owner.
//
void RT_SwitchLeadership(object oOldAlpha, object oNewAlpha)
{
    // Store the pack size on the new Alpha male.
    SetLocalInt(oNewAlpha, PACK_SIZE, 1);
    SetLocalInt(oNewAlpha, PACK_LEADER, TRUE);

    // Reform the pack around the new leader.
    RT_ReformPack(oNewAlpha);

    // Cleanup the old Alpha male.
    DeleteLocalInt(oOldAlpha, PACK_SIZE);
    SetLocalInt(oOldAlpha, PACK_LEADER, FALSE);
}

// Sets the target current creatures Pack leader.
// Increments the pack size.
//
void RT_SetMyPackLeader(object oAlpha, object oFollower)
{
    int nValue = GetLocalInt(oAlpha, PACK_SIZE);
    nValue = nValue + 1;

    SetLocalObject(oFollower, PACK_ALPHA_MALE, oAlpha);
    SetLocalInt(oAlpha, PACK_SIZE, nValue);

    // Also go ahead and send a command to follow the leader.
    // This will keep the creatures from wandering off before the heartbeat
    // gets them.
    RT_ActionFollowPackLeader(oFollower);
}

// Decrements the pack size.
// Should be called when a creature is killed.
//
void RT_RemoveFromPack(object oTarget)
{
    if (!RT_IsPackLeader(oTarget))
    {   object oAlpha = RT_GetPackLeader(oTarget);
        int nValue = GetLocalInt(oAlpha, PACK_SIZE);
        SetLocalInt(oAlpha, PACK_SIZE, nValue--);
    }
}

// Make the creature follow its pack leader.
// Make it a random (3-10 meters) distance to make it appear realistic.
// This also takes into account any odd behavior from running into transition points.
// If the creatures get stuck and the pack leaves them they will transport to them to keep
// up.
//
void RT_ActionFollowPackLeader(object oTarget)
{
    int nRandomDistance = 3 +  Random(3);
    object oAlpha = GetLocalObject(oTarget, PACK_ALPHA_MALE);
    location lLoc = RT_GetDestination(oAlpha);
    int nRoundCount = GetLocalInt(oTarget, ObjectToString(oTarget));

    // If the creature has not moved for 30 Seconds then they are effectively stuck.
    // Transport them to their pack leader. Just use GetIsFacingWall().
    if (GetIsFacingWall(oTarget))
    {
        nRoundCount++;
        if (nRoundCount > 3) //~24 Seconds
        {
            // Jump to the master if we're stuck.
            AssignCommand(oTarget, ActionJumpToObject(oAlpha));
            // Reset the value after a transportation.
            SetLocalInt(oTarget, ObjectToString(oTarget), 0);
        }
        else
            SetLocalInt(oTarget, ObjectToString(oTarget), nRoundCount);
    }
    else
    {
        // Save the current location of the creature.
        SetLocation(oTarget);
        // Reset the count.
        SetLocalInt(oTarget, ObjectToString(oTarget), 0);
    }

    // If all in same area just save this for later use.
    // If in same area just use Move to Object.
    if (GetArea(oTarget) == GetArea(oAlpha))
    {
        SetLocalLocation(oTarget, ObjectToString(oTarget), lLoc);
        AssignCommand(oTarget, ActionMoveToObject( oAlpha, FALSE, IntToFloat(nRandomDistance)));
    }
    else if (GetArea(oTarget) != GetArea(oAlpha))
    {
        // Get last good location in this area.
        location lLastGoodLoc = GetLocalLocation(oTarget, ObjectToString(oTarget));

        // If the creature is in a location that is completely bogus then just
        // transport them to their master.
        if (GetAreaFromLocation(lLastGoodLoc) != GetArea(oTarget))
            AssignCommand(oTarget, ActionJumpToObject(oAlpha));

        // Move the creature to that location. (Area Transition)
        AssignCommand(oTarget, ActionMoveToLocation(lLastGoodLoc, TRUE));
    }
}

// Function forms two un-affiliated creatures into a single pack.
//
void RT_FormPack(object oCreatureOne, object oCreatureTwo)
{
    object oAlpha = RT_DetermineAlphaMale(oCreatureOne, oCreatureTwo);
    object oFollower;

    if (oAlpha == oCreatureOne)
      oFollower = oCreatureTwo;
    else
      oFollower = oCreatureOne;

    // Initialize the pack leader.
    AssignCommand(oAlpha, SetLocalInt(oAlpha, PACK_SIZE, 2));
    AssignCommand(oAlpha, SetLocalInt(oAlpha, PACK_LEADER, TRUE));
    SetLocalInt(oAlpha, PACK_LEADER, TRUE);

    // Add the new wolf to the group.
    RT_SetMyPackLeader(oAlpha, oFollower);
}

//This function will check to see if the calling creature is a pack leader.
//
int RT_IsPackLeader(object oTarget)
{
    return GetLocalInt(oTarget, PACK_LEADER);
}

// Is this creature the leader of a pack.
//
int RT_IsLeaderOfPack(object oTarget)
{
    if ( RT_GetPackLeader(oTarget) == oTarget )
        return TRUE;
    else
        return FALSE;
}

// Is this creature a member of a current pack.
//
int RT_IsMemberOfPack(object oTarget)
{
    int nResult = GetIsObjectValid( RT_GetPackLeader(oTarget));
    return nResult;
}

// Set the morale variables.
//
void RT_SetMoraleType(int nMoraleType)
{
    SetLocalInt(OBJECT_SELF, MORALE_TYPE, nMoraleType);
}

int RT_GetMoraleType(object oCreature)
{
    return GetLocalInt(oCreature, MORALE_TYPE);
}

// Keep track of location so pack can follow you.
//
void RT_SetDestination(object oAlpha, location locTarget)
{
    SetLocalLocation(oAlpha, ALPHA_DESTINATION, locTarget);
}

// Get the location so the pack can follow you.
//
location RT_GetDestination(object oAlpha)
{
    return GetLocalLocation(oAlpha, ALPHA_DESTINATION);
}
//RT.5.4 End Pack Mentality Code.
