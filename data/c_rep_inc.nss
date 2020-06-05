const int nDebugReputation = FALSE;

const string INVALID_FACTION = "Invalid Faction";
const string DB_REPUTATION = "db_reputation";

/**********************************************************************
 * FUNCTION PROTOTYPES
 **********************************************************************/
void DebugReputation(string sString, object oTarget, object oSource);

// Return the first NPC from the faction reputation area that matches oString
object GetFactionNPC(string oString);

// Return the Area that holds the NPCs for each Faction.
object ReputationArea();

// Initialize faction reputation to base
void InitializeReputation(object oTarget);

// Return the tag for the matching reputation.
string FactionEqual(object oFactionMember);

//  Adjustments to the PCs Reputation.
//  This should replace all standard AdjustReputation Functions.
void CAdjustReputation(object oTarget, object oSourceFactionMember, int nAdjustment);

//  Adjustments to the PCs Reputation in the database only. Does not adjust reputation.
//  Used for onattack, onkill to adjust DB value without changing the reputation already
//  changed by the engine.
void CAdjustReputationDB(object oTarget, object oSourceFactionMember, int nAdjustment);
//  Load Reputation on Client Enter.
//  Set the reputation when the local variable for each Faction is FALSE
//  caused by a server rest.
//  The local variable for each Faction is set to TRUE when loaded.
void ReputationLoad(object oTarget);

/**********************************************************************
 * FUNCTION DEFINITIONS
 **********************************************************************/

void Debug(object oPC, string sMessage)
{

    SendMessageToPC(oPC, sMessage);
    SendMessageToAllDMs(sMessage);
    PrintString(sMessage);
}

void DebugReputation(string sString, object oTarget, object oSource)
{
Debug(oTarget,sString+"GetCampaignInt for faction " + FactionEqual(oSource) +
" = " + IntToString(GetCampaignInt(DB_REPUTATION, FactionEqual(oSource), oTarget)));

Debug(oTarget,"GetReputation() = " + IntToString(GetReputation(oSource, oTarget)));
}


// Return the first NPC from the faction reputation area that matches oString
object GetFactionNPC(string oString)
{
    object oArea = ReputationArea();
    object oSourceFactionMember = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oSourceFactionMember))
    {
        if (GetObjectType(oSourceFactionMember) == OBJECT_TYPE_CREATURE)
        {
           if (TestStringAgainstPattern(
                GetStringLowerCase("**"+oString+"**"),
                GetStringLowerCase(FactionEqual(oSourceFactionMember))))
              return oSourceFactionMember;
        }
        oSourceFactionMember = GetNextObjectInArea(oArea);
    }
    WriteTimestampedLogEntry("DEBUG: c_rep_inc: Invalid faction in GetFactionNPC: " + oString);
    return OBJECT_INVALID;
}

object ReputationArea()
{
    // Get the Area that stores all the NPC Factions.
    object oWaypoint = GetWaypointByTag("WP_Factions");
    object oArea = GetArea(oWaypoint);
    if (!GetIsObjectValid(oArea))
        WriteTimestampedLogEntry("DEBUG: c_rep_inc: Unable to set Factions!");
    return oArea;
}

string FactionEqual(object oFactionMember)
{
    object oArea = ReputationArea();
    object oSourceFactionMember = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oSourceFactionMember))
    {
        if (GetObjectType(oSourceFactionMember) == OBJECT_TYPE_CREATURE)
        {
            if (GetFactionEqual(oFactionMember, oSourceFactionMember))
            {
                return GetTag(oSourceFactionMember);
            }
        }
        oSourceFactionMember = GetNextObjectInArea(oArea);
    }
    return INVALID_FACTION;
}

void CAdjustReputation(object oTarget, object oSourceFactionMember, int nAdjustment)
{
    // Do not process for DMs
    if (GetIsDM(oTarget))
        return;

    object oPartyMember = GetFirstFactionMember(oTarget, TRUE);
    while (GetIsObjectValid(oPartyMember))
    {
        // Debug statements
        if (nDebugReputation)
            DebugReputation("Mem Before:", oPartyMember, oSourceFactionMember);

        // Change in memory
        if (GetPlotFlag(oSourceFactionMember))
        {
            SetPlotFlag(oSourceFactionMember, FALSE);
            AdjustReputation(oPartyMember, oSourceFactionMember, nAdjustment);
            SetPlotFlag(oSourceFactionMember, TRUE);
        }
        else
        {
            AdjustReputation(oPartyMember, oSourceFactionMember, nAdjustment);
        }

        // Find the corresponding faction for the source faction member.
        string sSourceFaction = FactionEqual(oSourceFactionMember);
        if (sSourceFaction != INVALID_FACTION)
        {
            // Get old reputation value
            int nCurrentReputation = GetCampaignInt(DB_REPUTATION, sSourceFaction, oPartyMember);
            // Adjust reputation
            int nNewReputation = nCurrentReputation + nAdjustment;
            if (nNewReputation < 0) nNewReputation=0;
            if (nNewReputation > 100) nNewReputation=100;

            // Write back new reputation value
            SetCampaignInt(DB_REPUTATION, sSourceFaction, nNewReputation, oPartyMember);
// Debug statements
if (nDebugReputation)
DebugReputation("Mem After:", oPartyMember, oSourceFactionMember);
        }
        oPartyMember = GetNextFactionMember(oTarget, TRUE);
    }
}

void CAdjustReputationDB(object oTarget, object oSourceFactionMember, int nAdjustment)
{
    // Do not process for DMs
    if (GetIsDM(oTarget))
        return;

    object oPartyMember = GetFirstFactionMember(oTarget, TRUE);
    while (GetIsObjectValid(oPartyMember))
    {
        // Find the corresponding faction for the source faction member.
        string sSourceFaction = FactionEqual(oSourceFactionMember);
        if (sSourceFaction != INVALID_FACTION)
        {
            // Debug statements
            if (nDebugReputation)
            DebugReputation("DB Before:", oPartyMember, oSourceFactionMember);

            // Get old reputation value
            int nCurrentReputation = GetCampaignInt(DB_REPUTATION, sSourceFaction, oPartyMember);
            // Adjust reputation
            int nNewReputation = nCurrentReputation + nAdjustment;
            if (nNewReputation < 0) nNewReputation=0;
            if (nNewReputation > 100) nNewReputation=100;
            // Write back new reputation value
            SetCampaignInt(DB_REPUTATION, sSourceFaction, nNewReputation, oPartyMember);
            // Debug statements
            if (nDebugReputation)
            DebugReputation("DB After:", oPartyMember, oSourceFactionMember);
        }
        oPartyMember = GetNextFactionMember(oTarget, TRUE);
    }
}

void ReputationLoad(object oTarget)
{
    // Do not process for DMs
    if (GetIsDM(oTarget))
        return;

    object oArea = ReputationArea();
    int nReputation;

    object oSourceFactionMember = GetFirstObjectInArea(oArea);
    // Loop through all Faction NPCs
    while (GetIsObjectValid(oSourceFactionMember))
    {   // Must be a creature
        if (GetObjectType(oSourceFactionMember) == OBJECT_TYPE_CREATURE)
        {
            // Ensure adjustment to reputation is requiped
            if (!GetLocalInt(oTarget, GetTag(oSourceFactionMember)))
            {
                // Get reputation from persistant storage
                nReputation = GetCampaignInt(DB_REPUTATION, GetTag(oSourceFactionMember), oTarget);
                if (GetPlotFlag(oSourceFactionMember))
                {
                    SetPlotFlag(oSourceFactionMember, FALSE);
                    // Set reputation to 0
                    AdjustReputation(oTarget, oSourceFactionMember, -100);
                    // Set reputation to reputation
                    AdjustReputation(oTarget, oSourceFactionMember, nReputation);
                    SetPlotFlag(oSourceFactionMember, TRUE);
                }
                else
                {
                    // Set reputation to 0
                    AdjustReputation(oTarget, oSourceFactionMember, -100);
                    // Set reputation to reputation
                    AdjustReputation(oTarget, oSourceFactionMember, nReputation);
                }
                // Set adjustment loaded.
                SetLocalInt(oTarget, GetTag(oSourceFactionMember), TRUE);
            }
        }
        oSourceFactionMember = GetNextObjectInArea(oArea);
    }
if (nDebugReputation)
Debug(oTarget, "Loaded persistant reputation values for player "+GetName(oTarget));
}

// Since base reputation for customer factions now are 0,
// we will manually set it for new players on the server.
void InitializeReputation(object oTarget)
{
   AdjustReputation(oTarget, GetFactionNPC("fac_bf_druids"), -100);
   AdjustReputation(oTarget, GetFactionNPC("fac_bf_elves"), -100);
   AdjustReputation(oTarget, GetFactionNPC("fac_blood_crow"), -100);
   AdjustReputation(oTarget, GetFactionNPC("fac_forharnians"),-100);
   AdjustReputation(oTarget, GetFactionNPC("fac_harpers"),-100);
   AdjustReputation(oTarget, GetFactionNPC("fac_melvauntian"),-100);
   AdjustReputation(oTarget, GetFactionNPC("fac_ondonti"), -100);
   AdjustReputation(oTarget, GetFactionNPC("fac_ride_bandits"), -100);
   AdjustReputation(oTarget, GetFactionNPC("fac_thentians"), -100);
   AdjustReputation(oTarget, GetFactionNPC("fac_wh_thieves"),-100);
   AdjustReputation(oTarget, GetFactionNPC("fac_white_tiger"),-100);
   AdjustReputation(oTarget, GetFactionNPC("fac_whitehornians"),-100);
   AdjustReputation(oTarget, GetFactionNPC("fac_wp_miners"), -100);
   AdjustReputation(oTarget, GetFactionNPC("fac_zhentarim"), -100);
   AdjustReputation(oTarget, GetFactionNPC("fac_thelvinian"), -100);

   CAdjustReputation(oTarget, GetFactionNPC("fac_bf_druids"), 25);
   CAdjustReputation(oTarget, GetFactionNPC("fac_bf_elves"), 0);
   CAdjustReputation(oTarget, GetFactionNPC("fac_blood_crow"), 10);
   CAdjustReputation(oTarget, GetFactionNPC("fac_forharnians"),20);
   CAdjustReputation(oTarget, GetFactionNPC("fac_harpers"),30);
   CAdjustReputation(oTarget, GetFactionNPC("fac_melvauntian"),50);
   CAdjustReputation(oTarget, GetFactionNPC("fac_ondonti"), 50);
   CAdjustReputation(oTarget, GetFactionNPC("fac_ride_bandits"), 8);
   CAdjustReputation(oTarget, GetFactionNPC("fac_thentians"), 50);
   CAdjustReputation(oTarget, GetFactionNPC("fac_wh_thieves"),30);
   CAdjustReputation(oTarget, GetFactionNPC("fac_white_tiger"),30);
   CAdjustReputation(oTarget, GetFactionNPC("fac_whitehornians"),50);
   CAdjustReputation(oTarget, GetFactionNPC("fac_wp_miners"), 50);
   CAdjustReputation(oTarget, GetFactionNPC("fac_zhentarim"), 30);
   CAdjustReputation(oTarget, GetFactionNPC("fac_thelvinian"), 50);

   SetCampaignInt("db_players_entered","has_played",1,oTarget);
if (nDebugReputation)
Debug(oTarget,"Initialized reputation values to default for player "+GetName(oTarget));
}
