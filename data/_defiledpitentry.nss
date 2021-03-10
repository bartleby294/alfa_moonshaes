void main()
{
object oTriggerer;
oTriggerer = GetEnteringObject();
SendMessageToPC(oTriggerer, "A musty, foul stench clouds your nostrils. This place feels horrible. The darkness crowds in around you.");
SendMessageToPC(oTriggerer, "Despite the claustrophobic atmosphere, those with keen senses may feel a very slight draft flowing through this tunnel.");
}
