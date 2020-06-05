#include "nw_i0_plotwizard"
int StartingConditional()
{
	int nShow = GetLocalInt(GetPCSpeaker(), "p001state_Aworriedlookingmerchant") >= 3;
	if (nShow)
	{
		PWSetMinLocalIntPartyPCSpeaker("p001state_Aworriedlookingmerchant", 5);
		PWSetMinLocalIntPartyPCSpeaker("p001state", 5);
	}
	return nShow;
}
