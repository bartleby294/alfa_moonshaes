//::///////////////////////////////////////////////
//:: FileName batsconvo2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
int StartingConditional()
{
    // if a wisp already exsits in the area you dont get another.
    object oArea = GetArea(GetPCSpeaker());
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject)) {
         // Destroy any objects tagged
         if(GetTag(oObject) == "moonwellwisp") {
            return FALSE;
         }
         oObject = GetNextObjectInArea(oArea);
    }

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "defiledcavernsbats") == TRUE))
        return FALSE;

    return TRUE;
}
