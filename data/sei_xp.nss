//
//  NWExperience
//
//  XP functionality to replace NWN standard XP handling
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
//  1/10/03                         Cereborn
//  - added XP_RewardXPForQuest() and XP_RewardXPToPartyForQuest()
//
//  8/17/03                         Cereborn
//  - modified to use the highest level party member as the party
//    level for XP calculation.
//  - modified to award no XP if party level is > the creature CR + 3.
//  - modified to use hit dice instead of ECL when splitting party XP.
//
////////////////////////////////////////////////////////////////////////

#include "dim_returns"

//void main(){}

// **************************************************************
// ** Constants
// **********************

// This value is added to the EL of a monster to determine if it's
// enough of a challenge to warrant any XP award to a player (or
// party).  If the player level is > than the monster EL plus this
// value, 1 XP is awarded.
const int XP_MAX_EL_LEVEL_DIFFERENCE = 3;

// If the player level is > than the monster EL plus this
// value, 0 XP is awarded.
const int XP_ULTRAMAX_EL_LEVEL_DIFFERENCE = 7;

// These special values are used to indicate that 1 or 0 XP should be awarded
// due to EL vs. party considerations
const int XP_AWARD_1_XP = -1;
const int XP_AWARD_0_XP = -2;

int XP_DEBUG_XP = FALSE;

// **************************************************************
// ** Forward declarations
// **********************

// Private function for the subraces script. Do not use.
int SEI_GetEffectiveCharacterLevel( object a_oCharacter );

// Private function for the subraces script. Do not use.
int SEI_ModifyXPForSubrace( object a_oCharacter, int a_nXP );

// **************************************************************
// ** Forward declarations for the Script Editor Help.
// **********************

// Reward experience to the character.
//  ARGUMENTS:
//      a_oCharacter    = The character to give the experience to.
//      a_nXP           = The experience to give to the character.
//
void XP_RewardXP( object a_oCharacter, int a_nXP );

// Give XP to a party dividing it between them based on level.
//  ARGUMENTS:
//      a_oCharacter    = One of the party members to give the experience to.
//      a_oArea         = Only party members in this area will get XP.
//      a_nXP           = The amount of experience to divide between the party.
//
void XP_RewardXPToPartyInArea( object a_oCharacter, object a_oArea, int a_nXP );

// Reward characters experience for a kill.
// Use in a creature's OnDeath script.
//
void XP_RewardXPForKill();

// Reward experience to a party for completing a quest.
//  ARGUMENTS:
//      oQuester          = One of the party members to give the experience to.
//      fChallengeRating  = Challenge rating for the quest.
//      oRecordKeeper     = OPTIONAL(Diminishing Returns)  The object on which
//                          quest completion info is kept.
//      nFullXPAllowed    = OPTIONAL(Diminishing Returns)  The number of times
//                          the quest may be completed for FULL XP
//      nDimXPAllowed     = OPTIONAL(Diminishing Returns)  The number of times
//                          the quest may be completed for add'l diminished XP
//      nDimXPAllowed     = OPTIONAL(Diminishing Returns)  An ID that can be
//                          used to allow info from multiple quests on a single
//                          recordkeeper object
//      Return:             XP Awarded
//
int XP_RewardXPToPartyForQuest(object oQuester, float fChallengeRating,
   object oRecordKeeper = OBJECT_INVALID, int nFullXPAllowed = 1,
      int nDimXPAllowed = 0, int nAwardID=0);

// Reward experience to a single player for completing a quest.
//  ARGUMENTS:
//      oQuester          = One of the party members to give the experience to.
//      fChallengeRating  = Challenge rating for the quest.
//      oRecordKeeper     = OPTIONAL(Diminishing Returns)  The object on which
//                          quest completion info is kept.
//      nFullXPAllowed    = OPTIONAL(Diminishing Returns)  The number of times
//                          the quest may be completed for FULL XP
//      nDimXPAllowed     = OPTIONAL(Diminishing Returns)  The number of times
//                          the quest may be completed for add'l diminished XP
//      nDimXPAllowed     = OPTIONAL(Diminishing Returns)  An ID that can be
//                          used to allow info from multiple quests on a single
//                          recordkeeper object
//      Return:             XP Awarded
//
int XP_RewardXPForQuest(object oQuester, float fChallengeRating,
   object oRecordKeeper = OBJECT_INVALID, int nFullXPAllowed = 1,
      int nDimXPAllowed = 0, int nAwardID=0);

// This just retrieves the value of "AlfaEncounterLevel" on the mob if
// recorded, otherwise returns the creature's CR
float GetEncounterLevel( object oKilled )
{
  int nEL = GetLocalInt( oKilled, "AlfaEncounterLevel" );
  float fEL = IntToFloat( nEL );

  if (fEL <= 0.)
  {
    fEL = GetChallengeRating(oKilled);
  }

  return fEL;
}

// Make certain the character doesn't get more than one level from their xp gain.
//
int XP_CapXPToMaxGain( object a_oCharacter, int a_nXP )
{

    int nResult = a_nXP;

    // Get the character's level (ECL).
    int nLevel = SEI_GetEffectiveCharacterLevel( a_oCharacter );

    // Get how much experience the character has.
    int nXP = GetXP( a_oCharacter );

    // Get the maximum number of levels the character can gain.
    int nMaxLevelGain = ( ( nLevel >= 20 ) ? 0 : 1 );

    // Get the maximum experience the character is allowed to have.
    int nMaxXP = ( 500 * ( ( nLevel + nMaxLevelGain + 1 ) * ( nLevel + nMaxLevelGain ) ) ) - 1;

    // Get the maximum amount of experience the character can gain.
    int nMaxXPGain = nMaxXP - nXP;

    // Cap the character's experience gain to a maximum gain.
    if( nResult > nMaxXPGain )
    {
        nResult = nMaxXPGain;
    }

    return nResult;

} // End XP_CapXPToMaxGain


// Reward experience to the character.
//
void XP_RewardXP( object a_oCharacter, int a_nXP )
{

    int nXP = a_nXP;

    if ( nXP < 0 )
    {
        if ( nXP == XP_AWARD_0_XP )
        {
            if (XP_DEBUG_XP)
            {
                SpeakString(GetName( a_oCharacter ) +
                    " received 0 XP due to EL vs. party lvl considerations.");
            }

            nXP = 0;
        }

        else
        {
            if (XP_DEBUG_XP)
            {
                SpeakString(GetName( a_oCharacter ) +
                    " received 1 XP due to EL vs. party lvl considerations.");
            }
            nXP = 1;
        }
    }

    else
    {
        if (XP_DEBUG_XP)
        {
            SpeakString(GetName( a_oCharacter ) + " received " +
                IntToString( FloatToInt((ADVANCE_XP_SCALE * nXP) + 0.5 )  ) +
                " before ECL adjustment");
        }

        nXP = SEI_ModifyXPForSubrace( a_oCharacter, nXP );
        nXP = FloatToInt( (ADVANCE_XP_SCALE * nXP) + 0.5 );

        if (XP_DEBUG_XP)
        {
            SpeakString(GetName( a_oCharacter ) + " received " +
                IntToString( nXP ) + " after ECL adjustment");
        }

        nXP = XP_CapXPToMaxGain( a_oCharacter, nXP );
    }

    GiveXPToCreature( a_oCharacter, nXP );

} // End XP_RewardXP


// Give XP to a party dividing it between them based on level.
//
void XP_RewardXPToPartyInArea( object a_oCharacter, object a_oArea, int a_nXP )
{

    // SEI_NOTE: There now is an exploit where higher level character can boost
    //           the XP from encounters by including low-level PC (and thus
    //           lowering the avarage level).
    //
    //           This exploit was eliminated 8/17/03 :)

    int nPartyMembers = 0;
    int nPartyLevelTotal = 0;
    object oPC = GetFirstFactionMember( a_oCharacter );

    int nCharXP;
    float fDimRetFactor;

    // First get the number of party members and total level.
    while( GetIsObjectValid( oPC ) )
    {

        if( !GetIsDM( oPC ) && ( a_oArea == GetArea( oPC ) ) )
        {
            ++nPartyMembers;

            // We now use character level for XP distribution, not ECL;
            // Using ECL meant the player got a bigger portion of the XP,
            // negating the ECL XP penalty
            nPartyLevelTotal += GetHitDice( oPC );
        }

        oPC = GetNextFactionMember( a_oCharacter, TRUE );

    } // End while

    oPC = GetFirstFactionMember( a_oCharacter );

    // Apply experience to each PC based on their level.
    while( GetIsObjectValid( oPC ) )
    {

        if( !GetIsDM( oPC ) && ( a_oArea == GetArea( oPC ) ) )
        {
            if ( a_nXP < 0 )
            {
                nCharXP = a_nXP; // just pass this special case through
            }

            else
            {
                nCharXP = FloatToInt( IntToFloat( a_nXP ) *
                    ( IntToFloat( GetHitDice( oPC ) ) /
                    IntToFloat( nPartyLevelTotal ) ) );

                fDimRetFactor = XP_GetDimReturnsXPFactor( oPC );

                nCharXP = FloatToInt( ( fDimRetFactor * nCharXP ) + 0.5 );
            }

            XP_RewardXP( oPC, nCharXP );
        }

        oPC = GetNextFactionMember( a_oCharacter, TRUE );

    } // End while

} // End XP_RewardXPToPartyInArea


// Get how much experience the CR is worth to a character of the average level.
//
int XP_GetXPFromCR( float a_fCR, float a_fAvgLvl )
{
    // Base experience to build the experience from.
    float fXP = 300.0;

    if( ( a_fAvgLvl >= 7.0 ) || ( a_fCR >= 1.5 ) )
    {

        fXP *= a_fAvgLvl;

        int nDiff = FloatToInt( ( ( a_fCR < 1.0 ) ? 1.0 : a_fCR ) - a_fAvgLvl );

        switch( nDiff )
        {

            // SEI_NOTE: Broken with styleguide for readability.

            case -7:    fXP /= 12.0;        break;
            case -6:    fXP /= 8.0;         break;
            case -5:    fXP *= 3.0 / 16.0;  break;
            case -4:    fXP /= 4.0;         break;
            case -3:    fXP /= 3.0;         break;
            case -2:    fXP /= 2.0;         break;
            case -1:    fXP *= 2.0 / 3.0;   break;
            case  0:                        break;
            case  1:    fXP *= 3.0 / 2.0;   break;
            case  2:    fXP *= 2.0;         break;
            case  3:    fXP *= 3.0;         break;
            case  4:    fXP *= 4.0;         break;
            case  5:    fXP *= 6.0;         break;
            case  6:    fXP *= 8.0;         break;
            case  7:    fXP *= 12.0;        break;
            // nDiff > 7 || nDiff < -7
            default:    fXP = 0.0;          break;

        } // End switch-case

    } // End if

    // Calculations for CR < 1
    if( ( a_fCR < 0.76 ) && ( fXP > 0.0 ) )
    {

        // SEI_NOTE: Broken with styleguide for readability.

             if( a_fCR <= 0.11 ) { fXP /= 10.0; }
        else if( a_fCR <= 0.13 ) { fXP /=  8.0; }
        else if( a_fCR <= 0.18 ) { fXP /=  6.0; }
        else if( a_fCR <= 0.28 ) { fXP /=  4.0; }
        else if( a_fCR <= 0.40 ) { fXP /=  3.0; }
        else if( a_fCR <= 0.76 ) { fXP /=  2.0; }

        // Only the CR vs Avg Level table could set nMonsterXP to 0...
        // to fix any round downs that result in 0:
        if( fXP <= 0.0 )
        {
            fXP = 1.0;
        }

    } // End if

    return FloatToInt( fXP );

} // End XP_GetXPFromCR

// Reward characters experience for a kill.
// Use in a creature's OnDeath script.
//
// ** Modified 12/01/02 to use XP_GetDimReturnsXPFactor() instead of
// the static MONSTER_XP_SCALE.
//
void XP_RewardXPForKill()
{

    object oKiller = GetLastKiller();
    if (XP_DEBUG_XP)
    {
      SpeakString("I was killed by " + GetName(XP_FindTrueKiller(oKiller)));
    }

    object oKilledArea = GetArea( OBJECT_SELF );

    float fPartyLevel = -1.0;
    float fCurrentPC_ECL;    // temp variable

    object oPC = GetFirstFactionMember( oKiller );

    while( GetIsObjectValid( oPC ) )
    {

        if( !GetIsDM( oPC ) && ( oKilledArea == GetArea( oPC ) ) )
        {
            fCurrentPC_ECL = IntToFloat (
               SEI_GetEffectiveCharacterLevel( oPC ) );

            if (fCurrentPC_ECL > fPartyLevel)
            {
                fPartyLevel = fCurrentPC_ECL;
            }

        }

        oPC = GetNextFactionMember( oKiller, TRUE );

    } // End while

    if (XP_DEBUG_XP)
    {
      SpeakString("I was killed by a party of level " +
         FloatToString(fPartyLevel));
    }

    // Bring partylevel up to 3 if less than 3
    if( fPartyLevel < 3.0 )
    {
        fPartyLevel = 3.0;
    }

    float fCR = GetChallengeRating( OBJECT_SELF );
    float fEL = GetEncounterLevel( OBJECT_SELF );

    if (XP_DEBUG_XP)
    {
      SpeakString("party level: " + FloatToString(fPartyLevel) +
         " - encounter level: " + FloatToString(fEL));
    }

    int nTotalXP;

    // Check that the encounter is appropriate for the party
    if ( fPartyLevel > (fEL + XP_MAX_EL_LEVEL_DIFFERENCE) )
    {

      // strip all loot from the creature
      if(gALFA_DESTROY_LOOT_ON_HIGH_EL)
      {
      DestroyInventory(OBJECT_SELF);
      DestroyEquipped(OBJECT_SELF);
      }

      if ( fPartyLevel > (fEL + XP_ULTRAMAX_EL_LEVEL_DIFFERENCE) )
      {
            nTotalXP = XP_AWARD_0_XP;
      }

      else
      {
            nTotalXP = XP_AWARD_1_XP;
      }

    }

    else
    {
      nTotalXP = XP_GetXPFromCR( fCR, fPartyLevel );
    }

    XP_RewardXPToPartyInArea( oKiller, oKilledArea, nTotalXP);

} // End XP_RewardXPForKill


int XP_RewardXPForQuest(object oQuester, float fChallengeRating,
   object oRecordKeeper = OBJECT_INVALID, int nFullXPAllowed = 1,
      int nDimXPAllowed = 0, int nAwardID=0)
{
    int nLevel = SEI_GetEffectiveCharacterLevel( oQuester );

    // Bring partylevel up to 3 if less than 3
    if( nLevel < 3 )
    {
        nLevel = 3;
    }

    int nTotalXP = XP_GetXPFromCR( fChallengeRating, IntToFloat( nLevel ) );
    //SpeakString("Quest worth " + IntToString(nTotalXP) + " XP");

    float fXPFactor = XP_GetDimReturnsQuestXPFactor( oQuester, oRecordKeeper,
       nFullXPAllowed, nDimXPAllowed, FALSE, nAwardID );

    int nAward = FloatToInt( ( fXPFactor * nTotalXP ) + 0.5 );
    XP_RewardXP( oQuester,  nAward);
    return FloatToInt( ( nAward * ADVANCE_XP_SCALE ) + 0.5 );

} // End XP_RewardXPForQuest


int XP_RewardXPToPartyForQuest(object oQuester, float fChallengeRating,
   object oRecordKeeper = OBJECT_INVALID, int nFullXPAllowed = 1,
      int nDimXPAllowed = 0, int nAwardID=0)
{
    object oQuestArea = GetArea( oQuester );
    int nPartyMembers = 0;
    int nPartyLevelTotal = 0;
    int nXPAward = 0;

    object oPC = GetFirstFactionMember( oQuester );

    while( GetIsObjectValid( oPC ) )
    {
        if( !GetIsDM( oPC ) && ( oQuestArea == GetArea( oPC ) ) )
        {
            ++nPartyMembers;
            nPartyLevelTotal += SEI_GetEffectiveCharacterLevel( oPC );
        }

        oPC = GetNextFactionMember( oQuester, TRUE );
    } // End while

    if( nPartyMembers != 0 )
    {
        float fAvgPartyLevel = IntToFloat( nPartyLevelTotal ) /
            IntToFloat( nPartyMembers );

        // Bring partylevel up to 3 if less than 3
        if( fAvgPartyLevel < 3.0 )
        {
            fAvgPartyLevel = 3.0;
        }

        int nTotalXP = XP_GetXPFromCR( fChallengeRating, fAvgPartyLevel );
        //SpeakString("Quest worth " + IntToString(nTotalXP) + " XP");

        float fXPFactor = XP_GetDimReturnsQuestXPFactor( oQuester, oRecordKeeper,
           nFullXPAllowed, nDimXPAllowed, TRUE, nAwardID );

        nXPAward = FloatToInt( ( fXPFactor  * nTotalXP ) + 0.5 );

        XP_RewardXPToPartyInArea( oQuester, oQuestArea, nXPAward);

    } // End if

    return FloatToInt( ( nXPAward * ADVANCE_XP_SCALE ) + 0.5 );

} // End XP_RewardXPForQuest


