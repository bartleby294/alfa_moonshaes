#include "nw_i0_2q4luskan"
#include "x0_i0_position"
#include "_btb_rand_gem"
#include "_btb_util"


void FishDropGold(int maxGP, object oPC, object oItem) {
    if(maxGP == 0) {
        return;
    }

    int gp = Random(maxGP) + 2;

    string description = "*As you start to gut the fish you find a few"
                         + " gold peices it must have mistakenly eaten.*";

    WriteTimestampedLogEntry("FISHING: " + GetName(oPC) + " found gold: "
        + " gp: " + IntToString(gp) + " from " + GetName(oItem)
        + ", tag: " + GetTag(oItem));

    DelayCommand(2.0, AssignCommand(oPC, ActionSpeakString(description)));
    DelayCommand(2.3, GiveGoldToCreature(oPC, gp));
}

void FishDrop(string description, string resRef, object oPC, object oItem) {
    if(resRef == "") {
        return;
    }

    string descriptionPart1 = "*As you start to gut the fish ";
    WriteTimestampedLogEntry("FISHING: " + GetName(oPC) + " description: "
        + description + " resref: " + resRef + " from " + GetName(oItem)
        + ", tag: " + GetTag(oItem));

    DelayCommand(2.0, AssignCommand(oPC,
        ActionSpeakString(descriptionPart1 + description +"*")));

    DelayCommand(2.3,
        CreateObjectVoid(OBJECT_TYPE_ITEM , resRef, GetLocation(oPC) , FALSE));
}

int DecideFishLoot(object oPC, object oItem) {
    int randChance = d20();
    // 1 out of 20 they find something.
    if(randChance == 20) {
        int randWhat = Random(1000);

        // Find a few coins   75%
        if(randWhat < 749) {
            FishDropGold(25, oPC, oItem);
            return TRUE;
        // Find a common gem  13%
        } else if (randWhat < 879) {
            FishDrop("a small common gem falls out of its stomach.",
                getRandomGemUnderCost(50), oPC, oItem);
            return TRUE;
        // Find a medium gem   7%
        } else if (randWhat < 949) {
            FishDrop("a gem falls out of its stomach!",
                getRandomGemUnderCost(100), oPC, oItem);
            return TRUE;
        // Find an expensive gem 3%
        } else if (randWhat < 989) {
            FishDrop("an expensive gem falls out of its stomach!",
                getRandomGemUnderCost(100), oPC, oItem);
            return TRUE;
        // Find a magic item 1%
        } else if (randWhat < 999) {
            // swimming 1x a day
            // sheild 1x a day
            // water breathing  1x day
            return TRUE;
        // DM quest 1 out of 1000 - spoiler alert!
        } else {
            // Find a dm plot key
            // Find a plot cursed item?
            // Find part of a treasure map on velum
            return TRUE;
        }
    }
    return FALSE;
}

void main()
{
   object  oPC = OBJECT_SELF;
   object oArea = GetArea(oPC);
   object oItem = GetItemActivated();
   location oItemLoc = GetItemActivatedTargetLocation();

   location oPCLoc = GetLocation(oPC);

   float oPCfacing = GetFacingFromLocation(oPCLoc)+90;
   vector oItemVec = GetPositionFromLocation(oItemLoc);

   location oItemLocFinal = Location(oArea, oItemVec, oPCfacing);

   AssignCommand(oPC, ActionSpeakString("*Cleans fish and sets up a spit.*"));
   CreateObjectVoid(OBJECT_TYPE_PLACEABLE , "_fish_placeable01", oItemLocFinal , FALSE);

   int rand2 = d100();

   if(GetTag(oItem) == "_fishing_item14")
   {
        // 1 out of 100 but only for one type of fish.
        int rand = d100(1);

        if(rand == 100)
        {
           WriteTimestampedLogEntry("FISHING: " + GetName(oPC) + " found a tin solder in a " + GetName(oItem) + ", tag: " + GetTag(oItem));
           DelayCommand(2.0, AssignCommand(oPC, ActionSpeakString("*As you start to gut the fish a small tin soldier falls out.*")));
           DelayCommand(2.3, CreateObjectVoid(OBJECT_TYPE_ITEM , "_fishing_item08", GetLocation(oPC) , FALSE));
           return;
        }
   }
   // 1 out of 50 you find a lure for any fish.
   if(rand2 == 50)
   {
       WriteTimestampedLogEntry("FISHING: " + GetName(oPC) + " found a lure in a " + GetName(oItem) + ", tag: " + GetTag(oItem));
       DelayCommand(2.0, AssignCommand(oPC, ActionSpeakString("*You notice a lure stuck in the fishes mouth.*")));
       DelayCommand(2.3, CreateObjectVoid(OBJECT_TYPE_ITEM , "_fishing_item10", GetLocation(oPC) , FALSE));
       return;
   }

    int lootFound = DecideFishLoot(oPC, oItem);
}
