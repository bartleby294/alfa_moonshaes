void main()
{
string Spoken;

SetListenPattern( OBJECT_SELF, "**", 1 );
object oDM = GetLastSpeaker();
object oMyTarget = GetLocalObject(oDM, "OMWandTarget");
if (!GetIsDM(oDM)) return;

int i = 0; int max = GetMatchedSubstringsCount();
for( ; i < max; ++i )
Spoken += GetMatchedSubstring( i );
SetLocalString( oDM, "dietyvar", Spoken );
SetDeity( oMyTarget, Spoken );
ActionWait(1.0);
string sNewDToken = GetDeity(oMyTarget);
SetCustomToken(6901,sNewDToken);
}
