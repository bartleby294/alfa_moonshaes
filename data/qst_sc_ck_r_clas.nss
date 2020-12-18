/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Quest Builder Version 2.0
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 25, 2004

       Used to Restrict Quests by Class required for Questing.
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "custom_tokens"
int StartingConditional()
{
    string sClass = GetLocalString(OBJECT_SELF, "class");
    // Restrict based on the player's class

    if ( sClass == "archer" )
    {
        if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "assassin" )
    {
        if(GetLevelByClass(CLASS_TYPE_ASSASSIN, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "bard" )
    {
        if(GetLevelByClass(CLASS_TYPE_BARD, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "barbarian" )
    {
        if(GetLevelByClass(CLASS_TYPE_BARBARIAN, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "blackguard" )
    {
        if(GetLevelByClass(CLASS_TYPE_BLACKGUARD, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "cleric" )
    {
        if(GetLevelByClass(CLASS_TYPE_CLERIC, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "champion" )
    {
        if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "dragon" )
    {
        if(GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "druid" )
    {
        if(GetLevelByClass(CLASS_TYPE_DRUID, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "defender" )
    {
        if(GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "fighter" )
    {
        if(GetLevelByClass(CLASS_TYPE_FIGHTER, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "harper" )
    {
        if(GetLevelByClass(CLASS_TYPE_HARPER, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "monk" )
    {
        if(GetLevelByClass(CLASS_TYPE_MONK, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "paladin" )
    {
        if(GetLevelByClass(CLASS_TYPE_PALADIN, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "palemaster" )
    {
        if(GetLevelByClass(CLASS_TYPE_PALEMASTER, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "ranger" )
    {
        if(GetLevelByClass(CLASS_TYPE_RANGER, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "rogue" )
    {
        if(GetLevelByClass(CLASS_TYPE_ROGUE, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "dancer" )
    {
        if(GetLevelByClass(CLASS_TYPE_SHADOWDANCER, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "shifter" )
    {
        if(GetLevelByClass(CLASS_TYPE_SHIFTER, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "sorcerer" )
    {
        if(GetLevelByClass(CLASS_TYPE_SORCERER, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "weapon" )
    {
        if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "wizard" )
    {
        if(GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 1)
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "caster" )
    {
        if((GetLevelByClass(CLASS_TYPE_SORCERER, GetPCSpeaker()) >= 1) || (GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 1))
        {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else if ( sClass == "bowuser" )
    {
        if((GetLevelByClass(CLASS_TYPE_RANGER, GetPCSpeaker()) >= 1) ||(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, GetPCSpeaker()) >= 1))
         {
            return FALSE;
        }
        else
        {
            return TRUE;
        }
    }
    else
    {
        return FALSE;
    }
}
