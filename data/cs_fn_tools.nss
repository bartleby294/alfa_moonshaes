//::///////////////////////////////////////////////
//:: CS_FN_TOOLS.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Tools to be included in files as needed.
    Ignore compile error, this file is a function tool
    Contents:   AbilityCheck    Performs ability checks as per 3rd edition rules
                                Operates in the same manner as AutoDC. Used in
                                conversation files.
*/
//:://////////////////////////////////////////////
//:: Created By:  Clayton Greene
//:: Created On:  Aug 8, 2003   version 1.0
//:://////////////////////////////////////////////
int DC_EASY = 0;
int DC_MEDIUM = 1;
int DC_HARD = 2;
//:://////////////////////////////////////////////
//::AbilityCheck Function
//::
//:://////////////////////////////////////////////

    // the declaration of AbilityCheck function
int AbilityCheck(int DC, int nAbility, object oTarget)
{
int nModify;
    // get the ability modifier for the target of the check.
int nAbility = GetAbilityModifier(nAbility, OBJECT_SELF);
    // get the ability modifier for the PC
int nPCAbility = GetAbilityModifier(nAbility, oTarget);
    // if the target of the check has a negative or zero ability modifier then
    // make the modifier 0
if (nAbility <= 0)
    {
    nAbility = 0;
    }
switch (DC)
    {
    //these add difficulty modifiers to the check
    case 0: nModify = 5;
    break;
    case 1: nModify = 0;
    break;
    case 2: nModify = -5;
    break;
    }
    // if the PC's ability modifier plus the difficulty modifier and a d20
    // is greater or equal to the target's ability modifier plus a d20
    // then the check succeeds.
if (nPCAbility + nModify + d20() >= nAbility + d20())

    {
       return TRUE;
    }
       return FALSE;
}

