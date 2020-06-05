/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 18, 2004

        Starting Conditionals of 8 part Quest with Low intelligence.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "qst__pqj_inc"
#include "custom_tokens"
#include "NW_I0_PLOT"

int StartingConditional()
{

    string sName = GetLocalString(OBJECT_SELF, "quest_name");
    object oPC = GetPCSpeaker();
    string sGet_Item = " ";

  // Inspect local variables
  if((RetrieveQuestState(sName, oPC) == 1) && (CheckIntelligenceLow()))
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_1");
    if(!HasItem(GetPCSpeaker(), sGet_Item))
    {
        return FALSE;
    }
    else
    {
            object oGet_Item = GetObjectByTag(sGet_Item);
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
            return TRUE;
    }
  }
  else if((RetrieveQuestState(sName, oPC) == 2) && (CheckIntelligenceLow()))
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_2");
    if(!HasItem(GetPCSpeaker(), sGet_Item))
    {
        return FALSE;
    }
    else
    {
            object oGet_Item = GetObjectByTag(sGet_Item);
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
            return TRUE;
    }
  }
  else if((RetrieveQuestState(sName, oPC) == 3) && (CheckIntelligenceLow()))
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_3");
    if(!HasItem(GetPCSpeaker(), sGet_Item))
    {
        return FALSE;
    }
    else
    {
            object oGet_Item = GetObjectByTag(sGet_Item);
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
            return TRUE;
    }
  }
  else if((RetrieveQuestState(sName, oPC) == 4) && (CheckIntelligenceLow()))
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_4");
    if(!HasItem(GetPCSpeaker(), sGet_Item))
    {
        return FALSE;
    }
    else
    {
            object oGet_Item = GetObjectByTag(sGet_Item);
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
            return TRUE;
    }
  }
  else if((RetrieveQuestState(sName, oPC) == 5) && (CheckIntelligenceLow()))
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_5");
    if(!HasItem(GetPCSpeaker(), sGet_Item))
    {
        return FALSE;
    }
    else
    {
            object oGet_Item = GetObjectByTag(sGet_Item);
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
            return TRUE;
    }
  }
  else if((RetrieveQuestState(sName, oPC) == 6) && (CheckIntelligenceLow()))
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_6");
    if(!HasItem(GetPCSpeaker(), sGet_Item))
    {
        return FALSE;
    }
    else
    {
            object oGet_Item = GetObjectByTag(sGet_Item);
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
            return TRUE;
    }
  }
  else if((RetrieveQuestState(sName, oPC) == 7) && (CheckIntelligenceLow()))
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_7");
    if(!HasItem(GetPCSpeaker(), sGet_Item))
    {
        return FALSE;
    }
    else
    {
            object oGet_Item = GetObjectByTag(sGet_Item);
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
            return TRUE;
    }
  }
  else if((RetrieveQuestState(sName, oPC) == 8) && (CheckIntelligenceLow()))
  {
    sGet_Item = GetLocalString(OBJECT_SELF, "item_col_8");
    if(!HasItem(GetPCSpeaker(), sGet_Item))
    {
        return FALSE;
    }
    else
    {
            object oGet_Item = GetObjectByTag(sGet_Item);
            SetCustomToken(ITEM_WANT_NAME_1, GetName(oGet_Item));
            return TRUE;
    }
  }
  else
  {
    return FALSE;
  }
}

