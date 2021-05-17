void main()
{
    int lastSeen = GetLastPerceptionSeen();
    int lastHeard = GetLastPerceptionHeard();
    object lastPercevied = GetLastPerceived();

    string lastPercDistance = FloatToString(GetDistanceToObject(lastPercevied));

    if(lastPercevied != OBJECT_INVALID) {
        SpeakString("Perceived: " + GetName(lastPercevied)
                    + " at a distance of: " + lastPercDistance);
    } else {
        // This should never happen
        SpeakString("Did not perceive anyone.");
    }

    if(lastSeen == TRUE) {
        SpeakString("Saw: " + GetName(lastPercevied)
                    + " at a distance of: " + lastPercDistance);
    } else {
        SpeakString("Did not see " + GetName(lastPercevied));
    }

    if(lastHeard == TRUE) {
        SpeakString("Heard: " + GetName(lastPercevied)
                    + " at a distance of: " + lastPercDistance);
    } else {
        SpeakString("Did not hear " + GetName(lastPercevied));
    }

}
