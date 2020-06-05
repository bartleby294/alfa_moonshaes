/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Starting Conditionals of 8 next item to get.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "nw_i0_tool"
#include "custom_tokens"

int StartingConditional()
{

    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();
    string sGet_Item = " ";

    int iWhich_Item = RetrieveQuestState(sName, oPC);
    iWhich_Item += 1;

  // Inspect local variables
  if( iWhich_Item == 2)
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_2");
    object oGet_Item = GetObjectByTag(sGet_Item);
    if (GetBaseItemType(oGet_Item) == BASE_ITEM_SPELLSCROLL)
    {
        string sItemName = "Scroll of " + GetName(oGet_Item);
        SetCustomToken(ITEM_WANT_NAME_1, sItemName);
    }
    else
    {
        SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
    }
    return TRUE;
  }
  else if(iWhich_Item == 3)
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_3");
    object oGet_Item = GetObjectByTag(sGet_Item);
    if (GetBaseItemType(oGet_Item) == BASE_ITEM_SPELLSCROLL)
    {
        string sItemName = "Scroll of " + GetName(oGet_Item);
        SetCustomToken(ITEM_WANT_NAME_1, sItemName);
    }
    else
    {
        SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
    }
    return TRUE;
  }
  else if(iWhich_Item == 4)
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_4");
    object oGet_Item = GetObjectByTag(sGet_Item);
    if (GetBaseItemType(oGet_Item) == BASE_ITEM_SPELLSCROLL)
    {
        string sItemName = "Scroll of " + GetName(oGet_Item);
        SetCustomToken(ITEM_WANT_NAME_1, sItemName);
    }
    else
    {
        SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
    }
    return TRUE;
  }
  else if(iWhich_Item == 5)
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_5");
    object oGet_Item = GetObjectByTag(sGet_Item);
    if (GetBaseItemType(oGet_Item) == BASE_ITEM_SPELLSCROLL)
    {
        string sItemName = "Scroll of " + GetName(oGet_Item);
        SetCustomToken(ITEM_WANT_NAME_1, sItemName);
    }
    else
    {
        SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
    }
    return TRUE;
  }
  else if(iWhich_Item == 6)
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_6");
    object oGet_Item = GetObjectByTag(sGet_Item);
    if (GetBaseItemType(oGet_Item) == BASE_ITEM_SPELLSCROLL)
    {
        string sItemName = "Scroll of " + GetName(oGet_Item);
        SetCustomToken(ITEM_WANT_NAME_1, sItemName);
    }
    else
    {
        SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
    }
    return TRUE;
  }
  else if(iWhich_Item == 7)
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_7");
    object oGet_Item = GetObjectByTag(sGet_Item);
    if (GetBaseItemType(oGet_Item) == BASE_ITEM_SPELLSCROLL)
    {
        string sItemName = "Scroll of " + GetName(oGet_Item);
        SetCustomToken(ITEM_WANT_NAME_1, sItemName);
    }
    else
    {
        SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
    }
    return TRUE;
  }
  else if(iWhich_Item == 8)
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_8");
    object oGet_Item = GetObjectByTag(sGet_Item);
    if (GetBaseItemType(oGet_Item) == BASE_ITEM_SPELLSCROLL)
    {
        string sItemName = "Scroll of " + GetName(oGet_Item);
        SetCustomToken(ITEM_WANT_NAME_1, sItemName);
    }
    else
    {
        SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
    }
    return TRUE;
  }
  else
  {
    return FALSE;
  }
}

