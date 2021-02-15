#include "nwnx_object"

void main()
{
     SpeakString("Serialized String Length: " + IntToString(GetStringLength(NWNX_Object_Serialize(OBJECT_SELF))));
}
