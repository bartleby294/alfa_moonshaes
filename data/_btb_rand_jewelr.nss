// NOTE TAGS FOR ALL JEWLERY ARE UPPER CASED!!!

//////////JEWLERY//////////
string getRandomJewelry() {

    /*AMULET*/
    switch (Random(6)) {
        case(0):
            // Copper Necklace
            return "nw_it_mneck020";
        case(1):
            // Gold Necklace
            return "nw_it_mneck022";
        case(2):
            //Silver Necklace
            return "nw_it_mneck021";

            /*RINGS*/
        case(3):
            // Copper Ring
            return "nw_it_mring021";
        case(4):
            // Gold Ring
            return "nw_it_mring023";
        case(5):
            // Silver Ring
            return "nw_it_mring022";
    }

    return "";
}
