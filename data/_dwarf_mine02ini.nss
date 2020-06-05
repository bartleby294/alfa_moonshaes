#include "alfa_include"

void main()
{
    ALFA_OnAreaEnter();

object VarStore1 = GetObjectByTag("Dwarven_Mines02_var_store1");
object oArea = GetArea(VarStore1);

object stool1 = GetObjectByTag("DwarfMineStool01");
object stool2 = GetObjectByTag("DwarfMineStool02");
object stool3 = GetObjectByTag("DwarfMineStool03");
object stool4 = GetObjectByTag("DwarfMineStool04");
object stool5 = GetObjectByTag("DwarfMineStool05");
object stool6 = GetObjectByTag("DwarfMineStool06");
object stool7 = GetObjectByTag("DwarfMineStool07");
object stool8 = GetObjectByTag("DwarfMineStool08");
object stool9 = GetObjectByTag("DwarfMineStool09");
object stool10 = GetObjectByTag("DwarfMineStool10");
object stool11 = GetObjectByTag("DwarfMineStool11");
object stool12 = GetObjectByTag("DwarfMineStool12");

object throneleft = GetObjectByTag("DwarfMines02ThrownLeft");
object throneright = GetObjectByTag("DwarfMines02ThrownRight");

object Rock1 = GetObjectByTag("Mines02RockChair");
object Rock2 = GetObjectByTag("Mines02RockChair2");

object Dwarf1 = GetObjectByTag("DwarfAndOrc01");
object Dwarf2 = GetObjectByTag("DwarfAndOrc02");
object Dwarf3 = GetObjectByTag("DwarfAndOrc03");
object Dwarf4 = GetObjectByTag("DwarfAndOrc04");
object Dwarf5 = GetObjectByTag("DwarfAndOrc05");
object Dwarf6 = GetObjectByTag("DwarfAndOrc06");
object Dwarf7 = GetObjectByTag("DwarfAndOrc07");
object Dwarf8 = GetObjectByTag("DwarfAndOrc08");
object Dwarf9 = GetObjectByTag("DwarfAndOrc09");
object Dwarf10 = GetObjectByTag("DwarfAndOrc10");
object Dwarf11 = GetObjectByTag("DwarfAndOrc11");
object Dwarf12 = GetObjectByTag("DwarfAndOrc12");

object Daughter = GetObjectByTag("Mines02EldersDaughter");
object Fiscal = GetObjectByTag("Mines02FiscalAdvisor");

object Worshiper1 = GetObjectByTag("Mines02Worshiper");
object Worshiper2 = GetObjectByTag("Mines02Worshiper2");

object ArmorBasher1 = GetObjectByTag("Mines02ArmorBasher01");
object ArmorBasher2 = GetObjectByTag("Mines02ArmorBasher02");

object ArmorBashed1 = GetObjectByTag("Mines02BashArmor01");
object ArmorBashed2 = GetObjectByTag("Mines02BashArmor02");

object InnKeep = GetObjectByTag("_mines_02_innkeeper");

    int Val = MusicBackgroundGetNightTrack(oArea);
    int DnO = MusicBackgroundGetDayTrack(oArea);

DelayCommand(0.2,AssignCommand(ArmorBasher1, DoPlaceableObjectAction(ArmorBashed1, PLACEABLE_ACTION_BASH)));
DelayCommand(0.2,AssignCommand(ArmorBasher2, DoPlaceableObjectAction(ArmorBashed2, PLACEABLE_ACTION_BASH)));

    //day = 1 night = 2
    if(GetIsDay())
    {
     SetLocalInt(VarStore1, "WasNightorDay", 1);
    }
    if(GetIsNight())
    {
     SetLocalInt(VarStore1, "WasNightorDay", 2);
    }



    if(GetLocalInt(VarStore1, "FirstEnter") == 0)
    {
        if(GetIsDay())
        {
            MusicBackgroundChangeDay(oArea, Val);
            MusicBackgroundChangeNight(oArea, DnO);
            //0 = false 1 = true
            SetLocalInt(VarStore1, "Siningon", 0);
        }
        AssignCommand(Dwarf1, ActionInteractObject(stool1) );
        AssignCommand(Dwarf2, ActionInteractObject(stool2) );
        AssignCommand(Dwarf3, ActionInteractObject(stool3) );
        AssignCommand(Dwarf4, ActionInteractObject(stool4) );
        AssignCommand(Dwarf5, ActionInteractObject(stool5) );
        AssignCommand(Dwarf6, ActionInteractObject(stool6) );
        AssignCommand(Dwarf7, ActionInteractObject(stool7) );
        AssignCommand(Dwarf8, ActionInteractObject(stool8) );
        AssignCommand(Dwarf9, ActionInteractObject(stool9) );
        AssignCommand(Dwarf10, ActionInteractObject(stool10) );
        AssignCommand(Dwarf11, ActionInteractObject(stool11) );
        AssignCommand(Dwarf12, ActionInteractObject(stool12) );

        AssignCommand(Fiscal, ActionInteractObject(throneright) );
        AssignCommand(Daughter, ActionInteractObject(throneleft));

        AssignCommand(Worshiper1, ActionInteractObject(Rock1));
        AssignCommand(Worshiper2, ActionInteractObject(Rock2));

        SetLocalInt(VarStore1, "DoorLocked", 0);
        SetLocalInt(VarStore1, "FirstEnter", 1);

        SetLocalInt(InnKeep, "one", 0);
        SetLocalInt(InnKeep, "two", 0);
        SetLocalInt(InnKeep, "three", 0);
        SetLocalInt(InnKeep, "four", 0);
    }

}
