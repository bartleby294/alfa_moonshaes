#include "x2_inc_switches"

void main()
{
// Sets the rogue UMD to also make checks when using scrolls
SetModuleSwitch (MODULE_SWITCH_ENABLE_UMD_SCROLLS, TRUE);

//Set to TRUE, AOE spells will also affect Neutral NPCs
SetModuleSwitch (MODULE_SWITCH_AOE_HURT_NEUTRAL_NPCS, TRUE);

//Set to TRUE, NPCs using WalkWaypoints can cross areas
SetModuleSwitch (MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS, TRUE);

//Set to TRUE, the Glyphs will turn invisible 6 seconds after they are created
SetModuleSwitch (MODULE_SWITCH_ENABLE_INVISIBLE_GLYPH_OF_WARDING, TRUE);

//Set to TRUE, the wands will always have 50 charges, instead of random
SetModuleSwitch (MODULE_SWITCH_ENABLE_CRAFT_WAND_50_CHARGES, FALSE);

//Set to TRUE, the Item Creation Feats are turned off
SetModuleSwitch (MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS, TRUE);

//Set to TRUE, the DeathMaster Touch ability will not work on too large creatures
//At the moment we do not use Prestige Classes, so it does not matter.
SetModuleSwitch (MODULE_SWITCH_SPELL_CORERULES_DMASTERTOUCH, TRUE);

//Set to TRUE, it stops the abuse of the Expertise Feat with casting spells.
SetModuleSwitch (MODULE_VAR_AI_STOP_EXPERTISE_ABUSE, TRUE);

//Set to TRUE, to activate tagbased script functions
SetModuleSwitch (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, TRUE);

}
