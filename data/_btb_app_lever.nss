void main()
{
    int i = 1;
    object phenoCreature = GetNearestObjectByTag("phenotype", OBJECT_SELF, i);
    while(phenoCreature != OBJECT_INVALID
          && GetObjectType(phenoCreature) != OBJECT_TYPE_CREATURE) {
        i++;
        phenoCreature = GetNearestObjectByTag("phenotype", OBJECT_SELF, i);
    }

    int pheno = GetAppearanceType(phenoCreature);
    if(GetTag(OBJECT_SELF) == "app_up") {
        pheno++;
    } else {
        pheno--;
    }

    if(pheno > 500 || pheno < 482) {
        pheno = 482;
    }

    SetCreatureAppearanceType(phenoCreature, pheno);
    SpeakString("App Set To: " + IntToString(pheno));
}
