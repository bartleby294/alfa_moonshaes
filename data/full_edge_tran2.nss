//////////////////////////////////////////////////////////////////////////////////////////////
//             ALL-IN-ONE SEAMLESS AREA TRANSITIONER  (for Neverwinter Nights)              //
//  Date:  July 19, 2002  -  Version 1.1                                                    //
//  Created by:  Jaga Te'lesin <jaga-nwn@earthlink.net>                                     //
//                                                                                          //
//  Date:  Oct 22nd, 2002 -  Version 1.2                                                    //
//   Rewrite with lot's of error checking                                                   //
//  Author: MegaPlex <megaplex@reality.net>                                                 //
//  Updated Script: http://www.reality.net/nwn/scripts                                      //
//////////////////////////////////////////////////////////////////////////////////////////////
//                               Copyright Notice                                           //
//  You may use this script for personal use however you like.                              //
//  But if you redistribute you *must*  leave all comments intact.                          //
//////////////////////////////////////////////////////////////////////////////////////////////
//                               For detailed instructions:                                 //
//  Please see the readme file that comes with .zip distribution of this script.            //
//  It contains detailed installation and configuration instructions.                       //
//  This script and the accompanying demo module can be found at:                           //
//     http://home.earthlink.net/~johncboat/AreaTrans.zip                                   //
//////////////////////////////////////////////////////////////////////////////////////////////

void   TransportEffect     ( object oTarget , float fDuration );
string GetNumberPadding    ( int nNumber );

void main()
{ /// Begin User-Defined Variables ///
    float fMaxAreaDim = 160.0f;     // 10.0 per tile in one dimension.  (Areas under 3x3 not recommended)
                                    // Example: 16x16 areas would use 160.0f, 8x8 areas would use 80.0f, etc.

                                    //    NOTE:  Linked areas _MUST_ be square only!

    float fLandingOffset = 4.0f;    // Distance out from edge in destination Area that PC will land (8 to 10 recommended)
    float fDiagTransSize = 4.0f;    // Distance out from any corner to sense diagonal movement (8 to 15 recommended)
    float fTransitionDelay = 4.0f;  // Delay before zoning, used to prevent cheating by PC's (2.0 to 4.0 recommended)
    int nDEBUG = FALSE;             // Turns on feedback while zoning.  Use for problem solving only, normal state is FALSE.
  /// End User-Defined Variables   ///

    // Determines the PC through a series of checks.
    object oPC = GetEnteringObject();
    if (oPC == OBJECT_INVALID)
        oPC = GetClickingObject();
    if (oPC == OBJECT_INVALID)
        oPC = GetLastUsedBy();
    if (oPC == OBJECT_INVALID)
    {
        string sDebug = "ERROR: oPC Object was invalid from area: "+GetTag(GetArea(OBJECT_SELF));
        WriteTimestampedLogEntry(sDebug);
        SendMessageToAllDMs(sDebug);
        return;
    }

    if (GetLocalInt(oPC,"m_nZoning") != TRUE)
    {
        if (GetLocalInt(GetLocalObject(oPC, "SpawnedBy"),"DontZone") == 1)  return;

        if (nDEBUG) SendMessageToPC(oPC, "Entered full edge trans");

        AssignCommand(oPC, ClearAllActions());

        location lLoc    = GetLocation(oPC);               // PC's current location
        object oArea     = GetAreaFromLocation(lLoc);      // PC's current Area
        vector vPCVector = GetPositionFromLocation(lLoc);  // PC's current Vector
        float fPCFacing  = GetFacingFromLocation(lLoc);    // Direction PC is facing
        float vPCx = vPCVector.x;
        float vPCy = vPCVector.y;
        float vPCz = vPCVector.z;

        //PrintString(GetTag(oArea));
        //location lNew = Location(oArea, vPos, fPCFacing);
        //vPos.x = 10.0f;
        //vPos.y = 10.0f;
        //fFacing = 90.0f;

        // Do some error checking to make sure we are within bounds
        if (vPCVector.x >= fMaxAreaDim)
            vPCx = (fMaxAreaDim - 2.0f);
        if (vPCVector.x < 1.0f)
            vPCx = 1.0f;
        if (vPCVector.y >= fMaxAreaDim)
            vPCy = (fMaxAreaDim - 2.0f);
        if (vPCVector.y < 1.0f)
            vPCy = 1.0f;

        float fNorthDist = fMaxAreaDim - vPCy;               // Distance from North edge
        float fSouthDist = vPCy;                             // Distance from South edge
        float fEastDist = fMaxAreaDim - vPCx;                // Distance from East edge
        float fWestDist = vPCx;                              // Distance from West edge
        float fLeast = fMaxAreaDim;                                 // Initialize smallest found dist from any edge
        object newArea;                                             // Destination area
        location newLoc;                                            // Placeholder location for general use
        int nNumber;                                                // Placeholder number for general use
        int nSuccess = FALSE;                                       // Good zone located flag
        int nDir;                                                   // Direction: N=1,S=2,E=3,W=4
        effect eZoneEffect3 = EffectVisualEffect(VFX_IMP_ACID_L);   // ZoneIn effect for end-of-transition

        // Loop through distances to find direction PC is moving, and set nDir to that direction
        // We start off assuming the PC is at the NORTH edge and work from there...
        nDir = 1;      // PC at NORTH edge
        fLeast = fNorthDist;
        if (fSouthDist <= fLeast)
        {
            nDir = 2;  // PC at SOUTH edge
            fLeast = fSouthDist;
        }
        if (fEastDist <= fLeast)
        {
            nDir = 3;  // PC at EAST edge
            fLeast = fEastDist;
        }
        if (fWestDist <= fLeast)
        {
            nDir = 4;  // PC at WEST edge
            fLeast = fWestDist;
        }

        string sTargetTag, sDestAreaX, sDestAreaY, sDir;
        int nCurAreaX, nCurAreaY;
        string sCurAreaTag  = GetStringLowerCase(GetTag(oArea));          // X,Y,Z Tag of Current Area
        string sXYTag       = GetStringLeft(sCurAreaTag,6);               // Separate out X/Y from Z coordinate
        string sCurAreaX    = GetStringLeft(sXYTag,3);                    // X-coordinate of current area (from Tag)
        string sCurAreaY    = GetStringRight(sXYTag,3);                   // Y-coordinate of current area (from Tag)
        string sCurAreaZ    = GetStringRight(sCurAreaTag,3);              // Z-coordinate of current area (from Tag)

        if (GetStringLeft(sCurAreaX,1) == "p")
        {
            nCurAreaX = StringToInt(GetStringRight(sCurAreaX,2));
            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Current Area X coordinate is " + GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX)) + ".");
        }
        else if (GetStringLeft(sCurAreaX,1) == "n")
        {
            nCurAreaX = (StringToInt(GetStringRight(sCurAreaX,2)) * (-1));
            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Current Area X coordinate is " + GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX)) + ".");
        }

        if (GetStringLeft(sCurAreaY,1) == "p")
        {
            nCurAreaY = StringToInt(GetStringRight(sCurAreaY,2));
            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Current Area Y coordinate is " + GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY)) + ".");
        }
        else if (GetStringLeft(sCurAreaY,1) == "n")
        {
            nCurAreaY = (StringToInt(GetStringRight(sCurAreaY,2)) * (-1));
            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Current Area Y coordinate is " + GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY)) + ".");
        }

        // Calculate new Area Tag based on the direction they are moving, and move them
        switch (nDir)
        {
            case 1:     // Moving NORTH
            {
                sDir = "North";
                nNumber = nCurAreaY + 1;
                sDestAreaY = GetNumberPadding(nNumber) + IntToString(abs(nNumber));
                sTargetTag = sCurAreaX + sDestAreaY + sCurAreaZ;
                newArea = GetObjectByTag(sTargetTag);
                if (newArea != OBJECT_INVALID)
                    newLoc = Location(newArea,Vector(vPCx,fLandingOffset,vPCz),fPCFacing);
                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Moving North:" + "\nDestination Area X TAG is " + sCurAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + "." + "\nDestination Area Z TAG is " + sCurAreaZ);
                break;
            }
            case 2:  // Moving SOUTH
            {
                sDir = "South";
                nNumber = nCurAreaY - 1;
                sDestAreaY = GetNumberPadding(nNumber) + IntToString(abs(nNumber));
                sTargetTag = sCurAreaX + sDestAreaY + sCurAreaZ;
                newArea = GetObjectByTag(sTargetTag);
                if (newArea != OBJECT_INVALID)
                    newLoc = Location(newArea,Vector(vPCx,fMaxAreaDim - fLandingOffset,vPCz),fPCFacing);
                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Moving South:" + "\nDestination Area X TAG is " + sCurAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + "." + "\nDestination Area Z TAG is " + sCurAreaZ);
                break;
            }
            case 3:  // Moving EAST
            {
                sDir = "East";
                nNumber = nCurAreaX + 1;
                sDestAreaX = GetNumberPadding(nNumber) + IntToString(abs(nNumber));
                sTargetTag = sDestAreaX + sCurAreaY + sCurAreaZ;
                newArea = GetObjectByTag(sTargetTag);
                if (newArea != OBJECT_INVALID)
                    newLoc = Location(newArea,Vector(fLandingOffset,vPCy,vPCz),fPCFacing);
                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Moving East:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sCurAreaY + "." + "\nDestination Area Z TAG is " + sCurAreaZ);
                break;
            }
            case 4:  // Moving WEST
            {
                sDir = "West";
                nNumber = nCurAreaX - 1;
                sDestAreaX = GetNumberPadding(nNumber) + IntToString(abs(nNumber));
                sTargetTag = sDestAreaX + sCurAreaY + sCurAreaZ;
                newArea = GetObjectByTag(sTargetTag);
                if (newArea != OBJECT_INVALID)
                    newLoc = Location(newArea,Vector(fMaxAreaDim - fLandingOffset,vPCy,vPCz),fPCFacing);
                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Moving West:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sCurAreaY + "." + "\nDestination Area Z TAG is " + sCurAreaZ);
                break;
            }
        }

        // If the new area is invalid, log messages and return
        if (newArea == OBJECT_INVALID)
        {
            if (nDEBUG && GetIsPC(oPC)) SendMessageToPC(oPC,"Movement to an invalid area attempted.  Area was not found with specified TAG.");
            string sDebug = "ERROR: AT Error newArea INVALID: Name:"+GetName(oPC)+" Vector: vPCx("+FloatToString(vPCx,4,0)+") vPCy("+FloatToString(vPCy,4,0)+") vPCz("+FloatToString(vPCz,4,0)+") new Target "+sTargetTag+" from oArea TAG "+GetTag(oArea)+"\n";
            WriteTimestampedLogEntry(sDebug);
            SendMessageToAllDMs(sDebug);
            return;
        }
        // If the target TAG is not correct, log messages and return
        if (GetTag(newArea) != sTargetTag)
        {
            string sDebug = "ERROR: AT Tag Mismatch: Vector: vPCx("+FloatToString(vPCx,4,0)+") vPCy("+FloatToString(vPCy,4,0)+") vPCz("+FloatToString(vPCz,4,0)+") new Target "+sTargetTag+" newArea TAG "+GetTag(newArea)+" from oArea TAG "+GetTag(oArea)+"\n";
            WriteTimestampedLogEntry(sDebug);
            SendMessageToAllDMs(sDebug);
            return;
        }
        // if the newArea is the same as the old one, don't do anything
        if (newArea == oArea)
        {
            string sDebug = "ERROR: newArea == oArea : Vector: vPCx("+FloatToString(vPCx,4,0)+") vPCy("+FloatToString(vPCy,4,0)+") vPCz("+FloatToString(vPCz,4,0)+") new Target "+sTargetTag+" oArea TAG "+GetTag(oArea)+"\n";
            WriteTimestampedLogEntry(sDebug);
            SendMessageToAllDMs(sDebug);
            return;
        }

        // we have the new location, so send them there
        if (GetIsDM(oPC)) { AssignCommand(oPC,JumpToLocation(newLoc)); return; }
        SetLocalInt(oPC,"m_nZoning",TRUE);
        TransportEffect(oPC,fTransitionDelay);
        if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving "+sDir,oPC,FALSE);
        AssignCommand(oPC, ClearAllActions());
        //DelayCommand(fTransitionDelay,AssignCommand(oPC,JumpToLocation(newLoc)));
        AssignCommand(oPC,JumpToLocation(newLoc));
        DelayCommand(fTransitionDelay,SetLocalInt(oPC,"m_nZoning",FALSE));
       // DelayCommand(fTransitionDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eZoneEffect3,newLoc));
    }
    else
    {
        if (nDEBUG) WriteTimestampedLogEntry("ERROR: area_trans: "+GetName(oPC)+" already in transit");

    }
    if (nDEBUG) WriteTimestampedLogEntry("ERROR: area_trans for "+GetTag(OBJECT_SELF)+" did nothing");
}

void TransportEffect (object oTarget, float fDuration)
{
    effect eZoneEffect1 = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eZoneEffect2 = EffectVisualEffect(VFX_IMP_ACID_L);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eZoneEffect1,oTarget,(fDuration*2.0f));
    //ApplyEffectToObject(DURATION_TYPE_INSTANT,eZoneEffect2,oTarget);
}

string GetNumberPadding ( int nNumber )
{
    if      ((nNumber >=  0) && (nNumber <=  9))  return "p0";
    else if ((nNumber >= 10) && (nNumber <= 99))  return "p";
    else if ((nNumber >=  -9) && (nNumber <=  -1))  return "n0";
    else if ((nNumber >= -99) && (nNumber <= -10))  return "n";
    else return "";
}

