/*** Secret Passage - Launch Conversation
    - for Item OnUse
    By: Ulias (Shawn Marcil)     Last Modified: September 22, 2004

    Description
    ---------------
    Opens a conversation associated with the specific placeable
    object.

    Requirements
    ---------------
    The placeable object (ie. bookshelf) that the current conversation
    belongs to must have _PK#### (ie. _PK0001) in its tag.

    Create a conversation named spassage_pk#### (ie. spassage_PK0001) so
    that the #### matches the corresponding placeable object's "_PK" flag number.

    Note: PK stands for Placeable (object) Key
**/

void main()
{
    object oPC = GetLastUsedBy();
    string sPlaceableTag = GetTag(OBJECT_SELF);
    // find "_PK" flag
    int nPKPosition = FindSubString(sPlaceableTag, "_PK");
    // get the value associated with the "_PK" flag
    string sConversation = "spassage_" + GetSubString(sPlaceableTag, (nPKPosition + 1), 6);
    // open conversation pk####
    ActionStartConversation(oPC, GetStringLowerCase(sConversation), TRUE, FALSE);
}
