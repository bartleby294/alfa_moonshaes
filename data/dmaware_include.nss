// DMAWARE: A library of utilities for making scripts
// that interract with the DM.
// Author: Jeffrey P. Kesselman
// Copyright Feb 1, 2003, All Rights Reserved
// Grant of Rights:
// This code is freely redestrubtable in part or
// whole so long as attribution and copyright notice are
// are preserved.

#include "wwds_include"

// events
int DMAWARE_DM_ACK = 601;
int DMAWARE_DM_NAK  = 602;
// strings
string ATTENTION_REQUEST_QUEUE = "DMA_requestQueue";
string PENDING_REQUEST_FLAG = "DMA_requestingDM";
string DM_COUNTER = "DMA_DMCounter";
string DM_RESPONDED = "DMA_responded";

//prototypes

void DMAware_Callback(object oNpc);
void DMAware_SendNAK(object oNpc);
void DMAware_SendACK(object oNpc);


// functions

// These functions track the number of DM's online
// They must be inserted into the module's onentry and
// onexit.

void DMAware_OnClientEnter(){
  object mod = GetModule();
//  SendMessageToAllDMs("SOmeone entering");
  if (GetIsDM(GetEnteringObject()))
  {
//    SendMessageToAllDMs("Its a DM.");
    int dmcount  =  GetLocalInt(mod,DM_COUNTER);
    dmcount = dmcount+1;
    SetLocalInt(mod,DM_COUNTER,dmcount);
  }
}

void DMAware_OnClientLeave() {
  object mod = GetModule();
  if (GetIsDM(GetExitingObject()))
  {
    int dmcount  =  GetLocalInt(mod,DM_COUNTER);
    dmcount = dmcount-1;
    SetLocalInt(mod,DM_COUNTER,dmcount);
  }
}


void DMAware_RequestDM(object oNpc, string message,
     float waitSecs, int waitAnyway=FALSE)
{
    // store the actions
    object mod = GetModule();
    if ((!waitAnyway)&&
        (GetLocalInt(mod,DM_COUNTER)==0)){
        // no DMs present
        DMAware_SendNAK(oNpc);
        return;
    }
    // log us as waiting
    SetLocalInt(oNpc,PENDING_REQUEST_FLAG,TRUE);
    SetLocalInt(oNpc,DM_RESPONDED,FALSE);
    WWDS_enqueueObject(mod,ATTENTION_REQUEST_QUEUE,oNpc);
    SendMessageToAllDMs("DM Attention Request: "+message);
    DelayCommand(waitSecs,DMAware_Callback(oNpc));
}

void DMAware_Callback(object oNpc){
    object mod = GetModule();
    SetLocalInt(oNpc,PENDING_REQUEST_FLAG,FALSE);
    int dmcount = GetLocalInt(mod,DM_COUNTER);
    if ((dmcount>0)&&
        (GetLocalInt(oNpc, DM_RESPONDED)==TRUE)){
        DMAware_SendACK(oNpc);
    } else {
        DMAware_SendNAK(oNpc);
    }
}


void DMAware_SendACK(object oNpc){
    //SpeakString("ACKing");
    SignalEvent(oNpc,EventUserDefined(DMAWARE_DM_ACK));
}

void DMAware_SendNAK(object oNpc) {
    //SpeakString("NAKing");
    SignalEvent(oNpc,EventUserDefined(DMAWARE_DM_NAK));
}

void DMAware_DMResponse(object DMobj){
    object mod = GetModule();
    while (!WWDS_queueEmpty(mod,ATTENTION_REQUEST_QUEUE)){
        object obj = WWDS_dequeueFirstObject(mod,
            ATTENTION_REQUEST_QUEUE);
        if (GetLocalInt(obj,PENDING_REQUEST_FLAG)) {
            SendMessageToAllDMs("Got object"+
                GetName(obj));
            // still valid so process it
            SetLocalInt(obj,DM_RESPONDED,TRUE);
            location loc = GetLocation(obj);
            AssignCommand(DMobj, JumpToLocation(loc));
        }
    }
}
