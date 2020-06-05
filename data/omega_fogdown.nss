#include "omega_include"
void main()
{
int nMath = GetLocalInt(oDM, "FOG_NUMBER");

    nMath -= 1;
  if (nMath == 0)
  {
  nMath = 17;
  }
        SetLocalInt(oDM,"FOG_NUMBER", nMath);
    GetFogColorWeel(nMath);
    string sColor = GetLocalString(oDM, "STR_COLOR");
    int nTime = GetLocalInt(oDM, "FOG_TIME_CONST");
            if(nTime == FOG_TYPE_SUN){
            SetCustomToken(6975, sColor);}
            if(nTime == FOG_TYPE_MOON) {
            SetCustomToken(6976, sColor); }
            if(nTime == FOG_TYPE_ALL) {
            SetCustomToken(6975, sColor);
            SetCustomToken(6976, sColor);}
}
