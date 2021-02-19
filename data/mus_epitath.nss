#include "x2_inc_switches"

void main()
{
 object oPC = GetItemActivator();
 SendMessageToPC(oPC,"** in the music**");

 object oArea = GetArea(oPC);
 int iMusicTrackDay = GetLocalInt(oArea, "musicchangeday");
 int iMusicTrackNight = GetLocalInt(oArea, "musicchangenight");
 if(iMusicTrackDay || iMusicTrackNight){
   MusicBackgroundChangeDay(oArea, iMusicTrackDay);
   MusicBackgroundChangeNight(oArea, iMusicTrackNight);
   SetLocalInt(oArea, "musicchangeday", 0);
   SetLocalInt(oArea, "musicchangenight", 0);
 }
 else{
   SetLocalInt(oArea, "musicchangeday", MusicBackgroundGetDayTrack(oArea));
   SendMessageToPC(oPC,"Day Music Track:" + IntToString(GetLocalInt(oArea, "musicchangeday")) );
   SetLocalInt(oArea, "musicchangenight", MusicBackgroundGetNightTrack(oArea));
   SendMessageToPC(oPC,"Night Music Track:" + IntToString(GetLocalInt(oArea, "musicchangenight")) );
   MusicBackgroundChangeDay(oArea, 289);
   MusicBackgroundChangeNight(oArea, 289);
 }




}
