#include "omega_include"
void main()
{
string sSlot1, sSlot2, sSlot3;
sSlot1 = GetCampaignString("Omega_Wand", "F_S1", oDM);
sSlot2 = GetCampaignString("Omega_Wand", "F_S2", oDM);
sSlot3 = GetCampaignString("Omega_Wand", "F_S3", oDM);

LoadAndSaveToken(sSlot1, sSlot2, sSlot3);

}
