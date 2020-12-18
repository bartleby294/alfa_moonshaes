void main()
{
//This script is in it's base form. It's not intended to go into ALFA as is,
//since I was just playing around with it.

//Thanks goes to LP for his excellent Omega Wand script which I used as a
//foundation.

//There are some things in the caller scripts (scr_horse_*) that I didn't know
//what to do with, though my intention was to let the player have to click on
//the horse to use the bridle.

//I also put in a catch-all that if they were not close enough to the horse,
//that they would not be able to mount up.

//Here is the list of script names and what they do:

//Buy New Horse- scr_newhrse_05 (brown), scr_newhrse_06 (grey), scr_newhrse_07 (black)
//Mount Horse: scr_mnthrse_05 (brown), scr_mnthrse_06 (grey), scr_mnthrse_07
//Dismount Horse: scr_dsmnthrse_05 (brown), scr_dsmnthrse_06 (grey), scr_dsmnthrse_07 (black)
//Horse Conversations: C_horse_05 (brown), c_horse_06 (grey), c_horse_07 (black)
//Baliver's Conversation: c_Baliver

//Resrefs and TAGS:

//Brown Riding Horse/Creature: playerhorse_01/PLAYERHORSE_01 (4hp horse)
//Grey Riding Horse/Creature: playerhorse_02/PLAYERHORSE_02 (4hp Horse)
//Black Riding Horse/Creature: playerhorse_03/ PLAYERHORSE_03 (4hp Horse)

//Brown Bridle/Item: 043_brwnbrdl_01/ 043_BRWNBRDL_01
//Grey Bridle/Item: 043_greybrdl_01/ 043_GREYBRDL_01
//Black Bridle/Item: 043_blakbrdl_01/ 043_BLAKBRDL_01

//Waypoints:

//Brown Horse Initial Spawnpoint: WP_NEWHORSE_01 (in the stables)
//Grey Horse Initial Spawnpoint: WP_NEWHORSE_02 (in the stables)
//Black Horse Initial Spawnpoint: WP_NEWHORSE_03 (in the stables)
//Horse Storage Area Waypoint: WP_HORSE_01 (For when the player mounts the horse)

//Step 1: Import the Horse_01.erf.

//Step 2: Put the lines of code into the alfa_onactiv script, or whatever
//script you use:

//        /*Black Riding Horse Bridle */
//    ExecuteScript("scr_horse_black", GetItemActivator());
//        /*Brown Riding Horse Bridle */
//    ExecuteScript("scr_horse_brown", GetItemActivator());
//        /*Grey Riding Horse Bridle */
//    ExecuteScript("scr_horse_grey", GetItemActivator());

//Step 5: Place the specific waypoints above in the module. Save and Exit the module.
//Load the server and enter via the game client, log in and go to the area,
//"Baliver's House of Horses".

//Step 4: Buy the horse from Baliver ($4k-8k gold, better change this, heh). You
//get the Bridle of the horse color you chose. It spawns the horse in the barn
//behind the shop. I had the player's name included in the Horse's tag so noone
//else could mount up on their horse.

//Step 5: Go near the horse, use the bridle and select yes for mount. It force-
//moves the player to the horse. This increases the speed 20%, but should be
//removed.

//Step 6: It sends the horse creature to the _Horse_Storage_Area, saves the
//players original Phenotype persistently, and then changes the player to the
//appropriate phenotype dependent on what color of bridle/horse they bought.

//Step 7: Run around and have fun.

//Step 8: Use the Bridle again and select Yes for Dismount. It changes the players
//phenotype back to persistently saved phenotype, teleports the Horse with the
//player's name in it's tag to the player and forces it to follow the player.
//Removes 20% speed increase, though, not sure if I applied 20% decrease as another
//effect. I forget and don't have the script in front of me. If they have both 20%
//increase and 20% decrease, just better to remove altogether anyway. I didn't
//make the effect supernatural, so dispel magic would remove it, and I was just too
//lazy to properly remove the effect if I didn't.


//That's pretty much it. Some of the things I've noticed:
// 1) Helmet VFX's show up on the Horse's head. Rather funny.
// 2) Most VFXs stick out of the side of the player while mounted. Ugly, but is this
//    fixable?
// 3) If the player logs out, crashes, server crashes, the player's horse disappears
//    and they come back with their original Phenotype.
// 4) Horse's stuck behind doors will attack the doors until destroyed to follow PC.
// 5) Horse will attack if attacked, but will not run away, will not assist player.


//Last minute suggestion from zer00: <zer00> and I wondered, maybe there should be a
//horse loyalty factor as well?

//I'll let the real coders worry about that if they want.

//I think that's everything. Any questions, see me in chat or PM me on the forums.

}
