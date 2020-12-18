void main()
{
object oPC = GetLastUsedBy();
object oChair = OBJECT_SELF;
object barkeep = GetObjectByTag("hammerstaadbarkeep1");

if(GetTag(oPC) == "hammerstaadsitter1" || GetTag(oPC) == "hammerstaadsitter2" || GetTag(oPC) == "hammerstaadsitter3"
|| GetTag(oPC) == "Alandert" || GetTag(oPC) == "Wino")
{
    if(!GetIsObjectValid(GetSittingCreature(oChair)))
    {
        AssignCommand(oPC,ActionSit(oChair));
        return;
    }
}
else
{
    AssignCommand(barkeep, ActionSpeakString("Ye cant sit there."));
}

}
