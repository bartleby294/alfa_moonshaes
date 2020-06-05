/*

The Portal How-To Ver. 1.4
On average, it will take you around 35 minutes to finish this Document.

Table of contents
Introduction
Preparation
Summary of steps
Part I: Set up the Visa for your server
Part II: Set up portals to other servers
Part III: Setting up waypoints for servers portaling to you
FAQ
Common Mistakes
Acknowledgements

Introduction
Bioware did not design portaling with a persistent world in mind. The
ActivatePortal function they provide only partially works for us.

This is why ALFA is providing its own portaling in the HCR and why you are now
reading this How-To. (For the curious HDMs, we've discussed the nuances at the
end of the document.)

Preparation
Before continuing with this document, you must have accomplished these steps:

1.   Installed the latest ACR

2.   Given your IP or Dynamic host name to the Infrastructure Admin

And you will need to know several things:

1.      Your server number

2.      The server numbers of the people you want to connect to.

3.      Familiar with how to create items in the toolset.

Note:  If you are confused by one of these steps, open the alfa_portal_in
script in the script editor and look in the "detailed How-To" section.


Summary of Steps
Basically we are going to do two things. Create a Visa that your server will
give to players, and create some Passports/portals to other servers.  We'll also
go over making Way Points for servers portaling to you. If you want to know why
we are going to all this trouble, skip to the discussion at the end of this Doc.

Part I:
Set up the ALFA Visa for your server. (you can check these steps off as you do
them.)

In the Module Properties, change the module NAME and TAG to "alfa_xxx" where xxx is
your server number. If your server number is "13" you must change the module
name to "alfa_013".

Start the Item Wizard to make a new item. You can choose any type of item, but
"misc. med." works best

Give this new item the same TAG and RESREF as your module name. Identical.
Example:"alfa_013". NAME should be 'Visa for XXX'

Put it somewhere in the special palette, toggle the "Launch Item Properties"
box, and click finished.

Change the Item Name to "ALFA Visa". You couldn't do this in step 3 because the
ResRef name gets auto-generated then, and we can't edit it later. You can add
anything onto the end you want, such as "ALFA Visa for Arabel".

Change the item image. Pick whatever you want. You'll probably want to pick one
of the images of a document rather than the default, which is a dead body.

In the "identified description" field, type any notes for the player to see.
This is a good area to introduce yourself to the player. You could put server
rules here, contact information, and so forth.

Save your module, you're done creating items.

Part II:
Setting up portals to other servers.



You need do this once for each portal you have planned, even if they all go to
the same destination. The reasons for this are in the discussion at the end.

Step I - Create and Name the Portal

Paint an Area Transition Trigger (or open an existing one) where you want a
portal to exist.

Open the properties of the Area Transition and change both the TAG and the NAME
to something like AP_013_001_073 where:

AP       Stands for Area Portal. This is an ALFA convention that allows your
         portals to sort themselves into a group in the toolset.

013      Is YOUR server number.

001      This is the nth portal to that particular DESTINATION SERVER you have
         created. (001 on the fist portal you make, 002 on the second, and
         so on)

073      Is the DESTINATION SERVER NUMBER.

You must always use 3 DIGITS for each of these numbers.


In the Scripts Tab of the properties, go to the OnClick field and select the
"alfa_portal_out" script.

Step II - Create a matching ALFA Pass

Start the Item Wizard and select any type of item. The "misc med" type is
recommended.

Give it the same TAG and RESREF as the portal you created in step 2. In our example, we
used AP_013_001_073.

Place it in the special palette somewhere you'll remember, like custom 2.

Toggle the "Launch Item Properties" box, and click finished.

NAME can be "ALFA Pass". We can't give it this name step 2 because of the
way the Item Wizard auto-generates the Blueprint ResRef field. If you want
to append text to the name, such as ALFA Pass to Hell's Gate, feel free.

Check the other fields. The Item Name should now read "ALFA Pass", but the Tag
and Blueprint ResRef should still say "AP_013_001_073" with your server numbers
substituted for our example of course. (case isn't important, you can append
text like mentioned in step 5)

Change the appearance to something you like. The default is a dead body, and
you might find one of the document images makes a better passport. Click OK to
finish.

Contact the HDMs with which you share a portal and give them the tag(s) you
just created. The HDM on the other side plunks down a WayPoint with that name
wherever he sees fit. Make sure you tell him what area on your map that tag is
from, like "the road leaving my server on the north" so he knows to put the
waypoint down on the road entering his server on the south.

Part III:
Setting up waypoints for servers portaling to you

Sooner or later, one of your neighbors will give you the tag of a portal they
created. This is a portal that goes from them to you. They may make several
portals to you. You need to create a separate Waypoint for each server portal.
If you want to know why, look in the discussion at the end.

1. Paint a WayPoint in the spot you think players from that server should
arrive at. It works best to put it next to your portal going to their server.
This creates the illusion of a two-way portal.

2. Change the Tag of your Waypoint to match the Tag the other DM gives you.

It's natural to put this waypoint on top of your Area Transition back to the
other server. Don't do this. Put it slightly in front. If both you and the
other DM configured your Area Transitions to fire OnEnter, or you could create
a loop.


FAQ:

Q: What exactly is the problem here anyway?

A: The players can "server-hop" around, regardless of where their character is at.
Even if they do portal appropriately, the Bioware AcivatePortal bug doesn't put
them where they are supposed to be at on the destination server. Instead, it
remembers their last position and places them there. Scripts were developed to
cover for this behavior.

Q: So what are we really doing about it here?

A: The player gets an "ALFA Visa" specific to the server they are currently on.
If they try to "hop" to another server with a direct-connect, they are
reconnected to the correct server. To travel, they must go though an Area
Transition where they are given an "ALFA Pass" to the server next door. The
destination server examines this passport and moves them to the proper waypoint.


Q: How does the Visa work?

A: When a player logs onto your server, it checks them for a Visa. If the Visa
matches your server, they get to stay. If it's for another server, (and they
don't have a valid passport) they get portaled to the other server.

Q: What does the Passport do?

A: The server can't tell the difference between people that are
direct-connecting, and people that are portaling in. The "ALFA Pass" tells it
that you are portaling in from one of its neighbors and not trying to
"server-hop" across Faerun. Additionally, it looks at the waypoint on the
pass, and moves you to the right map location. Otherwise, you'd end up at the
wrong spot because of a bug in the function provided by Bioware.

Q: Why do you say to use an Area Transition?

A: You can actually use any sort of trigger, even a lever, just as long as it
fires the alfa_portal_out script. A conversation would be really cool too where
you can give the PC a choice of multiple destinations.

Q: Why do I need to use that second set of numbers in the portal tag
AP_013_001_073

A: This is important when the two servers connect to each other more than once.
For instance, let's say you have two roads leading to your next door neighbor.
AP_013_001_073 would indicate one road, and AP_013_002_073 would indicate the
other. The DM on the other side puts a WayPoint down for each. Without
different WayPoints on the other server, you'd end up at the wrong spot.

Q: Why use OnClick?

A: I recommend using the OnClick as opposed to the OnEnter when possible.
This will save your player from getting in a portal-loop. This can happen
when both you and the other server have mistakes in the spelling or placing
of destination waypoints. If you are careful though, it doesn't matter.

Q: What about full edge server-server transitions?

A: This is theoretically possible. Someone would have to figure it out though.
Ideas involving sending in a stack of bullets with the number of bullets 0-100,
indicating some percentage of the edge's width, have been kicked around, but
nobody has tried to implement anything.

Q: I can toss away my Visa whenever I want and jump to a new server, is that
secure?

A: If you want to discard your Visa, all you have to do is drop it. The next
server assumes your new and gives you a new Visa. There is a feature to stop
you from discarding your Visa, but it's turned off right now. This will
probably change in the future.

Common Mistakes:

Password not set: Right now, your server must have the password set to ALFA,
or have none at all.

Name Mix Ups: Make sure you didn't accidentally put "visa" in the name when
you mean it to be a passport and vice versa.  Don't mix the two up. Strange
things happen because the keywords "pass" and "visa", when combined with the
word "alfa" on an item are being used by the scripts to find the information
they need.

Tag and ResRef miss-match: The Tag of the trigger needs to match the ResRef
of the passport you want it to give out. This is why the steps listed above
in the How-To have you create and item with an encoded name and then go back
and rename things later.

Name and Tag mix up: Put "ALFA Pass" in the NAME field, not the TAG field.
The tag should match the trigger tag.

Spelling: All you really have to do is get the strings "alfa" and "pass" in
the name somewhere. Something like "alfa passport" is ok, but "alfa pas: won't
cut it.

Acknowledgements

The entire concept of using passports is Zero's idea. Without his functional
technology demo, I don't think this would have happened. All I did is tack
some ideas onto his and write some code.

The authors of this document are Ranoulf, ZZTong, and Murky.

*/

void main() {}
