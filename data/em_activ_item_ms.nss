void main()
{
  object oPC = GetItemActivator();
  object oTarget = GetItemActivatedTarget();

  SetLocalObject(oPC, "EmoteItemTarget", oTarget);

  //Make the activator start a conversation with itself
  AssignCommand(oPC, ActionStartConversation(oPC, "emote_ms", TRUE));
}

