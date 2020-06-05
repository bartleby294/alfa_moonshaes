#include "NW_I0_SPELLS"

//////////////////////////////////////////////
// XE-Ryder KoJ's NPC Barmaid OnUserDefined //
//////////////////////////////////////////////
/*  This script has evolved over time and been greatly revised.
    Proper credit goes to David Gaider for the idea and original,
    then we have to credit Adam Miller for working it a bit better.
    This is where I got it and customized it quite a bit further. If
    someone else had a hand in this I am unawares, I pass it to you,
    the reader to enjoy.

    Place this in the OnUserDefined event of your barmaid and I
    suggest slowing her movement down a bit so they'll saunter around
    the tavern instead of power-walking! Set the nRandom number to the
    number of NPC's in the bar. Place a waypoint at the bar
    with tag WP_BAR and a Bartender with tag BARTEND close enough to
    give her the drinks. Place a waypoint where she should rest with
    tag WP_REST and a Cook with tag COOK close enough for her to confide
    in. While on her break you can make her face any way you like by entering
    it, look for the comment below. DIRECTION_WEST is the default.

    Make sure your NPC's have voicesets and they will speak once in awhile.
    Enter the direction to face while resting where indicated below so they
    don't look into a wall while on break. Follow tuning notes and comments
    below to get it working very easily. Don't forget to cut the OnSpawn
    script off the bottom and place in the OnSpawn event! Enjoy! XE :-)  */
void main()
{
int nUser = GetUserDefinedEventNumber();
object oCustomer = GetLocalObject(OBJECT_SELF, "CUSTOMER");

int nRandom = Random(8);    // Set this to the approx number of NPC's in the room
object oBar = GetWaypointByTag("WP_BAR");   // Place this waypoint where she gets drinks from
object oRest = GetWaypointByTag("WP_REST"); // Place this waypoint where she returns to rest
object oCook = GetObjectByTag("COOK");      // Place an NPC Cook in the kitchen with this tag
object oBartend = GetObjectByTag("BARTEND");// Place an NPC Bartender at bar with this tag
object oChair = GetNearestObjectByTag("Chair");
float fDelay;

if (nUser == 1001) // OnHeartbeat event
    {
    if (!GetIsObjectValid(oCustomer) && GetLocalInt(OBJECT_SELF, "BARMAID_STATE") < 1)
        { //Valid customer and state
        oCustomer = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, nRandom);
        if (oCustomer != oCook && oCustomer != oBartend && oCustomer != OBJECT_SELF && GetIsObjectValid(oCustomer))
            { //Customer is not cook, bartend or self & is valid
            SetLocalInt (OBJECT_SELF, "BARMAID_STATE", 1);
            SetLocalObject (OBJECT_SELF, "CUSTOMER", oCustomer);
            ActionMoveToObject(oCustomer);
            switch(Random(4))
                {
                case 0: ActionSpeakString ("Can I get you something?");
                        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_YES,oCustomer)); break;
                case 1: ActionSpeakString ("What would you like?"); break;
                case 2: ActionSpeakString ("How are we doing over here?"); break;
                case 3: ActionSpeakString ("Another round?");
                        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_GOODIDEA,oCustomer)); break;
                }
            ActionWait(5.0); //Wait, then order drinks from bar
            ActionDoCommand (SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 2));
            ActionMoveToObject(oBar);
            switch(Random(4))
                {
                case 0: ActionSpeakString ("I need two ales and a bottle of mead.");
                        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_CANDO,oBartend)); break;
                case 1: ActionSpeakString ("Two whiskeys with a water back please."); break;
                case 2: ActionSpeakString ("They want a pitcher of ale and a loaf of bread");
                        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_CANTDO,oBartend)); break;
                case 3: ActionSpeakString ("A bottle of wine and two glasses then.");
                        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_TASKCOMPLETE,oBartend)); break;
                }
            ActionWait(8.0); //Wait, then deliver the drinks
            ActionDoCommand (SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 3));
            ActionMoveToObject(oCustomer);
            switch(Random(4))
                {
                case 0: ActionSpeakString ("Enjoy this friend."); break;
                case 1: ActionSpeakString ("That'll be 5 platinum. I'm just kidding. 15 electrum, please.");
                        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oCustomer)); break;
                case 2: ActionSpeakString ("You look like you could use this."); break;
                case 3: ActionSpeakString ("Ice brewed in the Frigid North, friend. Enjoy.");
                        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_THANKS,oCustomer)); break;
                }
            ActionWait(3.0); // Wait, then back to bar to take a break
            ActionDoCommand (SetLocalObject(OBJECT_SELF, "CUSTOMER", OBJECT_INVALID));
            ActionMoveToObject(oRest);
            //Enter the direction for her to face while on break or comment line below out!


            ActionWait(5.0);
            switch(Random(4))
                {
                case 0: ActionSpeakString ("Slow night tonight, eh?");
                        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_YES,oBartend)); break;
                case 1: ActionSpeakString ("My feet are killing me."); break;
                case 2: ActionSpeakString ("Well they sure tip well here."); break;
                case 3: ActionSpeakString ("Look at that tender morsel!");
                        ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,OBJECT_SELF)); break;
                }

            ActionWait(15.0);//Wait then reset our variable for next go around
            ActionDoCommand (SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 0));
            }
        }
    }
if (nUser == 1004) // OnDialogue event so you can talk to them.
    {
    SetLocalObject (OBJECT_SELF, "CUSTOMER", OBJECT_INVALID);
    SetLocalInt (OBJECT_SELF, "BARMAID_STATE", 0);
    }
}
