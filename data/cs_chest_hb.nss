// the chest heartbeat script that enables traps to be detected


//::///////////////////////////////////////////////
//:: Name: Detect Trap
//:: FileName: detect_trap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/* This script uses the search skill to flag a trap. Only the people who detect
the trap will see the flag. Just like normal. It is meant to be used on a
container that is spawned by some event in game rather than placed in toolset.
Just place it in the containers On Heartbeat. It requires line of sight to the
container to detect the trap, and the PCs detect mode must be turned on. (I have
documented below how to turn this off easily I think that a PC should "SEARCH"
for traps not just spot them randomly but if your opinion differs you can
as I said easily turn the feature off. See line 41) In addition you can adjust
how far a trap can be detected by modifying line 35. I hope you enjoy this
script.*/
//:://////////////////////////////////////////////
//:: Created By: Elidrin
//:: Created On: 12-24-02
//:://////////////////////////////////////////////
int SkillCheck(object oPC, int iSkill, int iDC, int iMod=0);
void main()
{
//if (!GetLocalInt(GetArea(OBJECT_SELF),"Active")) //(OPTIONAL SEE BELOW)
// return; //(OPTIONAL SEE BELOW)
// The above 2 lines I use for shut down heartbeats in an inactive area,
// They are provided here for completeness but are not required. If you decide
// to use them you MUST set the local variable AREA,"Active",TRUE.
if (!GetIsTrapped(OBJECT_SELF)
|| (!GetTrapDetectable(OBJECT_SELF))
|| (GetTrapFlagged(OBJECT_SELF)))
return;
float fRange = 5.0;
object oPC = GetFirstObjectInShape(SHAPE_SPHERE,fRange,GetLocation(OBJECT_SELF),TRUE,OBJECT_TYPE_CREATURE);
while(GetIsObjectValid(oPC))
{
if (GetIsPC(oPC)
&& (!GetTrapDetectedBy(OBJECT_SELF,oPC))
&& (GetDetectMode(oPC) == DETECT_MODE_ACTIVE) /*Comment this line to not
require detect mode personally I think they should slow down and look */
&& (SkillCheck(oPC,SKILL_SEARCH,GetTrapDetectDC(OBJECT_SELF))))
SetTrapDetectedBy(OBJECT_SELF,oPC);
oPC = GetNextObjectInShape(SHAPE_SPHERE,fRange,GetLocation(OBJECT_SELF),TRUE,OBJECT_TYPE_CREATURE);
}
}
//::///////////////////////////////////////////////
//:: Name: SkillCheck
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*This script simply does a Skill check using the SKILL_* you send it. Returning
a TRUE/FALSE */
//:://////////////////////////////////////////////
//:: Created By: Elidrin
//:://////////////////////////////////////////////
int SkillCheck(object oPC, int iSkill, int iDC, int iMod)
{
int iRank = GetSkillRank(iSkill,oPC);
if (iRank <1)
{
if ((iSkill == SKILL_ANIMAL_EMPATHY) ||
(iSkill == SKILL_DISABLE_TRAP) ||
(iSkill == SKILL_LORE) ||
(iSkill == SKILL_OPEN_LOCK) ||
(iSkill == SKILL_PICK_POCKET) ||
(iSkill == SKILL_SET_TRAP) ||
(iSkill == SKILL_SPELLCRAFT))
return FALSE;
}
if (d20(1) + iRank + iMod >= iDC)
return TRUE;
return FALSE;
}
