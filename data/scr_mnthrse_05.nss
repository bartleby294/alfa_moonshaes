#include "alfa_include"
void main()
{
object oPC = GetPCSpeaker();
object oHorseWP = GetObjectByTag("WP_HORSE_01");
location lHorseWP = GetLocation(oHorseWP);
int nOldPheno = GetPhenoType(oPC);
string sMountUp = "You place a foot in the stirrup and pull yourself into the saddle.";
string sPlayerName = GetPCPlayerName(oPC);
string sHorseTag = sPlayerName+"_HORSE";
object oHorse = GetNearestObjectByTag(sHorseTag);
int nPercentChange = 20;
effect eSpeedUp = EffectMovementSpeedIncrease(nPercentChange);

if(oHorse == OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "You need to bear near your horse to ride it.");
        return;
    }
else
    {
ALFA_SetPersistentInt("ID_MISC", "playerpheno", nOldPheno, oPC);
DelayCommand(0.5, AssignCommand(oPC, ClearAllActions()));
DelayCommand(1.0, AssignCommand(oPC, ActionForceMoveToObject(oHorse)));
DelayCommand(3.0, SendMessageToPC(oPC, sMountUp));
DelayCommand(3.5, AssignCommand(oHorse, JumpToLocation(lHorseWP)));
DelayCommand(4.0, SetPhenoType(5, GetPCSpeaker()));
DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeedUp, oPC));
     }
}
