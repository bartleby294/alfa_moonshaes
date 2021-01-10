///////ARMOR///////
string getRandomBaseArmor() {
    switch (Random(18)) {
        // Clothing
        case 0:
            return "nw_cloth022";
            /*HEAVY ARMOR*/
            // Full Plate
        case 1:
            return "nw_aarcl007";
            // Half Plate
        case 2:
            return "nw_aarcl006";
            // Splint Mail
        case 3:
            return "nw_aarcl005";

            /*HEAD*/
            // Helmet
        case 4:
            return "050_helm";
            // Hood
        case 5:
            return "043_hoodblue_01";

            /*LIGHT ARMOR*/
            // Chain Shirt
        case 6:
            return "nw_aarcl012";
            // Leather Armor
        case 7:
            return "nw_aarcl001";
            // Padded Armor
        case 8:
            return "nw_aarcl009";
            // Studded Leather
        case 9:
            return "nw_aarcl002";

            /*MEDIUM ARMOR*/
            // Breast Plate
        case 10:
            return "nw_aarcl010";
            // Chainmail
        case 11:
            return "nw_aarcl004";
            // Hide Armor
        case 12:
            return "nw_aarcl008";
            // Scale Mail
        case 13:
            return "nw_aarcl003";

            /*SHEILDS*/
            // Heavy Sheild
        case 14:
            return "it_iwoodshldl001";
            // Large Sheild
        case 15:
            return "nw_ashlw001";
            // Small Sheild
        case 16:
            return "nw_ashsw001";
            // Tower Sheilld
        case 17:
            return "nw_ashto001";
    }
    // Clothing
    return "nw_cloth022";
}
