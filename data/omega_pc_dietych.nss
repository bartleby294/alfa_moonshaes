#include "dmw_inc"
      void main()
{

   SendMessageToPC(oMySpeaker,"\n-------------------------------------------" +
                       "\nReported: "+IntToString(GetTimeHour())+":"+IntToString(GetTimeMinute())+
                       "\nPlayer Name: " + GetPCPlayerName(oMyTarget) +
                       "\nChar Name:   " + GetName(oMyTarget) +
                       "\n-------------------------------------------" +
                        "\nAign:    " + Alignment(oMyTarget) +
                       "\nDiety:  " + GetDeity(oMyTarget) +
                       "\n-------------------------------------------");
}
