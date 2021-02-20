string GetText(object oPC) {

    int heardItBefore = GetLocalInt(oPC, "olTom");

    if(heardItBefore > 0 && d20(1) < 18) {
        return "";
    }

    SetLocalInt(oPC, "olTom", TRUE);

    switch(d4(1)) {
        case 1:
            return "eh.. EH... yew there.. *hiccups* AH WANNA TALK TA YOO..";
        case 2:
            return "*hawks and spits, swigs drink* eh.. yoo... am TALKIN to ya.. come 'ERE";
        case 3:
            return "eh... YOU... COME 'ERE..! *sways drunkenly, swigs from bottle*";
        case 4:
            return "eh.. yoo... I WANNA TALK TA YOO.. *belches loudly, swigs from bottle*";
     }

    return "";
}

void main()
{
    object oPC = GetEnteringObject();

    if(!GetIsPC(oPC)) {
        return;
    }

    string opening = GetText(oPC);
    if(opening != "") {
        AssignCommand(GetNearestObjectByTag("OlTom"), SpeakString(opening));
    }
}
