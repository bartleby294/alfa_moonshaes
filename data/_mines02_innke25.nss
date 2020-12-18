void main()
{
    object oPC = GetPCSpeaker();
    object InnKeep = GetObjectByTag("_mines_02_innkeeper");

    if(GetSkillRank(SKILL_PERSUADE, oPC) + d20(1) > 23)
    {
       SetLocalInt(oPC, "mines02Innkeeper", 0);
    }
}
