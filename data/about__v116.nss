/*******************************************************************************

                      -- New Features in Version 1.16 --

*** OnPlayerEquipItem & OnPlayerUnequipItem

These are two new features that came with patch 1.60+
Add these scripts to Module Properties:

OnPlayerEquipItem   = alfa_onplayequip
OnPlayerUnequipItem = alfa_onplayunequ

*** Global Weather System
A Global Weather System has been implemented fully with the ACR.
You can turn this on/off in the file alfa_options.
Set the gALFA_USE_GLOBAL_WEATHER to TRUE to activate it.

An invisible object has been added to the Quarantine Area.
             *** This must NOT be removed. ***
A copy of it is under Placeables/Custom/Special/Custom 5 and called 60.
If it is not in the module already, place this anywhere in the module.

Also included are four Waypoints:
alfa_cl_wea_only  <- Place this in area where you want Clear Weather only
alfa_rn_wea_only  <- Place this in area where you want Rainy Weather only
alfa_st_wea_only  <- Place this in area where you want Stormy Weather only
alfa_snow_area    <- Place this in area where you want Winter Weather

*** Global Skies System
A Global Skies System has been implemented fully with the ACR.
You can turn this on/off in the file alfa_options.
Set the gALFA_USE_GLOBAL_SKIES to TRUE to activate it.

You cannot have Skies activated without Weather activated also.

A new option has been added to the Emote Ball, so that the player can turn
the Skies on or off for herself, though only if the Skies are activated.

Note: Each area how has a fixed fog range. It's default is 45 meters,
and the Skies appears at 100. So you can "turn off" the Skies in certain
areas, by just setting the fog range to lower than 100.

*** Dynamic Quivers
Dynamic Quivers has now been added to the ACR. When a player equips arrows
in the arrow slot, an animation will start to run and display a quiver.

*** HotU Prestige Classes
Has been added to the list and banned for now

*** HotU Constants
There are also several new constants that came with HotU. These are:

MODULE_SWITCH_ENABLE_UMD_SCROLLS -
               Set to TRUE, a Rogue must now roll an UMD check
MODULE_SWITCH_AOE_HURT_NEUTRAL_NPCS -
               Set to TRUE, AOE spells will also affect Neutral NPCs
MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS -
               Set to TRUE, NPCs using WalkWaypoints can cross areas
MODULE_SWITCH_ENABLE_INVISIBLE_GLYPH_OF_WARDING -
               Set to TRUE, the Glyphs will turn invisible 6 seconds after they are created
MODULE_SWITCH_ENABLE_CRAFT_WAND_50_CHARGES -
               Set to TRUE, the wands will always have 50 charges, instead of random
               (This one should always be set to FALSE)
MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS -
               Set to TRUE, the Item Creation Feats are turned off
MODULE_VAR_AI_STOP_EXPERTISE_ABUSE -
               Set to TRUE, it stops the abuse of the Expertise Feat with casting spells.
MODULE_SWITCH_SPELL_CORERULES_DMASTERTOUCH -
               Set to TRUE, the DeathMaster Touch ability will not work on too large creatures

*** Spell changes
Continual Flame is changed to a Temporary Effect lasting 1 hour/level.
This was done to get it off the banned list, and to stop the danger of
abuse with ItemCreation Feats.

Light has also been changed to reflect the changes to Continual Flame.

Infestation of Maggots and Monstrous Regeneration has been changed
because of balancing reasons.

*******************************************************************************/

void main() {}
