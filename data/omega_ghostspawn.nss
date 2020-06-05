void main()
{

SetListening( OBJECT_SELF, TRUE);
SetListenPattern( OBJECT_SELF, "**",101);


ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectUltravision(), OBJECT_SELF, 99999.9);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(), OBJECT_SELF, 99999.9);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectInvisibility(INVISIBILITY_TYPE_IMPROVED), OBJECT_SELF, 99999.9);
                                                 }
