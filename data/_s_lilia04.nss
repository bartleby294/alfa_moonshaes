void main()
{
    object Lilia =OBJECT_SELF;
      int anotherRandNum = d4(1);

                if( anotherRandNum == 1)
                {
                    AssignCommand(Lilia, SpeakString("Whats the matter you scurvy curs dont like the sun?"));
                }
                if( anotherRandNum == 2)
                {
                    AssignCommand(Lilia, SpeakString("I never get tired of this!"));
                }
                if( anotherRandNum == 3)
                {
                    AssignCommand(Lilia, SpeakString("Bet youll think twice next time ehy? ... If you get a next time"));
                }
                if( anotherRandNum == 4)
                {
                    AssignCommand(Lilia, SpeakString("*Cackles coldly*"));
                }
                return;
}
