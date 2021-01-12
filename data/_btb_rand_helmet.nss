///////Helmet///////
string getRandomBaseHelmet() {
    switch (Random(2)) {
        /*HEAD*/
        // Helmet
        case 0:
            return "050_helm";
            // Hood
        case 1:
            return "043_hoodblue_01";

    }
    // Clothing
    return "050_helm";
}
