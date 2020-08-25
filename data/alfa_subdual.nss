/******************************************************************
 * Name: alfa_subdual
 * Type: ALFA Subdual Mode Functions
 * ---
 * Author: Cereborn
 * Date: 5/01/03
 * ---
 * Contains code for determining if damage done by oAttacker to
 * oVIctim should be considered subdual damage.
 *
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/


int SUBDUAL_DEBUG = FALSE;
int SUBDUAL_WEAPON_RESTRICTION = FALSE;

void SubdualDebug( string sMessage );

/*
int INT_MAX(int a, int b)
{
  if (a > b)
    return a;
  return b;
}
*/

int ALFA_GetLastDamageSubdual(object oAttacker, object oVictim)
{
  int nSubdued;
  object oWeaponUsed;
  int nWeaponType;

  if (oAttacker != OBJECT_INVALID)
  {
    SubdualDebug("attacker is " + GetName(oAttacker));
    nSubdued = GetLocalInt(oAttacker, "SubdualMode");

    // First step.  Is attacker in subdual mode?
    if (nSubdued)
    {
      // He is.  Check to see if the last damage received was non-melee
      int nNonMelee;
      int nDamageByType;

      nDamageByType = GetDamageDealtByType(DAMAGE_TYPE_ACID);
      if (nDamageByType > 0)
      {
         nNonMelee = nDamageByType;
         SubdualDebug("ACID: " + IntToString(GetDamageDealtByType(DAMAGE_TYPE_ACID)));
      }


      nDamageByType = GetDamageDealtByType(DAMAGE_TYPE_COLD);
      if (nDamageByType > 0)
      {
         nNonMelee += nDamageByType;
         SubdualDebug("COLD: " + IntToString(GetDamageDealtByType(DAMAGE_TYPE_COLD)));
      }

      nDamageByType = GetDamageDealtByType(DAMAGE_TYPE_DIVINE);
      if (nDamageByType > 0)
      {
         nNonMelee += nDamageByType;
         SubdualDebug("DIVINE: " + IntToString(GetDamageDealtByType(DAMAGE_TYPE_DIVINE)));
      }

      nDamageByType = GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL);
      if (nDamageByType > 0)
      {
         nNonMelee += nDamageByType;
         SubdualDebug("ELECTRICAL: " + IntToString(GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL)));
      }

      nDamageByType = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
      if (nDamageByType > 0)
      {
         nNonMelee += nDamageByType;
         SubdualDebug("FIRE: " + IntToString(GetDamageDealtByType(DAMAGE_TYPE_FIRE)));
      }

      nDamageByType = GetDamageDealtByType(DAMAGE_TYPE_MAGICAL);
      if (nDamageByType > 0)
      {
         nNonMelee += nDamageByType;
         SubdualDebug("MAGICAL: " + IntToString(GetDamageDealtByType(DAMAGE_TYPE_MAGICAL)));
      }

      nDamageByType = GetDamageDealtByType(DAMAGE_TYPE_NEGATIVE);
      if (nDamageByType > 0)
      {
         nNonMelee += nDamageByType;
         SubdualDebug("NEGATIVE: " + IntToString(GetDamageDealtByType(DAMAGE_TYPE_NEGATIVE)));
      }

      nDamageByType = GetDamageDealtByType(DAMAGE_TYPE_POSITIVE);
      if (nDamageByType > 0)
      {
         nNonMelee += nDamageByType;
         SubdualDebug("POSITIVE: " + IntToString(GetDamageDealtByType(DAMAGE_TYPE_POSITIVE)));
      }

      nDamageByType = GetDamageDealtByType(DAMAGE_TYPE_SONIC);
      if (nDamageByType > 0)
      {
         nNonMelee += nDamageByType;
         SubdualDebug("SONIC: " + IntToString(GetDamageDealtByType(DAMAGE_TYPE_SONIC)));
      }

      SubdualDebug(IntToString(nNonMelee) + " points of non-melee damage");

      if (nNonMelee > 0)
      {
        nSubdued = FALSE;
      }

      else
      {

        // The damage was melee damage.  Are weapons restricted to blunts?
        if (SUBDUAL_WEAPON_RESTRICTION)
        {
          oWeaponUsed = GetLastWeaponUsed(oAttacker);
          if (oWeaponUsed == OBJECT_INVALID)
          {
            SubdualDebug("no weapon found (bare handed?)");
          }

          else
          {
            nWeaponType = GetBaseItemType(oWeaponUsed);
            SubdualDebug("weapon based type is " + IntToString(nWeaponType));

            if (! (nWeaponType == BASE_ITEM_CBLUDGWEAPON
                || nWeaponType == BASE_ITEM_CLUB
                || nWeaponType == BASE_ITEM_DIREMACE
                || nWeaponType == BASE_ITEM_HEAVYFLAIL
                || nWeaponType == BASE_ITEM_LIGHTFLAIL
                || nWeaponType == BASE_ITEM_LIGHTHAMMER
                || nWeaponType == BASE_ITEM_LIGHTMACE
                || nWeaponType == BASE_ITEM_QUARTERSTAFF
                || nWeaponType == BASE_ITEM_WARHAMMER
                || nWeaponType == BASE_ITEM_BRACER
                ))
            {
              SubdualDebug("invalid subdual weapon");
              nSubdued = FALSE;
            }
          }
        }
      }
    }
  }

  else
  {
    SubdualDebug("attacker unknown");
    // Maybe this is an EffectDamage() case (caused by onDeath) If it is,
    // DamageDealtByType will report 10 bludgeoning damage
    int nForced = GetLocalInt(oVictim, "ForcedSubdual");
    if (nForced)
    {
      SubdualDebug("subdued to death!");
      DeleteLocalInt(oVictim, "ForcedSubdual");
      nSubdued = TRUE;
    }
  }

  return nSubdued;
}

void SubdualDebug( string sMessage )
{
  if (SUBDUAL_DEBUG)
  {
    SendMessageToPC(GetFirstPC(), sMessage);
  }
}

