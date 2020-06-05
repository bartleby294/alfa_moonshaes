#include "omega_include"
void main()
{

float fTime = GetLocalFloat(oDM, "DURATION_TIME");
string sTime;
int nDurationtype = DURATION_TYPE_TEMPORARY;

  fTime += 5.0;
int nSecond = FloatToInt(fTime);

SetLocalInt(oDM, "DURATION_TYPE", nDurationtype);
SetLocalFloat(oDM, "DURATION_TIME", fTime);

GetSecondToMinute(nSecond);
SetCustomToken( 6971, "5 seconds." );
}
