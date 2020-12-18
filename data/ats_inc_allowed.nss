/////////////////////////////////////////////////////
// ATS_GetIsAllowed                                //
//      Returns whether or not aplayer is allowed  //
//      access to Private things such as DM Tools. //
//      You may change this function to allow      //
//      more people.                               //
// Returns: boolean - TRUE if player is allowed    //
//                    FALSE if not allowed         //
/////////////////////////////////////////////////////
int ATS_GetIsAllowed(object oPlayer)
{
    return GetIsDM(oPlayer);
}
