void AdvancedTokenSetup()
{
int dRed, dGreen, dBlue, nRed, nGreen, nBlue;

dRed = GetLocalInt(oDM, "FOG_D_RED");
dGreen = GetLocalInt(oDM, "FOG_D_GREEN");
dBlue = GetLocalInt(oDM, "FOG_D_BLUE");
nRed = GetLocalInt(oDM, "FOG_N_RED");
nGreen = GetLocalInt(oDM, "FOG_N_GREEN");
nBlue = GetLocalInt(oDM, "FOG_N_BLUE");


    SetCustomToken(6978, IntToString(dRed ));
    SetCustomToken(6979, IntToString(dGreen ));
    SetCustomToken(6980, IntToString(dBlue ));

    SetCustomToken(6978, IntToString(nRed ));
    SetCustomToken(6979, IntToString(nGreen ));
    SetCustomToken(6980, IntToString(nBlue ));
}
void LoadAndSaveToken(string sSlot1, string sSlot2, string sSlot3)
{
string sEmpty, sFull;
sEmpty = "Empty";
sFull = "Full";

if (sSlot1 == "")
{
    SetCustomToken(6987, sEmpty);
}
        else
        {
            SetCustomToken(6987, sFull);
        }
if (sSlot2 == "")
{
    SetCustomToken(6988, sEmpty);
}
        else
        {
            SetCustomToken(6988, sFull);
        }
if (sSlot3 == "")
{
    SetCustomToken(6989, sEmpty);
}
        else
       {
            SetCustomToken(6989, sFull);
        }
}
void SetSimpleFogT()
{
  int nFDday =  GetLocalInt(oDM, "F_AM_D");
   int nFDnight =  GetLocalInt(oDM, "F_AM_N");
        SetCustomToken(6992,IntToString(nFDday));
        SetCustomToken(6993,IntToString(nFDnight));
        }

void AdvFogDen(int nVarable)
{
int nCheck = GetLocalInt(oDM, "FOG_TIME_CONST");

  if (nCheck == FOG_TYPE_SUN)
    {
        SetLocalInt(oDM, "F_AM_D", nVarable);
        SetCustomToken(6994, "Day");
        }

    else if (nCheck == FOG_TYPE_MOON)
    {
        SetLocalInt(oDM, "F_AM_N", nVarable);
        SetCustomToken(6994, "Night");
        }
    else if (nCheck == FOG_TYPE_ALL)
     {
      SetLocalInt(oDM, "F_AM_D", nVarable);
    SetLocalInt(oDM, "F_AM_N", nVarable);
     SetCustomToken(6994, "Day and Night");
     }
    SetSimpleFogT();
}
