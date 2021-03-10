//:://////////////////////////////////////////////////
//:: Created By:   Valerio Santinelli - tanis@mediacom.it
//:: Created On:   2002/08/09
//:://////////////////////////////////////////////////
/*
    Persistent World DataBase functions.
    Credits to E.J. Wilburn - zane@supernova.org for the original idea.
*/

//void main(){}
#include "math_protos"
#include "hc_inc"
#include "ms_xp_util"

const string campaign="tpi";

string GetPCKey( object oPC)
{
    return GetStringLeft( GetPCPlayerName(oPC),6)+ GetStringLeft( GetName(oPC),10);
}

// Determine an Object's key.
string GetLocalKey(object oTarget, string vName)
{
    string sKey;

    if (GetIsPC(oTarget))
        sKey = GetLocalString( oTarget, ".key");
    else
        sKey = GetStringLeft( GetTag(oTarget),6)+ GetStringLeft( GetName(oTarget),10);

    return sKey+vName;
}

// Determine an Object's DB key.
string GetDBKey(object oTarget, string vName, string vType)
{
    string sKey;


    if (GetIsPC(oTarget))
        sKey = GetLocalString( oTarget, ".key");
    else
        sKey = GetStringLeft( GetTag(oTarget),6) + GetStringLeft( GetName(oTarget),10)+sKey;

    if( GetStringLength( sKey) == 0) PrintString ("Key is Zero! "+GetName( oTarget));
    sKey +=":"+vName+vType;
    if( GetStringLength( sKey) > 32) PrintString("Key "+sKey+": too long!");
    return sKey;
}
int GetIsLocationValid(location loc)
{
    object newArea = GetAreaFromLocation( loc);
    vector v = GetPositionFromLocation( loc);
    PrintString( "Area = " +GetTag( newArea)+":"+FloatToString( v.x)+":"+FloatToString( v.y)+":"+FloatToString( v.z));
    return GetIsObjectValid( newArea) && v.x != 0.0 && v.y != 0.0 ;
}

//

string GetPersistentString(object oTarget, string sName)
{
    string vkey = GetLocalKey( oTarget, sName);
    string result = GetLocalString( oTarget, vkey);
    if( GetStringLength( result) > 0)
    {
//        PrintString("GPStr "+sName+" was found local = "+result);
        return result;
    }
    result =  GetDBKey( oTarget, sName, "_S");
//    PrintString("SSearching "+result);

    if (GetIsPC(oTarget))
        result= GetCampaignString( campaign, result, oTarget);
    else
        result= GetCampaignString(campaign, result);
//    PrintString("GPStr campaign "+result);

    SetLocalString( oTarget, vkey, result);
    return result;
}

int GetPersistentInt(object oTarget, string sName)
{
    string vkey = GetLocalKey( oTarget, sName);
    int result = GetLocalInt( oTarget, vkey);
    if( result != 0)
    {
//        PrintString("GPInt "+sName+" was found local = "+IntToString( result));
        return result;
    }

    string dbkey =  GetDBKey( oTarget, sName, "_I");
//    PrintString("ISearching "+dbkey);

    if (GetIsPC(oTarget))
        result= GetCampaignInt( campaign, dbkey, oTarget);
    else
        result= GetCampaignInt(campaign, dbkey);

//    PrintString("GPInt campaign "+IntToString( result));

    SetLocalInt( oTarget, vkey, result);
    return result;
}

int PChasDBInt( object oTarget, string sName)
{
    int result = 0;
    string dbkey =  GetDBKey( oTarget, sName, "_I");
//    PrintString("PCH Searching "+dbkey);

    result= GetCampaignInt( campaign, dbkey, oTarget);

    return result != 0;
}

int PChasLocalInt( object oTarget, string sName)
{
    string vkey = GetLocalKey( oTarget, sName);
    int result = GetLocalInt( oTarget, vkey);
    return result != 0;
}

float GetPersistentFloat(object oTarget, string sName)
{
    string vkey = GetLocalKey( oTarget, sName);
    float result = GetLocalFloat( oTarget, vkey);
    if( result != 0.0) return result;
    if (GetIsPC(oTarget))
        result=  GetCampaignFloat( campaign, GetDBKey( oTarget, sName, "_F"), oTarget);
    else
        result=  GetCampaignFloat(campaign, GetDBKey( oTarget, sName, "_F"));

    SetLocalFloat( oTarget, vkey, result);
    return result;
}

location GetPersistentLocation(object oTarget, string sName)
{
    string vkey = GetLocalKey( oTarget, sName);
    location result = GetLocalLocation( oTarget, vkey);
//    PrintString("GPL");
    if( GetIsLocationValid( result))
    {
//        PrintString("GPL found local location for "+GetLocalKey( oTarget, sName));
        return result;
    }
    if (GetIsPC(oTarget))
        result= GetCampaignLocation( campaign, GetDBKey( oTarget, sName, "_L"), oTarget);
    else
        result= GetCampaignLocation(campaign, GetDBKey( oTarget, sName, "_L"));

    SetLocalLocation( oTarget, vkey, result);
    return result;
}

// This version to restore an object to a player or
// other object but NOT in their inventory
//
object GetPersistentObject(object oTarget, string sName)
{
    string vkey = GetLocalKey( oTarget, sName);
    object result = GetLocalObject( oTarget, vkey);
    if( GetIsObjectValid( result)) return result;
    if (GetIsPC(oTarget))
        result= RetrieveCampaignObject( campaign, GetDBKey( oTarget, sName, "_O"), GetLocation( oTarget), OBJECT_INVALID, oTarget);
    else
        result= RetrieveCampaignObject( campaign, GetDBKey( oTarget, sName, "_O"), GetLocation( oTarget));
    SetLocalObject( oTarget, vkey, result);
    return result;
}

void SetPersistentString(object oTarget, string sName, string sValue) {
    if (GetIsPC(oTarget))
        SetCampaignString( campaign, GetDBKey( oTarget, sName, "_S"), sValue, oTarget);
    else
        SetCampaignString( campaign, GetDBKey( oTarget, sName, "_S"), sValue);

    SetLocalString( oTarget, GetLocalKey( oTarget, sName), sValue);
}

void SetPersistentInt(object oTarget, string sName, int iValue) {
    if (GetIsPC(oTarget))
        SetCampaignInt( campaign, GetDBKey( oTarget, sName, "_I"), iValue, oTarget);
    else
        SetCampaignInt( campaign, GetDBKey( oTarget, sName, "_I"), iValue);

    SetLocalInt( oTarget, GetLocalKey( oTarget, sName), iValue);
}

void SetPersistentFloat(object oTarget, string sName, float fValue) {
    if (GetIsPC(oTarget))
        SetCampaignFloat( campaign, GetDBKey( oTarget, sName, "_F"), fValue, oTarget);
    else
        SetCampaignFloat( campaign, GetDBKey( oTarget, sName, "_F"), fValue);

    SetLocalFloat( oTarget, GetLocalKey( oTarget, sName), fValue);
}

void SetPersistentLocation(object oTarget, string sName, location lValue) {
    if (GetIsPC(oTarget))
        SetCampaignLocation( campaign, GetDBKey( oTarget, sName, "_L"), lValue, oTarget);
    else
        SetCampaignLocation( campaign, GetDBKey( oTarget, sName, "_L"), lValue);

    SetLocalLocation( oTarget, GetLocalKey( oTarget, sName), lValue);

 }

void SetPersistentObject(object oTarget, string sName, object oValue) {
    int oType= GetObjectType( oValue);
    if( oType != OBJECT_TYPE_CREATURE && oType != OBJECT_TYPE_ITEM)
    {
//        PrintString("Error, tried to store wrong object on "+GetLocalKey( oTarget, sName));
        return;
    }
    if (GetIsPC(oTarget))
        oType = StoreCampaignObject( campaign, GetDBKey( oTarget, sName, "_O"), oValue, oTarget);
    else
        oType = StoreCampaignObject( campaign, GetDBKey( oTarget, sName, "_O"), oValue);
    SetLocalObject( oTarget, GetLocalKey( oTarget, sName), oValue);
    if( !oType)
    {
//        PrintString("Error, failed to store object "+GetLocalKey( oValue, "")+" on "+GetLocalKey( oTarget, sName));
        return;
    }
}

void DeletePersistentString(object oTarget, string sName)
{
    if (GetIsPC(oTarget))
        DeleteCampaignVariable( campaign, GetDBKey( oTarget, sName, "_S"), oTarget);
    else
        DeleteCampaignVariable( campaign, GetDBKey( oTarget, sName, "_S"));
    DeleteLocalString( oTarget, GetLocalKey( oTarget, sName));
}

void DeletePersistentInt(object oTarget, string sName)
{
    if (GetIsPC(oTarget))
        DeleteCampaignVariable( campaign, GetDBKey( oTarget, sName, "_I"), oTarget);
    else
        DeleteCampaignVariable( campaign, GetDBKey( oTarget, sName, "_I"));
    DeleteLocalInt( oTarget, GetLocalKey( oTarget, sName));
}

void DeletePersistentFloat(object oTarget, string sName)
{
    if (GetIsPC(oTarget))
        DeleteCampaignVariable( campaign, GetDBKey( oTarget, sName, "_F"), oTarget);
    else
        DeleteCampaignVariable( campaign, GetDBKey( oTarget, sName, "_F"));
    DeleteLocalFloat( oTarget, GetLocalKey( oTarget, sName));
}

void DeletePersistentLocation(object oTarget, string sName)
{
    if (GetIsPC(oTarget))
        DeleteCampaignVariable( campaign, GetDBKey( oTarget, sName, "_L"), oTarget);
    else
        DeleteCampaignVariable( campaign, GetDBKey( oTarget, sName, "_L"));
    DeleteLocalLocation( oTarget, GetLocalKey( oTarget, sName));
}

void DeletePersistentObject(object oTarget, string sName)
{
    if (GetIsPC(oTarget))
        DeleteCampaignVariable( campaign, GetDBKey( oTarget, sName, "_O"), oTarget);
    else
        DeleteCampaignVariable( campaign, GetDBKey( oTarget, sName, "_O"));
    DeleteLocalObject( oTarget, GetLocalKey( oTarget, sName));
}

int GetOffsetGameDate(int iOffset=0)
{
  /* If a negative number was given then
     this variable does not automatically expire. */
  if (iOffset < 0)
    return -1;
  else
  /* Otherwise, return the number of hours from "0/0/0".
     Which means if a zero was sent, the variable
     expires at the end of the current game day.*/
    {
      // Get the game calendar date
      int iYear=GetCalendarYear();
      int iMonth=GetCalendarMonth();
      int iDay=GetCalendarDay();
      int iHour = GetTimeHour();
      // Add to the appropriate integer until iOffset == 0
      while (iOffset > 8063)
        {
          iYear++;
          iOffset -= 8064;
        }
      while (iOffset > 671)
        {
          iMonth++;
          iOffset -= 672;
        }
      while (iOffset > 23)
        {
          iDay++;
          iOffset -= 24;
        }
      /* Now, if we have more than 28 days, roll the
         month, and if we have more than 12 months,
         roll the year - due to the way the year, month,
         and days were added above, it should be impossible
         to have more than 24 months or 56 days. */

      if (iDay > 28)
        {
          PrintString("NOTICE: iDay > 28 in GetO");
          iDay -= 28;
          iMonth++;
        }
      if (iMonth > 12)
        {
          PrintString("NOTICE: iMonth > 12 in GetO");
          iMonth -= 12;
          iYear++;
        }
      return (iYear*336 + iMonth*28 + iDay)*24 + iHour;
    }
}
// Short for get player state
/*int GPS(object oPC)
{
  return GetPersistentInt(oPC,"PlayerState");
}
// Short for set player state
void SPS(object oPC, int nPS)
{
  SetPersistentInt(oPC,"PlayerState", nPS);
}    */

void PCSaveInhibit( object oPC)
{
//  PrintString("Inhibiting save for "+GetName( oPC));
  SetLocalInt( oPC, "inhibitSave", 1);
}

void PCSaveAllow( object oPC)
{
//  PrintString("Allowing save for "+GetName( oPC));
  DeleteLocalInt( oPC, "inhibitSave");
}

int GetPCSaveInhibit( object oPC)
{
    return GetLocalInt( oPC, "inhibitSave");
}
// Set a local var to note a PC left during this session
// it is NOT persistent so we can tell if the game should be allowed
// to just leave them at their location or should we move them to their
// persistent location after a server restart.
// This has special ramifications during portalling
//
void MarkPCExited( string pcKey)
{
    SetLocalInt( GetModule(), pcKey, 1);
}

int GetPCExited( string pcKey)
{
    return GetLocalInt( GetModule(), pcKey);
}

void unMarkPCExited( string pcKey)
{
    PrintString("UNMarking "+pcKey+" exited");
    DeleteLocalInt( GetModule(), pcKey);
}

void SavePCInfo( object oPC)
{
//    if( GetPCSaveInhibit( oPC))
//        return;
    PrintString("Saving info for "+GetName( oPC));
//    location loc = GetLocation( oPC);
//    if( GetIsLocationValid( loc))
//        SetPersistentLocation( oPC, "LastLoc", GetLocation( oPC));
//    else
//        PrintString("Location invalid in SAVE!");
    SetPersistentInt(oPC,"LastHP", GetCurrentHitPoints( oPC));
    SetPersistentInt(oPC,"State", GPS( oPC));
    SetPersistentInt(oPC,"LastXP", GetXP( oPC));
    SetPersistentInt(oPC,"LastGold", GetGold( oPC));
}

void RemovePCInfo( object oPC)
{
    PrintString("Removing info for "+GetLocalKey( oPC,""));
    DeletePersistentLocation( oPC, "LastLoc");
    DeletePersistentInt(oPC,"LastHP");
    DeletePersistentInt(oPC,"State");
    DeletePersistentInt(oPC,"LastXP");
    DeletePersistentInt(oPC,"LastGold");
    unMarkPCExited( GetLocalKey( oPC, ""));
}

void SetPWDBCalendar(int iOffsetDate)
{
  PrintString("Setting calendar to "+IntToString( iOffsetDate));
  int iToday=GetOffsetGameDate(0);
  /* Only set the date if the saved date is after
     the start of the module. */
  if (iOffsetDate > iToday)
    {
      // Get "zero" date
      int iYear=0;
      int iMonth=0;
      int iDay=0;
      int iHour = 0;
      // Add to the appropriate integer until iOffset == 0
      while (iOffsetDate > 336*24-1)
        {
          iYear++;
          iOffsetDate -= 336*24;
        }
      while (iOffsetDate > 28*24-1)
        {
          iMonth++;
          iOffsetDate -= 28*24;
        }
      while (iOffsetDate > 23)
        {
          iDay++;
          iOffsetDate-=24;
        }
      iHour = iOffsetDate;
      /* Now, if we have more than 28 days, roll the
         month, and if we have more than 12 months,
         roll the year - due to the way the year, month,
         and days were added above, it should be impossible
         to have more than 24 months or 56 days. */
      if (iDay > 28)
        {
          PrintString("NOTICE: iDay > 28 in SetO");
          iDay -= 28;
          iMonth++;
        }
      if (iMonth > 12)
        {
          PrintString("NOTICE: iMonth > 12 in SetO");
          iMonth -= 12;
          iYear++;
        }
      SetCalendar(iYear, iMonth, iDay);
      SetTime( iHour, 0, 0, 0);
    }
    PrintString("Restored date");
}


void RestorePCLocation( object oPC)
{
    location loc =  GetPersistentLocation( oPC, "LastLoc");
    PrintString("ResPCL");
    if( GetIsLocationValid( loc))
    {
        SendMessageToPC(oPC, "Moving to persistent location");
        PrintString( "Resuming to "+GetName( GetAreaFromLocation( loc)));
        AssignCommand(oPC, JumpToLocation( loc));
    }
    else
        PrintString("Persistent location invalid");
}

void RestorePCHP( object oPC)
{
    int iTarget=GetPersistentInt(oPC,"LastHP");
    int iCurrent = GetCurrentHitPoints( oPC);
    if( iCurrent > iTarget)
    {
        effect eDam=EffectDamage(iCurrent-iTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC);
    }
    SPS( oPC, GetPersistentInt( oPC, "State"));
}

void RestorePCXP( object oPC)
{
    int iTarget = GetPersistentInt(oPC,"LastXP");
    int iCurrent = GetXP( oPC);
    if( iCurrent < iTarget)
    {
        PrintString("Adjusting XP");
        GiveAndLogXP(oPC, iTarget-iCurrent, "HC_INC", "for hc_inc_pwdb_func");
    }
}

void RestorePCGold( object oPC)
{
    int iTarget = GetPersistentInt(oPC,"LastGold");
    PrintString("Gold for "+GetName( oPC)+" is "+IntToString( iTarget));
    int iCurrent = GetGold( oPC);
    if( iCurrent < iTarget)
    {
        PrintString("Adjusting Gold to "+IntToString( iTarget-iCurrent));
        GiveGoldToCreature( oPC, iTarget-iCurrent);
    }
}

void RestorePCInfo(object oPC)
{
    if (!GetIsPC(oPC) || GetIsDM( oPC))
    {
        return;
    }
    PrintString("Restoring PC:"+GetName( oPC));
    RestorePCLocation( oPC);
//    RestorePCHP( oPC);
    RestorePCXP( oPC);
    RestorePCGold( oPC);
}

void SaveAllPCInfo()
{
    object oPlayer = GetFirstPC();
    while(GetIsObjectValid(oPlayer))
    {
        if( !GetIsDM( oPlayer ))
        {
          SavePCInfo( oPlayer);
        }
        oPlayer=GetNextPC();
    }
}

void PWDBSaveCharTimer( object oPC, float delay=120.0)
{
    if( GetIsObjectValid( oPC))
    {
        SavePCInfo( oPC);
        if (delay > 0.0)
            DelayCommand(delay, PWDBSaveCharTimer(oPC, delay));
    }
}
void PWDBExportCharTimer( object oPC, float delay=1200.0)
{
    string vkey = GetLocalKey( oPC,"");
    if( GetIsObjectValid( oPC) && !GetPCSaveInhibit(oPC) && !GetPCExited( vkey ))
    {
        PrintString("Exporting "+vkey);
        ExportSingleCharacter( oPC);
        if (delay > 0.0)
            DelayCommand(delay, PWDBExportCharTimer(oPC, delay));
    }
}
void PWDBDateTimer( float delay=0.0)
{
    SetPersistentInt( GetModule(), "iPWDBDate", GetOffsetGameDate());
    if (delay > 0.0)
        DelayCommand( delay, PWDBDateTimer( delay));
}

