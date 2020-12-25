void main()
{
    if(GetTag(OBJECT_SELF) == "clav")
    {
        if(GetLocalInt(OBJECT_SELF, "convolinenum") == 0)
            {
            SpeakString("You have to help us! Them raiders'll leave us starving, if'n they don't eat us first!");
            SetLocalInt(OBJECT_SELF, "convolinenum", 1);
            }

        else if (GetLocalInt(OBJECT_SELF, "convolinenum")==1)
            {
            SpeakString("What's them down the big smoke planning to do when all the crop for making bread's et by hungry goblins?");
            SetLocalInt(OBJECT_SELF, "convolinenum", 2);
            }

        else if(GetLocalInt(OBJECT_SELF, "convolinenum")==2)
            {
            SpeakString("Wouldn't even send a few guards, them useless bastards in town.");
            SetLocalInt(OBJECT_SELF, "convolinenum", 0);
            }
    }

    else if(GetTag(OBJECT_SELF) == "jart")
    {
        if(GetLocalInt(OBJECT_SELF, "convolinenum")==0)
            {
            SpeakString("You'll help won't you? Please, put a stop to this menace!");
            SetLocalInt(OBJECT_SELF, "convolinenum", 1);
            }

        else if(GetLocalInt(OBJECT_SELF, "convolinenum")==1)
            {
            SpeakString("Wish I'd seen this coming. Coulda packed it in ages ago.");
            SetLocalInt(OBJECT_SELF, "convolinenum", 2);
            }

        else if(GetLocalInt(OBJECT_SELF, "convolinenum")==2)
            {
            SpeakString("My ol' da, he always said I should stick to shepherding. Guess he was right!");
            SetLocalInt(OBJECT_SELF, "convolinenum", 0);
            }
    }


    else if(GetTag(OBJECT_SELF) == "rolling")
    {
        if(GetLocalInt(OBJECT_SELF, "convolinenum")==0)
            {
            SpeakString("What if, right, we stuck the dirt on carts and planted in that? Can't steal our crop if we're driving it away from 'em.");
            SetLocalInt(OBJECT_SELF, "convolinenum", 1);
            }

        else if(GetLocalInt(OBJECT_SELF, "convolinenum")==1)
            {
            SpeakString("Another good idea! Being so clever today, I'd better make sure my foot don't fall off.");
            SetLocalInt(OBJECT_SELF, "convolinenum", 2);
            }

        else if(GetLocalInt(OBJECT_SELF, "convolinenum")==2)
            {
            SpeakString("Yeah, my brother had this clever idea of cutting his toenails with a scythe, and his foot fell right off!");
            SetLocalInt(OBJECT_SELF, "convolinenum", 0);
            }
     }
}
