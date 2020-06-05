void main()
{
     AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("WP_From_Hammerstaad_Ship_Rottshe")));
     SendMessageToPC(GetPCSpeaker(), "A number of the crew come ashore with you and quickly disperse to do what ever it is they do.");
}
