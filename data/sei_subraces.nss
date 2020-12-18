//
//  NWSubraces
//
//  Basic subrace functionality - private stuff
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////
//  Modified:
//  Ariak, Nov 2004: changed SEI_RemoveEffect
//
///////////////////////////////////////////////////////

// **************************************************************
// ** Constants
// **********************

// Constant to note if we are currently debugging. Should be FALSE in release version.
int SUBRACE_DEBUG           = FALSE;

// Constant to note if we're using the subrace hide or the subrace effects.
int USE_SUBRACE_HIDE        = FALSE;

// Name of the subrace field on the characters.
string SUBRACE_FIELD        = "SUBRACE_CHARACTER";

// Base field name used to save subrace information.
string SUBRACE_STRUCT_TAG   = "SUBRACE";

// Field name for the number of stored subraces.
string SUBRACE_COUNT        = "SUBRACE_COUNT";

// Base field name for the mapping of subrace ID to index.
string SUBRACE_IDMAP        = "SUBRACE_IDMAP";

// Base field name for the mapping of subrace ID to description.
string SUBRACE_DESCMAP      = "SUBRACE_DESCMAP";

// The field name for the area settings.
string AREA_SETTING         = "AREA_SETTING";

// The Field name for the light setting on the character.
string LIGHT_SETTING        = "LIGHT_SETTING";

// The Field name for the ground setting on the character.
string GROUND_SETTING       = "GROUND_SETTING";


// **************************************************************
// ** Forward declarations
// **********************

// Private function for the subraces script. Do not use.
effect SEI_ParseTrait( object a_oCharacter, string a_sTrait );

// Private function for the subraces script. Do not use.
void SEI_DefineSubraces();



// **************************************************************
// ** Feedback functions
// **********************

// Write an entry for subraces in the log.
//
void SEI_WriteSubraceLogEntry( string a_sLogEntry, int a_bIsDebug = FALSE )
{
    // If this is a normal log entry or if we are debugging.
    if( !a_bIsDebug || SUBRACE_DEBUG )
    {
        // Write entry to log file.
        WriteTimestampedLogEntry( "SEI Subraces: " + a_sLogEntry );
    }
}


// Send a subraces message to a PC.
//
void SEI_SendSubraceMessageToPC( object a_oPC, string a_sMessage )
{
    // First make sure we actually have a valid PC
    if( GetIsPC( a_oPC ) )
    {
        SEI_WriteSubraceLogEntry( a_sMessage, TRUE );
        SendMessageToPC( a_oPC, "[Subraces] " + a_sMessage );
    }
}


// Translates the subrace enum to a readable string.
//
string SEI_SubraceEnumToString( int a_nSubrace )
{

    if( a_nSubrace == SUBRACE_NONE )
    {
        return "subrace not initialized";
    }
    else if( a_nSubrace == SUBRACE_MONSTER )
    {
        return "Monster";
    }
    else
    {
        return GetLocalString( GetModule(), SUBRACE_DESCMAP + IntToString( a_nSubrace ) );
    }

} // End SEI_SubraceEnumToString


// Send a message to the character that the subrace has been initialized.
//
void SEI_SendSubraceInitMsg( object a_oCharacter, int a_nSubrace )
{

    // Send a message to the PC that the subrace was successfully initialized.
    if( GetIsPC( a_oCharacter ) )
    {

        // Get the textual description of the subrace.
        string sSubraceDesc = SEI_SubraceEnumToString( a_nSubrace );

        // Write a debug message to the log.
        SEI_WriteSubraceLogEntry(
            "Subrace field of character '" + GetName( a_oCharacter ) +
            "' (played by '" + GetPCPlayerName( a_oCharacter ) +
            "') is '" + GetSubRace( a_oCharacter ) +
            "', which has been interpreted as [" + IntToString( a_nSubrace ) +
            "] '" + sSubraceDesc + "' and set accordingly." );

        // Tell the player that the subrace was initialized.
        SEI_SendSubraceMessageToPC( a_oCharacter,
            "Your subrace field has been interpreted as '" + sSubraceDesc +
            "' and your abilities have been set accordingly." );

    } // End if

} // End SEI_SendSubraceInitMsg




// **************************************************************
// ** Subrace data functions
// **********************

// Returns a new subrace structure and saves it to the global object.
//
struct Subrace SEI_CreateSubrace( int a_nSubrace, int a_nBaseRace, string a_sDescription )
{

    // The struct we're creating.
    struct Subrace stSubrace;

    // Global object to store the values on.
    object oModule = GetModule();

    // Number of subraces already added (highest index is nSubraceCount-1)
    int nSubraceCount = GetLocalInt( oModule, SUBRACE_COUNT );

    // Store the values in the new struct.
    stSubrace.m_nID                 = a_nSubrace;
    stSubrace.m_nBaseRace           = a_nBaseRace;
    stSubrace.m_nNumFieldValues     = 0;
    stSubrace.m_nNumTraits          = 0;
    stSubrace.m_bSpellResistance    = 0;
    stSubrace.m_nLightSensitivity   = 0;
    stSubrace.m_fLightBlindness     = 0.0;
    stSubrace.m_nStonecunning       = 0;
    stSubrace.m_nSpellLikeAbility   = 0;
    stSubrace.m_nECLAdd             = 0;
    stSubrace.m_nFavoredClassF      = -1;
    stSubrace.m_nFavoredClassM      = -1;
    stSubrace.m_bIsDefault          = FALSE;

    // Save the mapping of subrace ID to index.
    SetLocalInt( oModule, SUBRACE_IDMAP + IntToString(a_nSubrace), nSubraceCount );

    // Save the textual description of this subrace
    // SEI_NOTE: Storing strings in structs doesn't seem to work. Hence done this way.
    SetLocalString( GetModule(), SUBRACE_DESCMAP + IntToString( a_nSubrace ), a_sDescription );

    // Increase the number of added subraces.
    SetLocalInt( oModule, SUBRACE_COUNT, ++nSubraceCount );

    return stSubrace;

} // End SEI_CreateSubrace


// Adds a new field text for the subrace.
// These field texts translate to matches in the subrace field on the character
// sheet; if the field contains one of these texts the subrace will match.
//
struct Subrace SEI_AddFieldText( struct Subrace a_stSubrace, string a_sText )
{

    // Global object to store the values on.
    object oModule = GetModule();

    // The field name to store the new text under.
    string sTag = SUBRACE_STRUCT_TAG + IntToString(a_stSubrace.m_nID) +
                  "_FIELD" + IntToString(a_stSubrace.m_nNumFieldValues);

    // Store the text.
    SetLocalString( oModule, sTag, a_sText );

    // Increase the number of stored texts.
    ++(a_stSubrace.m_nNumFieldValues);

    return a_stSubrace;

} // End SEI_AddFieldText


// Adds a trait for the subrace.
// These trait strings are parsed into the effects applied to the character.
//
struct Subrace SEI_AddTrait( struct Subrace a_stSubrace, string a_sTrait )
{

    // Global object to store the values on.
    object oModule = GetModule();

    // The field name to store the new trait under.
    string sTag = SUBRACE_STRUCT_TAG + IntToString(a_stSubrace.m_nID) +
                  "_TRAIT" + IntToString(a_stSubrace.m_nNumTraits);

    // Store the text.
    SetLocalString( oModule, sTag, a_sTrait );

    // Increase the number of stored traits.
    ++(a_stSubrace.m_nNumTraits);

    return a_stSubrace;

} // End SEI_AddTrait


// Returns the mapping of the subrace to the index where the subrace is stored.
//
int SEI_SubraceIDToIdx( int a_nSubrace )
{
    return GetLocalInt( GetModule(), SUBRACE_IDMAP + IntToString(a_nSubrace) );
}


// Saves the subrace struct to the module for later retrieval to a specific index.
//
void SEI_SaveSubraceIdx( struct Subrace a_stSubrace, int a_nSubraceIdx )
{

    // Global object to store the values on.
    object oModule = GetModule();

    // The base field name to store the values under.
    string sTag = SUBRACE_STRUCT_TAG + IntToString(a_nSubraceIdx) + "_";

    // Save the values from the struct.
    SetLocalInt( oModule, sTag + "ID",   a_stSubrace.m_nID );
    SetLocalInt( oModule, sTag + "RACE", a_stSubrace.m_nBaseRace );
    SetLocalInt( oModule, sTag + "NFLD", a_stSubrace.m_nNumFieldValues );
    SetLocalInt( oModule, sTag + "NTRT", a_stSubrace.m_nNumTraits );
    SetLocalInt( oModule, sTag + "SRES", a_stSubrace.m_bSpellResistance );
    SetLocalInt( oModule, sTag + "LSEN", a_stSubrace.m_nLightSensitivity );
    SetLocalFloat( oModule, sTag + "LBLI", a_stSubrace.m_fLightBlindness );
    SetLocalInt( oModule, sTag + "STON", a_stSubrace.m_nStonecunning );
    SetLocalInt( oModule, sTag + "SLA",  a_stSubrace.m_nSpellLikeAbility );
    SetLocalInt( oModule, sTag + "ECL",  a_stSubrace.m_nECLAdd );
    SetLocalInt( oModule, sTag + "FAVF", a_stSubrace.m_nFavoredClassF );
    SetLocalInt( oModule, sTag + "FAVM", a_stSubrace.m_nFavoredClassM );
    SetLocalInt( oModule, sTag + "DEF",  a_stSubrace.m_bIsDefault );

} // End SEI_SaveSubraceIdx


// Loads the subrace struct from the module at a specific index.
//
struct Subrace SEI_LoadSubraceIdx( int a_nSubraceIdx )
{

    // The structure that the data will be loaded into.
    struct Subrace stSubrace;

    // Global object where the values are stored.
    object oModule = GetModule();

    // The base field name the values are stored under.
    string sTag = SUBRACE_STRUCT_TAG + IntToString(a_nSubraceIdx) + "_";

    // Load the values into the struct.
    stSubrace.m_nID                 = GetLocalInt( oModule, sTag + "ID" );
    stSubrace.m_nBaseRace           = GetLocalInt( oModule, sTag + "RACE" );
    stSubrace.m_nNumFieldValues     = GetLocalInt( oModule, sTag + "NFLD" );
    stSubrace.m_nNumTraits          = GetLocalInt( oModule, sTag + "NTRT" );
    stSubrace.m_bSpellResistance    = GetLocalInt( oModule, sTag + "SRES" );
    stSubrace.m_nLightSensitivity   = GetLocalInt( oModule, sTag + "LSEN" );
    stSubrace.m_fLightBlindness     = GetLocalFloat( oModule, sTag + "LBLI" );
    stSubrace.m_nStonecunning       = GetLocalInt( oModule, sTag + "STON" );
    stSubrace.m_nSpellLikeAbility   = GetLocalInt( oModule, sTag + "SLA" );
    stSubrace.m_nECLAdd             = GetLocalInt( oModule, sTag + "ECL" );
    stSubrace.m_nFavoredClassF      = GetLocalInt( oModule, sTag + "FAVF" );
    stSubrace.m_nFavoredClassM      = GetLocalInt( oModule, sTag + "FAVM" );
    stSubrace.m_bIsDefault          = GetLocalInt( oModule, sTag + "DEF" );

    return stSubrace;

} // End SEI_LoadSubraceIdx


// Saves the subrace struct to the module for later retrieval.
//
void SEI_SaveSubrace( struct Subrace a_stSubrace )
{
    SEI_SaveSubraceIdx( a_stSubrace, SEI_SubraceIDToIdx( a_stSubrace.m_nID ) );
}


// Loads the subrace struct from the module.
//
struct Subrace SEI_LoadSubrace( int a_nSubrace )
{
    return SEI_LoadSubraceIdx( SEI_SubraceIDToIdx( a_nSubrace ) );
}


// Returns the ECL modification for the character.
//
int SEI_GetECLAdd( object a_oCharacter )
{

    int nECLAdd = 0;

    // Read the local variable off the character.
    int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

    // Make sure we actually have a subrace.
    if( nSubrace != SUBRACE_NONE )
    {

        // Load the information on the character's subrace.
        struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

        // Get the ECL modification from the subrace information.
        nECLAdd = stSubrace.m_nECLAdd;

    } // End if

    return nECLAdd;

} // End SEI_GetECLAdd




// **************************************************************
// ** Subrace trait parser functions
// **********************

// Parse the trait string to get the effect it describes.
// This function recognises traits with three arguments.
//
effect SEI_ParseTrait3( object a_oCharacter, string a_sTrait, string a_sArg1, string a_sArg2, string a_sArg3 )
{

    effect eResult;

    if( a_sTrait == "save_inc" )
    {
        eResult = EffectSavingThrowIncrease( StringToInt(a_sArg1), StringToInt(a_sArg2), StringToInt(a_sArg3) );
    }
    else if( a_sTrait == "save_dec" )
    {
        eResult = EffectSavingThrowDecrease( StringToInt(a_sArg1), StringToInt(a_sArg2), StringToInt(a_sArg3) );
    }
    else
    {
        SEI_WriteSubraceLogEntry( "Unable to parse trait: '" +
            a_sTrait + " " + a_sArg1 + " " + a_sArg2 + " " + a_sArg3 + "'" );
    }

    return eResult;

} // End SEI_ParseTrait3


// Parse the trait string to get the effect it describes.
// This function recognises traits with two arguments.
//
effect SEI_ParseTrait2( object a_oCharacter, string a_sTrait, string a_sArg1, string a_sArg2 )
{

    effect eResult;

    if( a_sTrait == "ability_inc" )
    {
        eResult = EffectAbilityIncrease( StringToInt(a_sArg1), StringToInt(a_sArg2) );
    }
    else if( a_sTrait == "ability_dec" )
    {
        eResult = EffectAbilityDecrease( StringToInt(a_sArg1), StringToInt(a_sArg2) );
    }
    else if( a_sTrait == "skill_inc" )
    {
        eResult = EffectSkillIncrease( StringToInt(a_sArg1), StringToInt(a_sArg2) );
    }
    else if( a_sTrait == "skill_dec" )
    {
        eResult = EffectSkillDecrease( StringToInt(a_sArg1), StringToInt(a_sArg2) );
    }
    else if( a_sTrait == "vs" )
    {
        effect eEffect = SEI_ParseTrait( a_oCharacter, a_sArg2 );
        eResult = VersusRacialTypeEffect( eEffect, StringToInt( a_sArg1 ) );
    }
    else
    {

        int nSplit = FindSubString( a_sArg2, " " );

        if( nSplit >= 0 )
        {

            string sHead = GetStringLeft( a_sArg2, nSplit );
            string sTail = GetStringRight( a_sArg2, GetStringLength(a_sArg2) - ( nSplit + 1 ) );

            eResult = SEI_ParseTrait3( a_oCharacter, a_sTrait, a_sArg1, sHead, sTail );

        }
        else
        {
            SEI_WriteSubraceLogEntry( "Unable to parse trait: '" +
                a_sTrait + " " + a_sArg1 + " " + a_sArg2 + "'" );
        }

    } // End if-elseif-else

    return eResult;

} // End SEI_ParseTrait2


// Parse the trait string to get the effect it describes.
// This function recognises traits with one argument.
//
effect SEI_ParseTrait1( object a_oCharacter, string a_sTrait, string a_sArg1 )
{

    effect eResult;

    if( a_sTrait == "ac_inc" )
    {
        eResult = EffectACIncrease( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "ac_dec" )
    {
        eResult = EffectACDecrease( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "attack_inc" )
    {
        eResult = EffectAttackIncrease( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "attack_dec" )
    {
        eResult = EffectAttackDecrease( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "immune" )
    {
        eResult = EffectImmunity( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "ex" )
    {
        effect eEffect = SEI_ParseTrait( a_oCharacter, a_sArg1 );
        eResult = ExtraordinaryEffect( eEffect );
    }
    else if( a_sTrait == "su" )
    {
        effect eEffect = SEI_ParseTrait( a_oCharacter, a_sArg1 );
        eResult = SupernaturalEffect( eEffect );
    }
    else if( a_sTrait == "m" )
    {
        if( GetGender( a_oCharacter ) == GENDER_MALE )
        {
            eResult = SEI_ParseTrait( a_oCharacter, a_sArg1 );
        }
    }
    else if( a_sTrait == "f" )
    {
        if( GetGender( a_oCharacter ) == GENDER_FEMALE )
        {
            eResult = SEI_ParseTrait( a_oCharacter, a_sArg1 );
        }
    }
    else
    {

        int nSplit = FindSubString( a_sArg1, " " );

        if( nSplit >= 0 )
        {

            string sHead = GetStringLeft( a_sArg1, nSplit );
            string sTail = GetStringRight( a_sArg1, GetStringLength(a_sArg1) - ( nSplit + 1 ) );

            eResult = SEI_ParseTrait2( a_oCharacter, a_sTrait, sHead, sTail );

        }
        else
        {
            SEI_WriteSubraceLogEntry( "Unable to parse trait: '" +
                a_sTrait + " " + a_sArg1 + "'" );
        }

    } // End if-elseif-else

    return eResult;

} // End SEI_ParseTrait1


// Parse the trait string to get the effect it describes.
// This function recognises traits without arguments.
//
effect SEI_ParseTrait( object a_oCharacter, string a_sTrait )
{

    effect eResult;

    if( a_sTrait == "darkvision" )
    {
        //eResult = EffectVisualEffect( VFX_DUR_DARKVISION );
        eResult = EffectUltravision();
    }
    else
    {

        int nSplit = FindSubString( a_sTrait, " " );

        if( nSplit >= 0 )
        {

            string sHead = GetStringLeft( a_sTrait, nSplit );
            string sTail = GetStringRight( a_sTrait, GetStringLength(a_sTrait) - ( nSplit + 1 ) );

            eResult = SEI_ParseTrait1( a_oCharacter, sHead, sTail );

        }
        else
        {
            SEI_WriteSubraceLogEntry( "Unable to parse trait: '" + a_sTrait + "'" );
        }

    } // End if-else

    return eResult;

} // End SEI_ParseTrait




// **************************************************************
// ** Subrace initialization functions
// **********************

// Initializes the available subraces and everything that is needed to properly
// run this script.
//
void SEI_InitSubraces()
{

    struct Subrace stSubrace;

    // First define an invalid subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_NONE, RACIAL_TYPE_INVALID, "Invalid subrace" );
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Then define all the other subraces.
    SEI_DefineSubraces();

} // End SEI_InitSubraces


// Sets the subrace field on a_oCharacter to a_nSubrace.
//
void SEI_SetSubraceVar( object a_oCharacter, int a_nSubrace, int a_bPrintToLog = TRUE )
{

    if( a_oCharacter != OBJECT_INVALID )
    {

        SEI_WriteSubraceLogEntry(
            "Setting subrace variable of character '" + GetName(a_oCharacter) +
            "' (played by '" + GetPCPlayerName(a_oCharacter) +
            "') to [" + IntToString(a_nSubrace) +
            "] '" + SEI_SubraceEnumToString(a_nSubrace) + "'.", !a_bPrintToLog );

        // Store the subrace on the character for easy reference later.
        SetLocalInt( a_oCharacter, SUBRACE_FIELD, a_nSubrace );

    } // End if

} // End SEI_SetSubraceVar


// Test to see if the subrace field (and base race) match to this subrace.
//
int SEI_TestSubraceField( struct Subrace a_stSubrace, int a_nRace, string a_sSubraceField )
{

    int nSubrace = SUBRACE_NONE;

    // If subrace's base race matches the to be tested race.
    if( a_stSubrace.m_nBaseRace == a_nRace )
    {

        // Global object whre the values are stored.
        object oModule = GetModule();

        // Basic field name of the stored field texts.
        string sTag = SUBRACE_STRUCT_TAG + IntToString(a_stSubrace.m_nID) + "_FIELD";

        // If this subrace is a default and no subrace was specified then use this subrace.
        if( a_stSubrace.m_bIsDefault && ( GetStringLength( a_sSubraceField ) == 0 ) )
        {
            nSubrace = a_stSubrace.m_nID;
        }
        else
        {

            // For each text stored (and so long as we haven't found a match).
            int nField;
            for( nField = 0 ;
                 ( nField < a_stSubrace.m_nNumFieldValues ) && ( nSubrace == SUBRACE_NONE ) ;
                 ++nField )
            {
                // Get the field text and test for a match.
                string sFieldText = GetLocalString( oModule, sTag + IntToString(nField) );
                if( FindSubString( a_sSubraceField, sFieldText ) != -1 )
                {
                    nSubrace = a_stSubrace.m_nID;
                }
            }

        } // End if-else

    } // End if

    return nSubrace;

} // End SEI_TestSubraceField


// Interpret the subrace string and return the subrace enum.
//
int SEI_ReadSubraceField( int a_nRace, string a_sSubraceField )
{

    int nSubrace = SUBRACE_NONE;

    // Get the total number of added subraces.
    int nNrSubraces = GetLocalInt( GetModule(), SUBRACE_COUNT );

    // For each subrace stored (and so long as we haven't found a match).
    int nIdx;
    for( nIdx = 0 ; ( nIdx < nNrSubraces ) && ( nSubrace == SUBRACE_NONE ) ; ++nIdx )
    {
        // Load the subrace information and check to see if there's a match.
        struct Subrace stSubrace = SEI_LoadSubraceIdx( nIdx );
        nSubrace = SEI_TestSubraceField( stSubrace, a_nRace, a_sSubraceField );
    }

    return nSubrace;

} // End SEI_ReadSubraceField


// Start the subrace dialog for character a_oCharacter.
//
void SEI_StartSubraceDialog( object a_oCharacter )
{
    if( a_oCharacter != OBJECT_INVALID )
    {
        AssignCommand( a_oCharacter, SetCommandable( TRUE, a_oCharacter ) );
        AssignCommand( a_oCharacter, ClearAllActions() );
        AssignCommand( a_oCharacter, ActionStartConversation( a_oCharacter, "sei_subraces", TRUE ) );
        AssignCommand( a_oCharacter, ActionDoCommand( SetCommandable( FALSE, a_oCharacter ) ) );
    }
}


// Reads the character's subrace field and sets the corresponding variable
// on the character. To do this it tries to interpret the subrace field on
// the character sheet.
//
int SEI_InitSubraceVar( object a_oCharacter )
{

    // Read the local variable off the character.
    int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

    // Only initialize the subrace variable if we haven't done so already.
    if( nSubrace == SUBRACE_NONE )
    {

        string sSubraceField = GetStringLowerCase( GetSubRace( a_oCharacter ) );

        SEI_WriteSubraceLogEntry( "Subrace field of " + GetName( a_oCharacter ) +
                                  " is '" + sSubraceField + "'", TRUE );

        nSubrace = SEI_ReadSubraceField( GetRacialType( a_oCharacter ), sSubraceField );

        SEI_WriteSubraceLogEntry( "Subrace of player " + GetName( a_oCharacter ) +
                                  " interpreted as " + IntToString( nSubrace ) +
                                  " (" + SEI_SubraceEnumToString( nSubrace ) + ")", TRUE );

        // See if we have recognized the subrace or not.
        if( nSubrace == SUBRACE_NONE )
        {
            if( GetIsPC( a_oCharacter ) )
            {
                // Ask the player for a subrace we understand.
                SEI_StartSubraceDialog( a_oCharacter );
            }
            else
            {
                // Assume the character is a monster.
                nSubrace = SUBRACE_MONSTER;
            }
        }

        // Store the subrace on the character for easy reference later.
        SEI_SetSubraceVar( a_oCharacter, nSubrace, FALSE );

    } // End if

    return nSubrace;

} // End SEI_InitSubraceVar


// Remove the subrace hide item of the character.
//
void SEI_RemoveSubraceHide( object a_oCharacter )
{

    // Get the item stored in the creature hide slot.
    object oHide = GetItemInSlot( INVENTORY_SLOT_CARMOUR, a_oCharacter );

    if( GetIsObjectValid( oHide ) &&
        ( GetStringLeft( GetTag( oHide ), 11 ) == "sei_subrace" ) )
    {
        DestroyObject( oHide );
    }

} // End SEI_RemoveSubraceHide


// Create the subrace hide item on the character.
//
void SEI_CreateSubraceHide( object a_oCharacter, string a_sHide )
{

    object oHide = CreateItemOnObject( a_sHide, a_oCharacter );

    if( oHide != OBJECT_INVALID )
    {
        //AssignCommand( a_oCharacter, ActionEquipItem( oHide, INVENTORY_SLOT_CARMOUR ) );
        ActionEquipItem( oHide, INVENTORY_SLOT_CARMOUR );
    }

} // End SEI_CreateSubraceHide


// Set the subrace hide item of the character to a_sHide.
//
void SEI_GiveSubraceHide( object a_oCharacter, string a_sHide )
{

    object oHide = GetItemInSlot( INVENTORY_SLOT_CARMOUR, a_oCharacter );

    string sHideTag = GetTag( oHide );

    // If this item isn't already equiped.
    if( sHideTag != a_sHide )
    {

        // Let the character stop doing whatever it is doing.
        AssignCommand( a_oCharacter, ClearAllActions() );

        // First remove whatever hide item is already set on the character.
        AssignCommand( a_oCharacter, ActionDoCommand( SEI_RemoveSubraceHide( a_oCharacter ) ) );

        // Create the subrace hide and equip it.
        // SEI_NOTE: Assigned as an action to correctly follow the removal of the item.
        AssignCommand( a_oCharacter, ActionDoCommand( SEI_CreateSubraceHide( a_oCharacter, a_sHide ) ) );

    } // End if

} // End SEI_GiveSubraceHide




// **************************************************************
// ** Subrace area functions
// **********************

// Read a specific setting of the settings.
//
int SEI_ReadAreaSetting( int a_nSettings, int a_nUnit )
{
    if( a_nUnit == 0 )
    {
        return SEI_AREA_NONE;
    }
    else
    {
        // SEI_NOTE: Making use of the integer-division rounding here.
        return ( ( ( a_nSettings % ( 10 * a_nUnit ) ) / a_nUnit ) * a_nUnit );
    }
}


// Get an area setting.
//
int SEI_GetAreaSetting( object a_oArea, int a_nSettings, int a_nUnit )
{

    // Read the passed settings to get the specific setting.
    int nResult = SEI_ReadAreaSetting( a_nSettings, a_nUnit );

    // If we want to use the default for the area...
    if( nResult <= a_nUnit )
    {

        // Read the area settings from the area.
        int nAreaSetting = GetLocalInt( a_oArea, AREA_SETTING );

        // Get the area setting.
        nResult = SEI_ReadAreaSetting( nAreaSetting, a_nUnit );

        // If the area uses the module default...
        if( nResult <= a_nUnit )
        {

            // Get the module.
            object oModule = GetModule();

            // Read the default settings from the module.
            nAreaSetting = GetLocalInt( oModule, AREA_SETTING );

            // Get the default setting.
            nResult = SEI_ReadAreaSetting( nAreaSetting, a_nUnit );

            // We're already at the default, so if it's default again then nothing is set.
            if( nResult <= a_nUnit )
            {
                nResult = SEI_AREA_NONE;
            }

        } // End if

    } // End if

    return nResult;

} // End SEI_GetAreaSetting


// Sets the area settings for the area.
// SEI_NOTE: I'd much rather use the toolset area settings, but I can't
//           access them from script.
//
void SEI_SetAreaSettings( object a_oArea, int a_nSettings )
{

    // If we have a valid object.
    if( GetIsObjectValid( a_oArea ) )
    {

        // Get the current default settings.
        int nDefaultSettings = GetLocalInt( a_oArea, AREA_SETTING );

        // Make sure we're not going to set the same settings again.
        if( nDefaultSettings != a_nSettings )
        {

            // Get the current default light setting.
            int nDefaultLight =( nDefaultSettings % 10 );

            // Get the current default underground setting.
            int nDefaultGround = ( ( nDefaultSettings % 100 ) / 10 ) * 10;

            // Get the rest of the current default settings.
            int nDefaultRest =( nDefaultSettings / 100 ) * 100;

            // Get the light setting.
            int nSettingLight = ( a_nSettings % 10 );

            // Get the underground setting.
            int nSettingGround = ( ( a_nSettings % 100 ) / 10 ) * 10;

            // If we're trying to set the light setting, then change it.
            if( nSettingLight > 0 )
            {
                nDefaultLight = nSettingLight;
            }

            // If we're trying to set the underground setting, then change it.
            if( nSettingGround > 0 )
            {
                nDefaultGround = nSettingGround;
            }

            // Combine the new settings to get the new default setting.
            int nNewDefaultSettings = nDefaultRest + nDefaultGround + nDefaultLight;

            // Set the new settings if they have changed.
            if( nNewDefaultSettings != nDefaultSettings )
            {
                SetLocalInt( a_oArea, AREA_SETTING, nNewDefaultSettings );
            }

        } // End if

    } // End if

} // End SEI_SetAreaSettings


// Sets the default area settings for the module.
//
void SEI_SetDefaultAreaSettings( int a_nSettings )
{

    // Get the module to store the defaults on.
    object oModule = GetModule();

    // Set the default settings on the module object.
    // SEI_NOTE: This is a bit of a sneaky way of doing this, but since the
    //           SEI_SetAreaSettings functions doesn't use the fact that it is
    //           an area being passed to it, it works.
    SEI_SetAreaSettings( oModule, a_nSettings );

} // End SEI_SetDefaultAreaSettings


// Remove the effects from the character if it isn't a subrace effect.
//
void SEI_RemoveEffect( object a_oCharacter, effect a_eEffect )
{

    //Remove all effects that are not created by the module.
    //Subrace traits are created by the module and will be left alone.
    // -Ariak

    if(GetEffectCreator(a_eEffect) != GetModule())
    {
        RemoveEffect(a_oCharacter, a_eEffect);
    }

    // Only remove effects not applied by the module.
    //if( ( GetEffectCreator( a_eEffect ) != GetModule() ) &&
    //    ( GetEffectSubType( a_eEffect ) != SUBTYPE_SUPERNATURAL ) )

} // End SEI_RemoveEffect


// Remove the effects from the character if it isn't a subrace effect.
//
void SEI_RemoveEffects( object a_oCharacter )
{

    // Go through all effects on the character.
    effect eEffect = GetFirstEffect( a_oCharacter );
    while( GetIsEffectValid( eEffect ) )
    {

        SEI_RemoveEffect( a_oCharacter, eEffect );

        eEffect = GetNextEffect( a_oCharacter );

    } // End while

} // End SEI_RemoveEffects


// Remove the subrace effects from the character.
//
void SEI_RemoveSubraceEffects( object a_oCharacter, int a_bIncludePermanent = TRUE,
                               int a_iEffectType = EFFECT_TYPE_INVALIDEFFECT )
{

    // Go through all effects on the character.
    effect eEffect = GetFirstEffect( a_oCharacter );
    while( GetIsEffectValid( eEffect ) )
    {

        // Only remove subrace effects.
        if( ( GetEffectSubType( eEffect ) == SUBTYPE_SUPERNATURAL ) &&
            ( ( a_iEffectType == EFFECT_TYPE_INVALIDEFFECT ) ||
              ( GetEffectType( eEffect ) == a_iEffectType ) ) &&
            ( ( a_bIncludePermanent ) ||
              ( GetEffectCreator( eEffect ) != GetModule() ) ) )
        {
            RemoveEffect( a_oCharacter, eEffect );
        }

        eEffect = GetNextEffect( a_oCharacter );

    } // End while

} // End SEI_RemoveSubraceEffects


void SEI_ApplyEffectToObject( int a_nDurationType, effect a_eEffect, object a_oTarget, float a_fDuration = 0.0, int a_bPermanent = FALSE )
{

    // Make the effect supernatural so that it persists through resting.
    AssignCommand( ( a_bPermanent ? GetModule() : GetArea( a_oTarget ) ),
        ApplyEffectToObject( a_nDurationType, SupernaturalEffect( a_eEffect ), a_oTarget, a_fDuration ) );

} // End SEI_ApplyEffectToObject


// Create the effect simulating stonecunning.
//
effect SEI_EffectStonecunning()
{

    // Stonecunning gives +2 on search checks while underground.
    effect eResult = EffectSkillIncrease( SKILL_SEARCH, 2 );

    // +2 to Hide checks while underground.
    // SEI_NOTE: Included in Stonecunning to safe from adding yet another attribute.
    eResult = EffectLinkEffects( eResult,
        EffectSkillIncrease( SKILL_HIDE, 2 ) );

    return eResult;

} // End SEI_EffectStonecunning


// Create the effect simulating light sensitivity.
//
effect SEI_EffectLightSensitivity( int a_nSeverity )
{

    // Decrease attack rolls.
    effect eResult = EffectAttackDecrease( a_nSeverity );

    // Decrease all saving throws.
    eResult = EffectLinkEffects( eResult,
        EffectSavingThrowDecrease( SAVING_THROW_ALL, a_nSeverity, SAVING_THROW_TYPE_ALL ) );

    // Decrease all skill checks.
    eResult = EffectLinkEffects( eResult,
        EffectSkillDecrease( SKILL_ALL_SKILLS, a_nSeverity ) );

    return eResult;

} // End SEI_EffectLightSensitivity


// Apply the area settings to the character.
//
void SEI_ApplyAreaSettings( object a_oCharacter, int a_nSettings )
{

    // If we have something to work with.
    if( GetIsObjectValid( a_oCharacter ) )
    {

        // Read the local variable off the character.
        int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

        // Make sure we actually have a subrace.
        if( nSubrace != SUBRACE_NONE )
        {

            // Load the information on the character's subrace.
            struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

            // Get the area the character is in.
            object oArea = GetArea( a_oCharacter );

            // If this subrace has stonecunning...
            if( stSubrace.m_nStonecunning )
            {

                // Get the ground setting (underground/above ground).
                int nGroundSetting = SEI_GetAreaSetting( oArea, a_nSettings, 10 );

                // Get if the character thinks it's above or underground.
                int nCharGround = GetLocalInt( a_oCharacter, GROUND_SETTING );

                // If this area is underground...
                if( nGroundSetting == SEI_AREA_UNDERGROUND )
                {

                    // If the character just went underground.
                    if( nCharGround != SEI_AREA_UNDERGROUND )
                    {

                        // Apply the stonecunning effect to the character.
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            SEI_EffectStonecunning(),
                            a_oCharacter );

                        // Remember that the character is underground.
                        SetLocalInt( a_oCharacter, GROUND_SETTING, SEI_AREA_UNDERGROUND );

                    } // End if

                }
                else
                {

                    // If the character just came above ground.
                    if( nCharGround != SEI_AREA_ABOVEGROUND )
                    {

                        // Remove the stonecunning effect.
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_SKILL_INCREASE );

                        // Remember that the character is above ground.
                        SetLocalInt( a_oCharacter, GROUND_SETTING, SEI_AREA_ABOVEGROUND );

                    } // End if

                } // End if-else

            } // End if (Stonecunning)

            // If this subrace is sensitive to light...
            if( stSubrace.m_nLightSensitivity > 0 )
            {

                // Get the light setting.
                int nLightSetting = SEI_GetAreaSetting( oArea, a_nSettings, 1 );

                // Get the amount of light the character is in.
                int nCharLight = GetLocalInt( a_oCharacter, LIGHT_SETTING );

                // If the character is in a light area...
                if( ( nLightSetting == SEI_AREA_LIGHT ) ||
                    ( ( nLightSetting == SEI_AREA_SUN ) && ( GetIsDay() || GetIsDawn() ) ) )
                {

                    // If the character just entered a light area.
                    if( nCharLight != SEI_AREA_LIGHT )
                    {

                        // Apply the light sensitivity effect to the character.
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            SEI_EffectLightSensitivity( stSubrace.m_nLightSensitivity ),
                            a_oCharacter );

                        // If the character is blinded by bright light...
                        if( stSubrace.m_fLightBlindness > 0.0 )
                        {

                            // Blind the character for the time specified.
                            SEI_ApplyEffectToObject(
                                DURATION_TYPE_TEMPORARY,
                                EffectBlindness(),
                                a_oCharacter,
                                stSubrace.m_fLightBlindness );

                        } // End if

                        // Remember that the character is in a light area.
                        SetLocalInt( a_oCharacter, LIGHT_SETTING, SEI_AREA_LIGHT );

                    } // End if

                }
                else
                {

                    // If the character just entered a dark area.
                    if( nCharLight != SEI_AREA_DARK )
                    {

                        // Remove the light sensitivity effect.
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_SKILL_DECREASE );

                        // Remember that the character is in a dark area.
                        SetLocalInt( a_oCharacter, LIGHT_SETTING, SEI_AREA_DARK );

                    } // End if

                } // End if-else

            } // End if (Light sensitivity)

        } // End if

    } // End if

} // End SEI_ApplyAreaSettings


// Set spacial traits to a character when the characters enters an area.
//
void SEI_EnterArea( object a_oCharacter, int a_nSettings )
{

    // If we have something to work with.
    if( GetIsObjectValid( a_oCharacter ) )
    {

        // Get the area the character is in.
        object oArea = GetArea( a_oCharacter );

        // Save the settings as the area settings.
        SEI_SetAreaSettings( oArea, a_nSettings );

        // Apply the settings to the character.
        SEI_ApplyAreaSettings( a_oCharacter, a_nSettings );

    } // End if

} // End SEI_EnterArea


// Note by Modal (1/19/03):
// This script is obsolete, and shouldn't be getting called
// anymore - see csm_heartbeat
void SEI_AreaHeartbeat( object a_oArea )
{

    // Get the area's light setting setting.
    int nAreaLightSetting = SEI_ReadAreaSetting( GetLocalInt( a_oArea, AREA_SETTING ), 1 );

    if( nAreaLightSetting == SEI_AREA_SUN )
    {

        // Is it currently light or dark?
        int bIsLight = ( GetIsDay() || GetIsDawn() );

        // What does the area think it is?
        int nAreaLight = GetLocalInt( a_oArea, LIGHT_SETTING );

        // Variable of whether the characters in the area need updating.
        int bMustUpdate = FALSE;

        // If it is light, but the area still thinks it's dark...
        if( bIsLight && ( nAreaLight != SEI_AREA_LIGHT ) )
        {

            // We must update the characters in the area.
            bMustUpdate = TRUE;

            // Update the light setting of the area.
            SetLocalInt( a_oArea, LIGHT_SETTING, SEI_AREA_LIGHT );

        }
        // If it is dark, but the area still thinks it's light...
        else if( !bIsLight && ( nAreaLight != SEI_AREA_DARK ) )
        {

            // We must update the characters in the area.
            bMustUpdate = TRUE;

            // Update the light setting of the area.
            SetLocalInt( a_oArea, LIGHT_SETTING, SEI_AREA_DARK );

        } // End if-elseif

        // If the characters in the area must be updated.
        if( bMustUpdate )
        {

            // Go through all the PCs.
            object oPC = GetFirstPC();
            while( GetIsObjectValid( oPC ) )
            {

                // If the PC is in this area then update the character.
                if( GetArea( oPC ) == a_oArea )
                {
                    SEI_ApplyAreaSettings( oPC, 0 );
                }

                oPC = GetNextPC();

            } // End while

        } // End if

    } // End if

} // End SEI_AreaHeartbeat




// **************************************************************
// ** Subrace initialization functions (cont.)
// **********************

// Set the character's correct hide item based on the subrace.
//
void SEI_SetSubraceHide( struct Subrace a_stSubrace, object a_oCharacter )
{

    // If we're using the subrace hide instead of the subrace effects....
    if( USE_SUBRACE_HIDE )
    {

        // Default subraces don't have any traits (past the default).
        if( a_stSubrace.m_bIsDefault )
        {
            // Give the subrace hide item without any attributes.
            SEI_GiveSubraceHide( a_oCharacter, "sei_subrace0" );
        }
        else
        {
            // Give the subrace hide item with the traits.
            SEI_GiveSubraceHide( a_oCharacter, "sei_subrace_" + IntToString( a_stSubrace.m_nID ) );
        }

    }
    else
    {

        SEI_RemoveSubraceHide( a_oCharacter );

    } // End if-else

} // End SEI_SetSubraceHide


// Give the spell-like abilities to the character depending on the subrace.
//
void SEI_GiveSpellLikeAbilities( struct Subrace a_stSubrace, object a_oCharacter )
{

    // If this subrace has a spell-like ability then give it to them.
    if( a_stSubrace.m_nSpellLikeAbility > 0 )
    {

        // Create the tag for the item.
        string sItemTag = "sei_sla_" + IntToString( a_stSubrace.m_nSpellLikeAbility );

        // Get an item with the tag (if the character has one).
        object oSpellItem = GetItemPossessedBy( a_oCharacter, sItemTag );

        // If the character doesn't have the item yet...
        if( ! GetIsObjectValid( oSpellItem ) )
        {
            // Create a new spell-like abilities item on the character.
            CreateItemOnObject( sItemTag, a_oCharacter );
        }

    } // End if

} // End SEI_GiveSpellLikeAbilities


// Apply the subrace traits for this subrace to the character.
//
void SEI_ApplySubraceTraits( struct Subrace a_stSubrace, object a_oCharacter )
{

    effect eSubraceEffect;

    int bFirstValidInited = FALSE;

    // Only do this if we're not using the subrace hide item for this.
    if( !USE_SUBRACE_HIDE )
    {

        // Global object where the values are stored.
        object oModule = GetModule();

        // Basic field name of the stored traits.
        string sTag = SUBRACE_STRUCT_TAG + IntToString(a_stSubrace.m_nID) + "_TRAIT";

        // For each trait stored...
        int nTrait;
        for( nTrait = 0 ; nTrait < a_stSubrace.m_nNumTraits ; ++nTrait )
        {

            // Get the string describing this trait.
            string sTraitString = GetLocalString( oModule, sTag + IntToString( nTrait ) );

            if( bFirstValidInited )
            {

                // Add the effect to the chain of effects we already have.
                eSubraceEffect =  EffectLinkEffects( eSubraceEffect,
                    SEI_ParseTrait( a_oCharacter, sTraitString ) );

            }
            else
            {

                // This may be the first trait, so just parse the trait string.
                eSubraceEffect = SEI_ParseTrait( a_oCharacter, sTraitString );

                // If this is the first valid effect then note that so.
                if( GetEffectType( eSubraceEffect ) != EFFECT_TYPE_INVALIDEFFECT )
                {
                    bFirstValidInited = TRUE;
                }

            } // End if-else

        } // End for

    } // End if

    // If this subrace has spell resistance, apply it based on character level.
    if( a_stSubrace.m_bSpellResistance )
    {

        // Create the spell resistance effect.
        effect eSREffect = EffectSpellResistanceIncrease( 11 + GetHitDice( a_oCharacter ) );

        // Link it if we haven't linked anything yet.
        if( bFirstValidInited )
        {
            eSubraceEffect = EffectLinkEffects( eSubraceEffect, eSREffect );
        }
        else
        {
            // This is the first valid effect.
            eSubraceEffect = eSREffect;
            bFirstValidInited = TRUE;
        }

    } // End if

    // If we have something to apply, then apply it to the character.
    if( bFirstValidInited )
    {
        SEI_ApplyEffectToObject( DURATION_TYPE_PERMANENT,
            eSubraceEffect, a_oCharacter, 0.0, TRUE );
    }

} // End SEI_ApplySubraceTraits


// Reads the character's subrace field and sets the corresponding traits
// on the character.
//
void SEI_InitSubraceTraits( object a_oCharacter, int a_bIncludeItems = TRUE )
{

    // Read the local variable off the character.
    int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

    // Make sure we actually have a subrace.
    if( nSubrace != SUBRACE_NONE )
    {

        // Load the information on the character's subrace.
        struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

        // If we also want to include the items
        if( a_bIncludeItems )
        {

            // Set the subrace hide item to te character.
            SEI_SetSubraceHide( stSubrace, a_oCharacter );

            // Give the spell-like abilities item.
            SEI_GiveSpellLikeAbilities( stSubrace, a_oCharacter );

        } // End if

        // Apply the subrace's racial traits to the character.
        SEI_ApplySubraceTraits( stSubrace, a_oCharacter );

        // Apply effects based on the area settings if needed.
        SEI_ApplyAreaSettings( a_oCharacter, 0 );

    } // End if

} // End SEI_InitSubraceTraits


// Remove all possible subrace stuff from the character.
//
void SEI_RemoveSubrace( object a_oCharacter, int a_bRemoveItems = TRUE )
{

    if( GetIsObjectValid( a_oCharacter ) )
    {

        if( a_bRemoveItems )
        {

            // Remove the subrace hide.
            SEI_RemoveSubraceHide( a_oCharacter );

            int nSpellItem;
            for( nSpellItem = 1 ; nSpellItem <= 3 ; ++nSpellItem )
            {

                // Get the spell-like ability item.
                object oSpellItem = GetItemPossessedBy( a_oCharacter, "sei_sla_" + IntToString( nSpellItem ) );

                // If the character has the object, then destroy it.
                if( GetIsObjectValid( oSpellItem ) )
                {
                    DestroyObject( oSpellItem );
                }

            } // End for

        } // End if

        SEI_RemoveSubraceEffects( a_oCharacter );

    } // End if

} // End SEI_RemoveSubrace


// Initializes the subrace for character a_oCharacter.
//
void SEI_InitSubrace( object a_oCharacter )
{

    // Sanity check, make sure we have something to work with.
    if( GetIsObjectValid( a_oCharacter ) )
    {

        // Get the character's subrace.
        int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

        SEI_RemoveSubrace( a_oCharacter, FALSE );

        // See if this character's subrace has been initialized before.
        if( nSubrace == SUBRACE_NONE )
        {

            // Initialize the subrace variable on the character.
            nSubrace = SEI_InitSubraceVar( a_oCharacter );

            // See if we successfully initialized the character's subrace.
            if( nSubrace != SUBRACE_NONE )
            {

                // Initialize the subrace traits on the character.
                SEI_InitSubraceTraits( a_oCharacter );

                // Send a message that the subrace has been inited.
                SEI_SendSubraceInitMsg( a_oCharacter, nSubrace );

            } // End if

        }
        else
        {

            // Initialize the subrace traits on the character.
            SEI_InitSubraceTraits( a_oCharacter );

        } // End if

    } // End if

} // End SEI_InitSubrace


// Finishes the subrace dialog for the character, initializing the subrace.
//
void SEI_FinishSubraceDialog( object a_oCharacter )
{

    SetCommandable( TRUE, a_oCharacter );

    // Sanity check, make sure we have something to work with.
    if( GetIsObjectValid( a_oCharacter ) )
    {
        // Initialize the subrace for the effects, etc.
        SEI_InitSubraceTraits( a_oCharacter );
        SEI_SendSubraceInitMsg( a_oCharacter, GetLocalInt( a_oCharacter, SUBRACE_FIELD ) );
    }

} // End SEI_FinishSubraceDialog




// **************************************************************
// ** Subrace active functions
// **********************

// Modifies the character's subrace attributes on a character's level up.
//
void SEI_LevelUpSubrace( object a_oCharacter )
{

    // Read the local variable off the character.
    int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

    // Make sure that we actually have a subrace.
    if( nSubrace != SUBRACE_NONE )
    {

        // Load the information on the character's subrace.
        struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

        // If this subrace has spell resistance then increase it.
        if( stSubrace.m_bSpellResistance )
        {

            // Create the spell resistance effect (for being higher it overrides the old values).
            effect eSREffect = EffectSpellResistanceIncrease( 11 + GetHitDice( a_oCharacter ) );

            // Apply the effect to the character.
            SEI_ApplyEffectToObject( DURATION_TYPE_INSTANT, eSREffect, a_oCharacter, 0.0, TRUE );

        } // End if

    } // End if

} // End SEI_LevelUpSubrace


// Returns the subrace (enum) for the target.
//
int SEI_GetCharacterSubrace( object a_oCharacter )
{

    int nSubrace = SUBRACE_NONE;

    // Sanity check, make sure we have something to work with.
    if( a_oCharacter != OBJECT_INVALID )
    {

        // Read the local variable off the character.
        nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

        // Write the findings into the log.
        SEI_WriteSubraceLogEntry( "Subrace of player " + GetName( a_oCharacter ) +
                                  " is " + IntToString( nSubrace ) +
                                  " (" + SEI_SubraceEnumToString( nSubrace ) + ")", TRUE );

        // If subrace not initialized yet.
        if( nSubrace == SUBRACE_NONE )
        {
            SEI_InitSubrace( a_oCharacter );
            nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );
        } // End if

    } // End if

    // Return the character's subrace.
    return nSubrace;

} // End SEI_GetCharacterSubrace


// Returns whether the character is of subrace a_nSubrace.
//
int SEI_IsCharacterOfSubrace( object a_oCharacter, int a_nSubrace )
{
    return SEI_GetCharacterSubrace( a_oCharacter ) == a_nSubrace;
}


// Returns the effective character level of the character.
//
int SEI_GetEffectiveCharacterLevel( object a_oCharacter )
{
    return GetHitDice( a_oCharacter ) + SEI_GetECLAdd( a_oCharacter );
}


// Make sure that the character has the subrace items they're supposed to have.
//
void SEI_KeepSubraceItem( object a_oCharacter )
{

    // Have we been given a valid character?
    if( GetIsObjectValid( a_oCharacter ) )
    {

        // Read the local variable off the character.
        int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

        // Make sure we actually have a subrace.
        if( nSubrace != SUBRACE_NONE )
        {

            // Load the information on the character's subrace.
            struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

            // Give the spell-like abilities item.
            SEI_GiveSpellLikeAbilities( stSubrace, a_oCharacter );

        } // End if

    } // End if

} // End SEI_KeepSubraceItem


// Make sure that the subrace item is removed when someone loses it.
//
int SEI_DropSubraceItem( object a_oItem )
{

    // If this is a spell-like ability item...
    if( GetStringLeft( GetTag( a_oItem ), 8 ) == "sei_sla_" )
    {

        // Destroy the item.
        DestroyObject( a_oItem );

        // Return the we've recognized the item.
        return TRUE;

    }
    else
    {

        // This is not a spell-like ability item,
        // so return we haven't recognized it.
        return FALSE;

    } // End if-else

} // End SEI_DropSubraceItem




// **************************************************************
// ** Subrace experience functions
// **********************

// Finds the default subrace for the race.
//
int SEI_FindDefaultSubrace( int a_nRace )
{

    // Global object where the values are stored.
    object oModule = GetModule();

    // Get the total number of added subraces.
    int nNrSubraces = GetLocalInt( oModule, SUBRACE_COUNT );

    // For all stored subraces...
    int nIdx;
    for( nIdx = 0 ; nIdx < nNrSubraces ; ++nIdx )
    {

        // The base field name the values are stored under.
        string sTag = SUBRACE_STRUCT_TAG + IntToString( nIdx ) + "_";

        // If this is the default subrace for the race...
        if( ( GetLocalInt( oModule, sTag + "RACE" ) == a_nRace ) &&
            GetLocalInt( oModule, sTag + "DEF" ) )
        {
            // Return the ID of the subrace.
            return GetLocalInt( oModule, sTag + "ID" );
        }

    } // End for

    // There is no default race for this subrace.
    return SUBRACE_NONE;

} // End SEI_FindDefaultSubrace


// Returns the favored class for the subrace.
//
int SEI_GetFavoredClass( object a_oCharacter, struct Subrace a_stSubrace, int n_aHighestClass )
{

    int nResult = CLASS_TYPE_INVALID;

    int nClass = -1;

    // Get te favored class depending on the gender of the character.
    if( GetGender( a_oCharacter ) == GENDER_FEMALE )
    {
        nClass = a_stSubrace.m_nFavoredClassF;
    }
    else if( GetGender( a_oCharacter ) == GENDER_MALE )
    {
        nClass = a_stSubrace.m_nFavoredClassM;
    }

    // If we have a favored class...
    if( nClass >= 0 )
    {

        // If no specific class is specified then take the highest class.
        if( nClass == CLASS_TYPE_INVALID )
        {
            nResult = n_aHighestClass;
        }
        else
        {
            nResult = nClass;
        }

    } // End if

    return nResult;

}  // End SEI_GetFavoredClass


// Find the favored class for the subrace.
//
int SEI_FindFavoredClass( object a_oCharacter, struct Subrace a_stSubrace, int n_aHighestClass )
{

    // Get the favored class for the subrace.
    int nResult = SEI_GetFavoredClass( a_oCharacter, a_stSubrace, n_aHighestClass );

    // If no favored class was specified...
    if( nResult == CLASS_TYPE_INVALID )
    {

        // Get the favored class for the subrace's base race.
        nResult = SEI_GetFavoredClass(
            a_oCharacter,
            SEI_LoadSubrace( SEI_FindDefaultSubrace( a_stSubrace.m_nBaseRace ) ),
            n_aHighestClass );

    } // End if

    return nResult;

}  // End SEI_FindFavoredClass


// Calculate the amount of experience the character of would get with these two classes.
// It is assumed that a_nHigh is the highest level in a class.
// It is assumed that the favored class is already dropped.
//
float SEI_CalcXPPenaltyForClasses( int a_nHigh, int a_nLow )
{

    // Start without a penalty.
    float fPenalty = 0.0;

    // If the difference between the highest class and the other class is too
    // high then increase the penalty.
    if( ( a_nLow != 0 ) && ( ( a_nHigh - a_nLow ) > 1 ) )
    {
        fPenalty += 0.2;
    }

    return fPenalty;

} // End SEI_CalcXPPenaltyForClasses


// Calculate the amount of experience penalty the character will get.
// Sorts level according to highest level and drops the favored class.
//
float SEI_DropForFavoredClass( object a_oCharacter, struct Subrace a_stSubrace, int a_nClass1, int a_nLevel1, int a_nClass2, int a_nLevel2, int a_nClass3, int a_nLevel3 )
{

    // Get the class with the most levels.
    int nHighestClass = CLASS_TYPE_INVALID;
    if( a_nLevel2 > a_nLevel1 )
    {
        nHighestClass = ( ( a_nLevel3 > a_nLevel2 ) ? a_nClass3 : a_nClass2 );
    }
    else
    {
        nHighestClass = ( ( a_nLevel3 > a_nLevel1 ) ? a_nClass3 : a_nClass1 );
    }

    // Find the favored class for this subrace.
    int nFavoredClass = SEI_FindFavoredClass( a_oCharacter, a_stSubrace, nHighestClass );

    // Ignore the level in the favored class.
    int nLevel1 = ( ( a_nClass1 == nFavoredClass ) ? 0 : a_nLevel1 );
    int nLevel2 = ( ( a_nClass2 == nFavoredClass ) ? 0 : a_nLevel2 );
    int nLevel3 = ( ( a_nClass3 == nFavoredClass ) ? 0 : a_nLevel3 );

    // Sort the first and the second level to highest.
    int nTempHigh = ( ( nLevel1 > nLevel2 ) ? nLevel1 : nLevel2 );
    int nLow1 =     ( ( nLevel1 > nLevel2 ) ? nLevel2 : nLevel1 );

    // Sort the third level and the current highest.
    int nHigh = ( ( nLevel3 > nTempHigh ) ? nLevel3 : nTempHigh );
    int nLow2 = ( ( nLevel3 > nTempHigh ) ? nTempHigh : nLevel3 );

    // Start without a penalty.
    float fPenalty = 0.0;

    // Calculate the penalty for the two lower classes in relation to the higher one.
    fPenalty += SEI_CalcXPPenaltyForClasses( nHigh, nLow1 );
    fPenalty += SEI_CalcXPPenaltyForClasses( nHigh, nLow2 );

    // Return the calculated penalty.
    return fPenalty;

} // End SEI_DropForFavoredClass


// Modify the amount of experience for the character's favored class.
//
int SEI_ModifyXPForFavoredClass( object a_oCharacter, int a_nXP )
{

    int nXP = a_nXP;

    // Get the three classes the character has.
    int nClass1 = GetClassByPosition( 1, a_oCharacter );
    int nClass2 = GetClassByPosition( 2, a_oCharacter );
    int nClass3 = GetClassByPosition( 3, a_oCharacter );

    // If character only has one class then this isn't an issue.
    if( nClass2 != CLASS_TYPE_INVALID )
    {

        // Get the number of levels in the character's classes.
        int nLevel1 = GetLevelByClass( nClass1, a_oCharacter );
        int nLevel2 = GetLevelByClass( nClass2, a_oCharacter );
        int nLevel3 = 0;

        // If this character has three classes get the level in the third class.
        if(  nClass3 != CLASS_TYPE_INVALID  )
        {
            nLevel3 = GetLevelByClass( nClass3, a_oCharacter );
        }

        // Load the character's subrace.
        struct Subrace stSubrace = SEI_LoadSubrace( SEI_GetCharacterSubrace( a_oCharacter ) );

        // Get the normal XP modification.
        float fNormalMod = 1.0 - SEI_DropForFavoredClass(
            a_oCharacter, SEI_LoadSubrace( SEI_FindDefaultSubrace( stSubrace.m_nBaseRace ) ),
            nClass1, nLevel1, nClass2, nLevel2, nClass3, nLevel3 );

        // Get the XP modification for subrace.
        float fSubraceMod = 1.0 - SEI_DropForFavoredClass(
            a_oCharacter, stSubrace, nClass1, nLevel1, nClass2, nLevel2, nClass3, nLevel3 );

        // Undo the normal penalty and set the new one.
        // SEI_NOTE: No danger of div-0 as the max penalty is 40%.
        nXP = FloatToInt( IntToFloat( nXP ) * ( fSubraceMod / fNormalMod ) );

    } // End if

    return nXP;

} // End SEI_ModifyXPForFavoredClass


// Modify the experience to take into acount any ECL modification.
//
int SEI_ModifyXPForECL( object a_oCharacter, int a_nXP )
{

    // Get the level without ECL modification.
    float fBaseLevel = IntToFloat( GetHitDice( a_oCharacter ) );

    // Get the amount of ECL modification.
    int nECLAdd = SEI_GetECLAdd( a_oCharacter );

    // Calculate how much to modify the experience.
    float fModify = ( fBaseLevel / ( fBaseLevel + nECLAdd ) );

    // Modify the experience and return.
    return FloatToInt( fModify * a_nXP );

} // End SEI_ModifyXPForECL


// Modify the experience the character would get to correct for subrace.
//
int SEI_ModifyXPForSubrace( object a_oCharacter, int a_nXP )
{

    int nXP = a_nXP;

    nXP = SEI_ModifyXPForFavoredClass( a_oCharacter, nXP );

    nXP = SEI_ModifyXPForECL( a_oCharacter, nXP );

    return nXP;

} // End SEI_ModifyXPForSubrace


