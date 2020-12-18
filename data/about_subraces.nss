/*
Full Subraces Support
       BETA 1
By Shir'le E. Illios


The scripts included in this file offer full subraces support.


Quick Installation
==================

For each area in your module set the OnEnter event. This can be one of the following
scripts:

sei_oea_default - For area's using the module's default setting.
sei_oea_indoors - For indoor areas.
sei_oea_outside - For areas outside.
sei_oea_uground - For underground areas.

Alternatively you can also write your own script that calls Subraces_OnEnterArea and sets
light/ground settings for the area.

If the area is an outside area (using sei_oea_outside or otherwise having the AREA_SUN setting)
then also include sei_hb_area as the area's OnHeartbeat event. This script keeps track of whether
the sun is still up or not.

And that's it for the quick installation instructions. Any further questions then please contact
shirle@drowwanderer.com or wait for the full release with complete documentation.

And since this is a Beta I ask you to report any bugs, problems, possible improvements, etc to the
author of this script: shirle@drowwanderer.com.

Thank you for taking the time to test this script and enjoy the magic.


Love -x-x-x-

Shir'le
_______________

-= Shir'le E. Illios =-
 Chosen of Eilistraee
http://chosen.drowwanderer.com
*/

void main() {}
