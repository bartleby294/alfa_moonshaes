/*******************************************************************************

                      -- New Features in Version 1.17 --

*** Dynamic Quivers
Dynamic Quivers has now been removed from the ACR, due to many unfixable bugs.
It has instead been added as a 'used item' like our packpack system.
- NOTE: It is still an armor piece that you swap and not a VFX like the Backpack.

*** Loot destroyed on too high level - Trigger added
The constant gALFA_DESTROY_LOOT_ON_HIGH_EL has been added to control this. Set
to TRUE to turn this effect on.

*** Weapon Breakage - Trigger added
The constant gALFA_WEAPON_BREAKAGE has been added to control this. Set
to TRUE to turn this effect on.

*** Familiar Persistency system added.
The trigger const int PFP_PERMANENT_DEATH controls the system for getting it
back if it dies. Default is 1.

- A familiar can now be summoned and unsummoned as much as you like.
- You still loose XP if it dies.
- The familiar spells and spell like abilities are now persistently kept, and
  reset when resting.

*** Persistent Time
The clock can now be saved persistently by setting gALFA_PERSISTENT_TIME to TRUE
What it does is to every two minutes store the current server time, and on Module
Load, set the time to the stored value.

*** DM Only Area
DM Only Area change from tileset Sewers to tileset Castle Interior.

*** ALFA QUARANTINE
ALFA Quarantine changed from tileset MicroSet to tileset ALFA Exterior.

*** ALFA OnCutSceneAbort
alfa_oncutscene script has been added, so that all Events in the Module Properties
now should have a script in them.

*** Trade Scroll System
A Trade Scroll System has been added. Any wizard can now cast their spell into a
spellbook item, which create a TradeScroll with that spell. This scroll cannot be
cast as a normal spell, but can be memorized. Cost is 25 gold per level.
- NOTE: The Tradescrolls are a game mechanics items, so don't spawn that item
        A wizard starts with a Spellbook, but you can spawn this on other wizards
          also if you like, through RP.

*** No Stack System
Effects and events that should not stack will now not stack.

*** Temp Effects on Items
Temperary effects on items are now removed on Log In. This to fix a bug that
sometimes made temp. effects remain indefinitely.

*** Spell Changes
Light now last 1 hour per level
Continual flame set to last 24 hours when cast (12 hours when cast on items)

*** Placement of blueprint
Many blueprints have changed which folder they are placed in, taking advantage
of the expanded items and creture trees.

*** DOA Loot Notify
Add doa_lootnotify script to the OnDisturbed for all containers.

*** HAKS
Much content have been moved to the Haks, for clean up

*******************************************************************************/

void main() {}
