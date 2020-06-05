

void main()
{


 object oPC = GetLastUsedBy();
 object VarStorage = GetObjectByTag("VarStore");

if(GetLocalInt(VarStorage, "TableState") == 0)
{
 SetLocalInt(VarStorage, "TableState", 4);
 SetLocalInt(VarStorage, "TurnState", 0);
 SetLocalInt(VarStorage, "DrinksOffTable",10);
}

if(GetLocalInt(VarStorage, "TableState") == 1)
{
 //AssignCommand(oPC, ActionSpeakString("Games already going on") );
}

if(GetLocalInt(VarStorage, "TableState") == 2)
{
 //AssignCommand(oPC, ActionSpeakString("Table Ready to set up again") );
 SetLocalInt(VarStorage, "TableState", 4);
 SetLocalInt(VarStorage, "DrinksOffTable",10);
}

 if(GetLocalInt(VarStorage, "TableState") == 3)
 {
   //AssignCommand(oPC, ActionSpeakString("Need to clear the table off first") );
 }

 if(GetLocalInt(VarStorage, "TableState") == 4)
 {
   //AssignCommand(oPC, ActionSpeakString("Go ahead and set the table up what are you waiting for") );
 }

}
