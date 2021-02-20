/************************ [On Percieve] ****************************************
    Filename: j_ai_onpercieve or nw_c2_default2
************************* [On Percieve] ****************************************
    If the target is an enemy, attack
    Will determine combat round on that person, is an enemy, basically.
    Includes shouting for a big radius - if the spawn in condition is set to this.

    NOTE: Debug strings in this file will be uncommented for speed by default.
          - It is one of the most intensive scripts as it runs so often.
          - Attempted to optimise as much as possible.
************************* [History] ********************************************
    1.3 - We include j_inc_other_ai to initiate combat (or go into combat again)
                - j_inc_other_ai holds all other needed functions/integers ETC.
        - Turn off hide things.
        - Added "Only attack if attacked"
        - Removed special conversation things. Almost no one uses them, and the taunt system is easier.
        - Should now search around if they move to a dead body, and only once they get there.
************************* [Workings] *******************************************
    It fires:

    - When a creature enters it perception range (Set in creature properties) and
      is seen or heard.
    - When a creature uses invisiblity/leaves the area in the creatures perception
      range
    - When a creature appears suddenly, already in the perception range (not
      the other way round, normally)
    - When a creature moves out of the creatures perception range, and therefore
      becomes unseen.
************************* [Arguments] ******************************************
    Arguments: GetLastPerceived, GetLastPerceptionSeen, GetLastPerceptionHeard,
               GetLastPerceptionVanished, GetLastPerceptionInaudible.
************************* [On Percieve] ***************************************/

void main()
{

 int i = GetLocalInt(OBJECT_SELF, "walking");
 if (i == 1)
 {

 }
}
