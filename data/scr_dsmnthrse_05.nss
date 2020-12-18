#include "alfa_include"
void main()
{
object oPC = GetPCSpeaker();
object oHorseWP = GetObjectByTag("WP_HORSE_01");
location lHorseWP = GetLocation(oHorseWP);
location lTargetLoc = GetLocation(oPC);
int nOldPheno = ALFA_GetPersistentInt("ID_MISC", "playerpheno", oPC);
string sDismount = "You pull yourself out of the saddle.";
string sPlayerHorse = "PLAYERHORSE_01";
string sPlayerName = GetPCPlayerName(oPC);
string sHorseTag = sPlayerName+"_HORSE";
object oHorse = GetObjectByTag(sHorseTag);
int nPercentChange = 20;
effect eSpeedDown = EffectMovementSpeedDecrease(nPercentChange);
int bUseAppearAnimation = FALSE;
int nCreature = OBJECT_TYPE_CREATURE;

DelayCommand(0.5, AssignCommand(oPC, ClearAllActions()));
DelayCommand(1.0, SendMessageToPC(oPC, sDismount));
DelayCommand(1.5, SetPhenoType(nOldPheno, GetPCSpeaker()));
DelayCommand(3.0, AssignCommand(oHorse, ActionJumpToLocation(lTargetLoc)));
DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeedDown, oPC));
DelayCommand(4.0, AssignCommand(oHorse, ActionForceFollowObject(oPC)));
}

