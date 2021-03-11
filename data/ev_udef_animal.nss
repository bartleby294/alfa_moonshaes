//::///////////////////////////////////////////////
//:: Custom User Defined Event
//:: FileName
//:://////////////////////////////////////////////
/*
    Userdefined script for animals.
*/
//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 21/08/2002
//:://////////////////////////////////////////////

#include "ALFA_EVAINE"
#include "NW_I0_GENERIC"
#include "ms_xp_util"


void SetAlert( int bAlert )
{
    SetLocalInt( OBJECT_SELF, "EV_ALERT", bAlert );
}

int IsAlert()
{
    return GetLocalInt( OBJECT_SELF, "EV_ALERT" );
}

int IsFriendly( object oPC )
{
    if ( GetIsFriend( oPC ) ) return TRUE;
    if ( GetIsEnemy( oPC ) ) return FALSE;
    int iTimeStamp = GetCalendarYear() * 365
                   + GetCalendarMonth() * 28
                   + GetCalendarDay();

    if ( iTimeStamp - GetLocalInt( oPC, "EV_KILLER" ) < 15 ) return FALSE;
    if ( GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0 ) return TRUE;
    if ( GetLevelByClass(CLASS_TYPE_RANGER, oPC) > 0 ) return TRUE;
    return FALSE;
}

void Randomize( vector vPos )
{
    vPos.x += IntToFloat( Random( 11 ) - 5 );
    vPos.y += IntToFloat( Random( 11 ) - 5 );
}

vector Turn( vector vVec, float fAngle )
{
    vector vRes;
    vRes.x = cos( fAngle ) * vVec.x + sin( fAngle ) * vVec.y;
    vRes.y = cos( fAngle ) * vVec.y - sin( fAngle ) * vVec.x;

    return vRes;
}

void Flee( object oIntruder )
{
    vector vSelf = GetPositionFromLocation( GetLocation( OBJECT_SELF ) );
    vector vIntruder = GetPositionFromLocation( GetLocation( oIntruder ) ) ;

    vector vDiff = 30.0f * VectorNormalize( vSelf - vIntruder );
    vector vNewPos = vSelf +  vDiff;

    object oArea = GetArea( OBJECT_SELF );

    if ( !ALFA_IsPositionInArea( vNewPos , oArea ) )
    {
        // Try sideways
        vNewPos = vSelf + Turn( vDiff, 90.0f ) ;
    }
    else
    {
        location lNewLoc = Location( oArea, vNewPos, VectorToAngle( vNewPos ) );
        ActionMoveToLocation( lNewLoc, TRUE );
        return;
    }

    if ( !ALFA_IsPositionInArea( vNewPos , oArea ) )
    {
        // Try other side
        vNewPos = vSelf + Turn( vDiff, -90.0f );
    }
    else
    {
        location lNewLoc = Location( oArea, vNewPos, VectorToAngle( vNewPos ) );
        ActionMoveToLocation( lNewLoc, TRUE );
        return;
    }

    if ( !ALFA_IsPositionInArea( vNewPos , oArea ) )
    {
        // Cornered, try and charge past PC at an angle
        vNewPos = vSelf + Turn( vDiff, 150.0f );
    }
    else
    {
        location lNewLoc = Location( oArea, vNewPos, VectorToAngle( vNewPos ) );
        ActionMoveToLocation( lNewLoc, TRUE );
        return;
    }

    if ( !ALFA_IsPositionInArea( vNewPos , oArea ) )
    {
        // Cornered, try and charge past PC at an angle
        vNewPos = vSelf + Turn( vDiff, 210.0f );
    }
    else
    {
        location lNewLoc = Location( oArea, vNewPos, VectorToAngle( vNewPos ) );
        ActionMoveToLocation( lNewLoc, TRUE );
        return;
    }

    if ( !ALFA_IsPositionInArea( vNewPos , oArea ) )
    {
        // Cornered, unlikely we get to this point, go for broke
        vNewPos = vSelf + Turn( vDiff, 180.0f );
    }
    else
    {
        location lNewLoc = Location( oArea, vNewPos, VectorToAngle( vNewPos ) );
        ActionMoveToLocation( lNewLoc, TRUE );
        return;
    }

    location lNewLoc = Location( oArea, vNewPos, VectorToAngle( vNewPos ) );
    ActionMoveToLocation( lNewLoc, TRUE );
    return;

}


// See if a party member can calm the animal, party member must be seen
// Uses a passive animal empathy check
// HitDice of the animal get added to DC
int DruidCalms( object oIntruder, int iDC )
{
    object oMember = GetFirstFactionMember( oIntruder );
    int iSkillRank;
    int iRoll;
    int iTimeStamp;
    iDC += GetHitDice( OBJECT_SELF );

    while ( GetIsObjectValid( oMember ) )
    {
        if ( GetHasSkill( SKILL_ANIMAL_EMPATHY, oMember ) && GetObjectSeen( oMember ) )
        {
            iTimeStamp = GetCalendarYear() * 365
               + GetCalendarMonth() * 28
               + GetCalendarDay();

            if ( iTimeStamp - GetLocalInt( oMember, "EV_KILLER" ) >= 15 )
            {
                iSkillRank = GetSkillRank( SKILL_ANIMAL_EMPATHY, oMember );
                iRoll = d20() + iSkillRank;
                if ( iRoll >= iDC )
                {
                    string sNameAn = GetName( OBJECT_SELF );
                    string sName = GetName( oIntruder );
                    SendMessageToPC( oMember, "You convinced the " + sNameAn +
                                              " not to attack " + sName);
                    return TRUE;
                }
            }
        }
        oMember = GetNextFactionMember( oIntruder );
    }
    return FALSE;
}

int IsCarnivore( object oAnimal )
{
    int nPlot = GetLocalInt(oAnimal, "NW_BEHAVIOR_MASTER");
    if(nPlot & NW_FLAG_BEHAVIOR_CARNIVORE)
    {
        return TRUE;
    }
    return FALSE;
}

// If part of a pack, call upon allies
// Checks the tag for "PACK" + "N",  N = number of pack group
// Animals can only call upon members of the same pack group
void DoPackHunt( object oPrey )
{
    string sOwnTag = GetStringLowerCase( GetTag( OBJECT_SELF ) );
    int iPackPos = FindSubString( sOwnTag, "pack" );

    // Stop if not a pack animal
    if ( iPackPos < 1 ) return;

    string sGroup = GetSubString( sOwnTag, iPackPos, 5 );

    // Find nearby allies
    float fDist = 0.0f;
    object oAlly;
    int i = 1;
    string sAllyTag;

    while ( TRUE )
    {
        oAlly = GetNearestCreature( CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, OBJECT_SELF, i );
        if ( !GetIsObjectValid( oAlly ) ) return;
        i++;

        // Check if a pack member
        sAllyTag = GetStringLowerCase( GetTag( oAlly ) );
        if ( FindSubString( sAllyTag, sGroup ) > 0 && !GetIsFighting( oAlly ) )
        {
            AssignCommand( oAlly, SetAlert( TRUE ) );
            SetIsTemporaryEnemy( oPrey, oAlly, TRUE, 30.0f );
            AssignCommand( oAlly, ClearAllActions() );
            AssignCommand( oAlly, ActionAttack( oPrey ) );
            AssignCommand( oAlly, DelayCommand( 31.0f, ClearAllActions() ) );
            AssignCommand( oAlly, DelayCommand( 32.0f, SetAlert( FALSE ) ) );
            AssignCommand( oAlly, DelayCommand( 33.0f, ActionRandomWalk() ) );
        }
    }
}

// Herbivore behavior
void Herbivore( )
{
    object oPC = GetNearestPC();

    if ( !GetIsObjectValid( oPC ) ) return;

    // Don't fear druids and rangers
    if ( IsFriendly( oPC ) ) return;

    SetAlert( TRUE );
    ClearAllActions();

    float fDist = GetDistanceToObject( oPC );

    if ( fDist < 25.0f )
    {
        Flee( oPC );
//        DelayCommand( 3.0f, Herbivore( ) );
//        return;
    }
    else ActionRandomWalk();

    // Keep on the lookout if PC is still nearby
//    if ( GetObjectSeen( oPC ) || GetObjectHeard( oPC ) )
    if ( fDist < 50.0f )
    {
        DelayCommand( 3.0f, Herbivore( ) );
    }
    else
    {
        SetAlert( FALSE );
    }
}

// Omnivore behavior
void Omnivore( )
{
    object oPC = GetNearestPC();

    if ( !GetIsObjectValid( oPC ) ) return;

    // Don't attack druids and rangers
    if ( IsFriendly( oPC ) ) return;

    SetAlert( TRUE );
    ClearAllActions();

    float fDist = GetDistanceToObject( oPC );

    if ( fDist < 50.0f && GetIsEnemy( oPC )
        && IntToFloat( GetHitDice( oPC ) ) > GetChallengeRating( OBJECT_SELF ) )
    {
        Flee( oPC );
        DelayCommand( 3.0f, Omnivore( ) );
        return;
    }

    if ( fDist < 7.0f )
    {
        // Let the intruder of the hook if a nearby party druid or ranger can calm the animal
        if ( DruidCalms( oPC, 10 ) )
        {
            DelayCommand( 15.0f, Omnivore( ) );
            return;
        }
        // Don't go kamikazee, only attack the weak
        else if ( IntToFloat( GetHitDice( oPC ) ) <= GetChallengeRating( OBJECT_SELF ) )
        {
            // Give chase for a while
            SetIsTemporaryEnemy( oPC, OBJECT_SELF, TRUE, 30.0f );
            ActionAttack( oPC );
            DelayCommand( 30.0f, ClearAllActions() );
            //DelayCommand( 30.1f, ClearPersonalReputation( oPC ) );
            DelayCommand( 30.2f, Omnivore( ) );
            return;
        }
        else Flee( oPC );
    }
    else if ( fDist < 15.0f )
    {
        SetFacingPoint( GetPosition( oPC ) );
        ActionPlayAnimation( ANIMATION_FIREFORGET_TAUNT );
    }
    else ActionRandomWalk();

    // Keep on the lookout if PC is still nearby
//    if ( GetObjectSeen( oPC ) || GetObjectHeard( oPC ) )
    if ( fDist < 50.0f )
    {
        DelayCommand( 3.0f, Omnivore( ) );
    }
    else
    {
        SetAlert(FALSE);
    }
}

// Carnivore behavior
void Carnivore( )
{
    object oPC = GetNearestPC();

    if ( !GetIsObjectValid( oPC ) ) return;

    // Don't attack druids and rangers
    if ( IsFriendly( oPC ) ) return;

    // Stop this if already in combat
    if ( GetIsInCombat( OBJECT_SELF ) ) return;

    SetAlert( TRUE );
    ClearAllActions();

    float fDist = GetDistanceToObject( oPC );

    if ( fDist < 25.0f )
    {
        SetFacingPoint( GetPosition( oPC ) );
        ActionPlayAnimation( ANIMATION_FIREFORGET_TAUNT );
        // Druid or rangers calms animal
        if ( DruidCalms( oPC, 15 ) )
        {
            DelayCommand( 15.0f, Carnivore( ) );
            return;
        }
        // Don't go kamikazee, only attack the weak or threateningly near
        else if ( IntToFloat (  GetHitDice( oPC ) ) <= GetChallengeRating( OBJECT_SELF )
                    || fDist < 7.0f )
        {
            // Give chase for a while
            DoPackHunt( oPC );
            ActionDoCommand( SetIsTemporaryEnemy( oPC, OBJECT_SELF, TRUE, 30.0f ) );
            ActionAttack( oPC );
            DelayCommand( 30.0f, ClearAllActions() );
            //DelayCommand( 30.1f, ClearPersonalReputation( oPC ) );
            DelayCommand( 35.0f, Carnivore( ) );
            return;
        }
    }
    else ActionRandomWalk();

    // Keep on the lookout if PC is still nearby
//    if ( GetObjectSeen( oPC ) || GetObjectHeard( oPC ) )
    if ( fDist < 50.0f )
    {
        DelayCommand( 3.0f, Carnivore( ) );
    }
    else
    {
        SetAlert(FALSE);
    }
}

void main()
{
    int nUser = GetUserDefinedEventNumber();

    // ATS addition
    object   oDeadAnimal = OBJECT_SELF; //Get the Dead Animal Object

    if ( nUser == 1002 ) // PERCEIVE
    {
        // Only react to what you see
//        if ( !GetLastPerceptionSeen() ) return;

        // Already reacting to someone
        if ( IsAlert() ) return;

        object oSeen = GetLastPerceived();

        if ( GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE) )
        {
            if ( GetIsPC( oSeen ) )
            {
                Herbivore( );
            }
            else if ( IsCarnivore(oSeen)
                      && GetChallengeRating( OBJECT_SELF ) < GetChallengeRating( oSeen ) )
            {
                Flee( oSeen );
                DelayCommand( 6.0f , ActionRandomWalk() );
            }
        }
        else if ( GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) )
        {
            if ( GetIsPC( oSeen ) )
            {
                Omnivore( );
            }
            else if ( IsCarnivore(oSeen)
                      && GetChallengeRating( OBJECT_SELF ) < GetChallengeRating( oSeen ) )
            {
                Flee( oSeen );
                DelayCommand( 6.0f , ActionRandomWalk() );
            }
        }
        else if ( GetBehaviorState(NW_FLAG_BEHAVIOR_CARNIVORE) )
        {
            if ( GetIsPC( oSeen ) )
            {
                Carnivore( );
            }

            // Pick a meal if hungry
            else if ( d4() == 1
                    && GetChallengeRating( OBJECT_SELF ) > GetChallengeRating( oSeen )
                    && !IsFriendly( oSeen )
                    && GetLevelByClass(CLASS_TYPE_UNDEAD, oSeen) == 0
                    && GetLevelByClass(CLASS_TYPE_FEY, oSeen) == 0
                    && !IsCarnivore(oSeen) )
            {
                SetIsTemporaryEnemy( oSeen, OBJECT_SELF, TRUE, 60.0f );
                DoPackHunt( oSeen );
                ActionAttack( oSeen );
            }
        }
    }

/*    else if(nUser == 1001) //HEARTBEAT
    {

    }
    else if(nUser == 1003) // END OF COMBAT
    {

    }*/
    else if(nUser == 1004) // ON DIALOGUE
    {
        if ( GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE) )
        {
            object oSpeaker = GetLastSpeaker();
            if ( GetIsPC( oSpeaker ) && !IsFriendly( oSpeaker ) )
            {
                ClearAllActions();
                Flee( oSpeaker );
            }
        }
        else if ( GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) )
        {
            object oSpeaker = GetLastSpeaker();
            if ( GetIsPC( oSpeaker ) && !IsFriendly( oSpeaker ) )
            {
                if ( IntToFloat( GetHitDice( oSpeaker ) ) > GetChallengeRating( OBJECT_SELF ))
                {
                    ClearAllActions();
                    Flee( oSpeaker );
                }
                else ActionAttack( oSpeaker );
            }
        }
    }
    else if(nUser == 1005) // ATTACKED
    {
        object oAttacker = GetLastAttacker();

        if ( GetBehaviorState(NW_FLAG_BEHAVIOR_CARNIVORE) )
        {
            DoPackHunt( oAttacker );
            if ( !GetIsFighting( OBJECT_SELF ) )
            {
                ClearAllActions();
                ActionAttack( oAttacker );
            }
        }
        else if ( GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) )
        {
            float iChallenge;
            if ( GetIsPC( oAttacker ) )
            {
                iChallenge = IntToFloat( GetHitDice( oAttacker ) );
            }
            else
            {
                iChallenge = GetChallengeRating( oAttacker );
            }
            if ( iChallenge > GetChallengeRating( OBJECT_SELF ))
            {
                ClearAllActions();
                Flee( oAttacker );
            }
        }
        else if ( GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE ))
        {
            ClearAllActions();
            Flee( oAttacker );
        }
    }
    else if(nUser == 1006) // DAMAGED
    {
        object oPC = GetLastDamager();

        if ( GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0
          || GetLevelByClass(CLASS_TYPE_RANGER, oPC) > 0 )
        {
            int iTimeStamp = GetCalendarYear() * 365
                           + GetCalendarMonth() * 28
                           + GetCalendarDay();
            SetLocalInt( oPC, "EV_KILLER", iTimeStamp );
        }

        if ( GetBehaviorState(NW_FLAG_BEHAVIOR_CARNIVORE) )
        {
            DoPackHunt( oPC );
            if ( !GetIsFighting( OBJECT_SELF ) )
            {
                ClearAllActions();
                ActionAttack( oPC );
            }
        }
        else if ( GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) )
        {
            float iChallenge;
            if ( GetIsPC( oPC ) )
            {
                iChallenge = IntToFloat( GetHitDice( oPC ) );
            }
            else
            {
                iChallenge = GetChallengeRating( oPC );
            }
            if ( iChallenge > GetChallengeRating( OBJECT_SELF ))
            {
                ClearAllActions();
                Flee( oPC );
            }
        }
        else if ( GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE ))
        {
            ClearAllActions();
            Flee( oPC );
        }
    }
    else if(nUser == 1007) // DEATH
    {
        // ATS addition
        // No ATS Corpse! (Elorn)
        /*
        string sATS = GetStringUpperCase( GetStringLeft( GetTag( oDeadAnimal ), 3 ) );
        if ( sATS == "ATS" )
        {
            ATS_CreateSkinnableCorpse(oDeadAnimal, CINT_SAH_CORPSE_FADE);
        }
        */
    }
   /* else if(nUser == 1008) // DISTURBED
    {

    }  */

    else if( nUser == 500)
    {
        if(GetLocalInt(oDeadAnimal, "ats_self_destruct") == TRUE)
        {
            object oLootCorpse = GetLocalObject(oDeadAnimal, "ats_oLootCorse");
            DestroyObject(oLootCorpse);
            DelayCommand(1.0f, SetIsDestroyable(TRUE,TRUE,FALSE));
            DelayCommand(1.3f, DestroyObject(oDeadAnimal));
        }
    }
}

