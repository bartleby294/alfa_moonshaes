void CheckInConvo(object oUser)
{
    if (!IsInConversation(oUser))
    {
        DestroyObject(GetLocalObject(oUser, "oKit"));
    }
}

void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    if (GetTag(oItem) == "eln_note")
    {
        AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_READ));
        string sMessage = GetLocalString(oItem, "sMessage");
        string sSend;
        int iPos;
        SendMessageToPC(oUser, "The message reads: ");
        SendMessageToPC(oUser, "--------------------------------");
        SendMessageToPC(oUser, sMessage);
        SendMessageToPC(oUser, "--------------------------------");
    }
    if (GetTag(oItem) == "eln_quill")
    {
        object oPaper = GetItemPossessedBy(oUser, "eln_paper");
        if (oPaper != OBJECT_INVALID)
        {
            object oScribingKit = CreateObject(OBJECT_TYPE_CREATURE, "eln_scribingkit", GetLocation(oUser), FALSE);
            SetLocalObject(oScribingKit, "oSpawner", oUser);
            SetLocalObject(oUser, "oKit", oScribingKit);
            // Animation and delay added to give the listener time to spawn:
            // Not needed anymore, since there is a check now, but still a nice effect :)
            AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_READ));
            DelayCommand(2.5f, AssignCommand(oUser, ActionStartConversation(oUser, "eln_scribingkit", TRUE)));
            DelayCommand(7.5f, CheckInConvo(oUser));
        }
        else
        {
            SendMessageToPC(oUser, "You need paper to write on!");
        }
    }
}
