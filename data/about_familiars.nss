/*
ALFA Familiars V3 by U'lias

Changes
=================

- Replace familiar's default hide/skin with a new HD equivalent hide/skin (with
- increasly better properties) to be equiped on the newly summoned familiar at 
- the HD stages of 1, 5, 10 , 15, 20.
- The hide/skin properties of Regeneration, Damage Reduction, and Spell 
- Resistance have been ommitted in all replacement familiar hide/skins under 
- HD 10. These properties are gradually added appropriate to the familiar at 
- high HD. At the time of summoning their familiar the Wiz/Sor caster are 
- granted a single special ability according to the familiar's type. If the 
- Wiz/Sor does not have a familiar then this granted special ability will fade
- away within 60 seconds.
- Added Xp penalty from death of familiar (Xp Penalty = 200 * nClassLevels)
- prevent Wiz/Sor overall total Xp from being less than 1
- Wiz/Sor suffers full Xp penalty for failing saving throw
- Wiz/Sor suffers half Xp penalty for succeeding saving throw
- apply temporary knockdown effect to mimic shock of failing Fort saving throw
- due to familiar dying
- altered Familiar conversation "NW_G_FAM" so that it is no longer possible to
- Feed/Scold and Heal the familiar to its maximum hit points, instead Feeding 
- the familiar will make it happier and like you better (same as all the other 
- options that give the familiar more attention)

Granted Special Abilities by Familiar Type
----------------------------------------
Bat
Master gains a +2 bonus to Listen checks 

Panther
Master gains a +2 bonus to Move Silently checks

Fire Mephit
Master gains a +2 bonus to Fortitude Saving Throws vs. Fire

Hellhound
Master gains a +2 bonus to Search checks

Ice Mephit
Master gains a +2 bonus to Fortitude Saving Throws vs. Cold

Imp
Master gains a +2 bonus to Persuade checks

Pixie
Master gains a +2 bonus to Taunt checks 

Raven
Master gains a +2 bonus to Appraise checks 

Faerie Dragon
Master gains a +2 bonus to Spellcraft checks 

Pseudodragon
Master gains a +2 bonus to Hide checks

Hide Properties
-------------------

The properties listed for each HD of the familiar is cummulative (ie. the new 
property is in addition to or an improvement on the properties it has already 
been assigned at its previous HD stages). Please note that Damage Reduction +1 
(Soak 5 Damage) is only present on some of the flying familiars; consider this
property as compensation for how fast the familiar flies and how hard it is 
to hit them at HD 20.

Bat Hide Properties

HD 1	- Alertness, Improved Evasion, Immunity to Mind-Affecting Spells 
HD 5	- Freedom of Movement
HD 10	- Spell Resistance (10)
HD 15	- Spell Resistance (16), Regeneration (+1)
HD 20	- Spell Resistance (20), Damage Reduction +1 (Soak 5 Damage)

Panther Hide Properties

HD 1	- Alertness, Improved Evasion, Immunity to Fear
HD 5	- Dodge
HD 10	- Spell Resistance (10)
HD 15	- Spell Resistance (12), Regeneration (+ 1)
HD 20	- Spell Resistance (14), Regeneration (+2), Knockdown

Fire Mephit Hide Properties

HD 1	- Alertness, Damage Vulnerability Cold (50% Damage Vulnerability), 
        Immunity Damage Type Fire (100% Immunity), Immunity to Mind-Affecting 
        Spells 
HD 5	- Dodge
HD 10	- Spell Resistance (10)
HD 15	- Spell Resistance (14), Regeneration (+1)
HD 20	- Spell Resistance (20), Immunity to Spell (Planar Binding)

Hellhound Hide Properties

HD 1	- Alertness, Damage Vulnerability Cold (50% Damage Vulnerability), 
        Immunity Damage Type Fire (100% Immunity), Immunity to Mind-Affecting 
        Spells 
HD 5	- Dodge
HD 10	- Spell Resistance (10)
HD 15	- Spell Resistance (12), Regeneration (+1)
HD 20	- Spell Resistance (14), Regeneration (+2), Cleave

Ice Mephit Hide Properties

HD 1	- Alertness, Damage Vulnerability Fire (50% Damage Vulnerability), 
        Immunity Damage Type Cold (100% Immunity), Immunity to Mind-Affecting 
        Spells 
HD 5	- Dodge
HD 10	- Spell Resistance (10)
HD 15	- Spell Resistance (14), Regeneration (+1)
HD 20	- Spell Resistance (20), Immunity to Spell (Planar Binding)

Imp Hide Properties

HD 1	- Alertness, Damage Resistance Fire (Resist 20/-), Immunity to Poison, 
        Immunity to Mind-Affecting Spells
HD 5	- Freedom of Movement
HD 10	- Spell Resistance (10)
HD 15	- Spell Resistance (16), Regeneration (+1)
HD 20	- Spell Resistance (20), Damage Reduction +1 (Soak 5 Damage)

Pixie Hide Properties

HD 1	- Alertness, Improved Evasion, Immunity to Mind-Affecting Spells
HD 5	- Freedom of Movement
HD 10	- Spell Resistance (10)
HD 15	- Spell Resistance (16), True Seeing
HD 20	- Spell Resistance (20), Regeneration (+1)

Raven Hide Properties

HD 1	- Alertness, Improved Evasion, Immunity to Mind-Affecting Spells 
HD 5	- Dodge
HD 10	- Spell Resistance (10)
HD 15	- Spell Resistance (14), Regeneration (+1) 
HD 20	- Spell Resistance (18), Damage Reduction +1 (Soak 5 Damage)

Faerie Dragon Hide Properties (it_fm_faerie0)

HD 1	- Alertness, Improved Evasion, Immunity to Paralysis
HD 5	- Freedom of Movement
HD 10	- Spell Resistance (10)
HD 15	- Spell Resistance (16), Improved Invisibility
HD 20	- Spell Resistance (20), Regeneration (+1)

Pseudodragon Hide Properties (it_fm_pseudo0)

HD 1	- Alertness, Improved Evasion, Immunity to Paralysis, 
        Skill Bonus: Hide [+4]
HD 5	- True Seeing
HD 10	- Spell Resistance (10)
HD 15	- Spell Resistance (16), Regeneration (+1)
HD 20	- Spell Resistance (20), Damage Reduction +1 (Soak 5 Damage)

*/

void main(){}
