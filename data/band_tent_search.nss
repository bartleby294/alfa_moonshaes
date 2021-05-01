// Loot Tables
object chooseLoot() {
    return OBJECT_INVALID;
}

void mainOld()
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

void CreateBanditMapPeice(location loc) {

    string mapResRef = "ms_bmap_1";
    string countType = "q";
    string type = "j";

    int cntChance = d6();
    if(cntChance == 6) {
        countType = "h";
    } else if(cntChance > 3) {
        countType = "t";
    }

    int typeChance = d3();
    if(cntChance == 3) {
        type = "r";
    } else if(cntChance == 2) {
        type = "t";
    }

    mapResRef +=  countType + "_" + type;
    WriteTimestampedLogEntry("BANDIT TREASURE MAP: Tent Creating map " + mapResRef);

    CreateObject(OBJECT_TYPE_ITEM, mapResRef, loc);
}

void main() {
    object oPC = GetLastAttacker();
    location lTentLocation = GetLocation(OBJECT_SELF);
    if(d6() == 6) {
        CreateBanditMapPeice(lTentLocation);
    }
}
