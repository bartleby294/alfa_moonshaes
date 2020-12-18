#include "subraces"

const int ADMF_XPROD_DEBUG_LOGGING = TRUE;

// Returns the correct amount of XP to award to oPC when the DM wants to award
// nXP xp (before taking subrace-ECL/multiclassing penalties into account).
int admf_CalculateXPtoAward(object oPC, int nXP);

// Reward the correct amount of XP to oPC, taking into account subrace-ECL and
// multiclassing penalties.
// - oPC
// - nXP: The amount to be awarded BEFORE subrace-ECL/multiclassing penalties
//   are taken into account
// - bAwardToParty: if set to TRUE, award nXP (after penalties) to oPC's entire
//   party
void admf_AwardXP(object oPC, int nXP, int bAwardToParty = FALSE);


// Wrapper functions to ensure no stuffups with variables
void admf_SetQuestCR(int nCR);
void admf_SetImportanceRating(int nIR);
void admf_SetRPAward(int nRP_XP);
void admf_SetSessionDuration(float fHours);
int admf_GetQuestCR();
int admf_GetImportanceRating();
int admf_GetRPAward();
float admf_GetSessionDuration();

/******************************************************************************/

int admf_CalculateXPtoAward(object oPC, int nXP)
{
  int nReturn;

  int nSubRace = Subraces_GetCharacterSubrace(oPC);
  int nECL = 0;
  int nFavored;
  switch(nSubRace)
  {
    case 2: nFavored = CLASS_TYPE_FIGHTER; break;
    case 3: nECL = 2; nFavored = CLASS_TYPE_FIGHTER; break;
    case 4: nFavored = CLASS_TYPE_FIGHTER; break;
    case 5: nECL = 2; if(GetGender(oPC) == GENDER_FEMALE){nFavored = CLASS_TYPE_CLERIC;}
                      else{nFavored = CLASS_TYPE_WIZARD;} break;
    case 6: nFavored = CLASS_TYPE_WIZARD; break;
    case 7: nFavored = CLASS_TYPE_WIZARD; break;
    case 8: nFavored = CLASS_TYPE_SORCERER; break;
    case 9: nFavored = CLASS_TYPE_RANGER; break;
    case 10: nECL = 3; nFavored = CLASS_TYPE_WIZARD; break;
    case 11: nFavored = CLASS_TYPE_WIZARD; break;
    case 12: nFavored = -1; break;
    case 13: nFavored = CLASS_TYPE_BARBARIAN; break;
    case 14: nFavored = CLASS_TYPE_BARBARIAN; break;
    case 15: nFavored = CLASS_TYPE_ROGUE; break;
    case 16: nFavored = CLASS_TYPE_ROGUE; break;
    case 17: nFavored = -1; break;
    case 18: nFavored = -1; break;
    default: SendMessageToPC(GetPCSpeaker(),"ERROR: The player you are targetting does not have a valid subrace."
                            +" Please wait until they finish choosing their subrace, then try again."); return 0;
  }

  if(nECL)
  {
    int nLevel = GetHitDice(oPC);
    int nTrueLevel = nLevel + nECL;
    nXP = FloatToInt(IntToFloat(nXP)/(nTrueLevel*1000)*(nLevel*1000));
  }

  int nClass1 = GetClassByPosition(1,oPC);
  int nClass2 = GetClassByPosition(2,oPC);
  int nClass3 = GetClassByPosition(3,oPC);

  int nCL1 = GetLevelByClass(nClass1,oPC);
  int nCL2;
  int nCL3;
  int nCNum = 0;
  if(nClass2 != CLASS_TYPE_INVALID)
  {
    nCL2 = GetLevelByClass(nClass2,oPC);
    nCNum = 1;
    if(nClass3 != CLASS_TYPE_INVALID)
    {
      nCL3 = GetLevelByClass(nClass3,oPC);
      nCNum = 2;
    }
  }
  switch(nCNum)
  {
    case 0: nReturn = nXP; break;
    case 1:
            if((nClass1 == nFavored || nClass2 == nFavored || nFavored == -1)
              || (nCL1 <= (nCL2+1) && nCL1 >= (nCL2-1)))
            {
              nReturn = nXP;
            }
            else
            {
              nReturn = FloatToInt(nXP*0.8);
            }
            break;
    case 2: if(nClass1 == nFavored || (nCL1 >= nCL2 && nCL1 >= nCL3 && nFavored == -1))
            {
              if(nCL2 <= (nCL3+1) && nCL2 >= (nCL2-1))
              {
                nReturn = nXP;
              }
              else
              {
                nReturn = FloatToInt(nXP*0.8);
              }
            }
            else if(nClass2 == nFavored || (nCL2 >= nCL1 && nCL2 >= nCL3 && nFavored == -1))
            {
              if(nCL1 <= (nCL3+1) && nCL1 >= (nCL3-1))
              {
                nReturn = nXP;
              }
              else
              {
                nReturn = FloatToInt(nXP*0.8);
              }
            }
            else if(nClass3 == nFavored || (nCL3 >= nCL2 && nCL3 >= nCL1 && nFavored == -1))
            {
              if(nCL1 <= (nCL2+1) && nCL1 >= (nCL2-1))
              {
                nReturn = nXP;
              }
              else
              {
                nReturn = FloatToInt(nXP*0.8);
              }
            }
            else
            {
              if(nCL1 <= (nCL2+1) && nCL1 >= (nCL2-1))
              {
                if(nCL1 <= (nCL3+1) && nCL1 >= (nCL3-1))
                {
                  if(nCL2 <= (nCL3+1) && nCL2 >= (nCL3-1))
                    nReturn = nXP;
                  else
                    nReturn = FloatToInt(nXP*0.8);
                }
                else
                {
                  nReturn = FloatToInt(nXP*0.8);
                }
              }
              else
              {
                if(nCL1 <= (nCL3+1) && nCL1 >= (nCL3-1))
                {
                  nReturn = FloatToInt(nXP*0.8);
                }
                else
                {
                  if(nCL2 <= (nCL3+1) && nCL2 >= (nCL3-1))
                  {
                    nReturn = FloatToInt(nXP*0.8);
                  }
                  else
                  {
                    nReturn = FloatToInt(nXP*0.6);
                  }
                }
              }
            }
            break;
  }

  return nReturn;
}

void admf_AwardXP(object oPC, int nXP, int bAwardToParty = FALSE)
{
  int nCalculatedXP;
  if(bAwardToParty)
  {
    object oParty = GetFirstFactionMember(oPC);
    while(GetIsObjectValid(oParty))
    {
      nCalculatedXP = admf_CalculateXPtoAward(oParty,nXP);
      SendMessageToPC(GetPCSpeaker(),"DM has awarded "+IntToString(nCalculatedXP)
        +"xp to "+GetName(oParty));
      if(ADMF_XPROD_DEBUG_LOGGING && nCalculatedXP > 0)
      {
        WriteTimestampedLogEntry("ADMF_XPROD_START:- DM: "+GetPCPlayerName(GetPCSpeaker())
          +" has awarded player: "+GetName(oParty)+" [played by: "
          +GetPCPlayerName(oParty)+"] "+IntToString(nCalculatedXP)+"xp. ADMF_XPROD_END");
      }
      nCalculatedXP += GetXP(oParty);
      SetXP(oParty,nCalculatedXP);
      oParty = GetNextFactionMember(oPC);
    }
  }
  else
  {
    nCalculatedXP = admf_CalculateXPtoAward(oPC,nXP);
    SendMessageToPC(GetPCSpeaker(),"DM has awarded "+IntToString(nCalculatedXP)
        +"xp to "+GetName(oPC));
    if(ADMF_XPROD_DEBUG_LOGGING && nCalculatedXP > 0)
    {
      WriteTimestampedLogEntry("ADMF_XPROD_START:- DM: "+GetPCPlayerName(GetPCSpeaker())
        +" has awarded player: "+GetName(oPC)+" [played by: "
        +GetPCPlayerName(oPC)+"] "+IntToString(nCalculatedXP)+"xp. ADMF_XPROD_END");
    }
    nCalculatedXP += GetXP(oPC);
    SetXP(oPC,nCalculatedXP);
  }
}

void admf_SetQuestCR(int nCR)
{
  SetLocalInt(OBJECT_SELF,"ADMF_XPROD_QUESTCR",nCR);
}

void admf_SetImportanceRating(int nIR)
{
  SetLocalInt(OBJECT_SELF,"ADMF_XPROD_IMPORTANCE",nIR);
}

void admf_SetRPAward(int nRP_XP)
{
  SetLocalInt(OBJECT_SELF,"ADMF_XPROD_RPSESSION_XP",nRP_XP);
}

void admf_SetSessionDuration(float fHours)
{
  SetLocalFloat(OBJECT_SELF,"ADMF_XPROD_RPSESSION_DURATION",fHours);
}

int admf_GetQuestCR()
{
  return GetLocalInt(OBJECT_SELF,"ADMF_XPROD_QUESTCR");
}

int admf_GetImportanceRating()
{
  return GetLocalInt(OBJECT_SELF,"ADMF_XPROD_IMPORTANCE");
}

int admf_GetRPAward()
{
  return GetLocalInt(OBJECT_SELF,"ADMF_XPROD_RPSESSION_XP");
}

float admf_GetSessionDuration()
{
  return GetLocalFloat(OBJECT_SELF,"ADMF_XPROD_RPSESSION_DURATION");
}
/*
void main()
{

}
*/

