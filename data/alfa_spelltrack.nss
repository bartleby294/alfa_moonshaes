//::///////////////////////////////////////////////
//:: Name Alfa Spell Tracking System
//:: FileName alfa_spelltrack
//:://////////////////////////////////////////////
/*
    This script tracks spell cast persistantly
    so spells can only be regained by a full rest.

    Credits:
    - Creslyn, who wrote a similar script, which
    this script borrowed some great ideas from.

*/
//:://////////////////////////////////////////////
//:: Created By: Ariak
//:: Created On: Dec 30, 2004
//:://////////////////////////////////////////////


//:://///////////////////////////////////////////
//:: Constants
//:://///////////////////////////////////////////

// Constant for the item that stores spells spent persistantly
const string ST_VAR_STORAGE_ITEM = "emoteitem";


//:://///////////////////////////////////////////
//:: Function Prototypes
//:://///////////////////////////////////////////


// Track the spell when it is cast
void TrackSpellCast(int nSpellId, object oCaster);

// Remove spells gained when interrupting rest
void TrackSpellsOnRestCancelled(object oPC);

// Remove spells stored as cast
void TrackSpellsOnRestFinished(object oPC);

// Remove spells cast in last session
void TrackSpellsOnEnter(object oCaster);

// Increment the number of times a spell has been cast and store it persistantly
void IncrementTimesSpellCast(object oStorage, int nSpellId, int nTimes);

// Decrement the uses of a particular spell
void DecrementSpellUses(object oCaster, int nSpellID, int nUses, float fDelay = 0.1);


//:://///////////////////////////////////////////
//:: Functions
//:://///////////////////////////////////////////


void TrackSpellCast(int nSpellId, object oCaster)
{
    object oStorageItem;

    //Check that we have a valid PC
    if(GetIsPC(oCaster) && !GetIsDM(oCaster) && !GetIsDMPossessed(oCaster))
    {
        //Check that the spell wasn't cast from a item
        if(!GetIsObjectValid(GetSpellCastItem()))
        {
            oStorageItem = GetItemPossessedBy(oCaster, ST_VAR_STORAGE_ITEM);

            if(GetIsObjectValid(oStorageItem))
            {
                IncrementTimesSpellCast(oStorageItem, nSpellId, 1);
            }
        }
    }
}


void TrackSpellsOnRestCancelled(object oPC)
{
    //Strip PC of spells gained on partial rest to prevent cheating
    TrackSpellsOnEnter(oPC);
}

void TrackSpellsOnRestFinished(object oPC)
{
    object oStorageItem = GetItemPossessedBy(oPC, ST_VAR_STORAGE_ITEM);

    if(GetIsObjectValid(oStorageItem))
    {
        //Remove spells marked as cast
        DeleteLocalString(oStorageItem, "SPELLTRACKER");
    }

}

void TrackSpellsOnEnter(object oCaster)
{
    int nPos, nSpellID, nUses, nLenght;
    object oStorageItem;
    string sSpellString, sSpell;

    if(GetIsPC(oCaster))
    {
        SendMessageToPC(oCaster, "Restoring spells cast");
        oStorageItem = GetItemPossessedBy(oCaster, ST_VAR_STORAGE_ITEM);

        if(GetIsObjectValid(oStorageItem))
        {
            sSpellString = GetLocalString(oStorageItem, "SPELLTRACKER");

            if(sSpellString != "")
            {
                nPos = FindSubString(sSpellString, "_");
                while(nPos > 0)
                {
                    nLenght = GetStringLength(sSpellString);
                    sSpell = GetSubString(sSpellString, 0, nPos-3);
                    nSpellID = StringToInt(sSpell);
                    nUses = StringToInt(GetSubString(sSpellString, nPos-2, 2));

                    if(GetHasSpell(nSpellID, oCaster) && nUses > 0)
                    {
                        DecrementSpellUses(oCaster, nSpellID, nUses);
                    }
                    sSpellString = GetSubString(sSpellString, nPos+1, nLenght - nPos);
                    nPos = FindSubString(sSpellString, "_");
                }
            }
        }
    }
}

void IncrementTimesSpellCast(object oStorage, int nSpellId, int nTimes)
{
    string sSpell = IntToString(nSpellId) + "U";
    string sSpellString = GetLocalString(oStorage, "SPELLTRACKER");
    string sNumCast, sTmpLeft, sTmpRight;


    int nLenght = GetStringLength(sSpellString);
    int nNumCast, nNumCastPos;
    int nPos = FindSubString(sSpellString, sSpell);
    int nSpellLenght = GetStringLength(sSpell);

    if(nPos == -1)
    {
        sSpellString += sSpell + "01_";
    }
    else
    {
        nNumCastPos = nPos + nSpellLenght;
        sNumCast = GetSubString(sSpellString, nNumCastPos, 2);
        nNumCast = StringToInt(sNumCast) + 1;
        sTmpLeft = GetStringLeft(sSpellString, nNumCastPos);
        sTmpRight= GetStringRight(sSpellString, nLenght - (nNumCastPos + 2));

        if(nNumCast < 10)
        {
            sSpellString = sTmpLeft + "0" + IntToString(nNumCast) + sTmpRight;
        }
        else
        {
            sSpellString = sTmpLeft + IntToString(nNumCast) + sTmpRight;
        }

    }
    SetLocalString(oStorage, "SPELLTRACKER", sSpellString);
}

void DecrementSpellUses(object oCaster, int nSpellID, int nUses, float fDelay = 0.1)
{
    DecrementRemainingSpellUses(oCaster, nSpellID);
    nUses--;

    if(nUses)
    {
        DelayCommand(fDelay, DecrementSpellUses(oCaster, nSpellID, nUses));
    }
}
