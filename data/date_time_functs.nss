int ParseDateString(string sDateString, string sOption)//option = day, month, year
{
    string sTemp1;
    int iResult, iIndex, iStrLength;
    int iSlash1 = 0;
    int iSlash2 = 0;
    int iSlash3 = 0;
    iStrLength = GetStringLength(sDateString);
    for(iIndex = 0; iIndex <= (iStrLength - 1); iIndex++)//get position of slashes
    {
        sTemp1 = GetSubString(sDateString, iIndex, 1);
        if(sTemp1 == "/")
        {
            if(iSlash1 == 0)
            {
                iSlash1 = iIndex;
            }
            else if (iSlash2 == 0)
            {
                iSlash2 = iIndex;
            }
            else if (iSlash3 == 0)
            {
                iSlash3 = iIndex;
            }
        }
    }
    if(sOption == "month")
    {
        sTemp1 = GetStringLeft(sDateString, iSlash1);
        iResult = StringToInt(sTemp1);
    }
    else if(sOption == "day")
    {
        sTemp1 = GetSubString(sDateString, iSlash1 + 1, iSlash1 - iSlash2 - 1);
        iResult = StringToInt(sTemp1);
    }
    else if(sOption == "year")
    {
        sTemp1 = GetSubString(sDateString, iSlash2 + 1, iSlash2 - iSlash3 - 1);
        iResult = StringToInt(sTemp1);
    }
    else if(sOption == "hour")
    {
        sTemp1 = GetStringRight(sDateString, iSlash3);
        iResult = StringToInt(sTemp1);
    }
    else
        return -1;//invalid option

    return iResult;
}
////////////////////////////////////////////////////////////////////////////////
int TimeSince(string sDate1, string sDate2, string sOption)//option = "hours", "days", "months", "years"
{
    int iTempDay1, iTempMonth1, iTempYear1, iTempHour1, iTempMinute1;
    int iTempDay2, iTempMonth2, iTempYear2, iTempHour2, iTempMinute2;
    int iResult;
    int iYears, iDays, iMonths, iHours;
    int nOption;

    iTempDay1 = ParseDateString(sDate1, "day");
    iTempMonth1 = ParseDateString(sDate1, "month");
    iTempYear1 = ParseDateString(sDate1, "year");
    iTempHour1 = ParseDateString(sDate1, "hour");
    iTempDay2 = ParseDateString(sDate2, "day");
    iTempMonth2 = ParseDateString(sDate2, "month");
    iTempYear2 = ParseDateString(sDate2, "year");
    iTempHour1 = ParseDateString(sDate2, "hour");

    if(sOption == "hours")
        nOption = 1;
    else if(sOption == "days")
        nOption = 2;
    else if(sOption == "months")
        nOption = 3;
    else if(sOption == "years")
        nOption = 4;

    if(iTempYear2 == iTempYear1)//same year
    {
        iYears = 0;
        if(iTempMonth2 == iTempMonth1)//same year and same month
        {
            if(iTempDay2 == iTempDay1)//same year, month & day
            {//figure the hours
                iMonths = 0;
                iDays = iTempDay2 - iTempDay1;
                iHours = iTempHour2 - iTempHour1;
            }
            else
            {//same year & month (get days and hours)
                iMonths = 0;
                iDays = iTempDay2 - iTempDay1;
                iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
            }
        }
        else //same year and different month
        {
            if(iTempDay2 == iTempDay1)//same year, different month, same day
            {
                iMonths = iTempMonth2 - iTempMonth1;
                iDays = iMonths * 28;
                iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
            }
            else //same year, diff month, diff day
            {
                if(iTempDay2 >= iTempDay1)//different month at least one month
                {
                    iMonths = iTempMonth2 - iTempMonth1;
                    iDays = (iTempDay2 - iTempDay1) + (iMonths * 28);
                    iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
                }
                else //different month, at least one month, ending in incomplete month
                {
                    iMonths = (iTempMonth2 - iTempMonth1) - 1;
                    iDays = (28 * iMonths) + (28 - (iTempDay1 - 1)) + (28 - ((28 - iTempDay2) + 1));
                    iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
                }
            }
        }
    }

    if(iTempYear2 > iTempYear1)//not same year
    {
        if(iTempMonth2 == iTempMonth1)//diff year, same month
        {
            if(iTempDay2 == iTempDay1)//diff year, same month, same day
            {
                iYears = iTempYear2 - iTempYear1;
                iMonths = 12 * iYears;
                iDays = 28 * iMonths;
                iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
            }
            else //diff year, same month, diff day
            {
                if(iTempDay2 > iTempDay1)//diff year, same month, at least one year
                {
                    iYears = iTempYear2 - iTempYear1;
                    iMonths = 12 * iYears;
                    iDays = (28 * iMonths) + (iTempDay2 - iTempDay1);
                    iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
                }
                else //diff year, same month, one less year
                {
                    iYears = (iTempYear2 - iTempYear1) -1;
                    iMonths = (12 * iYears) + 11;
                    iDays = (28 * iMonths) + (28 + (iTempDay2 - iTempDay1));
                    iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
                }
            }
        }
        else //diff year, diff month
        {
            if(iTempMonth2 > iTempMonth1)//diff year, diff month, at least one year, extra months
            {
                if(iTempDay2 == iTempDay1)//diff year, diff month, same day
                {
                    iYears = iTempYear2 - iTempYear1;
                    iMonths = (12 * iYears) + (iTempMonth2 - iTempMonth1);
                    iDays = 28 * iMonths;
                    iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
                }
                else //diff year, diff month, diff day
                {
                    if(iTempDay2 > iTempDay1)//diff year, diff month, extra days
                    {
                        iYears = iTempYear2 - iTempYear1;
                        iMonths = (12 * iYears) + (iTempMonth2 - iTempMonth1);
                        iDays = (28 * iMonths) + (iTempDay2 - iTempDay1);
                        iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
                    }
                    else //diff year, diff month, fewer days
                    {
                        iYears = iTempYear2 - iTempYear1;
                        iMonths = (12 * iYears) + (iTempMonth2 - iTempMonth1);
                        iDays =(28 * iMonths) + (28 + (iTempDay2 - iTempDay1));
                        iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
                    }
                }
            }
            else //diff year, diff month, one year less (fewer months)
            {
                if(iTempDay2 == iTempDay1)//diff year, less months, same day
                {
                    iYears = (iTempYear2 - iTempYear1) -1;
                    iMonths = (12 * iYears) - (iTempMonth2 - iTempMonth1);
                    iDays = 28 * iMonths;
                    iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
                }
                else //diff year, fewer months, diff day
                {
                    if(iTempDay2 > iTempDay1)//diff year, fewer months, extra days
                    {
                        iYears = (iTempYear2 - iTempYear1) -1;
                        iMonths = (12 * iYears) - (iTempMonth2 - iTempMonth1);
                        iDays = (28 * iMonths) + (iTempDay2 - iTempDay1);
                        iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
                    }
                    else //diff year, fewer months, less days
                    {
                        iYears = (iTempYear2 - iTempYear1) -1;
                        iMonths = (12 * iYears) - (iTempMonth2 - iTempMonth1);
                        iDays =(28 * iMonths) + (28 + (iTempDay2 - iTempDay1));
                        iHours = (iTempHour2 - iTempHour1) + (24 * iDays);
                    }
                }
            }
        }
    }

    if(iTempYear2 < iTempYear1)
        return -1;//badness insues

    if(sOption == "hours")
    {
        return iHours;
    }
    else if(sOption == "days")
    {
        return iDays;
    }
    else if(sOption == "months")
    {
        return iMonths;
    }
    else if(sOption == "years")
    {
        return iYears;
    }
    else
        return -1; //invalid option

}
//void main(){}
