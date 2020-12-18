//This takes the PCs alignment to True Neutral, so the alignment quiz can begin
//Made by Rotku
void main()
{

object oPC = GetPCSpeaker();

AdjustAlignment(oPC, ALIGNMENT_LAWFUL, 50);
AdjustAlignment(oPC, ALIGNMENT_GOOD, 50);

}

