#include "date_time_functs"

void OnUseDrugs()
{
    object oUsed = GetItemActivated();
    object oTarget = GetItemActivatedTarget();

    //______________________________________________________________________________
    if(GetTag(oUsed) == "Haunspeir")
        {
        object oPC = GetItemActivator();
        SetLocalObject(GetModule(), "PC_DRUG_USER", oPC);
        //see if the PC can use the drug:
        int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
        int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
        int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
        if(nCheck1 >= 12 || nCheck2 >= 12 || nCheck3 >= 12)
            {
            int nThisTripHour = GetTimeHour();
            int nThisTripDay = GetCalendarDay();
            int nThisTripMonth = GetCalendarMonth();
            int nThisTripYear = GetCalendarYear();
            string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
            //check to see if the PC took this drug too soon
            if(GetLocalString(oPC, "LAST_HUANSPEIR_TRIP") == "" || TimeSince(GetLocalString(oPC, "LAST_HUANSPEIR_TRIP"), sThisTrip, "hours") >= 24)
                {//if the last drug use was more than one day ago, the PC can use it again...
                //tell the PC they took the drug successfully
                SendMessageToPC(oPC, "You ingested the Haunspeir");
                //make the visuals:
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_SANCTUARY), oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_BLINDDEAF), oPC);
                //make the effects:
                float fLast = (d10() + 15.0) * 2.0;//how long the effect will last(calc'd to number of "real-time" seconds
                int nAdd = d4() + 1;//the increase in intelligence
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d4(), DAMAGE_TYPE_SLASHING, DAMAGE_POWER_NORMAL), oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(ABILITY_INTELLIGENCE, nAdd), oPC, fLast);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageDecrease(1, DAMAGE_TYPE_SLASHING), oPC, fLast);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageDecrease(1, DAMAGE_TYPE_BLUDGEONING), oPC, fLast);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageDecrease(1, DAMAGE_TYPE_PIERCING), oPC, fLast);
                DelayCommand(fLast, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_MIND), oPC));
                //set up the overdose system:
                int nYear = GetCalendarYear();
                int nMonth = GetCalendarMonth();
                int nDay = GetCalendarDay();
                int nHour = GetTimeHour();
                int nMinute = GetTimeMinute();
                string sLastTrip = IntToString(nMonth) + "/" + IntToString(nDay) + "/" + IntToString(nYear) + "/" + IntToString(nHour);
                //record the date and time of this trip:
                SetLocalString(oPC, "LAST_HUANSPEIR_TRIP", sLastTrip);
                //setup addiction stuff

                }
             else//overdose
                {
                int nDamage = d4() + d4();
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_NORMAL), oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
                string sOD = "You just overdosed on Haunspeir, taking " + IntToString(nDamage) + " damage";
                SendMessageToPC(oPC, sOD);
                }
            }//end nCheck's if
        else
            SendMessageToPC(oPC, "You didn't ingested the Haunspeir");
        }//end Huanspeir
    //______________________________________________________________________________
    if(GetTag(oUsed) == "Jhuild")
        {
        object oPC = GetItemActivator();
        //see if the PC can use the drug:
        int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
        int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
        int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
        if(nCheck1 >= 15 || nCheck2 >= 15 || nCheck3 >= 15)
            {
            //tell the PC they took the drug successfully
            SendMessageToPC(oPC, "You drank the Jhuild");
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_HOLY), oPC);
            int nLast = d3();//1d3 hours of game time
            float fTime = nLast * 120.0;//get the number of seconds the effect will last
            //now make the real effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_WISDOM, 1), oPC, fTime);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(ABILITY_STRENGTH, 2), oPC, fTime);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowDecrease(SAVING_THROW_ALL, 5, SAVING_THROW_TYPE_MIND_SPELLS), oPC, fTime);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowDecrease(SAVING_THROW_ALL, 5, SAVING_THROW_TYPE_FEAR), oPC, fTime);
            DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oPC));
            //no overdose, no addiction :-)
            }
        else
            SendMessageToPC(oPC, "You didn't drink the Jhuild");
        }
    //______________________________________________________________________________
    if(GetTag(oUsed) == "Kammarth")
        {
        object oPC = GetItemActivator();
        //see if the PC can use the drug:
        int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
        int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
        int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
        if(nCheck1 >= 10 || nCheck2 >= 10 || nCheck3 >= 10)
            {
            int nThisTripHour = GetTimeHour();
            int nThisTripDay = GetCalendarDay();
            int nThisTripMonth = GetCalendarMonth();
            int nThisTripYear = GetCalendarYear();
            string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
            //check to see if the PC took this drug too soon
            if(GetLocalString(oPC, "LAST_KAMMARTH_TRIP") == "" || TimeSince(GetLocalString(oPC, "LAST_KAMMARTH_TRIP"), sThisTrip, "hours") >= 8)
                {
                //tell the PC they took the drug successfully
                SendMessageToPC(oPC, "You touched the Kammarth");
                //make the visual effects:
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_COLD), oPC);
                int nIEffect = d4() + 1;
                float fIEffect = nIEffect * 2.0;//make the initial effect game-time length
                int nSEffect = d4();
                float fSEffect = nSEffect * 120.0;
                //Initial Effect: The PC becomes frieghtened for 1d4+1 game-time minutes
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectFrightened(), oPC, fIEffect);
                //Secondary Effect: plus 2 to dexterity for 1d4 hours
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(ABILITY_DEXTERITY, 2), oPC, fSEffect);
                DelayCommand(fIEffect + fSEffect, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_SONIC), oPC));
                SetLocalString(oPC, "LAST_KAMMARTH_TRIP", sThisTrip);
                //setup addiction rules:

                }
             else//overdose
                {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
                int nDamage = d4();
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL), oPC);
                float fPTime = (d4() + d4()) * 2.0;
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectParalyze(), oPC, fPTime);
                string sODMessage = "You just overdosed on Kammarth, Taking " + IntToString(nDamage) + " damage. You're paralyzed for " + FloatToString(fPTime) + " seconds";
                SendMessageToPC(oPC, sODMessage);
                }
            }
        else
            SendMessageToPC(oPC, "You didn't touch the Kammarth");
        }
    //______________________________________________________________________________
    if(GetTag(oUsed) == "MordaynVapor")
        {
        object oPC = GetItemActivator();
        //see if the PC can use the drug:
        int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
        int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
        int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
        if(nCheck1 >= 17 || nCheck2 >= 17 || nCheck3 >= 17)
            {
            int nThisTripHour = GetTimeHour();
            int nThisTripDay = GetCalendarDay();
            int nThisTripMonth = GetCalendarMonth();
            int nThisTripYear = GetCalendarYear();
            string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
            //check to see if the PC took this drug too soon
            if(GetLocalString(oPC, "LAST_MVAPOR_TRIP") == "" || TimeSince(GetLocalString(oPC, "LAST_MVAPOR_TRIP"), sThisTrip, "hours") >= 3)
                {
                //tell the PC they took the drug successfully
                SendMessageToPC(oPC, "You inhaled the Mardayn Vapor");
                //make the visual effects:
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_BLINDDEAF), oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE), oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_PROT_PREMONITION), oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE), oPC);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(AOE_PER_FOGACID), GetLocation(oPC));
                //make the effects:
                float fDur = (d12() + 10.0) * 2.0;
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectUltravision(), oPC, fDur);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTrueSeeing(), oPC, fDur);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSeeInvisible(), oPC, fDur);
                //Secondary Effect: loss of constitution and wisdom
                DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_CONSTITUTION, d4()), oPC, 15.0));
                DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_WISDOM, d4()), oPC, 15.0));
                DelayCommand(fDur, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_HOLY), oPC));
                DelayCommand(fDur, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_HEAL), oPC));
                SetLocalString(oPC, "LAST_MVAPOR_TRIP", sThisTrip);
                //setup the addiction rules:

                }
            else//overdose
                {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
                int nSave = WillSave(oPC, 17, SAVING_THROW_TYPE_POISON);
                switch(nSave)
                    {
                    case 0://the PC failed the save
                        SendMessageToPC(oPC, "You just overdosed on Mardayn Vapor and died");
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oPC);
                        break;
                    case 1://the PC passed the save
                        SendMessageToPC(oPC, "You just overdosed on Mardayn Vapor but didn't die");
                        //setup the addiction rules:

                        break;
                    case 2://the PC was immune to the save
                        SendMessageToPC(oPC, "You just overdosed on Mardayn Vapor but didn't die");
                        //setup the addiction rules:

                        break;
                    }
                }
            }
        else
            SendMessageToPC(oPC, "You didn't inhale the Mardayn Vapor");
        }
    //______________________________________________________________________________
    if(GetTag(oUsed) == "Katakuda")
        {
        object oPC = GetItemActivator();
        //see if the PC can use the drug:
        int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
        int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
        int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
        if(nCheck1 >= 18 || nCheck2 >= 18 || nCheck3 >= 18 || GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
            {
            int nThisTripHour = GetTimeHour();
            int nThisTripDay = GetCalendarDay();
            int nThisTripMonth = GetCalendarMonth();
            int nThisTripYear = GetCalendarYear();
            string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
            //check to see if the PC took this drug too soon
            if(GetLocalString(oPC, "LAST_KATAKUDA_TRIP") == "" || TimeSince(GetLocalString(oPC, "LAST_KATAKUDA_TRIP"), sThisTrip, "hours") >= 48)
                {
                //tell the PC they took the drug successfully
                SendMessageToPC(oPC, "You touched the Katakuda");
                //make the visual effects:
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_AC_BONUS), oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_BARKSKIN), oPC, 60.0);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIRESTORM), oPC);
                //Secondary effect: +3 to natual AC
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(3, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), oPC, 60.0);
                //Side Effects: Muscle spasms and dexterity decrease
                DelayCommand(60.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
                DelayCommand(60.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_DEXTERITY, (d4()+1)), oPC, 15.0));
                DelayCommand(75.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ODD), oPC));
                SetLocalString(oPC, "LAST_KATAKUDA_TRIP", sThisTrip);
                }
            else//overdose
                {
                SendMessageToPC(oPC, "You overdosed on Katakuda causing only +2 to Natural Armor");
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(2, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), oPC, 60.0);
                }
            }
        else
            SendMessageToPC(oPC, "You didn't touch the Katakuda");
        }
    //______________________________________________________________________________
    if(GetTag(oUsed) == "Rhul")
        {
        object oPC = GetItemActivator();
        //see if the PC can use the drug:
        int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
        int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
        int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
        if(nCheck1 >= 15 || nCheck2 >= 15 || nCheck3 >= 15)
            {
            int nThisTripHour = GetTimeHour();
            int nThisTripDay = GetCalendarDay();
            int nThisTripMonth = GetCalendarMonth();
            int nThisTripYear = GetCalendarYear();
            string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
            //check to see if the PC took this drug too soon
            if(GetLocalString(oPC, "LAST_RHUL_TRIP") == "" || TimeSince(GetLocalString(oPC, "LAST_RHUL_TRIP"), sThisTrip, "hours") >= 1)
                {
                //tell the PC they took the drug successfully
                SendMessageToPC(oPC, "You drank the Rhul");
                //make the visual effects:
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_AC_BONUS), oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD), oPC, 15.0);
                //initial effect: +4 to strength and cons: -4 to wisdon
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(ABILITY_STRENGTH, 4), oPC, 60.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(ABILITY_CONSTITUTION, 4), oPC, 60.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_WISDOM, 4), oPC, 60.0);
                //secondary effect: fatigue
                DelayCommand(15.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oPC, 10.0));
                DelayCommand(25.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oPC));
                SetLocalString(oPC, "LAST_RHUL_TRIP", sThisTrip);
                //setup addiction rules

                }
            else//overdose
                {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
                int nIntelDam = d4();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_INTELLIGENCE, nIntelDam), oPC, 60.0);
                SendMessageToPC(oPC, "You overdosed on Rhul, taking " + IntToString(nIntelDam) + " temporary intelligence damage");
                }
            }
        else
            SendMessageToPC(oPC, "You didn't drink the Rhul");
        }
    //______________________________________________________________________________
    if(GetTag(oUsed) == "SezaradRoot")
        {
        object oPC = GetItemActivator();
        //see if the PC can use the drug:
        int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
        int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
        int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
        if(nCheck1 >= 14 || nCheck2 >= 14 || nCheck3 >= 14)
            {
            int nThisTripHour = GetTimeHour();
            int nThisTripDay = GetCalendarDay();
            int nThisTripMonth = GetCalendarMonth();
            int nThisTripYear = GetCalendarYear();
            string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
            //tell the PC they took the drug successfully
            SendMessageToPC(oPC, "You ingested the Sezard Root");
            //make the visual effects:
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_G), oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE), oPC);
            //make the effects:
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTemporaryHitpoints(d8()), oPC, 30.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_WISDOM, d4()), oPC, 30.0);
            DelayCommand(30.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ACID), oPC));
            //setup addiction rules

            }
        else
            SendMessageToPC(oPC, "You didn't ingest the Sezard Root");
        }
    //______________________________________________________________________________
    if(GetTag(oUsed) == "Ziran")
        {
        object oPC = GetItemActivator();
        //see if the PC can use the drug:
        int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
        int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
        int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
        if(nCheck1 >= 17 || nCheck2 >= 17 || nCheck3 >= 17)
            {
            int nThisTripHour = GetTimeHour();
            int nThisTripDay = GetCalendarDay();
            int nThisTripMonth = GetCalendarMonth();
            int nThisTripYear = GetCalendarYear();
            string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
            //tell the PC they took the drug successfully
            SendMessageToPC(oPC, "You ingested the Ziran");
            float fDur = d3() * 120.0;//1d3 hours
            //make the visual effects:
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT), oPC, fDur);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGICAL_VISION), oPC);
            //make the effects:
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 4.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(ABILITY_DEXTERITY, 2), oPC, fDur);
            DelayCommand(fDur, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_CONSTITUTION, 2), oPC, 45.0));
            DelayCommand(fDur + 45.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_SONIC), oPC));
            //setup  addiction rules

            }
        else
            SendMessageToPC(oPC, "You didn't ingest the Ziran");
        }
    //______________________________________________________________________________
}
