void main()
{

    object phenoCreature = GetLastUsedBy();

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
