/******************************************************************
 * Name: alfa_spellhook
 * Type: ALFA Spellhook Functions
 * ---
 * Author: Ariak
 * Date: 12/12/04
 * ---
 * Contains code for controlling coming spell events
 *
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/

#include "x2_inc_switches"
#include "alfa_spelltrack"
#include "alfa_tradescroll"
#include "alfa_spells_inc"
#include "alfa_ioun_inc"

void main()
{
    if(!GetCommandable()) {
        SetModuleOverrideSpellScriptFinished();
        return;
    }

    object oTarget =  GetSpellTargetObject();

    //Get which spell has been cast, and track it.
    TrackSpellCast(GetSpellId(), OBJECT_SELF);

    //Check the Ioun Stone systems
    if (GetLocalInt(oTarget, "s767") == 1 || GetLocalInt(oTarget, "s768") == 1)
      AsorbSpell(oTarget);
    if (GetTag(oTarget) == "alfa_ioun_s763")
      StoreSpell(oTarget);
    if (GetLocalInt(oTarget, "SPELL_CANC"))
      SetModuleOverrideSpellScriptFinished();
    DeleteLocalInt(oTarget, "SPELL_CANC");


    //Check if the spell is cast at the spellbook or from a tradescroll.
    if (DoTradeScrollSpellHook())
    {
        return;
    }
    else
    {
        //Cast the spell normaly
        ALFA_Spellhook();
    }
}

