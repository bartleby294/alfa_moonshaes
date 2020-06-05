//  Use this script in a conversation fil used by Merchants
//  The TAG of the store should be "Store_NPCname"
//  Eg. The NPC Bob runs a tavern
//  The tavern store has a tag: Store_Bob
//  Put this script on Actions Taken and your store will open

#include "nw_i0_plot"

void main()
{
    string theMerchantTag = "Store_" + GetTag( OBJECT_SELF );
    object theStore = GetNearestObjectByTag( theMerchantTag );

    if ( GetIsObjectValid( theStore ) == TRUE )
    {
        object thePC = GetPCSpeaker();
        gplotAppraiseOpenStore( theStore, thePC, 0, 0 );
    }
    else
    {
        string theError ="ERROR: Unable to find Merchant. Tag=" + theMerchantTag;
        SpeakString( theError );
        WriteTimestampedLogEntry( theError );
    }
}
