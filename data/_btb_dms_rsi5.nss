#include "_btb_dms_rsi_con"

void main()
{
    SetLocalInt(GetArea(OBJECT_SELF), EAMON_STATE, CONVERSATION_ENABLED);
    SetLocalInt(GetArea(OBJECT_SELF), ALVINA_STATE, CONVERSATION_ENABLED);
}
