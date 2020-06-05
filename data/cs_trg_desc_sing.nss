///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////            Created By               ///////////////
///////////////     Abaddon, Angel of the Abyss     ///////////////
///////////////       Contactabe via Bioware®       ///////////////
///////////////     Forums and Private Message      ///////////////
///////////////            Utilities:               ///////////////
///////////////            __Abaddon__              ///////////////
///////////////                                     ///////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////     All Scripts and Hakpak's are    ///////////////
///////////////     distibuted as is, with no       ///////////////
///////////////     warranty or responsibility      ///////////////
///////////////     undertaken by the author.       ///////////////
///////////////          Caveat Emptor!             ///////////////
///////////////    This is freeware, You may        ///////////////
///////////////    distribute it in its ORIGINAL    ///////////////
///////////////   form at will, if this script      ///////////////
///////////////  is used in any large projects such ///////////////
/////////////// as a PW or story module, the author ///////////////
/////////////// would like to be informed, merly as ///////////////
///////////////   a curtosey and indicator of both  ///////////////
///////////////    applicability and success :)       ///////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//////////////  Script Name: ab_DescTrig            ///////////////
//////////////  File Name: Descriptive Triggers     ///////////////
//////////////  Author(s): Abaddon                  ///////////////
//////////////             Galap                    ///////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//                  Commentary/Introduction:                     //
//                  -----------------------                      //
//  Fire and forget trigger.  Grabs the name of the trigger
// its attatched to and displays it as floaty text on a PC
// only one time.
// Modified as per Nathraiben's suggestion so that individual tags are no longer
// required on the trigers.
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//////////////         Function Headers             ///////////////
///////////////////////////////////////////////////////////////////

//Fires The name of the trigger at the entering PC*
// uses an int to make only fire once.
// Int is established on the PC
// String Variance == GetTag(of the trigger) + Has Fired
// *There is a GetIsPC check in this function.
void ab_Trig_Description_FireOnceOnly();

void ab_Trig_Description_FireOnceOnly()
{
  object oPC = GetEnteringObject();
  string sDesc = GetName(OBJECT_SELF);
  //Determine that the trigger hasnt fired for this PC before
  if (GetLocalInt(OBJECT_SELF, GetName(oPC) + "Has Fired") < 1)
    {
    //Determine that the PC is a valid object
    if (GetIsObjectValid(oPC))
      {
        //If conditional just to verify that it is a PC not a wandering NPC or something of that nature
        if (GetIsPC(oPC))
        {
        // I like floaty text :)    soo much nicer and more in mood for a player
        FloatingTextStringOnCreature(sDesc, oPC, FALSE);
        //Set the Int so that it will no longer fire for the PC
        SetLocalInt(OBJECT_SELF, GetName(oPC) + "Has Fired", 1);
        }
      }
    }
}
void main()
{
ab_Trig_Description_FireOnceOnly();
}

