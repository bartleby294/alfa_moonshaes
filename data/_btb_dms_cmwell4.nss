#include "_btb_moonwellcon"
#include "_btb_moonwelllea"

void main()
{
    object oPC = GetPCSpeaker();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
    object highDruid = GetNearestObjectByTag("moonwelldruid000");
    object Druid01 = GetNearestObjectByTag("moonwelldruid001");
    object Druid02 = GetNearestObjectByTag("moonwelldruid002");
    object Druid03 = GetNearestObjectByTag("moonwelldruid003");
    object Druid04 = GetNearestObjectByTag("moonwelldruid004");
    object light = GetNearestObjectByTag("alfa_shaftligt6");

    druidsLeave(oPC, obHbObj, highDruid, Druid01, Druid02, Druid03, Druid04,
                LEAVING_STATE ,light);

    SetLocalInt(obHbObj, "state", LEAVING_STATE);
}
