void main()
{

// Variable and Object Initialization
int randpatron = d10();
object oPatron = GetObjectByTag("cw_cd_patron", randpatron);
object oBartender = GetObjectByTag("cd_Zach");
object oBar = GetWaypointByTag("cw_cd_bar");

//Get random drink order and price.

//Move to Patron, talk, and do action
ActionMoveToObject(oPatron, FALSE, 2.0);
ActionWait(2.5);

//Move to Bar, give order
ActionMoveToObject(oBar, FALSE, 1.0);
ActionWait(7.5);

//Move back to Patron, get money
ActionMoveToObject(oPatron, FALSE, 2.0);
ActionWait(2.0);
ActionWait(1.5);

}


