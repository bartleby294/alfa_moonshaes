//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_set1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "iElsworthquest", 1);

    // Give the speaker the items
    CreateItemOnObject("elsworthsletter", GetPCSpeaker(), 1);

}