//::///////////////////////////////////////////////
//:: RUST MONSTER SCRIPT
//:: On UserDefined Script
//:: By: El Magnifico Uno
//:://////////////////////////////////////////////
/*
    Rust Monster will -
     * Wander around and eat dropped metal objects
     * Attack people who carry metal
     * Can destroy metal weapons used to attack it
*/
//:://////////////////////////////////////////////
//:: Created On: January 5, 2003
//:: Based on excellent scripts by Lord Emil & September
//:://////////////////////////////////////////////

int IsMetalItem(object oItem);
int CarriesMetal(object oTarget);
int HoldsMetal(object oTarget);
void RustAttack(object oPC,object oItem);

void main()
{
  int nUser = GetUserDefinedEventNumber();
  int nInstant = DURATION_TYPE_INSTANT;
  object oSelf = OBJECT_SELF;
  effect eAcidExp = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
  effect eAcidLrg = EffectVisualEffect(VFX_IMP_ACID_L);

// *************************************************************
// HEARTBEAT -
// *************************************************************
  if(nUser == 1001)
  {
    ActionRandomWalk();

    int nNum = 1;
    object oThing = GetNearestObject(OBJECT_TYPE_ALL,oSelf,nNum);

    while(oThing != OBJECT_INVALID && GetDistanceToObject(oThing) < 50.0)
    {
      if ((GetObjectType(oThing) == OBJECT_TYPE_CREATURE)
       && (HoldsMetal(oThing) || CarriesMetal(oThing)))
      {
        ClearAllActions();
        ActionAttack(oThing);
        break;
      }

      if(GetObjectType(oThing) == OBJECT_TYPE_ITEM && IsMetalItem(oThing))
      {
        ClearAllActions();
        ActionMoveToObject(oThing,TRUE,1.0);
        if(GetDistanceToObject(oThing) < 1.5)
        {
          ApplyEffectAtLocation(nInstant,eAcidExp,GetLocation(oThing));
          DestroyObject(oThing);
        }
        break;
      }
      nNum++;
      oThing = GetNearestObject(OBJECT_TYPE_ALL,oSelf,nNum);
    }
  }

// *************************************************************
// PERCEIVE -
// *************************************************************
  else if(nUser == 1002)
  {
  }

// *************************************************************
// END OF COMBAT -
// *************************************************************
  else if(nUser == 1003)
  {
    int nItemSlot;
    int nHoldsMetal = FALSE;
    object oPC = GetAttackTarget();
    if(oPC == OBJECT_INVALID) oPC = GetAttemptedAttackTarget();

    if(GetDistanceToObject(oPC) < 2.5)
    {
      for(nItemSlot=0;nItemSlot<13;nItemSlot++)
      {
        object oItem = GetItemInSlot(nItemSlot,oPC);
        if(IsMetalItem(oItem))
        {
          RustAttack(oPC,oItem);
          nHoldsMetal = TRUE;
          break;
        }
      }
      if(!nHoldsMetal)
      {
        object oItem = GetFirstItemInInventory(oPC);
        while(oItem != OBJECT_INVALID)
        {
          if(IsMetalItem(oItem))
          {
            RustAttack(oPC,oItem);
            break;
          }
          oItem = GetNextItemInInventory(oPC);
        }
      }
    }
  }


// *************************************************************
// ON CONVERSATION
// *************************************************************
  else if(nUser == 1004)
  {
  }


// *************************************************************
// ON ATTACKED
// *************************************************************
  else if(nUser == 1005)
  {
  }


// *************************************************************
// ON DAMAGED -
// *************************************************************
  else if((nUser == 1006) || (nUser == 1007))
  {
    object oPC = GetLastDamager();
    object oRghtWpn = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    object oLeftWpn = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    object oWeapon;
    int nDmg;

    if(GetDamageDealtByType(DAMAGE_TYPE_SLASHING) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_SLASHING);
    if(GetDamageDealtByType(DAMAGE_TYPE_BLUDGEONING) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_BLUDGEONING);
    if(GetDamageDealtByType(DAMAGE_TYPE_PIERCING) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_PIERCING);
    if(GetDamageDealtByType(DAMAGE_TYPE_ACID) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_ACID);
    if(GetDamageDealtByType(DAMAGE_TYPE_COLD) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_COLD);
    if(GetDamageDealtByType(DAMAGE_TYPE_DIVINE) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_DIVINE);
    if(GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL);
    if(GetDamageDealtByType(DAMAGE_TYPE_FIRE) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_FIRE);
    if(GetDamageDealtByType(DAMAGE_TYPE_MAGICAL) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_MAGICAL);
    if(GetDamageDealtByType(DAMAGE_TYPE_NEGATIVE) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_NEGATIVE);
    if(GetDamageDealtByType(DAMAGE_TYPE_POSITIVE) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_POSITIVE);
    if(GetDamageDealtByType(DAMAGE_TYPE_SONIC) > 0)
      nDmg = nDmg + GetDamageDealtByType(DAMAGE_TYPE_SONIC);

    if ((GetObjectType(oLeftWpn) == BASE_ITEM_LARGESHIELD)
     || (GetObjectType(oLeftWpn) == BASE_ITEM_SMALLSHIELD)
     || (GetObjectType(oLeftWpn) == BASE_ITEM_TOWERSHIELD))
      oLeftWpn = OBJECT_INVALID;

    if ((GetDistanceToObject(oPC) < 4.0) && (nDmg < GetTotalDamageDealt())
     && (IsMetalItem(oRghtWpn) || IsMetalItem(oLeftWpn)))
    {
      if (IsMetalItem(oLeftWpn)) oWeapon = oLeftWpn;
        else oWeapon = oRghtWpn;

      string sWeapon = GetName(oWeapon);
      if(ReflexSave(oPC,20))
        SendMessageToPC(oPC,"Your "+sWeapon+" resists the rust effects.");
      else
      {
        SendMessageToPC(oPC,"Your "+sWeapon+" damages the monster, but is "
          +"destroyed in the process!");
        DestroyObject(oWeapon);
        ApplyEffectToObject(nInstant,eAcidLrg,oPC);
      }
    }
  }


// *************************************************************
// ON DEATH -
// *************************************************************
  else if(nUser == 1007)
  {
  }


// *************************************************************
// ON DISTURBED
// *************************************************************
  else if(nUser == 1008)
  {
  }

}


// *************************************************************
// IS METAL ITEM
// *************************************************************
int IsMetalItem(object oItem)
{
  switch (GetBaseItemType(oItem))
  {
    case BASE_ITEM_ARMOR: if(GetItemACValue(oItem) > 3) return TRUE;
      else return FALSE;
      break;
    case BASE_ITEM_HELMET: return TRUE; break;
    case BASE_ITEM_LARGESHIELD: return TRUE; break;
    case BASE_ITEM_SMALLSHIELD: return TRUE; break;
    case BASE_ITEM_TOWERSHIELD: return TRUE; break;

    case BASE_ITEM_AMULET: return TRUE; break;
    case BASE_ITEM_BRACER: return TRUE; break;
    case BASE_ITEM_RING: return TRUE; break;
    case BASE_ITEM_THIEVESTOOLS: return TRUE; break;
    case BASE_ITEM_TRAPKIT: return TRUE; break;

    case BASE_ITEM_BASTARDSWORD: return TRUE; break;
    case BASE_ITEM_BATTLEAXE: return TRUE; break;
    case BASE_ITEM_DART: return TRUE; break;
    case BASE_ITEM_DIREMACE: return TRUE; break;
    case BASE_ITEM_DOUBLEAXE: return TRUE; break;
    case BASE_ITEM_GREATAXE: return TRUE; break;
    case BASE_ITEM_GREATSWORD: return TRUE; break;
    case BASE_ITEM_HALBERD: return TRUE; break;
    case BASE_ITEM_HANDAXE: return TRUE; break;
    case BASE_ITEM_HEAVYCROSSBOW: return TRUE; break;
    case BASE_ITEM_HEAVYFLAIL: return TRUE; break;
    case BASE_ITEM_KAMA: return TRUE; break;
    case BASE_ITEM_KATANA: return TRUE; break;
    case BASE_ITEM_KUKRI: return TRUE; break;
    case BASE_ITEM_LIGHTCROSSBOW: return TRUE; break;
    case BASE_ITEM_LIGHTFLAIL: return TRUE; break;
    case BASE_ITEM_LIGHTHAMMER: return TRUE; break;
    case BASE_ITEM_LIGHTMACE: return TRUE; break;
    case BASE_ITEM_LONGSWORD: return TRUE; break;
    case BASE_ITEM_MORNINGSTAR: return TRUE; break;
    case BASE_ITEM_RAPIER: return TRUE; break;
    case BASE_ITEM_SCIMITAR: return TRUE; break;
    case BASE_ITEM_SCYTHE: return TRUE; break;
    case BASE_ITEM_SHORTSWORD: return TRUE; break;
    case BASE_ITEM_SHURIKEN: return TRUE; break;
    case BASE_ITEM_SICKLE: return TRUE; break;
    case BASE_ITEM_THROWINGAXE: return TRUE; break;
    case BASE_ITEM_TWOBLADEDSWORD: return TRUE; break;
    case BASE_ITEM_WARHAMMER: return TRUE; break;
  }
  return FALSE;
}


// *************************************************************
// CARRIES METAL
// *************************************************************
int CarriesMetal(object oTarget)
{
  object oItem = GetFirstItemInInventory(oTarget);
  while (oItem != OBJECT_INVALID)
  {
    if(IsMetalItem(oItem))
    {
      return TRUE;
      break;
    }
    oItem = GetNextItemInInventory(oTarget);
  }
  return FALSE;
}


// *************************************************************
// HOLDING METAL
// *************************************************************
int HoldsMetal(object oTarget)
{
  int nSlot = 0;
  object oItem = GetItemInSlot(nSlot);
  while (nSlot <= 5)
  {
    if (IsMetalItem(oItem))
    {
      return TRUE;
      break;
    }
    nSlot++;
    oItem = GetItemInSlot(nSlot);
  }
  return FALSE;
}


// *************************************************************
// RUST ATTACK
// *************************************************************
void RustAttack(object oPC,object oItem)
{
  int nInstant = DURATION_TYPE_INSTANT;
  effect eAcidExp = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
  string sName = GetName(oItem);

  if(TouchAttackMelee(oPC))
  {
    SendMessageToPC(oPC,"The Rust Monster's antennae brush against "
      +"your "+sName);
    if(ReflexSave(oPC,20))
      SendMessageToPC(oPC,"But the "+sName+" resists the rust effects!");
    else
    {
      SendMessageToPC(oPC,"And destroys your "+sName+"!");
      DestroyObject(oItem);
      ApplyEffectAtLocation(nInstant,eAcidExp,GetLocation(oPC));
    }
  }
}
