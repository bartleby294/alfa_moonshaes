#include "NW_I0_GENERIC"

//Spawn in NPC's store and randomly remove non-infinite items
//Sets gold/max buy based upon current inventory
void MakeStore();

void main()
{
    SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
    SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    SetIsDestroyable( FALSE, FALSE, FALSE);

    //Check to see if there is a store left over from yesterday, and destroy.
    object oStore = GetNearestObject(OBJECT_TYPE_STORE);
    string oTag = GetTag(oStore); //Existing store if any
    string sTag = GetTag(OBJECT_SELF) + IntToString(GetCalendarDay()); //Tag plus date for today's store
    if (oTag != sTag)
    {
        if (GetDistanceToObject(oStore) < 1.0)
        {
            DestroyObject(oStore);
        }
        MakeStore();
    }
    else
    ActionSpeakString("Well, back from lunch and the store's still standin'");
}

void MakeStore()
{
   int nValue = 0;
   int nCount = 0;
   object oItem;

    //Create the base template
    ActionSpeakString("Another day, another dubloon...");
    object newStore = CreateObject(
            OBJECT_TYPE_STORE,
             GetTag(OBJECT_SELF),
             GetLocation(OBJECT_SELF),
             FALSE,
             GetTag(OBJECT_SELF) + IntToString(GetCalendarDay())
             );


   //Destroy a percentage of items from the base store
   //Default is 50%, but this may be overridden by a local int on the NPC.
   int nStockLevel = GetLocalInt(OBJECT_SELF, "StockLevel");
                     if (nStockLevel < 1) nStockLevel = 50;

        oItem = GetFirstItemInInventory( newStore );
        while(GetIsObjectValid(oItem))
        {
            if((d100() > nStockLevel) && (!GetInfiniteFlag(oItem)))
            {
                DestroyObject(oItem);
                //SpeakString("Destroying " + GetName(oItem));
            }
            else
            {
                nValue += GetGoldPieceValue(oItem);
                //SpeakString("Counting " + GetName(oItem));
                nCount++;
            }
            oItem = GetNextItemInInventory(newStore);
         }

    //Set store parameters
    //This may be changed to a dynamic property based upon the NESS tag spawning the merchant
    //By default, Store has 20% of inventory in cash, and will pay at most 5% for any item
    nValue = nValue / 5;
    SetStoreGold(newStore, nValue);
    nValue = nValue / 4;
    SetStoreMaxBuyPrice(newStore, nValue);
    SetStoreIdentifyCost(newStore, 250);

    ActionSpeakString("Well, let's see what I have in stock today...");
}
