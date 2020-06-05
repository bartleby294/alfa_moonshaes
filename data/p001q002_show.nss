#include "nw_i0_plotwizard"
int StartingConditional()
{
	int nShow = GetLocalInt(GetPCSpeaker(), "p001state_Aworriedlookingmerchant") >= 1;
	if (nShow)
	{
		PWSetMinLocalIntPartyPCSpeaker("p001state_Aworriedlookingmerchant", 2);
		PWSetMinLocalIntPartyPCSpeaker("p001state", 2);
	}
	return nShow;
}
