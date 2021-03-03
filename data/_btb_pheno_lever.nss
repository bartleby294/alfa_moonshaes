void main()
{
    int i = 1;
    object phenoCreature = GetNearestObjectByTag("phenotype", OBJECT_SELF, i);
    while(phenoCreature != OBJECT_INVALID
          && GetObjectType(phenoCreature) != OBJECT_TYPE_CREATURE) {
        i++;
        phenoCreature = GetNearestObjectByTag("phenotype", OBJECT_SELF, i);
    }

    int pheno = GetPhenoType(phenoCreature);
    if(GetTag(OBJECT_SELF) == "pheno_up") {
        pheno++;
    } else {
        pheno--;
    }

    if(pheno > 25 || pheno < 0) {
        pheno = 0;
    }

    SetPhenoType(pheno, phenoCreature);
    SpeakString("Phenotype Set To: " + IntToString(pheno));
}
