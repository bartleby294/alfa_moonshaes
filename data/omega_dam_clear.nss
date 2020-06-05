#include "omega_include"
// Initialize DM wand damage values

void main()
{
DeleteLocalInt( oDM, "DM_WAND_DAMAGE_VALUE" );

  SetCustomToken( 16551, "0" );
  SetCustomToken( 6970, "Not specified");
}

