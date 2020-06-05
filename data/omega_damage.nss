#include "omega_include"
// DM Wand - Do damage
// Edited and conformed to Omega wand, by LP

void main()
{
  int nValue = GetLocalInt( oDM, "DM_WAND_DAMAGE_VALUE" );
  int nDmType = GetLocalInt(oDM, "DAMAGE_TYPE" );
  string sMessage;

  if ( oMyTarget == OBJECT_INVALID )
  {
    SendMessageToPC( oDM, "Your target has logged out." );
    return;
  }

  if (nValue == 0)
  {
    SendMessageToPC( oDM, "No damage amount indicated - none done." );
    return;
  }


  if (nValue == 1)
  {
    sMessage = "Doing 1 point of damage to " + GetName(oMyTarget) + ".";
  }

  else
  {
    sMessage = "Doing " + IntToString( nValue ) + " points of damage to " +
       GetName(oMyTarget) + ".";
  }

  effect eDamage = EffectDamage(nValue, nDmType);
  ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oMyTarget);

  SendMessageToPC( oDM, sMessage );
}

