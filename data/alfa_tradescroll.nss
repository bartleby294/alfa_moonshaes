#include "x2_inc_craft"
#include "x2_inc_switches"
//these are the item tags and resref of your spellbook and tradescroll items
//TRADE_SCROLL_COST is per spell level
const int TRADE_SCROLL_COST = 25;
//resref for the spellbook item
const string spellbook_resref = "alfa_spellbook";
//resref for tradescrolls
const string tradescroll_resref="alfa_tradescroll";
//tag for an item you mark as a trade scroll in the toolset
const string tradescroll_tag="alfa_tradescroll";

//this function activates the Trade Scroll system
//Make sure you check for a true return value and end the spellhook
int DoTradeScrollSpellHook();
//this function gets the spell level of a spell
int TS_GetSpellLevel(int nSpellID);

int DoTradeScrollSpellHook()
{
    int nCost = 0;
    int nReturn = FALSE;
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    object oItem = GetSpellCastItem();
    //if an ability booster spell is cast, then trigger our version of the spell

    if (GetResRef(oItem) == tradescroll_resref || (FindSubString(GetTag(oItem), tradescroll_tag) != -1)) {
        SendMessageToPC(OBJECT_SELF, "You cannot cast spells through trade scrolls as they are not imbued with magic.");
        SetModuleOverrideSpellScriptFinished();
        return TRUE;
    }

    if (GetResRef(oTarget) == spellbook_resref) {
        if (GetLevelByClass(CLASS_TYPE_WIZARD) > 0 || GetIsDM(OBJECT_SELF)) {
            int nPropID = IPGetIPConstCastSpellFromSpellID(nSpell);
            if (nPropID == -1) {
                SendMessageToPC(OBJECT_SELF, "For some reason you can't copy this spell. Possibly a bug! Ask!");
            }
            else {
                if (GetGold() >= nCost || GetIsDM(OBJECT_SELF)) {
                    nCost = TS_GetSpellLevel(nSpell) * TRADE_SCROLL_COST;
                    object oScroll = CreateItemOnObject(tradescroll_resref, OBJECT_SELF);
                    IPRemoveAllItemProperties(oScroll, DURATION_TYPE_PERMANENT);
                    itemproperty iProp = ItemPropertyCastSpell(nPropID, IP_CONST_CASTSPELL_NUMUSES_SINGLE_USE);
                    AddItemProperty(DURATION_TYPE_PERMANENT, iProp, oScroll);
                    SendMessageToPC(OBJECT_SELF, "You have created a trading copy.");
                    TakeGoldFromCreature(nCost, OBJECT_SELF, TRUE);
                }
                else
                    SendMessageToPC(OBJECT_SELF, "You don't have enough gold to make a copy!");
            }
        }
        else {
                SendMessageToPC(OBJECT_SELF, "That sure is a spellbook but you don't know how to copy spells!");
        }
        SetModuleOverrideSpellScriptFinished();
        nReturn = TRUE;
    }
    return nReturn;
}
int TS_GetSpellLevel(int nSpellID)
{
    int nRet = StringToInt(Get2DAString(X2_CI_CRAFTING_SP_2DA, "Level", nSpellID));

    return nRet;
}
