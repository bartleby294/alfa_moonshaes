//  Override NWN Core AI behavior
// with a pre-event
// similar to hardcore wrappers around functions
// USE THE NW_FLAG_* constants here from NW_I0_GENERIC
// for the nCondition args
// UDOV stands for User Defined OVerride
//


string sl_master = "slUDOv";


void SetUDOvCondition(int nCondition, int bValid = TRUE, object me = OBJECT_SELF)
{
    int nPlot = GetLocalInt(me, sl_master);
    if(bValid)
    {
        nPlot = nPlot | nCondition;
        SetLocalInt(me, sl_master, nPlot);
    }
    else
    {
        nPlot = nPlot & ~nCondition;
        SetLocalInt(me, sl_master, nPlot);
    }
//    PrintString("Setting "+IntToString(nCondition)+
//                " for "+GetName( me)+" is "+IntToString( nPlot));
}

int GetUDOvCondition(int nCondition, object me = OBJECT_SELF)
{
    int nPlot = GetLocalInt(me, sl_master);
    int retValue = nPlot & nCondition;
//    PrintString("GetUDC for "+IntToString( nCondition)+"&"+IntToString(nPlot)+" computes "+IntToString( retValue));
    return (retValue) != 0;
}

int GetUDOv( object me = OBJECT_SELF)
{
    return GetLocalInt(me, sl_master);
}

void ClearUDOv( object me = OBJECT_SELF)
{
    DeleteLocalInt( me, sl_master);
}

// int preEvent();
