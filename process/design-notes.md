# Design Notes

## 18 June 2011

>>> SAFETY INSTRUCTIONS <<<
        A game of saving your life.

The basic concept: minisituations from an air safety card that you have to negotiate by typing the appropriate word (or phrase) in before a timer elapses (and you die).

It then consists almost entirely of a sequence of animations (the positive and negative outcomes) and mechanics for checking what people typed.

You could easily change difficulty levels by varying what they have to type.
e.g. "BRACE" versus "BRACE BRACE"? Haha.

(Levels: Easy, Hard, Fatalistic Acceptance of Early Death)

PER MINIGAME / SCENE

- A particular word(s) you have to type to activate the success animation.
- A success animation in which you survive.
- A failure animation in which you die (unless it's a bonus?)
- A BG animation that keeps the intro and typing periods visually engaging rather than flat - e.g. movement suggestive of plane (juddering), water movement, life raft bobbing. Also potential for the visual thing to be progress toward failure - e.g. life raft sinking... any other things suggestive of impending doom... almost like you could register the time limit this way somehow - fire bursting out of windows in turn until they get to you at the door.
- At least hypothetically, the success/failure should more or less lay over the top of the BG animation if at all possible. BG animation should be very very simple and possibly looping and rhythmic unless I go the progress route.

Maybe at the end of each animation it should say "SURVIVAL!" or "DEAD!" with some kind of sound effect.

= BUCKLE =

Buckle your seatbelt because the plane is crashing!

FRONT VIEW
BG: Maybe just clouds passing out the window, things should be calm here.
(Progress: increasing turbulence?)
SUCCEED: Big turbulence but you stay in your seat
FAIL: Turbulence starts and you fly up and hit your heat on the ceiling

= BREATHE =

Grabbing an oxygen mask.

FRONT VIEW
BG: oxygen mask drops down and swings
(Progress: cracking window?)
SUCCEED: Grab mask and put on face
FAIL: Grab for mask(?) and miss: go blue and die

= ASSIST OTHERS!  (BONUS!) =

Putting a mask on a baby.

FRONT VIEW
BG: baby crying and waving arms
(Progress: baby turns bluer and bluer)
SUCCEED: Put mask on baby
FAIL: Baby goes blackblue and dies

= BRACE =

Bracing for impact (with the water). Should be wearing the breathing mask in this instance?

SIDE VIEW
BG: tilted horizon out the window? Or even tilt the entire image?
(Progress: increasing tilt?)
SUCCEED: Brace position, survive the crash
FAIL: Smack head against seat and die

= CRAWL =

Crawling down the aisle through smoke.

SIDE VIEW
BG: Roiling smoke above your head
(PROGRESS: smoke getting lower to choke you)
SUCCESS: Crawl through the scene
FAIL: Asphyxiate in the smoke

= OPEN =
Opening the emergency door

FRONT VIEW
BG: Licking flames? View out the window on the door? Hmmm... tilting view?
(PROGRESS: Flames get closer?
SUCCESS: You get the door open and throw it out
FAIL: You burn up

= INFLATE =

Inflating your life vest.

FRONT VIEW
BG: Standing in the doorway... what?
(PROGRESS: ?)
(ANIM TYPING: inflates per correct letter, one breath per letter...)
SUCCESS: Life jacket inflates
FAIL: You drown (later?) - or you fall in and drown? Or caught by flames?

= SLIDE =

Sliding down the slide to safety.

SIDE VIEW / WIDE VIEW
BG: Wider shot of the plane, bobbing in water? Sinking?
(PROGRESS: Flames coming through windows closer and closer?)
(ANIM TYPING: Preparatory knee bends or something?)
SUCCESS: Slide down the slide
FAIL: You burn up from flames inside - flames burst out the door and incinerate you

= DODGE =

Dodge a shark coming up at you from beneath
(If you hadn't inflated the vest this could be where you drown...)

FRONT VIEW
BG: Top half above water, bottom half under
PROGRESS: Shark coming up toward your legs
SUCCESS: Pull legs up, shark misses
FAIL: Shark eats your legs

= WHISTLE = [OPTIONAL]

Blowing the whistle on your life vest?

SIDE VIEW
BG: Floating in semi-darkness?
PROGRESS: Lights of boats moving away?
SUCCESS: Lights of boats come to you.
FAIL: The lights of boats go away from you and disappear.

= GET IN = [OPTIONAL]

Get into the one of the floatation devices

SIDE VIEW?
BG: Bobbing of life raft
PROGRESS: More violent bobbing?
SUCCESS: Get in
FAIL: Drown

= PUSH =

Shoving someone out of the sinking life boat, or hitting someone off the edge. Leonardo Di Caprio? Fat guy?

SIDE VIEW
BG: The bobbing of the life raft
PROGRESS: the raft is sinking under the weight of all the people
SUCCESS: raft bobs back up with less weight
FAIL: The boat sinks

= FIGHT =

Killing someone in the boat for food. (or over food)

SIDE VIEW, ZOOMED
BG: Sky?
PROGRESS: airline forks pushing closer to your face
ANIM TYPING: your fork getting closer
SUCCESS: You stab them
FAIL: They stab you.

= SOME REALLY LONG PHRASE THEY HAVE NO HOPE OF TYPING =

The last one which they won't be able to get in which case they die, the last person on the floatation device, floating away... maybe a helicopter is going past, or a ship, and you have to type "signal ship with makeshift blah blah blah"...

WIDE VIEW
BG: ?
PROGRESS: ?
SUCCESS: You survive...
FAIL: The game ends on you dying - the ship moves on

END: At least you didn't eat anyone... at least you've still got your heels on... at least you have your bag... at least that baby's still alive...

[ AMUSING OTHER OPTIONS ]

= RETURN SEAT TO AN UPRIGHT POSITION (BONUS!) =

As it says...

FAIL: No consequence (OR: you die in the flames while doing it)

= GET BAG! (BONUS!) =

Grab your personal effects.

FAIL: No consequence (OR: it kills you by falling on your head)

= REMOVE HEELS! (BONUS!) =

Take off your heels before sliding.
BG: Same as inflate...
(PROGRESS: ?)
SUCCESS: Removed heels...
FAIL: You puncture the slide later? Meaning others are trapped.

= EAT! (BONUS?) =

Eating someone else

BG: ?
PROGRESS: ?
SUCCESS: You eat them?
FAIL: Nothing - it's only been a couple of minutes...

## 12 July 2011

>> SAFETY INSTRUCTIONS <<

= THE CODE STRUCTURE =

- One big question is whether each of the sequences should be a separate PlayState?
  - This would help in terms of transitions?
- Or whether it should all be in PlayState and it just tracks what the current StageIs and loads things appropriately...
- Any given Stage needs
  - The FlxSprite that has the animations (FlxSprite)
  - The defined frames of the three animations (int Array?)
  - The text needed to be types for that Stage (FlxText)
- So a Stage is a FlxGroup, easy enough.
- And the PlayState has an Array (?) of Stages that it runs through? (What about when there are bonus levels?) and an Index pointing to the CurrentStage
- Maybe the Array contained all the Stages, but null if the Stage hasn't been unlocked? Then you just check for null to avoid, and if it's unlocked you make the Stage object.

- Stage(FlxSprite, Frames, Frames, Frames, Text)
- Stage.getText()
- Stage.playDefault()
- Stage.playFail()
- Stage.playSuccess()

- And in the PlayState loop you just create the GameStage array
- Then in update you do the appropriate actions on the current state - which means that you check for keyboard and then play the appropriate animation, and then change to the next stage if they succeeded.

= THE ANIMATION GUIDELINES =

- 50x50 pixels is a basic guideline for a square containing some action (e.g. the brace position).
- Looking at the Air France one, it seems like I could go constant height, but some double width 100x50 panels (e.g. for slide)
- Probably makes sense to have a rounded-corner frame around them all, but outside the 50x50 area? Or on its periphery?
- For each sequence it makes sense to have both the success and fail animations in the same image sequence so that either one can be triggered from the same FlxSprite in the code.
- There remains the question of some kind of default animation loop prior to the result loop - there's the shake() method for pre-brace and probably for buckle, but generally will need something else the rest of the time... basically: some kind of "start loop" followed by the succeess and fail actions, which should map to the start loops first frame so that it's easy to make the transition.

- Other than these guidelines, I basically just need to draw them?

= OTHER GRAPHICS =

- Could draw graphics for text or use built-in. It should say "SAFE!" or "DEAD!" depending on how you do in each STAGE, they should be called STAGES.

= THE TEN =

1/ BUCKLE

2/ BRACE

3/ BREATHE

4/ CRAWL

5/ OPEN

6/ INFLATE

7/ SLIDE

8/ WHISTLE

9/ CLIMB

10/ SIGNAL FOR HELP FROM THE PASSING SHIP

= THE EXTRAS =

A/ ASSIST OTHERS

B/ GET HAND LUGGAGE

C/ THERE'S SOMETHING ON THE WING OF THIS PLANE!

D/ REMOVE HEELS

E/ DODGE SHARK

F/ PUSH FAT GUY OUT OF THE BOAT

G/ EAT FELLOW SURVIVOR

## 17 July 2011

>> SAFETY INSTRUCTIONS <<

ALL ANIMATIONS:

BUCKLE -> BREATHE -> [ASSIST] -> BRACE -> [CARRYON] ->
CRAWL -> OPEN -> INFLATE -> SLIDE -> [DODGE] -> WHISTLE ->
[SHOVE] -> SIGNAL

Every stage has five key animations (and one stage, whistle, has another two):

preLoop - the loop animation that plays on intro and during typing
failAnim - the one-off animation of failing to type (dying)
winAnim - the one-off animation of typing successfully (living)
postFailLoop - a loop animation that follows from failure, to display "DEAD!" over
postWinLoop - a loop animation that follows from winning, to display "SAFE!" over

A word on BONUS animations:

We'll have four?:
ASSIST (a baby with their mask) -> DEAD BABY! or SAFE BABY!
CARRYON (get your luggage) -> SAFE! or DEAD! (your luggage hits you if you even try)
DODGE (a shark coming for your legs) -> DEAD! or SAFE!
SHOVE (a fat guy sinking the boat) -> DEAD! or SAFE!
[Note the impact of SHOVE on SIGNAL]

FRAME ARRAYS FOR THE ANIMATIONS:

BUCKLE

preLoop: 0
failAnim: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
winAnim: 14, 15, 16, 17, 18, 19, 20, 21, 22, 22
postFailLoop: 13
postWinLoop: 22

BREATHE

preLoop: 0, 1, 2, 3
failAnim: 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
winAnim: 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38
postFailLoop: 24, 25, 26, 27
postWinLoop: 38

** ASSIST

preLoop:
failAnim:
winAnim:
postFailLoop:
postWinLoop:

BRACE

preLoop: 0
failAnim: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
winAnim: 16, 17, 18, 19, 20, 21, 22, 23, 24
postFailLoop: 15
postWinLoop: 24

** CARRYON

preLoop:
failAnim:
winAnim:
postFailLoop:
postWinLoop:

CRAWL

preLoop: 0, 1, 2, 3, 4
failAnim: 5, 6, 7, 8, 9, 10, 11, 12
winAnim: 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27
postFailLoop: 12
postWinLoop: 28, 29, 30, 31, 32

OPEN
preLoop: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
failAnim: 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39
winAnim: 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134
postFailLoop:  40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111
postWinLoop: 134

INFLATE

preLoop: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
failAnim: 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25
winAnim: 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37
postFailLoop: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
postWinLoop: 38, 39, 40, 41, 42, 43

SLIDE

preLoop: 0, 1, 2, 3, 4, 5, 6, 7
failAnim: 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
winAnim: 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42
postFailLoop: 24, 25, 26, 27, 28, 29, 30, 31
postWinLoop: 43, 44, 45, 46, 47, 48, 49, 50

[DODGE]

preLoop:
failAnim:
winAnim:
postFailLoop:
postWinLoop:
++ drownAnim
++ postDrownLoop

WHISTLE

preLoop: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
failAnim: 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42
winAnim: 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76
postFailLoop: 43, 44, 45, 46, 47, 48, 49, 50, 51, 52
postWinLoop: 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88
++ drownAnim: 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
++ postDrownLoop: 20, 21, 22, 23, 24, 25, 26, 27, 28, 29

[SHOVE]

preLoop:
failAnim:
winAnim:
postFailLoop:
postWinLoop:

SIGNAL

preAnim: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42 [NO LOOP] [HAS TO PLAY THROUGH BEFORE REACTING TO TYPING]
postPreAnimLoop: 43, 44, 45, 46, 47, 48, 49, 50, 51, 52
failAnim: 43, 44, 45, 46, 47, 48, 49, 50, 51, 52
winAnim: 53, 54, 55, 56, 57, 58, 59, 60, 61, 62
postFailLoop: 43, 44, 45, 46, 47, 48, 49, 50, 51, 52
postWinLoop: 53, 54, 55, 56, 57, 58, 59, 60, 61, 62
