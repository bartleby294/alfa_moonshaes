#include "alfa_include"
void VoidCreateObject(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="");

void main()
{
object oPC = GetPCSpeaker();
object oHorseWP = GetObjectByTag("WP_HORSE_01");
location lHorseWP = GetLocation(oHorseWP);
location lTargetLoc = GetLocation(oPC);
int nOldPheno = ALFA_GetPersistentInt("ID_MISC", "playerpheno", oPC);
string sDismount = "You pull yourself out of the saddle.";
string sPlayerHorse = "PLAYERHORSE_02";
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
DelayCommand(4.5, AssignCommand(oHorse, ActionJumpToLocation(lTargetLoc)));
DelayCommand(4.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeedDown, oPC));
DelayCommand(7.0, AssignCommand(oHorse, ActionForceFollowObject(oPC)));
}

void VoidCreateObject(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag = "")
 {
   CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation, sNewTag);
 }
