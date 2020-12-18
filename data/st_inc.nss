

// -- Spell Tracking v1.3 -- //

// -- Creslyn: greatwhitepossum@hotmail.com -- //

/******************************************************************************/
/*****************************   Constants   **********************************/
/******************************************************************************/

// Determine what method of storing tracking variables to use
// * Set to 0 and it will use the module to store variables
// * Set to 1 and it will use the item players possess with
//   the tag specified in the constant ST_VAR_STORAGE_ITEM
// * Set to 2 and it will use the creature hide item
const int ST_VAR_STORAGE = 1;

// If you want to use an item (non-drop is essential) such as
// an emote ball/rod in players inventory to store the variables
// you must specify the item's tag here
const string ST_VAR_STORAGE_ITEM = "emoteitem";

/******************************************************************************/
/***********************                           ****************************/
/***********************   Function Declarations   ****************************/
/***********************                           ****************************/
/******************************************************************************/

// Track the number of times a spell has been cast since
// the last time oCaster rested, only for player characters.
void st_SpellCast(int nSpellId, object oCaster = OBJECT_SELF);

// Reset all tracking variables and note which spells
// have been memorised for future use in determining
// if a spell has been legitimately memorised for player
// characters.
// * Only call this in the OnPlayerRest (REST_EVENTTYPE_REST_FINISHED)
//   event script.
void st_OnRestCompleted(object oCaster = OBJECT_SELF);

// Reset spell memorisations to the appropriate number
// and wipe illegal spell memorisations on player entry.
void st_SpellCheck(object oCaster = OBJECT_SELF);

// Check that oPlayer has a hide item equipped (for storing variables on)
// and if not, create one and equip it on oPlayer. Also removes polymorph,
// wildshape and shapechange effects on the player if such exist so as not
// to allow those spell/abilities hides to interfere with spell tracking
// (and to prevent an exploit with sorcerer/bard spells).
// * Only call this in the OnClientEnter event script.
// * Note: If not using creature hides to store tracking variables, you
//   can leave this function out of your OnClientEnter event script.
void st_HideCheck(object oPlayer);

// Remove any temporary hit points from a polymorph/shapechange that
// exceed oPlayer's maximum hit points. Only used in conjuction with
// using the creature hide item to store variables
void st_TempHPCheck(object oPlayer);

// Method of decrementing spells used to avoid loop errors
void st_StripLoopDecrement(object oCaster, int nID, float fDelay = 0.1);

// Method of decrementing spells used to avoid loop errors
void st_LegalLoopDecrement(object oCaster, int nID, int nCasts, float fDelay = 0.1);

// Wrapper function for getting tracking variables
int st_GetInt(object oPlayer, string sVariable);

// Wrapper function for setting tracking variables
void st_SetInt(object oPlayer, string sVariable, int nValue);

/******************************************************************************/
/**********************                             ***************************/
/**********************   Function Implementation   ***************************/
/**********************                             ***************************/
/******************************************************************************/

void st_SpellCast(int nSpellId, object oCaster = OBJECT_SELF)
{
  if(GetIsPC(oCaster) && !GetIsDM(oCaster) && !GetIsDMPossessed(oCaster))
  {
// Check that the spell was not cast from an item (stave, scroll, wand etc)
    if(!GetIsObjectValid(GetSpellCastItem()))
    {
// Increment the variable holding the number of time this spell has been cast
      string sVar = "st_NumSpellCast_"+IntToString(nSpellId)+"_";
      int nCasts = st_GetInt(oCaster,sVar) + 1;
      st_SetInt(oCaster,sVar,nCasts);
    }
  }
}

/******************************************************************************/

void st_OnRestCompleted(object oCaster = OBJECT_SELF)
{
  int nID, nSpell;
  for(nID=0;nID<641;nID++)
  {
    if((nID >= 0 && nID <= 194) || 324 || (nID >= 340 && nID <= 356)
       || (nID >= 363 && nID <= 377) || (nID >= 387 && nID <= 396)
       || (nID >= 414 && nID <= 427) || (nID >= 429 && nID <= 463)
       || nID == 485 || nID == 486 || (nID >= 512 && nID <= 549)
       || nID == 569 || (nID >= 636 && nID <= 640))
    {
// Set a spell as legally memorised
      nSpell = GetHasSpell(nID,oCaster);
      st_SetInt(oCaster,"st_SpellCastLegal_"+IntToString(nID)+"_",nSpell);
    }
// Reset the variable tracking the number of times this spell was cast to 0
    st_SetInt(oCaster,"st_NumSpellCast_"+IntToString(nID)+"_",0);
  }
}

/******************************************************************************/

void st_SpellCheck(object oCaster)
{
  if(GetIsPC(oCaster) && !GetIsDM(oCaster) && !GetIsDMPossessed(oCaster))
  {
    int nID, nSpell, nLegal, nCasts;
    for(nID=0;nID<641;nID++)
    {
      if((nID >= 0 && nID <= 194) || 324 || (nID >= 340 && nID <= 356)
         || (nID >= 363 && nID <= 377) || (nID >= 387 && nID <= 396)
         || (nID >= 414 && nID <= 427) || (nID >= 429 && nID <= 463)
         || nID == 485 || nID == 486 || (nID >= 512 && nID <= 549)
         || nID == 569 || (nID >= 636 && nID <= 640))
      {
        nSpell = GetHasSpell(nID,oCaster);
        if(nSpell)
        {
// Check if a spell was memorised legally (with resting)
          nLegal = st_GetInt(oCaster,"st_SpellCastLegal_"+IntToString(nID)+"_");
          if(nLegal)
          {
// Remove any castings of the spell already used
            nCasts = st_GetInt(oCaster,"st_NumSpellCast_"+IntToString(nID)+"_");
            st_LegalLoopDecrement(oCaster, nID, nCasts);
          }
// Spell was illegally memorised (not gained by resting)
          else
          {
// Remove all castings of that spell
            st_StripLoopDecrement(oCaster, nID);
          }
        }
      }
    }
  }
}

/******************************************************************************/

void st_HideCheck(object oPlayer)
{
// If not using hide items for variable storage, end the function here.
  if(ST_VAR_STORAGE != 2)
    return;

  if(GetIsPC(oPlayer) && !GetIsDM(oPlayer) && !GetIsDMPossessed(oPlayer))
  {
// If oPlayer does not have a creature hide equipped (ie. is a new
// player) create one and equip it on oPlayer
    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPlayer);
    if(!GetIsObjectValid(oSkin))
      AssignCommand(oPlayer,ActionEquipItem(CreateItemOnObject("x2_it_emptyskin",oPlayer),INVENTORY_SLOT_CARMOUR));
// Remove Polymorph/Shapechange/Wildshape effects as they interfere with
// the removal of cast spells.
    effect ePoly = GetFirstEffect(oPlayer);
    int nType, bValid;
    while(GetIsEffectValid(ePoly))
    {
      nType = GetEffectType(ePoly);
      if(nType == EFFECT_TYPE_POLYMORPH || nType == EFFECT_TYPE_TEMPORARY_HITPOINTS)
      {
        RemoveEffect(oPlayer,ePoly);
        bValid = TRUE;
      }
      ePoly = GetNextEffect(oPlayer);
    }
// Remove temporary hit points from a polymorph/shapechange that
// exceed oPlayer's maximum hit points.
    if(bValid)
      DelayCommand(0.8,st_TempHPCheck(oPlayer));
  }
}

/******************************************************************************/

void st_TempHPCheck(object oPlayer)
{
// Check if oPlayer's current hit points exceed his maximum hit points.
  int nHP = GetCurrentHitPoints(oPlayer);
  int nMaxHP = GetMaxHitPoints(oPlayer);
  if(nHP > nMaxHP)
  {
// If so, remove the extra hit points over oPlayer's maximum hit points.
    nHP -= nMaxHP;
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nHP),oPlayer);
  }
}

/******************************************************************************/

void st_StripLoopDecrement(object oCaster, int nID, float fDelay = 0.1)
{
  if(GetHasSpell(nID, oCaster))
  {
    DecrementRemainingSpellUses(oCaster, nID);
    DelayCommand(fDelay, st_StripLoopDecrement(oCaster, nID, fDelay));
  }
}

/******************************************************************************/

void st_LegalLoopDecrement(object oCaster, int nID, int nCasts, float fDelay = 0.1)
{
  if(GetHasSpell(nID, oCaster) && nCasts)
  {
    DecrementRemainingSpellUses(oCaster, nID);
    DelayCommand(fDelay, st_LegalLoopDecrement(oCaster, nID, --nCasts, fDelay));
  }
}

/******************************************************************************/

int st_GetInt(object oPlayer, string sVariable)
{
  object oHolder;
  int nReturn;
  switch(ST_VAR_STORAGE)
  {
    case 0: oHolder = GetModule(); break;
    case 1: oHolder = GetItemPossessedBy(oPlayer, ST_VAR_STORAGE_ITEM); break;
    case 2: oHolder = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPlayer); break;
    default: break;
  }
  if(GetIsObjectValid(oHolder))
  {
    string sVar = sVariable + GetName(oPlayer) + GetPCPlayerName(oPlayer);
    nReturn = GetLocalInt(oHolder, sVar);
  }
  return nReturn;
}

/******************************************************************************/

void st_SetInt(object oPlayer, string sVariable, int nValue)
{
  object oHolder;
  switch(ST_VAR_STORAGE)
  {
    case 0: oHolder = GetModule(); break;
    case 1: oHolder = GetItemPossessedBy(oPlayer, ST_VAR_STORAGE_ITEM); break;
    case 2: oHolder = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPlayer); break;
    default: break;
  }
  if(GetIsObjectValid(oHolder))
  {
    string sVar = sVariable + GetName(oPlayer) + GetPCPlayerName(oPlayer);
    SetLocalInt(oHolder, sVar, nValue);
  }
}

/******************************************************************************/
