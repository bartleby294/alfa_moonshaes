void DockShip(object oLever, location lGangWP, float fGangWP)
{
  object oGangPlank = CreateObject(OBJECT_TYPE_PLACEABLE, "tcn_citygangplk", lGangWP);
  AssignCommand(oGangPlank, SetFacing(fGangWP));
  object oBlocker = GetNearestObjectByTag("lyplc_nowalk2", oLever, 1);
  object oCapWP = GetNearestObjectByTag("WP_FERRYCAP", oLever, 1);
  location lCap = GetLocation(oCapWP);
  object oCaptain = CreateObject(OBJECT_TYPE_PLACEABLE, "docked_shipcap", lCap);
  SetLocalInt(oLever, "InitialState", 1);
    if (GetIsObjectValid(oBlocker))
    {
    DestroyObject(oBlocker);
    }
}

void OutputWPLocation(object waypoint, string prefix, object oPC) {
    vector WPLocVec = GetPosition(waypoint);
    float WPFacing = GetFacing(waypoint);
    string outputStr = prefix + " x: " + FloatToString(WPLocVec.x)
                              + " y: " + FloatToString(WPLocVec.y)
                              + " z: " + FloatToString(WPLocVec.z)
                              + " facing: " + FloatToString(WPFacing);
    SendMessageToPC(oPC, outputStr);
}

void main()
{
   object oPLC = OBJECT_SELF;
   string sPLCTag = GetTag(oPLC);
   object oArea = GetArea(oPLC);
   object oPC = GetLastUsedBy();

     // Ship Dock Call Lever
     if (sPLCTag == "ship_ferrylever")
     {
     float fArriving = 125.0;
     float fDeparting = 125.0;
     object oCityShip = GetNearestObjectByTag("lyship_sailfdr", OBJECT_SELF, 1);
     object oGangWP = GetNearestObjectByTag("WP_GANGPLANK", OBJECT_SELF, 1);
     location lGangWP = GetLocation(oGangWP);
     float fGangWP = GetFacing(oGangWP);
     object oBlockerWP = GetNearestObjectByTag("WP_PLANKBLOCKER", OBJECT_SELF, 1);
     location lBlockerWP = GetLocation(oBlockerWP);
     float fBlockerWP = GetFacing(oBlockerWP);
     int iAmActivated = GetLocalInt(oPLC, "InitialState");

     OutputWPLocation(oGangWP, "lGangWP - ", oPC);
     OutputWPLocation(oBlockerWP, "oBlockerWP - ", oPC);

       if (iAmActivated == 1) // Activated  - So Deactivate - LEAVE DOCK
       {
       object oGangPlank = GetNearestObjectByTag("tcn_citygangplk", OBJECT_SELF, 1);
       object oShipCenter = GetNearestObjectByTag("WP_7mSPHERE", OBJECT_SELF, 1);
       location lShipLoc = GetLocation(oShipCenter);
       object oBootLoc = GetNearestObjectByTag("WP_BOOTLOC", OBJECT_SELF, 1);
       location lBootLoc = GetLocation(oBootLoc);
       object oCaptain = GetNearestObjectByTag("docked_shipcap", OBJECT_SELF, 1);
       // check who is on ship
       int CreaturesOnDeck = 0;
       object oOnDeck = GetFirstObjectInShape(SHAPE_SPHERE, 7.0, lShipLoc, FALSE, OBJECT_TYPE_CREATURE);
         while (GetIsObjectValid(oOnDeck))
         {
         CreaturesOnDeck++;
         oOnDeck = GetNextObjectInShape(SHAPE_SPHERE, 7.3, lShipLoc, FALSE, OBJECT_TYPE_CREATURE);
         }
         if (CreaturesOnDeck > 0)
         {
         AssignCommand(oCaptain, SpeakString("The ship cannot leave port until the deck is cleared!"));
         // option ... announce the deck will be cleared in XX seconds, wait that specified time, then
         // boot all creatures to location *lBootLoc*
         }
         else
         {
         SendMessageToPC(oPC, "The ferry has started it's departure from the harbor.");
         DestroyObject(oGangPlank);
         DestroyObject(oCaptain);
         object oBlocker = CreateObject(OBJECT_TYPE_PLACEABLE, "lyplc_nowalk2", lBlockerWP);
         AssignCommand(oBlocker, SetFacing(fBlockerWP));
         PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
         AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
         SetLocalInt(oPLC, "InitialState", 2); // departing
         DelayCommand(fDeparting, DeleteLocalInt(oPLC, "InitialState"));
         }
       }
       else if (iAmActivated == 2) // Still Departing (on to off animation still running)
       {
       SendMessageToPC(oPC, "The ferry is still departing the harbor and cannot be called again until it has cleared the outer harbor bouys.");
       }
       else if (iAmActivated == 3) // Arriving (off to on animation still running)
       {
       SendMessageToPC(oPC, "The ferry is already inbound from the outer harbor bouys. It cannot be called again right now.");
       }
       else // Deactivated - So Activate - SHIP AT DOCK
       {
       SendMessageToPC(oPC, "The ferry has been called and has started it's run to the dock.");
       PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
       AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
       SetLocalInt(oPLC, "InitialState", 3); // arriving
       DelayCommand(fArriving, DockShip(oPLC, lGangWP, fGangWP));
       }
     return;
     }
}

