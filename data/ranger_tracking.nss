#include "TRACKING_INCLUDE"
void main()
{
    object oUser = GetItemActivator();
    float fMaxDist = 50.0;//This is the maximum distance, at which "trasking" takes effect
    //The three closest, "enemy" creatures...
    object oTarget1 = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY ,oUser,1);
    //Their racial types...
    //Nearest
    float fDist1 = GetDistanceBetween(oUser, oTarget1);
    if(fDist1 <= fMaxDist){
    int iRangerSkillCheck = (GetSkillRank(SKILL_SEARCH, oUser)+d20(1)+GetLevelByClass(CLASS_TYPE_RANGER,oUser));//Search Skill+d20+Ranger's # of "ranger" Lvls
    int iTarget1SkillCheck = ((GetSkillRank(SKILL_HIDE, oTarget1)/2)+(GetSkillRank(SKILL_MOVE_SILENTLY, oTarget1)/2)+d20(1)+GetHitDice(oTarget1)); // 1/2 Hide Skill+1/2 Move Silently +d20+hitdice
    int iHas = GetHasRacialEnemy(oUser, oTarget1);
        if (iRangerSkillCheck >= iTarget1SkillCheck){
            CreateTrackingPoint(oTarget1, oUser, iHas);
        }
        else{
        }
    }
    else{}
}
