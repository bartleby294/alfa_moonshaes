/******************************************************************
 * Name: alfa_items
 * Type: ALFA Modules Include File
 * ---
 * Author: Cereborn
 * Date: 6/01/03
 * ---
 * Contains ALFA functions for managing ALFA items.
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/


struct ItemInfo
{
  int    nNoDrop;
  int    nDMOnly;
  int    nGiveToDM;
  int    nGiveToPlayer;
  string sItemTag;
  string sActivateScript;
  string sAcquireScript;
  string sUnacquireScript;
};

//
// Do it all at once....
//
void ALFA_RegisterItem(string sItemTag, string sActivateScript="",
    string sAcquireScript="", string sUnacquireScript="", 
    int nNoDrop=FALSE, int nDMOnly=FALSE, int nGiveToDM=FALSE,
    int nGiveToPlayer=FALSE);

//
// Individual registrations
//
void ALFA_SetItemActivateScript(string sItemTag, string sActivateScript);
void ALFA_SetItemAcquireScript(string sItemTag, string sAcquireScript);
void ALFA_SetItemUnacquireScript(string sItemTag, string sUnacquireScript);
void ALFA_SetItemNoDrop(string sItemTag, int nNoDrop);
void ALFA_SetItemDMOnly(string sItemTag, int nDMOnly);
void ALFA_SetItemGiveToDM(string sItemTag, int nGiveToDM);
void ALFA_SetItemGiveToPlayer(string sItemTag, int nGiveToPlayer);

//

void ALFA_ActivateItem(object oItem);
void ALFA_AcquireItem(object oItem);
void ALFA_UnacquireItem(object oItem);
void ALFA_InvalidItem(object oItem, object oUser);

int ITEM_SCRIPT_DEBUG = FALSE;

string ITEM_INFO_VAR_SUFFIX = "ItemInfo";

struct ItemInfo ALFA_CreateItemInfo(string sItemTag)
{
  struct ItemInfo iItemInfo;

  iItemInfo.sItemTag = sItemTag;
  iItemInfo.nNoDrop = FALSE;
  iItemInfo.nDMOnly = FALSE;
  iItemInfo.nGiveToDM = FALSE;
  iItemInfo.nGiveToPlayer = FALSE;
  iItemInfo.sActivateScript = "";
  iItemInfo.sAcquireScript = "";
  iItemInfo.sUnacquireScript = "";

  return iItemInfo;
}

struct ItemInfo ALFA_LookupItemInfo(string sItemTag)
{

  struct ItemInfo iItemInfo;

  if (sItemTag == "")
  {
      if (ITEM_SCRIPT_DEBUG)
      {
        SendMessageToPC(GetFirstPC(), "Attempt to lookup NULL sItemTag");

      }
      iItemInfo.sItemTag = "";
      return iItemInfo;
  }

  // Global object values are stored on.
  object oModule = GetModule();

  // The base field name the values are stored under.
  string sTag = sItemTag + ITEM_INFO_VAR_SUFFIX + "_";

  iItemInfo.nNoDrop = GetLocalInt( oModule, sTag + "NoDrop" );
  iItemInfo.nDMOnly = GetLocalInt( oModule, sTag + "DMOnly" );
  iItemInfo.nGiveToDM = GetLocalInt( oModule, sTag + "GiveToDM" );
  iItemInfo.nGiveToPlayer = GetLocalInt( oModule, sTag + "GiveToPC" );
  iItemInfo.sItemTag = GetLocalString( oModule, sTag + "ItemTag" );
  iItemInfo.sActivateScript = GetLocalString( oModule, sTag + "Activate" );
  iItemInfo.sAcquireScript = GetLocalString( oModule, sTag + "Acquire" );
  iItemInfo.sUnacquireScript = GetLocalString( oModule, sTag + "Unacquire" );

  return iItemInfo;
}

void ALFA_SaveItemInfo(struct ItemInfo iItemInfo)
{
    if (iItemInfo.sItemTag == "")
    {
      if (ITEM_SCRIPT_DEBUG)
      {
        SendMessageToPC(GetFirstPC(), "Attempt to save empty struct ItemInfo");

      }
      return;
    }

    // Global object to store the values on.
    object oModule = GetModule();

    // The base field name to store the values under.
    string sTag = iItemInfo.sItemTag + ITEM_INFO_VAR_SUFFIX + "_";

    // Save the values from the struct.
    SetLocalInt( oModule, sTag + "NoDrop",  iItemInfo.nNoDrop );
    SetLocalInt( oModule, sTag + "DMOnly",   iItemInfo.nDMOnly );
    SetLocalInt( oModule, sTag + "GiveToDM", iItemInfo.nGiveToDM );
    SetLocalInt( oModule, sTag + "GiveToPC", iItemInfo.nGiveToPlayer );

    SetLocalString( oModule, sTag + "ItemTag",   iItemInfo.sItemTag );
    SetLocalString( oModule, sTag + "Activate",  iItemInfo.sActivateScript );
    SetLocalString( oModule, sTag + "Acquire",   iItemInfo.sAcquireScript );
    SetLocalString( oModule, sTag + "Unacquire", iItemInfo.sUnacquireScript );

}


void ALFA_RegisterItem(string sItemTag, string sActivateScript="",
    string sAcquireScript="", string sUnacquireScript="", 
    int nNoDrop=FALSE, int nDMOnly=FALSE, int nGiveToDM=FALSE,
    int nGiveToPlayer=FALSE)
{
  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);

  if (iItemInfo.sItemTag == "")
  {
      iItemInfo = ALFA_CreateItemInfo(sItemTag);
  }
  
  iItemInfo.sActivateScript = sActivateScript;
  iItemInfo.sAcquireScript = sAcquireScript;
  iItemInfo.sUnacquireScript = sUnacquireScript;
  iItemInfo.nNoDrop = nNoDrop;
  iItemInfo.nDMOnly = nDMOnly;
  iItemInfo.nGiveToDM = nGiveToDM;
  iItemInfo.nGiveToPlayer = nGiveToPlayer;

  // put onto the 'giveToPlayer' list
  if (nGiveToPlayer)
  {
  }

  // put onto the 'giveToDM' list
  if(nGiveToDM)
  {
  }

  ALFA_SaveItemInfo(iItemInfo);

}
void ALFA_SetItemActivateScript(string sItemTag, string sActivateScript)
{
  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);

  if (iItemInfo.sItemTag == "")
  {
      iItemInfo = ALFA_CreateItemInfo(sItemTag);
  }

  iItemInfo.sActivateScript = sActivateScript;
  ALFA_SaveItemInfo(iItemInfo);

}

void ALFA_SetItemAcquireScript(string sItemTag, string sAcquireScript)
{
  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);

  if (iItemInfo.sItemTag == "")
  {
      iItemInfo = ALFA_CreateItemInfo(sItemTag);
  }

  iItemInfo.sAcquireScript = sAcquireScript;
  ALFA_SaveItemInfo(iItemInfo);
}

void ALFA_SetItemUnacquireScript(string sItemTag, string sUnacquireScript)
{  
  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);

  if (iItemInfo.sItemTag == "")
  {
      iItemInfo = ALFA_CreateItemInfo(sItemTag);
  }

  iItemInfo.sUnacquireScript = sUnacquireScript;
  ALFA_SaveItemInfo(iItemInfo);
}

void ALFA_SetItemNoDrop(string sItemTag, int nNoDrop)
{  
  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);

  if (iItemInfo.sItemTag == "")
  {
      iItemInfo = ALFA_CreateItemInfo(sItemTag);
  }

  iItemInfo.nNoDrop = nNoDrop;
  ALFA_SaveItemInfo(iItemInfo);
}

void ALFA_SetItemDMOnly(string sItemTag, int nDMOnly)
{
  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);

  if (iItemInfo.sItemTag == "")
  {
      iItemInfo = ALFA_CreateItemInfo(sItemTag);
  }

  iItemInfo.nDMOnly = nDMOnly;
  ALFA_SaveItemInfo(iItemInfo);
}

void ALFA_SetItemGiveToDM(string sItemTag, int nGiveToDM)
{
  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);

  if (iItemInfo.sItemTag == "")
  {
      iItemInfo = ALFA_CreateItemInfo(sItemTag);
  }

  iItemInfo.nGiveToDM = nGiveToDM;

  // put onto the 'giveToDM' list

  ALFA_SaveItemInfo(iItemInfo);
}

void ALFA_SetItemGiveToPlayer(string sItemTag, int nGiveToPlayer)
{
  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);

  if (iItemInfo.sItemTag == "")
  {
      iItemInfo = ALFA_CreateItemInfo(sItemTag);
  }

  iItemInfo.nGiveToPlayer = nGiveToPlayer;

  // put onto the 'giveToPlayer' list

  ALFA_SaveItemInfo(iItemInfo);
}

void ALFA_ActivateItem(object oItem)
{
  string sItemTag = GetTag( oItem );
  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);
  string sScript;
  int nDMOnly;
  object oPC;

  if (iItemInfo.sItemTag != "")
  {
    sScript = iItemInfo.sActivateScript;
    nDMOnly = iItemInfo.nDMOnly;

    if (nDMOnly)
    {
      oPC = GetItemActivator();

      if ( ! GetIsDM( oPC ) )
      {
        SendMessageToPC( oPC, "This item is not for you!" );
        DestroyObject( oItem );
        return;
      }
    }

    if (sScript != "")
    {
      ExecuteScript(sScript, oItem);
      return;
    }
  }

  if (ITEM_SCRIPT_DEBUG)
  {
      object oPC = GetItemActivator();
      SendMessageToPC(oPC, "Item " + GetName(GetObjectByTag(sItemTag)) + 
         " not supported on this server.");
  }
}


void ALFA_AcquireItem(object oItem)
{
  string sItemTag = GetTag( oItem );
  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);
  string sScript;
  int nDMOnly;
  object oPC;

  if (iItemInfo.sItemTag != "")
  {
    sScript = iItemInfo.sAcquireScript;
    nDMOnly = iItemInfo.nDMOnly;

    if (nDMOnly)
    {
      oPC = GetItemPossessor(oItem);

      if ( ! GetIsDM( oPC ) )
      {
        SendMessageToPC( oPC, "This item is not for you!" );
        DestroyObject( oItem );
        return;
      }
    }

    if (sScript != "")
    {
      ExecuteScript(sScript, oItem);
      return;
    }
  }
 
  if (ITEM_SCRIPT_DEBUG)
  {
      object oPC = GetItemActivator();
      SendMessageToPC(oPC, "Item " + GetName(GetObjectByTag(sItemTag)) + 
         ": no acquire script registered");
  }
}

void ALFA_UnacquireItem(object oItem)
{
  string sItemTag = GetTag( oItem );
  if (sItemTag == "")
  {
    // Not sure why this happens, but it does.  When an NPC dies, unacquire
    // gets fired for stuff in there inventory, oItem is NOT object_invalid,
    // but tag/name/resref etc. are all NULL
    return; 
  }

  struct ItemInfo iItemInfo = ALFA_LookupItemInfo(sItemTag);
  string sScript;
  
  if (iItemInfo.sItemTag != "")
  {
    sScript = iItemInfo.sUnacquireScript;
    if (sScript != "")
    {
      ExecuteScript(sScript, oItem);
      return;
    }
  }
  
  if (ITEM_SCRIPT_DEBUG)
  {
      object oPC = GetItemActivator();
      SendMessageToPC(oPC, "Item " + GetName(oItem) + 
         ": no unacquire script registered");
  }
}

void ALFA_InvalidItem(object oItem, object oUser)
{
  string sItemName = GetName(oItem);
  SendMessageToPC(oUser, sItemName + "is not a valid ALFA item. " +
      "Please tell a DM where you got this item. " + 
      "It may be turned it for a valid replacement.");
}

