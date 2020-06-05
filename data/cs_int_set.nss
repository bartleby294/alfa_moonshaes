///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//////////////////////////TEMPLATE/////////////////////////////////
///////////////////////DO NOT MODIFY///////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

// This script sets a persistent variable on every member of a party.
// Define the name of your variable in "nVariable" and save this script as:
// "cs_int_set_var1", where var1 is the first 3 letters of your variable name, and 1,
// the number of the variable you are setting
// This script would typically go in the Actions Taken of a conversation


#include "sos_include"
void main()

{

   object oFirstMember = GetPCSpeaker();
   object oPC = GetFirstFactionMember(oFirstMember, TRUE); // declare oPC to be the first member of the party

// cycle through party and set flag

    while (GetIsObjectValid(oPC) == TRUE)
       {

    SOS_SetPersistentInt(oPC, "nVariable", 1); //Set Variable name and Value here

    oPC = GetNextFactionMember(oPC,TRUE);

       }
}

