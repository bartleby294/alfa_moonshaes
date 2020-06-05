#include "omega_include"
// Increase the damage value stored on the DM using the wand
// (+5 damage)

void main()
{
  int nValue = GetLocalInt( oDM, "DM_WAND_DAMAGE_VALUE" );
  string sToken;


  nValue += 5;
  sToken = IntToString(nValue);

  SetLocalInt( oDM, "DM_WAND_DAMAGE_VALUE", nValue );

  SetCustomToken( 16551, sToken );
}

