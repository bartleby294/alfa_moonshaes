/*  ================================================================
    Title:        DOA Party Loot Notification
    Author:       Den, Project Lead at Carpe Terra (http://carpeterra.com)
    Version:      2.3
    Features:     + notification when item taken from a corpse or a container
                    (not off ground, no module onAcquire/onUnacquire scripts)
                  + configurable notification type (console message, floaty
                    text or both)
                  + configurable distance from looter for notification
                  + optional DM notification
                  + optional auto-distribute gold among the party when corpse
                    or container opened
                  + optional concealed looting where PC with pickpocket skill
                    can attempt to conceal looting by dragging items directly
                    from chests/corpses into their Hidden Pocket (contest
                    between PC pickpocket vs. party members' spot skills)
                    - item encumbrance (function of size and weight) impacts
                      difficulty of concealed looting
                    - concealed looting receives bonuses if looter is in
                      stealth mode or party members in combat
                    - spotting concealed looting can be relayed only to the
                      spotter or to the entire party
                    - optional custom icon (hak pak) for Hidden Pocket
                  + automatically plug-ins to Scrotok's Lootable Corpses 3.2+
                    and gold-related settings used in other DOA loot scripts
                  + includes library for base item functions (authors of
                    these functions: Party Loot Notification by InterSlayer,
                    GetArmorType by Eyrdan)

    Usage:        1. Place gbl_mod_load in the onModuleLoad event
                  2. Place doa_lootnotify in the onDisturbed of containers.
                  3. If enabling auto-distribute gold, place doa_lootnotify_o
                     in the onUsed of containers.
                  4. The Hidden Pocket is a custom item under Special 1
                     which you can give to your PCs through an NPC if you
                     wish. It is strongly recommended that you only allow a
                     PC to have one Hidden Pocket at a time (not tested).
                  5. If you would like to use the custom icon for the Hidden
                     Pocket, copy HiddenPocketIcon.hak into your HAK folder
                     and choose the file under advanced module options. Then
                     import HiddenPocketIcon.erf into your module.
                  *  Additional questions may be answered in the FAQ found at
                     http://carpeterra.com/

    Packaged:     [required base scripts] gbl_mod_load, doa_lootnotify, _cfg_lootnotify, inc_lootnotify, lib_baseitem
                  [items for concealed looting] doa_hiddenpocket
                  [additional autogold scripts] doa_lootnotify_o, inc_givewtgold

    History:      1.0 initial release
                  2.0 - added hidden pocket, eliminating the need for
                        stealth looting
                      - item size penalty made exponential to keep with
                        pocket theme
                  2.1 - corrected spelling mistake on doa_lootnotify file
                      - added option to auto-split gold among party members
                      - added encumberance function to lib_baseitem which
                        reflects the weight *and* size of the item
                      - item size penalty now uses encumberance
                      - attempting to put too large of an item into Hidden
                        Pocket will destroy Pocket and cause contents to be
                        dropped to ground
                      - failing the difficulty check versus the item results
                        in item dropped to ground (plus notification)
                  2.2 - new setting for auto-distribute gold only to party
                        members in same area as looter
                      - added DM notification
                      - added plug-in support for Scrotok's Lootable Corpses 3.2+
                  2.3 - added CopyObject instead of CreateObject by resref
                      - updated baseitem types to SoU/Hou compatibility
                      - encumbrance uses actual item weight (weight increase/
                        decrease properites)
    ================================================================ */
void cfg_LootNotify() {
/*  Set to 0 to disable party notification, 1 for console message to party
    members, 2 for floaty text over looter, 3 for both. */

NotifyType =         1;

/*  Meters from looting party member to receive console message notification.
    NOTE: viewing range of floaty text is 30 meters and cannot be changed */

NotifyDistance =   30.0f;

/*  Set to 0 to disable DM notification, 1 to enable. */

DMNotify =         0;

/*  When rogue drops looted item into hidden pocket, contest between rogue's
    pickpocket skill and party members' spot skill to see if looting noticed.
    The encumberance of the item determines the difficulty of the pick pocket
    attempt (failure results in dropping item and immediate notification) and
    also gives party members' a spot bonus. It will be impossible to use the
    hidden pocket on any item over 12 encumberance without destroying it.
    Party members' will not receive a spot check if dead, sleeping or blind. */

EnableHiddenPocket = TRUE;

/*  If a rogue is in stealth mode, set to 1 for a fixed spot penalty to
    notice the looting (below) or set to 2 for a separate contest (spot vs.
    hide and if successful, spot vs. pickpocket). Note that a rogue should
    not be able to hide in direct line of sight of an intelligent creature,
    but this is not checked against party members. While we believe the spot
    vs. hide contest is not very realistic, it is included for completeness. */

StealthModeType =  1;

/*  Party member spot penalty to notice looting if rogue in stealth mode if
    StealthModeType is set to 1 (above)*/

StealthSpotPenalty =  -4;

/*  Party member spot penalty to notice looting when in-combat */

CombatSpotPenalty =  -4;

/*  Set to 1 for spotter only console message, 2 for spotter only floaty text+
    console message, 3 for relayed to entire party via setting of NotifyType */

SpottedNotifyType =  2;

/*  Taking gold from a chest/corpse will not fire the onDisturbed event
    so one possible work around is to automatically split gold among the
    party when the chest/corpse is first opened. Set to 0 to disable
    auto-distribute gold, 1 to enable auto-distribute gold to everyone in
    party, 2 to auto-distribute gold only to party members in same area as
    looter. */

AutoDistributeGold =  0;

}

