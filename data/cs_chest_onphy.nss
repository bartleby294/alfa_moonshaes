// part of the chest scripts...this script allows PCs to force a chest without destroying it

void main()
{
    object oAttacker=GetLastAttacker();
    int unlockDC=GetLockUnlockDC(OBJECT_SELF)-10;
    int abilitymod=GetAbilityModifier(ABILITY_STRENGTH, oAttacker);
    int roll=d20();
    int result=roll+abilitymod;
    string sRoll=IntToString(roll);
    string sRank=IntToString(abilitymod);
    string sResult=IntToString(result);
    AssignCommand( oAttacker, SpeakString("Strength Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult));
    if(result > unlockDC || roll==20)   //perfect 20 will always succeed.
    {
        SetLocked(OBJECT_SELF, FALSE);
        ActionOpenDoor(OBJECT_SELF);
        SpeakString("You forced it.");
    }
    else
    {
        SpeakString("You failed to force it.");
    }
}
