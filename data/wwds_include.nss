// WWDSTRUCT: A library of data strcutures utilities for
// NWN.
// Author: Jeffrey P. Kesselman
// Copyright Feb 1, 2003, All Rights Reserved
// Grant of Rights:
// This code is freely redestrubtable in part or
// whole so long as attribution and copyright notice are
// are preserved.

// clipepd rom Bioware for #include reasons.
// all Copyright Bioware
/*
 *
 * Noel's Array stuff
 *
 *
*/

//::///////////////////////////////////////////////
//:: GetLocalArrayInt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns an integer, from nVarNum in the array
*/
//:://////////////////////////////////////////////
//:: Created By: Noel
//:: Created On:
//:://////////////////////////////////////////////

    string GetLocalArrayString(object oidObject, string sVarName, int nVarNum)
    {
        string sFullVarName = sVarName + IntToString(nVarNum) ;
        return GetLocalString(oidObject, sFullVarName);
    }

//::///////////////////////////////////////////////
//:: SetLocalArrayInt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets the integer at nVarNum position
*/
//:://////////////////////////////////////////////
//:: Created By: Noel
//:: Created On:
//:://////////////////////////////////////////////

    void SetLocalArrayString(object oidObject, string sVarName, int nVarNum, string nValue)
    {
        string sFullVarName = sVarName + IntToString(nVarNum) ;
        SetLocalString(oidObject, sFullVarName, nValue);
    }


//::///////////////////////////////////////////////
//:: GetLocalArrayInt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns an integer, from nVarNum in the array
*/
//:://////////////////////////////////////////////
//:: Created By: Noel
//:: Created On:
//:://////////////////////////////////////////////

    int GetLocalArrayInt(object oidObject, string sVarName, int nVarNum)
    {
        string sFullVarName = sVarName + IntToString(nVarNum) ;
        return GetLocalInt(oidObject, sFullVarName);
    }

//::///////////////////////////////////////////////
//:: SetLocalArrayInt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets the integer at nVarNum position
*/
//:://////////////////////////////////////////////
//:: Created By: Noel
//:: Created On:
//:://////////////////////////////////////////////

    void SetLocalArrayInt(object oidObject, string sVarName, int nVarNum, int nValue)
    {
        string sFullVarName = sVarName + IntToString(nVarNum) ;
        SetLocalInt(oidObject, sFullVarName, nValue);
    }
//::////////////// END Bioware Code /////////////

// object arrayt functions, based on bioware's int and string
// array concepts

object GetLocalArrayObject(object oidObject, string sVarName,
    int nVarNum)
{
    string sFullVarName = sVarName + IntToString(nVarNum);
    return GetLocalObject(oidObject, sFullVarName);
}

void SetLocalArrayObject(object oidObject, string sVarName,
    int nVarNum, object oValue)
{
    string sFullVarName = sVarName + IntToString(nVarNum) ;
    SetLocalObject(oidObject, sFullVarName, oValue);
}


// queuing functions

void WWDS_enqueueInt(object obj, string queueName,
    int value)
{
    string qname = "queue_"+queueName;
    string ptrname = qname+"_endptr";
    int queueEnd = GetLocalInt(obj,ptrname);
    SetLocalArrayInt(obj,qname,queueEnd,value);
    SetLocalInt(obj,ptrname,queueEnd+1);
}

int WWDS_queueEmpty(object obj, string queueName){
    string qname = "queue_"+queueName;
    string ptrname = qname+"_endptr";
    string rootname = qname+"_startptr";
    int queueEnd = GetLocalInt(obj,ptrname);
    int queueStart = GetLocalInt(obj,rootname);
    return (queueEnd<=queueStart);
}

int WWDS_dequeueLastInt(object obj,string queueName){
    string qname = "queue_"+queueName;
    string ptrname = qname+"_endptr";
    string rootname = qname+"_startptr";
    int queueEnd = GetLocalInt(obj,ptrname);
    int queueStart = GetLocalInt(obj,rootname);
    if (queueStart == queueEnd) {
        return 0;
    }
    int result = GetLocalArrayInt(obj,qname,
        queueEnd);
    SetLocalInt(obj,ptrname,queueEnd-1);
    return result;
}

int WWDS_dequeueFirstInt(object obj, string queueName){
    string qname = "queue_"+queueName;
    string rootname = qname+"_startptr";
    string ptrname = qname+"_endptr";
    int queueEnd = GetLocalInt(obj,ptrname);
    int queueStart = GetLocalInt(obj,rootname);
    if (queueEnd == queueStart) {
        return 0;
    }
    int result = GetLocalArrayInt(obj,qname,
        queueStart);
    SetLocalInt(obj,rootname,queueStart+1);
    return result;
}

void WWDS_enqueueString(object obj, string queueName,
    string value)
{
    string qname = "queue_"+queueName;
    string ptrname = qname+"_endptr";
    int queueEnd = GetLocalInt(obj,ptrname);
    SetLocalArrayString(obj,qname,queueEnd,value);
    SetLocalInt(obj,ptrname,queueEnd+1);
}

string WWDS_dequeueLastString(object obj,
    string queueName)
{
    string qname = "queue_"+queueName;
    string ptrname = qname+"_endptr";
    string rootname = qname+"_startptr";
    int queueEnd = GetLocalInt(obj,ptrname);
    int queueStart = GetLocalInt(obj,rootname);
    if (queueStart == queueEnd) {
        return "";
    }
    string result = GetLocalArrayString(obj,qname,
        queueEnd);
    SetLocalInt(obj,ptrname,queueEnd-1);
    return result;
}

string WWDS_dequeueFirstString(object obj,
    string queueName)
{
    string qname = "queue_"+queueName;
    string rootname = qname+"_startptr";
    string ptrname = qname+"_endptr";
    int queueEnd = GetLocalInt(obj,ptrname);
    int queueStart = GetLocalInt(obj,rootname);
    if (queueEnd == queueStart) {
        return "";
    }
    string result = GetLocalArrayString(obj,qname,
        queueStart);
    SetLocalInt(obj,rootname,queueStart+1);
    return result;
}

void WWDS_enqueueObject(object obj, string queueName,
    object value)
{
    string qname = "queue_"+queueName;
    string ptrname = qname+"_endptr";
    int queueEnd = GetLocalInt(obj,ptrname);
    SetLocalArrayObject(obj,qname,queueEnd,value);
    SetLocalInt(obj,ptrname,queueEnd+1);
}

object WWDS_dequeueLastObject(object obj,
    string queueName)
{
    string qname = "queue_"+queueName;
    string ptrname = qname+"_endptr";
    string rootname = qname+"_startptr";
    int queueEnd = GetLocalInt(obj,ptrname);
    int queueStart = GetLocalInt(obj,rootname);
    if (queueStart == queueEnd) {
        return obj;
    }
    object result = GetLocalArrayObject(obj,qname,
        queueEnd);
    SetLocalInt(obj,ptrname,queueEnd-1);
    return result;
}

object WWDS_dequeueFirstObject(object obj,
    string queueName)
{
    string qname = "queue_"+queueName;
    string rootname = qname+"_startptr";
    string ptrname = qname+"_endptr";
    int queueEnd = GetLocalInt(obj,ptrname);
    int queueStart = GetLocalInt(obj,rootname);
    if (queueEnd == queueStart) {
        return obj;
    }
    object result = GetLocalArrayObject(obj,qname,
        queueStart);
    SetLocalInt(obj,rootname,queueStart+1);
    return result;
}



