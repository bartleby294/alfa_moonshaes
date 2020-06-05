void main()
{
  if(GetIsDM(GetItemActivator()))
    ExecuteScript("csu_area_trans", GetItemActivator());
  else
    SendMessageToPC(GetItemActivator(), "You are not allowed to use this item, and are not supposed to have it.");

}
