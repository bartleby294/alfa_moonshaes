//Created by: Eldernurin
//Date: March 2004
//Type: #include file
//I would prefer that credit be given for this work
//or at least, that no one else takes credit for "slight"
//modifications of it.

//As this is an include file, you must add #include "in_e_repulsion"
//to the header of each script to gain access to the function
//in the right-hand function list.

//This function makes the caller repel a target creature.
//object oTarget= The creature being repelled.
//float fDistance= The distance to repel (10.0 = 10m = 1tile)
//float fTime= The duration of repelling (seconds)
//This may be called by creatures or placeables, though placeables
//may only repel one creature at a time. Creatures may repel several.
//
//The function repels, and only repels the target.
//It assumes the target is not immune to sliding.
//Sliding cannot be resisted. Any extra features must be added
//by the end user (YOU) afterwards, outside of this function.
void ActionRepel(object oTarget, float fDistance, float fTime);

//This internal function of the repelling is not for general use.
location NewLoc(object oTarget, float fDistance);

//the actual code.
void ActionRepel(object oTarget, float fDistance, float fTime)
{
 if(GetLocalInt(oTarget, "SLIDING")==TRUE)
  return;
 float fPause= 0.7; //edit this built-in delay time at your own
 //risk. It controls how muc time passes before the target is
 //frozen and moved.

 //to make sure that two slide orders are not given at once.
 SetLocalInt(oTarget, "SLIDING", TRUE);

 //initial fall-down.
 AssignCommand(oTarget, ClearAllActions());
 AssignCommand(oTarget, PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 90.0, fTime));

 //application of effects to make the slide look better.
 effect eFreeze= EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
 effect eMove= EffectMovementSpeedIncrease(99);

 DelayCommand(fPause, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oTarget, fTime-fPause));
 DelayCommand(fPause, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMove, oTarget, fTime-fPause));

//giving the orders to "run" to the new location.
 location lLoc;
 lLoc= NewLoc(oTarget, fDistance);

 AssignCommand(oTarget, DelayCommand(fPause-0.1, ClearAllActions()));
 AssignCommand(oTarget, DelayCommand(fPause, ActionMoveToLocation(lLoc, TRUE)));

//making sure that the effects wear off.
  AssignCommand(oTarget, DelayCommand(fTime, SetLocalInt(oTarget, "SLIDING", FALSE)));
  AssignCommand(oTarget, DelayCommand(fTime, SetCommandable(TRUE)));
  AssignCommand(oTarget, DelayCommand(fPause, SetCommandable(FALSE)));
}

location NewLoc(object oTarget, float fDistance)
{
 vector v1= GetPosition(oTarget);
 vector v2= GetPosition(OBJECT_SELF);
 vector v3;
 vector v4= v2*-1.0;
 vector vn= v1+v4;
 vn= VectorNormalize(vn);
 vn= vn*fDistance;
 vn= vn+v1;
 int nNth=1;

 object oWp= GetNearestObjectByTag("repel_limit_marker", oTarget, nNth);
 while(GetIsObjectValid(oWp))
 {
 nNth++;
 v3= GetPosition(oWp);
 if(((v3.x<vn.x)&&(v2.x<v3.x))||((v3.x>vn.x)&&(v2.x>v3.x)))
 vn.x=v3.x;
 if(((v3.y<vn.y)&&(v2.y<v3.y))||((v3.y>vn.y)&&(v2.y>v3.y)))
 vn.y=v3.y;
 oWp= GetNearestObjectByTag("repel_limit_marker", oTarget, nNth);
 }

 return Location(GetArea(OBJECT_SELF), vn, GetFacing(OBJECT_SELF));
}
