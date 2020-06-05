#include "sos_include"
#include "nw_i0_tool"

//if(sResRef == "aaronsrod")
void AR(object oPC, object oTarget)
{

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTemporaryHitpoints(d4()), oTarget, HoursToSeconds(2));
    AssignCommand(oPC, ActionSpeakString("*Applies Aaron's Rod*"));
}
//if(sResRef == "adderstongue")
void AT(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 10)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(d2()), oTarget);
        SOS_SetPersistentInt(oTarget,"cmk_sleepbonus",d3());
        AssignCommand(oPC, ActionSpeakString("*Applies Adder's Tongue*"));
    }
    else
        AssignCommand(oPC, ActionSpeakString("*Fails to apply Adder's Tongue correctly*"));
}
//if(sResRef == "allsaintswort")
void ASW(object oPC, object oTarget)
{
    AssignCommand(oPC, ActionSpeakString("*Applies All-Saint's Wort*"));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(d4()), oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_POISON), oTarget, HoursToSeconds(2));
    AssignCommand(oPC,ActionSpeakString("*Applies All Saint's Wort*"));
}
//if(sResRef == "allcure")
void AC(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 10)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(d4()+1),oTarget);
        AssignCommand(oPC,ActionSpeakString("*Applies Allcure*"));
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Allcure correctly*"));
}
//if(sResRef == "aloe")
void ALO(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 5)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(d2()),oTarget);
        SOS_SetPersistentInt(oTarget,"cmk_sleepbonus",d2());
        AssignCommand(oPC,ActionSpeakString("*Applies Aloe*"));
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Aloe correctly*"));
}
//if(sResRef == "arnica")
void ARN(object oPC, object oTarget)
{
    int iD = d2()+1;
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 10)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTemporaryHitpoints(d3()),oTarget,HoursToSeconds(iD));
        AssignCommand(oPC,ActionSpeakString("*Applies Arnica*"));
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Arnica correctly*"));
}
//if(sResRef == "bilberry")
void BIL(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Bilberry*"));
    effect eEffect = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectType(eEffect) == EFFECT_TYPE_BLINDNESS)
        {
            if(FortitudeSave(oTarget,15))
            {
                RemoveEffect(oTarget,eEffect);
                AssignCommand(oTarget,ActionSpeakString("I can see!"));
            }
        }
        eEffect = GetNextEffect(oTarget);
    }
}
//if(sResRef == "binglang")
void BL(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 5)
    {
        AssignCommand(oPC,ActionSpeakString("*Applies Bing Lang*"));
        int iD = d2();
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_SPOT,1),oTarget,HoursToSeconds(iD));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_LISTEN,1),oTarget,HoursToSeconds(iD));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_SEARCH,1),oTarget,HoursToSeconds(iD));
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Bing Lang correctly*"));
}
//if(sResRef == "birthwort")
void BW(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Birthwort*"));
    SOS_SetPersistentInt(oTarget,"cmk_sleepbonus",d2());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_POISON),oTarget,HoursToSeconds(2));
    if(GetRacialType(oTarget) != RACIAL_TYPE_HUMAN)
    {
        if(!FortitudeSave(oTarget,20))
        {
            DelayCommand(RoundsToSeconds(2),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectParalyze(),oTarget,RoundsToSeconds(d8())));
        }
    }
}
//if(sResRef == "bloodroot")
void BR(object oPC, object oTarget)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(d4()),oTarget);
    SOS_SetPersistentInt(oTarget,"cmk_sleepbonus",3);
    AssignCommand(oPC,ActionSpeakString("*Applies Bloodroot*"));
}
//if(sResRef == "bugsbane")
void BB(object oPC, object oTarget)
{
    effect eAC = VersusRacialTypeEffect(EffectACIncrease(2,AC_NATURAL_BONUS,AC_VS_DAMAGE_TYPE_ALL),RACIAL_TYPE_VERMIN);
    int iD = d4(2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAC,oTarget,HoursToSeconds(iD));
    AssignCommand(oPC,ActionSpeakString("*Applies Bugsbane*"));
}
//if(sResRef == "catsclaw")
void CC(object oPC, object oTarget)
{
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_DISEASE),oTarget,HoursToSeconds(24));
    AssignCommand(oPC,ActionSpeakString("*Applies Cat's Claw*"));
}
//if(sResRef == "comfrey")
void CF(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 5)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(d4()), oTarget);
        SOS_SetPersistentInt(oTarget,"cmk_sleepbonus",d3());
        AssignCommand(oPC, ActionSpeakString("*Applies Comfrey*"));
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Comfrey correctly*"));

}
//if(sResRef == "crawlbane")
void CB(object oPC, object oTarget)
{
    effect eAC = VersusRacialTypeEffect(EffectACIncrease(3,AC_NATURAL_BONUS,AC_VS_DAMAGE_TYPE_ALL),RACIAL_TYPE_VERMIN);
    int iD = d4(2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAC,oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSpellImmunity(SPELL_CREEPING_DOOM),oTarget,HoursToSeconds(iD));
    AssignCommand(oPC,ActionSpeakString("*Applies Crawlbane*"));
}
//if(sResRef == "darkweed")
void DW(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Darkweed*"));
    int iD = d10(2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectBlindness(),oTarget,RoundsToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTrueSeeing(),oTarget,RoundsToSeconds(iD));
}
//if(sResRef == "dwale")
void DA(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 5)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(d3()+2),oTarget);
        AssignCommand(oPC,ActionSpeakString("*Applies Dwale*"));
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Dwale correctly*"));
}
//if(sResRef == "echinacea")
void EC(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 5)
    {
        AssignCommand(oPC,ActionSpeakString("*Applies Echinacea*"));
        effect eEffect = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eEffect))
        {
            if(eEffect == EffectDisease(DISEASE_DREAD_BLISTERS) || eEffect == EffectDisease(DISEASE_GHOUL_ROT) || eEffect == EffectDisease(DISEASE_MUMMY_ROT) || eEffect == EffectDisease(DISEASE_RED_ACHE))
            {
                if(FortitudeSave(oTarget,8,SAVING_THROW_TYPE_DISEASE))
                {
                    RemoveEffect(oTarget,eEffect);
                    AssignCommand(oTarget,ActionSpeakString("*The Echinacea takes effect*"));
                }
                else
                    AssignCommand(oTarget,ActionSpeakString("Fails to shrug off the disease's effects*"));
            }
            eEffect = GetNextEffect(oTarget);
        }
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Echinacea correctly*"));
}

//if(sResRef == "euphorisum")
void EU(object oPC, object oTarget)
{
    int iD = d4();
    AssignCommand(oPC,ActionSpeakString("*Applies Euphorisum*"));
    AssignCommand(oTarget,ActionSpeakString("*Feels good*"));
    effect eEffect = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eEffect))
    {
        if(eEffect == EffectDisease(DISEASE_CACKLE_FEVER) || eEffect == EffectDisease(DISEASE_DEMON_FEVER) || eEffect == EffectDisease(DISEASE_FILTH_FEVER) || eEffect == EffectDisease(DISEASE_DEVIL_CHILLS))
        {
            if(FortitudeSave(oTarget,9,SAVING_THROW_TYPE_DISEASE))
            {
                RemoveEffect(oTarget,eEffect);
                AssignCommand(oTarget,ActionSpeakString("*The Euphorisum takes effect*"));
            }
            else
                AssignCommand(oTarget,ActionSpeakString("Fails to shrug off the disease's effects*"));
        }
        eEffect = GetNextEffect(oTarget);
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACDecrease(2),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAttackDecrease(2),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageDecrease(2),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_ALL_SKILLS,2),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowDecrease(SAVING_THROW_ALL,2),oTarget,HoursToSeconds(iD));

}
//if(sResRef == "fiendflower")
void FF(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Fiendflower*"));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectConfused(),oTarget,RoundsToSeconds(d6()));
}

//if(sResRef == "garclive")
void GC(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 5)
    {
        SOS_SetPersistentInt(oTarget,"cmk_sleepbonus",d4()+1);
        AssignCommand(oPC,ActionSpeakString("*Applies Garclive*"));
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Garclive correctly*"));
}
//if(sResRef == "ghostroot")
void GR(object oPC, object oTarget)
{
    effect eAC = VersusRacialTypeEffect(EffectACIncrease(2,AC_NATURAL_BONUS,AC_VS_DAMAGE_TYPE_ALL),RACIAL_TYPE_UNDEAD);
    int iD = 15;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAC,oTarget,RoundsToSeconds(iD));
    AssignCommand(oPC,ActionSpeakString("*Applies Ghostroot*"));
}
//if(sResRef == "ginkgo")
void GI(object oPC, object oTarget)
{
    int iD = d4(2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_DISABLE_TRAP,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_HEAL,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_LORE,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_SEARCH,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_SPELLCRAFT,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_SPOT,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_LISTEN,1),oTarget,HoursToSeconds(iD));
    AssignCommand(oPC,ActionSpeakString("*Applies Ginkgo*"));
}
//if(sResRef == "ginseng")
void GS(object oPC, object oTarget)
{
    int iD = d4(2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_DISCIPLINE,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_HIDE,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_MOVE_SILENTLY,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_OPEN_LOCK,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_PARRY,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_PICK_POCKET,1),oTarget,HoursToSeconds(iD));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_SET_TRAP,1),oTarget,HoursToSeconds(iD));
    AssignCommand(oPC,ActionSpeakString("*Applies Ginseng*"));
}
//if(sResRef == "henbane")
void HE(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 8)
    {
        int iRoll = d6();
        if(iRoll > 2)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTemporaryHitpoints(iRoll-2),oTarget,HoursToSeconds(2));
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(2),oTarget);
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(iRoll),oTarget);
        }
        AssignCommand(oPC,ActionSpeakString("*Applies Henbane*"));
        AssignCommand(oTarget,ActionSpeakString("*Feels good*"));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACDecrease(4),oTarget,HoursToSeconds(2));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAttackDecrease(4),oTarget,HoursToSeconds(2));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageDecrease(4),oTarget,HoursToSeconds(2));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_ALL_SKILLS,4),oTarget,HoursToSeconds(2));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowDecrease(SAVING_THROW_ALL,4),oTarget,HoursToSeconds(2));
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Henbane correctly*"));
}
//if(sResRef == "juniperberries")
void JB(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 8)
    {
        AssignCommand(oPC, ActionSpeakString("*Applies Juniper berries*"));
        if(GetCurrentHitPoints(oTarget) <= 0)
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(d4()), oTarget);
        if(GetCurrentHitPoints(oTarget) == 0)
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1),oTarget);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_POISON), oTarget, HoursToSeconds(2));

        if(GetRacialType(oTarget) == RACIAL_TYPE_ELF || GetRacialType(oTarget) == RACIAL_TYPE_HALFELF)
        {
            if(!WillSave(oTarget,15))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCharmed(),oTarget,RoundsToSeconds(d4(2)));
            }
        }
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Juniper Berries correctly*"));
}
//if(sResRef == "passionflower")
void PF(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 5)
    {
        AssignCommand(oPC,ActionSpeakString("*Applies Passion Flower*"));
        if(GetRacialType(oTarget) == RACIAL_TYPE_ELF || GetRacialType(oTarget) == RACIAL_TYPE_HALFELF)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSleep(),oTarget,HoursToSeconds(d3(3)));
        }
        else
            AssignCommand(oPC,ActionSpeakString("*It apparently has no effect on the elvish*"));
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Passion Flower correctly*"));

}
//if(sResRef == "plagueward")
void PW(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Plague Ward*"));
    int iD = d4();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_ALL,4,SAVING_THROW_TYPE_DISEASE),oTarget,HoursToSeconds(iD));
}
//if(sResRef == "poppy")
void PO(object oPC, object oTarget)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(d4()+2),oTarget);
    AssignCommand(oPC,ActionSpeakString("*Applies Poppy*"));
    AssignCommand(oTarget,ActionSpeakString("*Feels good*"));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACDecrease(4),oTarget,HoursToSeconds(2));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAttackDecrease(4),oTarget,HoursToSeconds(2));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageDecrease(4),oTarget,HoursToSeconds(2));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_ALL_SKILLS,4),oTarget,HoursToSeconds(2));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowDecrease(SAVING_THROW_ALL,4),oTarget,HoursToSeconds(2));
}
//if(sResRef == "wintersalve")
void WS(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Wintersalve*"));
    int iD = d4();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_ALL,1,SAVING_THROW_TYPE_COLD),oTarget,HoursToSeconds(iD));
}
//if(sResRef == "witchwood")
void WW(object oPC, object oTarget)
{
    if(d20() + GetSkillRank(SKILL_HEAL,oPC) >= 5)
    {
        AssignCommand(oPC,ActionSpeakString("*Applies Witchwood*"));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(d3(2)),oTarget);
    }
    else
        AssignCommand(oPC,ActionSpeakString("*Fails to apply Witchwood correctly*"));
}

//if(sResRef == "004HERBHaunspeir")
void HAUN(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Haunspeir*"));
    int iDur = d10() + 15;
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4()),oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACDecrease(1,AC_NATURAL_BONUS,DAMAGE_TYPE_PIERCING),oTarget,RoundsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACDecrease(1,AC_NATURAL_BONUS,DAMAGE_TYPE_SLASHING),oTarget,RoundsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_INTELLIGENCE,d4()+1),oTarget,RoundsToSeconds(iDur));
}
//if(sResRef == "004HERBJhuild")
void JHUILD(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Jhuild*"));
    int iDur = d3();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_WISDOM,1),oTarget,TurnsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowDecrease(SAVING_THROW_ALL,20,SAVING_THROW_TYPE_FEAR),oTarget,TurnsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_CONCENTRATION,20),oTarget,TurnsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_DISCIPLINE,20),oTarget,TurnsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,2),oTarget,TurnsToSeconds(iDur));

}
//if(sResRef == "004HERBKammarth")
void KAMM(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Kammarth*"));
    int iDur = d4() + 1;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_DEXTERITY,2),oTarget,RoundsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedIncrease(100),oTarget,RoundsToSeconds(iDur));

}
//if(sResRef == "004HERBKatakuda")
void KATA(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Katakuda*"));
    int iDur = 30;
    DelayCommand(RoundsToSeconds(iDur),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_DEXTERITY,d4()+1),oTarget,RoundsToSeconds(iDur)));
    DelayCommand(RoundsToSeconds(iDur),AssignCommand(oTarget,ActionSpeakString("Struck with spasms*")));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACIncrease(3,AC_NATURAL_BONUS,AC_VS_DAMAGE_TYPE_ALL),oTarget,RoundsToSeconds(iDur));
}
//if(sResRef == "004HERBBattlewine")
void BATTLE(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Battlewine*"));
    int iDur = d4()+1;
    DelayCommand(RoundsToSeconds(iDur),AssignCommand(oTarget,ActionSpeakString("*Exhausted!*")));
    DelayCommand(RoundsToSeconds(iDur),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_STRENGTH,6),oTarget,TurnsToSeconds(iDur)));
    DelayCommand(RoundsToSeconds(iDur),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_CONSTITUTION,6),oTarget,TurnsToSeconds(iDur)));
    DelayCommand(RoundsToSeconds(iDur),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedDecrease(50),oTarget,TurnsToSeconds(iDur)));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,4),oTarget,RoundsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CONSTITUTION,4),oTarget,RoundsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACDecrease(2,AC_DEFLECTION_BONUS,AC_VS_DAMAGE_TYPE_ALL),oTarget,RoundsToSeconds(iDur));
}
//if(sResRef == "sezarad")
void SEZ(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Sezarad Root*"));
    int iDur = 10;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_WISDOM,d4()),oTarget,RoundsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTemporaryHitpoints(d8()),oTarget,RoundsToSeconds(iDur));

}
//if(sResRef == "tekki")
void TEK(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Tekkil*"));
    int iDur = d4();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_DEXTERITY,3),oTarget,RoundsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageReduction(1,DAMAGE_POWER_NORMAL,0),oTarget,RoundsToSeconds(iDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_ALL,1,SAVING_THROW_TYPE_ALL),oTarget,RoundsToSeconds(iDur));

}
//if(sResRef == "004HERBBloodfast")
void BLOOD(object oPC, object oTarget)
{
    AssignCommand(oPC,ActionSpeakString("*Applies Bloodfast*"));
    int iDur = d3();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDazed(),oTarget,RoundsToSeconds(1));
    DelayCommand(RoundsToSeconds(1),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_CONSTITUTION,2),oTarget,RoundsToSeconds(iDur)));
    DelayCommand(RoundsToSeconds(1),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_DEXTERITY,2),oTarget,RoundsToSeconds(iDur)));

}

void main()
{
    string sResRef = GetTag(GetItemActivated());
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();

    if(GetDistanceBetween(oPC, oTarget) <= 3.0)
    {
        if(GetIsFriend(oPC, oTarget))
        {
                if(sResRef == "004HERBAaronsRod")
                    AR(oPC, oTarget);
                if(sResRef == "004HERBAddersTongue")
                    AT(oPC, oTarget);
                if(sResRef == "004HERBAllsaintswort")
                    ASW(oPC, oTarget);
                if(sResRef == "004HERBAllcure")
                    AC(oPC, oTarget);
                if(sResRef == "004HERBAloe")
                    ALO(oPC, oTarget);
                if(sResRef == "004HERBArnica")
                    ARN(oPC, oTarget);
                if(sResRef == "004HERBBilberry")
                    BIL(oPC, oTarget);
                if(sResRef == "004HERBBinglang")
                    BL(oPC, oTarget);
                if(sResRef == "004HERBBirthwort")
                    BW(oPC, oTarget);
                if(sResRef == "004HERBBloodroot")
                    BR(oPC, oTarget);
                if(sResRef == "004HERBBugsbane")
                    BB(oPC, oTarget);
                if(sResRef == "004HERBCatsclaw")
                    CC(oPC, oTarget);
                if(sResRef == "004HERBComfrey")
                    CF(oPC, oTarget);
                if(sResRef == "004HERBCrawlbane")
                    CB(oPC, oTarget);
                if(sResRef == "004HERBDarkweed")
                    DW(oPC, oTarget);
                if(sResRef == "004HERBDwale")
                    DA(oPC, oTarget);
                if(sResRef == "004HERBEchinacea")
                    EC(oPC, oTarget);
                if(sResRef == "004HERBEuphorisum")
                    EU(oPC, oTarget);
                if(sResRef == "004HERBFiendflower")
                    FF(oPC, oTarget);
                if(sResRef == "004HERBGarclive")
                    GC(oPC, oTarget);
                if(sResRef == "004HERBGhostroot")
                    GR(oPC, oTarget);
                if(sResRef == "004HERBGinkgo")
                    GI(oPC, oTarget);
                if(sResRef == "004HERBGinseng")
                    GS(oPC, oTarget);
                if(sResRef == "004HERBHenbane")
                    HE(oPC, oTarget);
                if(sResRef == "004HERBJuniperberries")
                    JB(oPC,oTarget);
                if(sResRef == "004HERBPassionflower")
                    PF(oPC, oTarget);
                if(sResRef == "004HERBPlagueward")
                    PW(oPC, oTarget);
                if(sResRef == "004HERBPoppy")
                    PO(oPC, oTarget);
                if(sResRef == "004HERBWintersalve")
                    WS(oPC, oTarget);
                if(sResRef == "004HERBWitchwood")
                    WW(oPC, oTarget);
                if(sResRef == "004HERBHaunspeir")
                    HAUN(oPC, oTarget);
                if(sResRef == "004HERBJhuild")
                    JHUILD(oPC, oTarget);
                if(sResRef == "004HERBKammarth")
                    KAMM(oPC, oTarget);
                if(sResRef == "004HERBKatakuda")
                    KATA(oPC, oTarget);
                if(sResRef == "004HERBBattlewine")
                    BATTLE(oPC, oTarget);
                if(sResRef == "004HERBSezarad")
                    SEZ(oPC, oTarget);
                if(sResRef == "004HERBTekkil")
                    TEK(oPC, oTarget);
                if(sResRef == "004HERBBloodfast")
                    BLOOD(oPC, oTarget);
        }
        else
        {
            FloatingTextStringOnCreature("You can only use it on a willing target.",oPC,FALSE);
        }
    }
    else
    {
        FloatingTextStringOnCreature("You're too far away.",oPC,FALSE);
    }
}
