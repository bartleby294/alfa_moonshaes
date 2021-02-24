int GetHasRacialEnemy(object oRanger, object oCreature)
//Input a ranger and creature, will check to see if the ranger has "Favored enemy" for that creature's racial type, returns TRUE or FALSE.On Error returns FALSE
{
    int iRacialType = GetRacialType(oCreature);
    if(iRacialType == RACIAL_TYPE_ABERRATION){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_ABERRATION, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_ANIMAL){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_ANIMAL, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_BEAST){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_BEAST, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_CONSTRUCT){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_CONSTRUCT, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_DRAGON){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_DRAGON, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_DWARF){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_DWARF, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_ELEMENTAL){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_ELEMENTAL, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_ELF){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_ELF, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_FEY){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_FEY, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_GIANT){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_GIANT, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_GNOME){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_GNOME, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_HALFELF){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_HALFELF, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_HALFLING){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_HALFLING, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_HALFORC){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_HALFORC, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_HUMAN){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_HUMAN, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_HUMANOID_GOBLINOID){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_GOBLINOID, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_HUMANOID_MONSTROUS){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_MONSTROUS, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_HUMANOID_ORC){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_ORC, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_HUMANOID_REPTILIAN){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_REPTILIAN, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_MAGICAL_BEAST){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_MAGICAL_BEAST, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_OUTSIDER){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_OUTSIDER, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_SHAPECHANGER){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_SHAPECHANGER, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_UNDEAD){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_UNDEAD, oRanger);
        return iFeat;
    }
    if(iRacialType == RACIAL_TYPE_VERMIN){
        int iFeat = GetHasFeat(FEAT_FAVORED_ENEMY_VERMIN, oRanger);
        return iFeat;
    }
    else{
        return FALSE;
    }
}
void CreateTrackingPoint(object oTarget, object oSelf, int iHas)
//Input the target, the ranger, and whether the ranger has the appropraite racial enemy skill or not
{
    object oArea = GetArea(oSelf);
    string sResref = "trackingarrow"; //This is the resref for the custom placeable...
    float fDistBetween = GetDistanceBetween(oSelf, oTarget);
    int iErrorHas = 5; //The error is they have the right racial enemy skill
    int iErrorNot = 15; //If they don't
    int iDistPerceivedH = FloatToInt(fDistBetween)+Random(iErrorHas+1)-Random(iErrorHas+1);
    int iDistPerceivedN = FloatToInt(fDistBetween)+Random(iErrorNot+1)-Random(iErrorNot+1);
    string sDistH = IntToString(iDistPerceivedH);
    string sDistN = IntToString(iDistPerceivedN);
    string sDistDisplayH = GetStringLeft(sDistH, 3);
    string sDistDisplayN = GetStringLeft(sDistN, 3);
    string sName = GetName(oTarget);
    string sUnidentified = "Unknown";
    int iHd = GetHitDice(oTarget);
    vector vTarget = GetPosition(oTarget);
    vector vSelf = GetPosition(oSelf);
    float fx = IntToFloat(d3(1)-d3(1));
    float fy = IntToFloat(d3(1)-d3(1));
    vector vNearAdjust = Vector(fx, fy, 0.0);
    vector vNew = vSelf+vNearAdjust;
    location lTarget = Location(oArea, vNew, 0.0);
    object oArrow = CreateObject(OBJECT_TYPE_PLACEABLE, sResref, lTarget, FALSE);
    AssignCommand(oArrow, SetFacingPoint(vTarget));
    if(iHas == TRUE){
        SetLocalString(oArrow, "dist", sDistDisplayH);
        SetLocalString(oArrow, "name", sName);
        SetLocalString(oArrow, "level", IntToString(iHd));
    }
    else{
        SetLocalString(oArrow, "dist", sDistDisplayN);
        SetLocalString(oArrow, "name", sUnidentified);
        SetLocalString(oArrow, "level", sUnidentified);
    }
}
