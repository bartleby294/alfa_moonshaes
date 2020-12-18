#include "nw_i0_generic"
#include "j_inc_generic_ai"
#include "mrg_constants"

const int treas_mult=2;

string things_taken = "nThgs";


string GetNameString( object target)
{
  if( GetIsObjectValid( target))
    {
      if( GetIsPC( target))
        return GetName( target);
      else
        return GetTag( target);
    }
  else
    return "Invalid";
}

void TakeOffHat()
{
    object currentHat = GetItemInSlot( INVENTORY_SLOT_HEAD);
    if( GetIsObjectValid( currentHat))
        ActionDoCommand( ActionUnequipItem( currentHat));
}

/* Note this function won't take off your current hat */
void PutOnBestHat()
{
  object bestHat = OBJECT_INVALID;
  int best = 0;
  object hat = GetFirstItemInInventory( );
  while( GetIsObjectValid( hat))
    {
      if( GetBaseItemType( hat) == BASE_ITEM_HELMET)
        {
          int AC = GetGoldPieceValue( hat);
          if( AC > best)
          {
            bestHat = hat;
            best = AC;
          }
        }
        hat = GetNextItemInInventory();
    }
//    PrintString( GetNameString( OBJECT_SELF)+" putting on hat "+GetTag( bestHat));
    ActionEquipItem( bestHat, INVENTORY_SLOT_HEAD);
}

int FindAndAttackEnemy()
{
     object badGuy = jGetNearestSeenOrHeardEnemy();
       if( GetIsObjectValid( badGuy) &&
        GetArea( badGuy) == GetArea( OBJECT_SELF))
     {
//        PrintString(GetNameString( OBJECT_SELF)+" f&e enemy"+GetNameString( badGuy));
        PutOnBestHat();
        if( GetLocalInt( OBJECT_SELF, "iHide"))
        {
            ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
            DeleteLocalInt( OBJECT_SELF, "iHide");
        }
        jDetermineCombatRound( badGuy);
        return TRUE;
     }
     return FALSE;
}

int GetIsCreaturePlayable( object creature)
{
    int racialType = GetRacialType( creature);
    return racialType == RACIAL_TYPE_DWARF ||
           racialType == RACIAL_TYPE_GNOME ||
           racialType == RACIAL_TYPE_HALFELF ||
           racialType == RACIAL_TYPE_HALFLING ||
           racialType == RACIAL_TYPE_HALFORC ||
           racialType == RACIAL_TYPE_HUMAN ||
           racialType == RACIAL_TYPE_DWARF;
}
// Find a nearby particular object by tag, if any
object FindObject( string tag, float sphere_size, int objectType)
{
   object something = GetFirstObjectInShape( SHAPE_SPHERE, sphere_size,
      GetLocation( OBJECT_SELF), TRUE, objectType);
   while ( GetIsObjectValid( something) )
   {
     if( GetTag( something)==tag)
        return something;
     something = GetNextObjectInShape( SHAPE_SPHERE, sphere_size,
        GetLocation( OBJECT_SELF), TRUE, objectType);
   }
   return OBJECT_INVALID;
}
// Find a nearby item that seems to have some value
object FindLoot( float sphere_size, int goldMin)
{
   object something = GetFirstObjectInShape( SHAPE_SPHERE, sphere_size,
      GetLocation( OBJECT_SELF), TRUE, OBJECT_TYPE_ITEM);
   while ( GetIsObjectValid( something) )
   {
        if( GetTag( something) != "alfa_pc_corpse" && GetGoldPieceValue( something) >= goldMin)
            return something;
        something = GetNextObjectInShape( SHAPE_SPHERE, sphere_size,
            GetLocation( OBJECT_SELF), TRUE, OBJECT_TYPE_ITEM);
   }
   return OBJECT_INVALID;
}

// We look for an injured player or NPC
// its CurrentHitPoints * nCurMult must be less than it's MaxHitPoints * nMaxMult
// e.g.  if nCurMult is 3 and nMaxMult is one, the Hitpoints of the creature would
// have to be currently less than 1/3 of maximum in order to select that creature
//
object FindInjuredCreature( int nCurMult, int nMaxMult, float sphereSize )
{
   object something = GetFirstObjectInShape( SHAPE_SPHERE, sphereSize,
      GetLocation( OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
   while ( GetIsObjectValid( something)  )
   {
    if( !GetIsDead( something) )
    {
        int hp = GetCurrentHitPoints( something);
        if( hp < 0 || hp*nCurMult <= GetMaxHitPoints( something)*nMaxMult)
        {
            string text = "Found "+GetNameString( something)+" injured";
            PrintString(text);
            ActionDoCommand( ActionSpeakString( text, TALKVOLUME_SHOUT));
            return something;
        }
    }
     something = GetNextObjectInShape( SHAPE_SPHERE, sphereSize,
        GetLocation( OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
   }
   return OBJECT_INVALID;
}

// We look for an dead player or NPC
//
object FindDeadCreature( float sphereSize )
{
   object something = GetFirstObjectInShape( SHAPE_SPHERE, sphereSize,
      GetLocation( OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
   while ( GetIsObjectValid( something)  )
   {
    if( GetIsDead( something))
    {
        string text = "Found "+GetNameString( something)+" seemingly dead";
        PrintString(text);
        ActionDoCommand( ActionSpeakString( text, TALKVOLUME_SHOUT));
        return something;
    }
     something = GetNextObjectInShape( SHAPE_SPHERE, sphereSize,
        GetLocation( OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
   }
   return OBJECT_INVALID;
}

int GetThingsTaken( object who=OBJECT_SELF)
{
    return GetLocalInt( who, things_taken);
}

void SetItemTaken( object what)
{
    SetLocalInt( what, "!#", 1);
}

void ClearItemTaken( object what)
{
    DeleteLocalInt( what, "!#");
}

int IsItemTaken( object what)
{
    int taken = GetLocalInt( what, "!#");
//    PrintString("Checking "+GetNameString( what)+" taken = "+IntToString( taken));
    return taken;
}

void IncrementThingsTaken( object who=OBJECT_SELF)
{
    SetLocalInt( who, things_taken, GetLocalInt( who, things_taken)+1);
}

void DecrementThingsTaken( object who=OBJECT_SELF)
{
    int howmany =GetLocalInt( who, things_taken);
    if( howmany > 1)
        SetLocalInt( who, things_taken, howmany-1);
    else
        DeleteLocalInt( who, things_taken);
}

void ClearThingsTaken( object who=OBJECT_SELF)
{
    DeleteLocalInt( who, things_taken);
}

int GetHasSomethingInInventory( object something=OBJECT_SELF)
{
    return GetIsObjectValid( GetFirstItemInInventory( something)) || GetGold( something);
}

// We look for a placeable object with an inventory
//
object FindLootable( float sphereSize )
{
    location where = GetLocation( OBJECT_SELF);
   object something = GetFirstObjectInShape( SHAPE_SPHERE, sphereSize,
      where, TRUE, OBJECT_TYPE_ALL);
   string text;
   while ( GetIsObjectValid( something)  )
   {
    int oType = GetObjectType( something);
    if( // (oType == OBJECT_TYPE_CREATURE && GetIsDead( something))
     (oType == OBJECT_TYPE_PLACEABLE && GetTag( something)=="BodyBag")
     || ( oType == OBJECT_TYPE_ITEM && GetTag( something) == "BodyBag")
    && GetHasSomethingInInventory( something))
    {
        text = "Found "+GetNameString( something)+" seemingly dead with stuff";
        FloatingTextStringOnCreature( text, OBJECT_SELF);
        PrintString( GetName( OBJECT_SELF)+" "+text);
        PrintString( "GetGold = "+IntToString( GetGold( something)));
//        ActionDoCommand( ActionSpeakString( text, TALKVOLUME_SHOUT));
        return something;
    }
    else if( oType == OBJECT_TYPE_PLACEABLE && GetTag( something) == ALFA_OBJ_PC_FAKE_CORPSE_TAG )
    { // A dead player
        string sCorpseID = GetLocalString( something, ALFA_PC_CORPSE_ID );
        text = "Found "+GetStringLeft( sCorpseID, FindSubString( sCorpseID, "_" ) )+" seemingly dead";
        WriteTimestampedLogEntry(text);
        FloatingTextStringOnCreature( text, OBJECT_SELF);
        return something;
    }

     something = GetNextObjectInShape( SHAPE_SPHERE, sphereSize,
        where, TRUE, OBJECT_TYPE_ALL);
   }
   return OBJECT_INVALID;
}

void RunAwayFromCreature( object what)
{
     if( GetIsObjectValid( what))
    {
       int oType= GetObjectType( what);
       if( GetIsPC( what) || (oType == OBJECT_TYPE_CREATURE && !GetIsFriend( what)))
       {
          ClearAllActions();
          ActionMoveAwayFromObject( what, TRUE);
        }
    }
}
// the current object context takes what from who
void TakeOneItem( object what, object who)
{
    object new = OBJECT_INVALID;
    if( !GetIsObjectValid( who) || !GetIsObjectValid( what) || !GetDroppableFlag( what)) return;
    int bType = GetBaseItemType( what);
    if( bType == BASE_ITEM_CPIERCWEAPON || bType == BASE_ITEM_CSLASHWEAPON || bType == BASE_ITEM_CSLSHPRCWEAP || bType == BASE_ITEM_CREATUREITEM) return;
    PrintString( GetName(OBJECT_SELF)+" taking "+GetName( what));
    if( bType == BASE_ITEM_GOLD)
    {
        int howMuch =  GetNumStackedItems( what);
        PrintString("Gold:"+IntToString( howMuch));
        GiveGoldToCreature( OBJECT_SELF, howMuch );
    }
    else
    {
        new = CopyObject( what, GetLocation( OBJECT_SELF), OBJECT_SELF);
        SetItemTaken( new);
        IncrementThingsTaken();
    }
    DestroyObject( what);
    PrintString( "The size of the stack was "+IntToString( GetNumStackedItems( what)));
}

void GiveOneItem( object what, object who)
{
    if( !GetIsObjectValid( who) || !GetIsObjectValid( what) || !GetDroppableFlag( what)) return;
    int bType = GetBaseItemType( what);
    if( bType == BASE_ITEM_CPIERCWEAPON || bType == BASE_ITEM_CSLASHWEAPON || bType == BASE_ITEM_CSLSHPRCWEAP || bType == BASE_ITEM_CREATUREITEM) return;
    PrintString( GetName(OBJECT_SELF)+" giving "+GetName( what));
    ClearItemTaken( what);
    object new = CopyObject( what, GetLocation( who), who);
//    ActionDoCommand( ActionGiveItem(what, who));
    DestroyObject( what);
    DecrementThingsTaken();
}

int CountThingsInInventory( object target=OBJECT_SELF)
{
    int i = 0;
    object what = GetFirstItemInInventory( target);
    while( GetIsObjectValid( what))
    {
        i++;
        what = GetNextItemInInventory( target);
    }
    return i;
}

object ChooseRandomThing( object target=OBJECT_SELF)
{
    int i = Random( CountThingsInInventory( target))+1;
    int j = 0;
    object what = GetFirstItemInInventory( target);
    while( GetIsObjectValid( what) && (j++ < i))
        what = GetNextItemInInventory( target);

//    PrintString("CRT "+GetNameString( what));
    return what;
}

//    TakeOneItem( ChooseRandomThing( target), target);

void TakeRandomThingFromBody( object target)
{
    int roll = d100();
    object what = GetFirstItemInInventory( target);
    if( roll < 52) // take something from inventory
    {
        int i = Random( CountThingsInInventory( target))+1;
        int j = 0;
        while( GetIsObjectValid( what) && ++j < i)
            what = GetNextItemInInventory( target);
        TakeOneItem( what, target);

    } else if( roll < 55){
        TakeOneItem( GetItemInSlot( INVENTORY_SLOT_ARMS, target), target);
    } else if( roll < 58){

    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_ARROWS, target), target);
    } else if( roll < 61){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_BELT, target), target);
    } else if( roll < 63){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_BOLTS, target), target);
    } else if( roll < 66){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_BOOTS, target), target);
    } else if( roll < 69){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_BULLETS, target), target);
    } else if( roll < 72){
//    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_CARMOUR, target), target);
//    } else if( roll < 75){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_CHEST, target), target);
    } else if( roll < 78){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_CLOAK, target), target);
    } else if( roll < 81){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_HEAD, target), target);
    } else if( roll < 84){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_LEFTHAND, target), target);
    } else if( roll < 87){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_LEFTRING, target), target);
    } else if( roll < 90){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_NECK, target), target);
    } else if( roll < 93){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_RIGHTHAND, target), target);
    } else if( roll < 96){
    TakeOneItem( GetItemInSlot( INVENTORY_SLOT_RIGHTRING, target), target);
    }
    else
    TakeGoldFromCreature( GetGold(target), target);

}
// Object in whose context this is executed
// will take all non-equipped items from target
void StripInventory( object target)
{
//    PrintString("Stripping inventory from "+GetNameString( target));
    object what = GetFirstItemInInventory( target);
    while( GetIsObjectValid( what))
    {
        TakeOneItem( what, target);
        what = GetNextItemInInventory( target);
    }
}

void slDestroyInventory( object target=OBJECT_SELF)
{
    object what = GetFirstItemInInventory( target);
    while( GetIsObjectValid( what))
    {
        if( GetHasInventory( what))
            slDestroyInventory( what);
        else
            DestroyObject( what);
        what = GetNextItemInInventory( target);
    }
}

int GetGoldValueOfInventory( object target)
{
    object what = GetFirstItemInInventory( target);
    int g = 0;
    while( GetIsObjectValid( what))
    {
        g += GetGoldPieceValue( what);
        what = GetNextItemInInventory( target);
    }
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_ARMS, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_ARROWS, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_BELT, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_BOLTS, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_BOOTS, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_BULLETS, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_CARMOUR, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_CHEST, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_CLOAK, target));
//    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_CWEAPON_B, target);
//    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_CWEAPON_L, target);
//    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_CWEAPON_R, target);
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_HEAD, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_LEFTHAND, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_LEFTRING, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_NECK, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_RIGHTHAND, target));
    g += GetGoldPieceValue( GetItemInSlot( INVENTORY_SLOT_RIGHTRING, target));
    return g;
}
// Object in whose context this is executed will
// move source's inventory to target
void MoveInventory( object source, int takenOnly = FALSE, object target=OBJECT_SELF)
{
    PrintString("Moving inventory from "+GetTag( source)+" to "+GetTag( target)+" taken:"+IntToString(takenOnly));
    object what = GetFirstItemInInventory( source);
    while( GetIsObjectValid( what) && (!takenOnly || IsItemTaken(what)))
    {
        if( GetTag( what) == "NW_IT_GOLD001" || GetBaseItemType( what) == BASE_ITEM_GOLD)
        {
            int howmuch =GetItemStackSize(what);
            PrintString("There was "+IntToString(howmuch)+" gold");
            GiveGoldToCreature( target, howmuch);
            DestroyObject( what);
        }
        else
        {
            TakeOneItem( what, source);
            if( target != OBJECT_SELF)
                GiveOneItem( what, target);
        }
        what = GetNextItemInInventory( source);
    }
    int type = GetObjectType( source);
    if( type == OBJECT_TYPE_CREATURE)
    {
        int gold = GetGold( source);
        ActionDoCommand( TakeGoldFromCreature( gold, source, FALSE));
        if( target != OBJECT_SELF)
           ActionDoCommand( GiveGoldToCreature( target, gold));
    }
}

// Object in whose context this is executed will
// Take all of target's inventory including equipped items
// and gold
void Strip( object target)
{

   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_ARMS, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_ARROWS, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_BELT, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_BOLTS, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_BOOTS, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_BULLETS, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_CHEST, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_CLOAK, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_HEAD, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_LEFTRING, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_NECK, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, target), target);
   TakeOneItem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, target), target);
   StripInventory( target);
   TakeGoldFromCreature( GetGold(target), target);

}

// Object in whose context this is executed will
// Take one equipped item
void TakeOneEquippedItem( object target)
{

    int roll = Random(14)+1;
   switch( roll)
   {
    case 1:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_ARMS, target), target);
       break;
   case 2:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_ARROWS, target), target);
       break;
   case 3:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_BELT, target), target);
       break;
   case 4:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_BOLTS, target), target);
       break;
   case 5:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_BOOTS, target), target);
       break;
   case 6:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_BULLETS, target), target);
       break;
   case 7:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_CHEST, target), target);
       break;
   case 8:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_CLOAK, target), target);
       break;
   case 9:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_HEAD, target), target);
       break;
   case 10:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, target), target);
       break;
   case 11:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_LEFTRING, target), target);
       break;
   case 12:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_NECK, target), target);
       break;
   case 13:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, target), target);
       break;
   case 14:
       TakeOneItem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, target), target);
       break;
   }
}

// Find some random creature within the sphere and select
// it if a d100() roll is less than probOutOf100
//
object FindRandomCreature( float sphereSize, int probOutOf100)
{
   object something = GetFirstObjectInShape( SHAPE_SPHERE, sphereSize,
      GetLocation( OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
   while ( GetIsObjectValid( something)  )
   {
     if( d100() <= probOutOf100)
        return something;
     something = GetNextObjectInShape( SHAPE_SPHERE, sphereSize,
        GetLocation( OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
   }
   return OBJECT_INVALID;
}


// Find first object in source's inventory with a tag that
// starts with startTag
// returns object invalid if no such tag
object GetObjectWithTagLike( object source, string startTag)
{
    object what = GetFirstItemInInventory( source);
    while( GetIsObjectValid( what))
    {
        if( FindSubString( GetTag( what), startTag) == 0)
            return what;
        what = GetNextItemInInventory( source);
    }
    return what;
}

int ItemIsNonRangedWeapon( object item)
{
    int iType =GetBaseItemType( item);
    return( iType == BASE_ITEM_BASTARDSWORD ||
        iType == BASE_ITEM_BATTLEAXE ||
        iType == BASE_ITEM_CLUB ||
        iType == BASE_ITEM_DAGGER ||
        iType == BASE_ITEM_DIREMACE ||
        iType == BASE_ITEM_DOUBLEAXE ||
        iType == BASE_ITEM_GREATAXE ||
        iType == BASE_ITEM_GREATSWORD ||
        iType == BASE_ITEM_HALBERD ||
        iType == BASE_ITEM_HANDAXE ||
        iType == BASE_ITEM_HEAVYFLAIL ||
        iType == BASE_ITEM_KAMA ||
        iType == BASE_ITEM_KATANA ||
        iType == BASE_ITEM_KUKRI ||
        iType == BASE_ITEM_LIGHTHAMMER ||
        iType == BASE_ITEM_LIGHTFLAIL ||
        iType == BASE_ITEM_LIGHTMACE ||
        iType == BASE_ITEM_LONGSWORD ||
        iType == BASE_ITEM_MORNINGSTAR ||
        iType == BASE_ITEM_RAPIER ||
        iType == BASE_ITEM_SCIMITAR ||
        iType == BASE_ITEM_SCYTHE ||
        iType == BASE_ITEM_SHORTSPEAR ||
        iType == BASE_ITEM_SHORTSWORD ||
        iType == BASE_ITEM_SICKLE ||
        iType == BASE_ITEM_TWOBLADEDSWORD ||
        iType == BASE_ITEM_WARHAMMER);
}

int spellCost( int sType, object oTarget)// sType is the listen string match number
{
    int spellToCast;
    int cost;
    int level = GetCharacterLevel( oTarget);
    switch( sType)
    {
        case 67:
            spellToCast = SPELL_CURE_LIGHT_WOUNDS;
            cost = 12;
            break;
        case 68:
            spellToCast = SPELL_CURE_MODERATE_WOUNDS;
            cost = 24;
            break;
        case 69:
            spellToCast = SPELL_CURE_SERIOUS_WOUNDS;
            cost = 48;
            break;
        case 70:
            spellToCast = SPELL_CURE_CRITICAL_WOUNDS;
            cost = 96;
            break;
        case 71:
            spellToCast = SPELL_REMOVE_CURSE;
            cost = (level-1)*100;
            if( level == 1)
                cost = 10;
            break;
        case 72:
            spellToCast = SPELL_REMOVE_DISEASE;
            cost = (level-1)*60;
            if( level == 1)
                cost = 10;
            break;
        case 73:
            spellToCast = SPELL_REMOVE_BLINDNESS_AND_DEAFNESS;
            cost = (level-1)*30;
            if( level == 1)
                cost = 10;
            break;
        case 74:
            spellToCast = SPELL_HEAL;
            cost = (level-1)*160;
            if( level == 1)
                cost = 50;
            break;
        case 75:
            spellToCast = SPELL_NEUTRALIZE_POISON;
            cost = (level-1)*30;
            if( level == 1)
                cost = 10;
            break;

    }
    SetLocalInt( oTarget, "s.TC" , spellToCast);
    SetLocalInt( oTarget, "s.Cst", cost);
    return cost;
}
// I will put the most cheapest one I own into target
void ThinInventoryCheapest( object target, object source=OBJECT_SELF)
{
    object cheapest = OBJECT_INVALID;
    int value = 100000000;
    if(  GetHasInventory( source))
    {
        object this = GetFirstItemInInventory( source);
        while( GetIsObjectValid( this))
        {
            int ggpv =   GetGoldPieceValue( this);
            if(  ggpv < value && GetDroppableFlag( this))
            {
                cheapest = this;
                value =ggpv;
            }
            this = GetNextItemInInventory( source);
        }
        if( GetIsObjectValid( cheapest))
        {
            GiveOneItem( cheapest, target);
        }
    }
}
// I will put the most expensive one I own into target
void ThinInventoryGrandest( object target, object source=OBJECT_SELF)
{
    object grandest = OBJECT_INVALID;
    int value = 0;
    if( GetHasInventory( source))
    {
        object this = GetFirstItemInInventory( source);
        while( GetIsObjectValid( this))
        {
            int ggpv =   GetGoldPieceValue( this);
            if(  ggpv >= value && GetDroppableFlag( this))
            {
                grandest = this;
                value =ggpv;
            }
            this = GetNextItemInInventory( source);
        }
        if( GetIsObjectValid( grandest))
        {
            GiveOneItem( grandest, target);
        }
    }
}

// Destroy things in my inventory with a low gold piece value
void ThinInventoryValue( int minValue)
{
    object this = GetFirstItemInInventory();
    while( GetIsObjectValid( this))
    {
        int ggpv =   GetGoldPieceValue( this);
        if(  ggpv < minValue && !(GetDroppableFlag( this)||GetPlotFlag( this)))
            DestroyObject( this);
        this = GetNextItemInInventory();
    }
}
int GetIsMagical(object oItem) {

    int iProperty;

    for ( iProperty = ITEM_PROPERTY_ABILITY_BONUS; iProperty <= ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL; iProperty ++ ) {
        if ( GetItemHasItemProperty(oItem,iProperty) ) return TRUE;
    }

    return FALSE;
}

// Possibly Identify everything in my inventory
void IdInventory( int chance=100 )
{
    object this = GetFirstItemInInventory();
    while( GetIsObjectValid( this))
    {
        if( GetGoldPieceValue( this) < 100 ||
        (!GetIdentified( this) && GetIsMagical( this) && d100() <= chance))
            SetIdentified( this, TRUE);
        this = GetNextItemInInventory();
    }
}

// Possibly UnIdentify everything in my inventory
void UnIdInventory( int minValue=500 )
{
    object this = GetFirstItemInInventory();
    while( GetIsObjectValid( this))
    {
        if( GetIdentified( this) && GetIsMagical( this) && GetGoldPieceValue( this) >= minValue)
            SetIdentified( this, FALSE);
        this = GetNextItemInInventory();
    }
}

void SortLoot()
{
    object what = GetFirstItemInInventory( );
    while( GetIsObjectValid( what))
    {
        int gold =GetGoldPieceValue( what);
        if( gold <= 5 )
        {
            DestroyObject( what);
        }
        else
        {
            ClearItemTaken( what);
            SetIdentified(  what, TRUE);
            if( gold < 50) gold = 0;
            else if( gold < 150) gold = 1;
            else if( gold < 500) gold = 2;
            else if( gold < 2500) gold = 3;
            else if( gold < 10000) gold = 4;
            else gold = 5;

            if( GetPlotFlag( what)) gold = 5;
//            PrintString( GetNameString( what)+" value: "+IntToString(gold));

            // Sort the loot into the merchant from 0 to 5
            PrintString("Putting "+GetNameString( what)+" into chest "+IntToString( gold));
            GiveOneItem( what, GetObjectByTag( "LootChest"+IntToString( gold)));
        }
        what = GetNextItemInInventory();
    }
}

int CanHaveTreasure( int classType)
{
    return( classType != CLASS_TYPE_ANIMAL &&
            classType != CLASS_TYPE_BEAST &&
            classType != CLASS_TYPE_CONSTRUCT &&
            classType != CLASS_TYPE_MAGICAL_BEAST &&
            classType != CLASS_TYPE_MONSTROUS &&
            classType != CLASS_TYPE_VERMIN);
}

void MakeTreasure( object recip=OBJECT_SELF, float CR=0.0)
{
    int cType1 =  GetClassByPosition( 1, recip) ;
    int cType2 =   GetClassByPosition( 2, recip);
    int cType3 = GetClassByPosition( 3, recip);
    object thing;
    object newThing;
    float cR = CR;
    int numThings=Random(1);
    int numMade = 0;
    int cNum = 0;
    int cnn;
    object merc = OBJECT_INVALID;
    object chest =  OBJECT_INVALID;
    int numC  ;

    if( !GetIsDM( recip))
    {
        if( GetLocalInt( recip, ".t!")) return; // Already made treasure

//        PrintString("GenTreas for "+GetName( recip));
        if( !CanHaveTreasure( cType1) || !CanHaveTreasure( cType2) || !CanHaveTreasure( cType3))
            return;
    }
//    PrintString("getting...");
    if( CR == 0.0) cR = GetChallengeRating( recip);


    if( cR >= 3.0 && cR < 6.0)
    {
        cNum = 1;
        numThings = Random(3);
    }
    else if( cR >= 6.0 && cR < 9.0)
    {
        cNum = 2;
        numThings = Random(4);
    }
    else if( cR >= 9.0 && cR < 12.0)
    {
        cNum = 3;
        numThings = Random(5);
    }
    else if( cR >=12.0  && cR < 15.0)
    {
        cNum = 4;
        numThings = Random(6);
    }
    else if ( cR >= 15.0)
    {
        cNum = 5;
        numThings = Random(6);
    }
    numThings = numThings* treas_mult;

    if( numThings > 0)
    {

        PrintString("cR = "+FloatToString( cR)+" num things "+IntToString( numThings));
        numC = CountThingsInInventory( chest);
        if( cType1 == CLASS_TYPE_COMMONER || cType2 == CLASS_TYPE_COMMONER || cType3 == CLASS_TYPE_COMMONER)
            numThings = Random(1);  // Commoners MAYBE get 1 thing
        while( numMade < numThings)
        {
            cnn = Random( cNum+1);
            merc = GetObjectByTag("LootMerc"+IntToString( cnn));
            chest =  GetObjectByTag("LootChest"+IntToString( cnn));
            if( !GetIsObjectValid( merc) && !GetIsObjectValid( chest))
            {
                PrintString("Merc & Chest invalid");
                return;
            }
            if( numC > 0 && d4() == 1)
            {
                thing = OBJECT_INVALID;
                if( d4() == 1 && numC > 0)
                {
                    thing = ChooseRandomThing( chest);
                    if( GetIsObjectValid( thing))
                    {
                        numC--;
                        newThing =CopyObject( thing, GetLocation( recip), recip);
                        PrintString("From Chest "+GetNameString( newThing)) ;
                        DestroyObject( thing);
                    }
                }
            }
            else
            {
               thing = ChooseRandomThing( merc);
//               PrintString("Chose a "+GetNameString( thing));
               newThing= CopyObject( thing, GetLocation( recip), recip);
            }

            numMade++;
        }
    }
    numC = Random( FloatToInt( pow( 10.0, cNum*0.5)*5.0));
    if( numC > 0)
    {
//        thing = CreateItemOnObject( "nw_it_gold001", recip,  numC);
        GiveGoldToCreature( recip, numC);
//        PrintString("Created "+IntToString( numC)+" gold");
    }
    SetLocalInt( recip, ".t!", 1) ; // Note that treasure was already made

    if( GetObjectType(recip) == OBJECT_TYPE_CREATURE)// Take advantage of new stuff
    {
        if( d100()<=50)
            AssignCommand( recip, ActionEquipMostDamagingRanged());
        else
            AssignCommand( recip, ActionEquipMostDamagingMelee());
        AssignCommand( recip, ActionEquipMostEffectiveArmor());
        PutOnBestHat();
    }
}
// return the current time as a number of seconds since midnight
int GetCurrentTimeSeconds()
{
    return (GetTimeHour()*24)+(GetTimeMinute()*60)+GetTimeSecond();
}

void MoveDirection( float direction, float distance=5.0, int run=TRUE, object what=OBJECT_SELF)
{
    vector v = GetPosition( what);
//                PrintString("Old Loc = "+FloatToString( v.x, 9,2)+":"+FloatToString( v.y, 9,2));
    v.x += distance*cos(direction);
    v.y += distance*sin(direction);
//                PrintString("New Loc = "+FloatToString( v.x, 9,2)+":"+FloatToString( v.y, 9,2));
     location newLoc = Location( GetArea( what), v, direction);
    AssignCommand( what, ActionMoveToLocation( newLoc, run));
}

void MoveRandomDirection( float distance=5.0, int run=TRUE, object what=OBJECT_SELF)
{
    MoveDirection(  IntToFloat( 359), distance, run, what);
}

// Send signal to every object int the area whose type ORs with 'types'
// I believe the OBJECT_TYPE ints are bit flags
void SignalObjectsInArea( object area, int types, int signal)
{
    object thing = GetFirstObjectInArea( area);
    while (GetIsObjectValid (thing))
    {
        int type = GetObjectType( thing);
        if(  (type&types)!= 0 )
            SignalEvent( thing, EventUserDefined( signal));
        thing = GetNextObjectInArea( area);
    }
}

void SaveSpawn( string spawn_name, object target=OBJECT_SELF)
{
    SetLocalString( target, ".spawn", spawn_name);
}

void ExecuteSpawn( object target=OBJECT_SELF)
{
    string spawn=GetLocalString( target, ".spawn");
    if( GetStringLength( spawn) > 0)
    {
        PrintString( GetNameString( target)+" executing "+spawn);
        ExecuteScript( spawn, target);
    }
    else
    {
        PrintString( GetNameString( target)+" has no .spawn");
    }
}

object FindAreaObjectByTag( string tag, object area)
{
    object thing = GetFirstObjectInArea( area);
    while (GetIsObjectValid (thing))
    {
        if(GetTag( thing) == tag)
            return thing;
        thing = GetNextObjectInArea( area);
    }
    return OBJECT_INVALID;

}

