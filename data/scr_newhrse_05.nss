#include "alfa_include"
void VoidCreateObject(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="");

void main()
{
object oPC = GetPCSpeaker();
object oHorseWP = GetObjectByTag("WP_HORSE_01");
location lHorseWP = GetLocation(oHorseWP);
object oNewHorseWP = GetObjectByTag("WP_NEWHORSE_01");
location lNewHorseWP = GetLocation(oNewHorseWP);
string sPlayerHorse = "PLAYERHORSE_01";
string sPlayerName = GetPCPlayerName(oPC);
string sHorseTag = sPlayerName+"_HORSE";
int bUseAppearAnimation = FALSE;
int nCreature = OBJECT_TYPE_CREATURE;

object oHorse = CreateObject(nCreature, sPlayerHorse, lHorseWP, bUseAppearAnimation, sHorseTag);
DelayCommand(3.0, AssignCommand(oHorse, ActionJumpToLocation(lNewHorseWP)));
ALFA_SetPersistentObject("ID_MISC", sPlayerName+"_HORSE", oPC);
}
