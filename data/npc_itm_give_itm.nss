/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
        Starting Conditions for giving the Item.
        Gives Item and Sets Plot Flag, Cursed and ID'ed
        created by: Forsettii
        created for: Layonara Online
        website:  www.layonaraonline.com
        August 09, 2004
   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
#include "custom_tokens"
void main()
{
    object oPC = GetPCSpeaker();
    string sItem_2_Sell = GetLocalString(OBJECT_SELF, "item_2_sell");
    object oItem_2_Sell = GetObjectByTag(sItem_2_Sell);

    int iItem_Cost = GetLocalInt(OBJECT_SELF, "item_cost");

    TakeGoldFromCreature(iItem_Cost, oPC, TRUE);
    SetItemCursedFlag(CreateItemOnObject(sItem_2_Sell, oPC, 1), 1);
    SetIdentified( oItem_2_Sell, TRUE);
    SetPlotFlag( oItem_2_Sell, TRUE);
}
