// Loot Tables
object chooseLoot() {
    return OBJECT_INVALID;
}

void main()
{
    int searchSuccess = 0;
    object oPC = GetLastUsedBy();
    int circle_max = GetLocalInt(OBJECT_SELF, "circle_max");
    int searchDiff = 8 * circle_max;
    int roll = d20();
    int searchSkill =  GetSkillRank(SKILL_SEARCH, oPC, FALSE);
    string searchMsg = "Searching tent - Roll: " + IntToString(roll)
                            + " + Skill: " + IntToString(searchSkill) + " = "
                            + IntToString(roll + searchSkill);

    if(roll + searchSkill >= searchDiff) {
        searchSuccess = 1;
        searchMsg = searchMsg + " Success.";
    } else {
        searchMsg = searchMsg + " Fail.";
    }

    SendMessageToPC(oPC, searchMsg);



    DestroyObject(OBJECT_SELF, 1.0);
}
