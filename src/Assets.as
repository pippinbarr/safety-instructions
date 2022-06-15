package
{
	import org.flixel.FlxSound;

	public class Assets
	{
		
		[Embed(source="assets/fonts/slkscr.ttf", fontName="Silkscreen", fontWeight="Regular", embedAsCFF="false")]
		public static const SILKSCREEN_FONT:Class;
		
		[Embed(source="assets/png/Button.png")]
		public static var ButtonSheet:Class;
		
		[Embed(source="assets/mp3/ThemeMusic.mp3")]
		public static var ThemeMusic:Class;
		public static var _themeSong:FlxSound = null;
		
		[Embed(source="assets/png/BlackFrame.png")]
		public static var BlackFrame:Class;
		
		[Embed(source="assets/mp3/Announcement.mp3")]
		public static var AnnounceSnd:Class;
		[Embed(source="assets/mp3/Success.mp3")]
		public static var SuccessSnd:Class;
		[Embed(source="assets/mp3/Wrong.mp3")]
		public static var WrongSnd:Class;
		[Embed(source="assets/mp3/Impact.mp3")]
		public static var ImpactSnd:Class;
		[Embed(source="assets/mp3/Open.mp3")]
		public static var OpenSnd:Class;
		[Embed(source="assets/mp3/Whistle.mp3")]
		public static var WhistleSnd:Class;
		
		[Embed(source="assets/png/Introduction50.png")]
		public static var IntroductionSheet:Class;
		public static var _introWidth:int = 75;
		public static var _introHeight:int = 50;
		public static var _introPartOneFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14);
		public static var _tutorialPreLoopFrames:Array = new Array(15, 15);
		public static var _tutorialWinFrames:Array = new Array(15, 16, 17, 18, 19, 20);
		public static var _tutorialFailFrames:Array = new Array(21, 22, 23, 24, 25, 26);
		public static var _tutorialImpactFrames:Array = new Array(23, 23);
		public static var _tutorialPostWinFrames:Array = new Array(20, 20);
		public static var _tutorialPostFailFrames:Array = new Array(26, 26);
		public static var _introPartTwoFrames:Array = new Array(27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39);
		public static var _introPartThreeFrames:Array = new Array(40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54);
		
		
		
		public static var _defaultResults:Array = new Array(
			"SAFE!",
			"(PRESS SPACE)",
			"DEAD!",
			"(PRESS SPACE)");
		
		
		[Embed(source="assets/png/Buckle50.png")]
		public static var BuckleSheet:Class;
		public static var _buckleWidth:int = 50;// 400;
		public static var _buckleHeight:int = 50;//400;
		public static var _bucklePreLoopFrames:Array = new Array(0, 0);
		public static var _buckleWinFrames:Array = new Array(14, 15, 16, 17, 18, 19, 20, 21, 22);
		public static var _buckleFailFrames:Array = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13);
		public static var _buckleImpactFrames:Array = new Array(5,11);
		public static var _bucklePostFailFrames:Array = new Array(13, 13);
		public static var _bucklePostWinFrames:Array = new Array(22, 22);
		
		public static var _buckleText:Array = new Array(
			"FASTEN YOUR SEATBELT",
			"BUCKLE YOUR SEATBELT AND ADJUST TO FIT AS NEEDED",
			"INSERT TAB INTO BUCKLE MECHANISM UNTIL YOU HEAR IT CLICK, THEN TIGHTEN WITH STRAP.",
			"DEBUG");
		
		public static var _buckleResults:Array = null;
		
		
		[Embed(source="assets/png/Breathe50.png")]
		public static var BreatheSheet:Class;
		public static var _breatheWidth:int = 50;//400;
		public static var _breatheHeight:int = 50;//400;
		public static var _breathePreLoopFrames:Array = new Array(0, 1, 2, 3);
		public static var _breatheWinFrames:Array = new Array(28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38);
		public static var _breatheFailFrames:Array = new Array(4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23);
		public static var _breathePostFailFrames:Array = new Array(24, 25, 26, 27);
		public static var _breathePostWinFrames:Array = new Array(38, 38);
		
		public static var _breatheText:Array = new Array(
			"BREATHE USING THE MASK PROVIDED",
			"ATTACH THE MASK WITH THE STRAP AND BREATHE NORMALLY",
			"PUT ON THE MASK AND TRY NOT TO FREAK OUT ABOUT HOW THE PLASTIC BAG ISN'T INFLATING...",
			"DEBUG");
		
		public static var _breatheResults:Array = null;
		
		
		
		[Embed(source="assets/png/Assist50.png")]
		public static var AssistSheet:Class;
		public static var _assistWidth:int = 75;//400;
		public static var _assistHeight:int = 50;//400;
		public static var _assistPreLoopFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);
		public static var _assistWinFrames:Array = new Array(38, 39, 40, 41, 42, 43, 44, 45, 46, 47);
		public static var _assistFailFrames:Array = new Array(12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31);
		public static var _assistPostFailFrames:Array = new Array(32, 33, 34, 35, 36, 37);
		public static var _assistPostWinFrames:Array = new Array(47, 47);
		
		public static var _assistText:Array = new Array(
			"ASSIST OTHERS WITH THEIR MASKS",
			"ONCE YOUR OWN MASK IS FASTENED, HELP OTHERS WHO NEED IT",
			"OH SHIT THE LITTLE KID! PLEASE DON'T LET ME BE THE GUY WHO LETS THE LITTLE KID DIE!",
			"DEBUG");
		
		public static var _assistResults:Array = new Array(
			"SAVED!",
			"(PRESS SPACE)",
			"POOR KID",
			"(PRESS SPACE)");
		
		
		[Embed(source="assets/png/Brace50.png")]
		public static var BraceSheet:Class;
		public static var _braceWidth:int = 50;//400;
		public static var _braceHeight:int = 50;//400;
		public static var _bracePreLoopFrames:Array = new Array(0, 0);
		public static var _braceWinFrames:Array = new Array(16, 17, 18, 19, 20, 21, 22, 23, 24);
		public static var _braceFailFrames:Array = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
		public static var _braceImpactFrames:Array = new Array(7,7);
		public static var _bracePostFailFrames:Array = new Array(15, 15);
		public static var _bracePostWinFrames:Array = new Array(24, 24);
		
		public static var _braceText:Array = new Array(
			"ASSUME THE BRACE POSITION",
			"BRACE YOURSELF AGAINST THE SEAT IN FRONT OF YOU",
			"OH MY GOD WE'RE GOING TO CRASH INTO THE SEA! NO ONE WILL EVER FIND MY BODY!",
			"DEBUG");
		
		public static var _braceResults:Array = null;
		
		
		[Embed(source="assets/png/Crash50.png")]
		public static var CrashSheet:Class;
		public static var _crashWidth:int = 75;
		public static var _crashHeight:int = 50;
		public static var _crashFrames:Array = new Array(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31);
		public static var _crashPostLoopFrames:Array = new Array(28,29,30,31);
		public static var _crashImpactFrames:Array = new Array(21,21);
		
		
		[Embed(source="assets/png/Luggage50.png")]
		public static var LuggageSheet:Class;
		public static var _luggageWidth:int = 50;//400;
		public static var _luggageHeight:int = 50;//400;
		public static var _luggagePreLoopFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19);
		public static var _luggageFailFrames:Array = new Array(46, 47, 48, 49, 50, 51, 52);
		public static var _luggageImpactFrames:Array = new Array(34,43);
		public static var _luggageWinFrames:Array = new Array(20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45);
		public static var _luggagePostWinFrames:Array = new Array(45, 45);
		public static var _luggagePostFailFrames:Array = new Array(52, 52);
		
		public static var _luggageText:Array = new Array(
			"GRAB YOUR CARRY ON",
			"TAKE YOUR CARRY ON, EVEN THOUGH YOU'RE NOT MEANT TO",
			"FUCK IT, MIGHT AS WELL TAKE MY BAG. AT LEAST I CAN WATCH MOVIES ON MY LAPTOP.",
			"DEBUG");
		
		public static var _luggageResults:Array = new Array(
			"DEAD!",
			"(PRESS SPACE)",
			"WISE!",
			"(PRESS SPACE)");
		
		
		
		[Embed(source="assets/png/Crawl50.png")]
		public static var CrawlSheet:Class;
		public static var _crawlWidth:int = 75;//600;
		public static var _crawlHeight:int = 50;//400;
		public static var _crawlPreLoopFrames:Array = new Array(0, 1, 2, 3, 4);
		public static var _crawlWinFrames:Array = new Array(13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27);
		public static var _crawlFailFrames:Array = new Array(5, 6, 7, 8, 9, 10, 11, 12);
		public static var _crawlPostFailFrames:Array = new Array(12, 12);
		public static var _crawlPostWinFrames:Array = new Array(28, 29, 30, 31, 32);
		
		public static var _crawlText:Array = new Array(
			"CRAWL TO THE NEAREST EXIT",
			"FOLLOW THE ILLUMINATED STRIPS ON THE FLOOR TO THE EXIT",
			"MAYBE I SHOULD JUST BREATHE DEEP AND DIE OF SMOKE INHALATION INSTEAD... NAH.",
			"DEBUG");
		
		public static var _crawlResults:Array = null;
		
		
		
		[Embed(source="assets/png/Open50.png")]
		public static var OpenSheet:Class;
		public static var _openWidth:int = 50;//400;
		public static var _openHeight:int = 50;//400;
		public static var _openPreLoopFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
		public static var _openWinFrames:Array = new Array(112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134);
		public static var _openFailFrames:Array = new Array(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39);
		public static var _openImpactFrames:Array = new Array(16, 16);
		public static var _openOpenFrames:Array = new Array (33,122);
		public static var _openPostFailFrames:Array = new Array(40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111);
		public static var _openPostWinFrames:Array = new Array(134, 134);
		
		public static var _openText:Array = new Array(
			"OPEN THE EMERGENCY DOOR",
			"TURN THE HANDLE CLOCKWISE TO OPEN THE EMERGENCY DOOR",
			"OH SHIT, THESE PEOPLE LOOK ANGRY! BETTER OPEN THE DOOR BEFORE THEY GO APESHIT!",
			"DEBUG");
		
		public static var _openResults:Array = null;
		
		
		
		[Embed(source="assets/png/Inflate50.png")]
		public static var InflateSheet:Class;
		public static var _inflateWidth:int = 50;//400;
		public static var _inflateHeight:int = 50;//400;
		public static var _inflatePreLoopFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
		public static var _inflateWinFrames:Array = new Array(26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37);
		public static var _inflateFailFrames:Array = new Array(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25);
		public static var _inflatePostFailFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
		public static var _inflatePostWinFrames:Array = new Array(38, 39, 40, 41, 42, 43);		
		
		public static var _inflateText:Array = new Array(
			"INFLATE YOUR LIFE JACKET",
			"INFLATE YOUR LIFE JACKET UPON EXITING THE PLANE",
			"I'LL INFLATE IT, BUT IT FEELS POINTLESS. ONE LAST PLACEBO BEFORE I DIE.",
			"DEBUG");
		
		public static var _inflateResults:Array = new Array(
			"SAFE!",
			"(PRESS SPACE)",
			"SAFE...",
			"(PRESS SPACE)");
		
		
		
		[Embed(source="assets/png/Slide50.png")]
		public static var SlideSheet:Class;
		public static var _slideWidth:int = 50;//400;
		public static var _slideHeight:int = 50;//400;
		public static var _slidePreLoopFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7);
		public static var _slideWinFrames:Array = new Array(32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42);
		public static var _slideFailFrames:Array = new Array(8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23);
		public static var _slideImpactFrames:Array = new Array(15, 15);
		public static var _slidePostFailFrames:Array = new Array(24, 25, 26, 27, 28, 29, 30, 31);
		public static var _slidePostWinFrames:Array = new Array(43, 44, 45, 46, 47, 48, 49, 50);
		
		public static var _slideText:Array = new Array(
			"USE THE EMERGENCY SLIDE",
			"CROSS YOUR ARMS OVER YOUR CHEST AND USE THE SLIDE",
			"AT LEAST THIS LOOKS FUN, I GUESS. THIS FUCKING LIFE VEST BETTER DO ITS DAMN JOB.",
			"DEBUG");
		
		public static var _slideResults:Array = null;
		
		
		
		[Embed(source="assets/png/Dodge50.png")]
		public static var DodgeSheet:Class;
		public static var _dodgeWidth:int = 50;//400;
		public static var _dodgeHeight:int = 50;//400;
		public static var _dodgeDrownFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14);
		public static var _dodgePostDrownFrames:Array = new Array(15, 16, 17, 18, 19, 20, 21, 22, 23, 24);
		public static var _dodgePreLoopFrames:Array = new Array(25, 26, 27, 28, 29, 30, 31, 32, 33, 34);
		public static var _dodgeWinFrames:Array = new Array(35, 36, 43, 44, 45, 46, 47, 48);
		public static var _dodgeFailFrames:Array = new Array(35, 36, 37, 38, 39, 40, 41, 42);
		public static var _dodgePostFailFrames:Array = new Array(19, 20, 21, 22, 23, 24, 15, 16, 17, 18);
		public static var _dodgePostWinFrames:Array = new Array(49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67 , 68);
		
		public static var _dodgeText:Array = new Array(
			"AVOID THE SHARK",
			"PULL YOUR LEGS TO YOUR CHEST TO AVOID SHARK ATTACK",
			"HOLY FUCK THERE'S A SHARK DOWN THERE! REALLY HOPE IT GOES FOR SOMEONE ELSE!",
			"DEBUG");
		
		public static var _dodgeResults:Array = null;
		public static var _dodgeDrownRestartText:String = "(PRESS SPACE)";

		
		[Embed(source="assets/png/Whistle50.png")]
		public static var WhistleSheet:Class;
		public static var _whistleWidth:int = 75;//600;
		public static var _whistleHeight:int = 50;//400;
		public static var _whistlePreLoopFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
		public static var _whistleWinFrames:Array = new Array(53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76);
		public static var _whistleFailFrames:Array = new Array(30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42);
		public static var _whistlePostFailFrames:Array = new Array(43, 44, 45, 46, 47, 48, 49, 50, 51, 52);
		public static var _whistlePostWinFrames:Array = new Array(77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88);
		public static var _whistleDrownFrames:Array = new Array(10, 11, 12, 13, 14, 15, 16, 17, 18, 19);
		public static var _whistlePostDrownFrames:Array = new Array(20, 21, 22, 23, 24, 25, 26, 27, 28, 29);
		public static var _whistleFrames:Array = new Array(59,67);

		public static var _whistleText:Array = new Array(
			"WHISTLE FOR ATTENTION",
			"USE THE WHISTLE ON YOUR LIFE VEST TO CALL FOR HELP",
			"SO IT COMES TO THIS. BLOWING A WHISTLE IN THE HOPE THESE ASSHOLES WILL RESCUE ME.",
			"DEBUG");
		
		public static var _whistleResults:Array = null;
		public static var _whistleDrownRestartText:String = "(PRESS SPACE)";
		
		[Embed(source="assets/png/Shove50.png")]
		public static var ShoveSheet:Class;
		public static var _shoveWidth:int = 75;//400;
		public static var _shoveHeight:int = 50;//400;
		public static var _shovePreLoopFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
		public static var _shoveWinFrames:Array = new Array(20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33);
		public static var _shoveFailFrames:Array = new Array(10, 11, 12, 13, 14, 15, 16, 17, 18, 19);
		public static var _shoveImpactFrames:Array = new Array(25, 25);
		public static var _shovePostFailFrames:Array = new Array(19, 19);
		public static var _shovePostWinFrames:Array = new Array(34, 35, 36, 37, 38, 39, 40, 41, 42, 43);
		public static var _shoveDeadText:String = "DEAD!";
		
		public static var _shoveText:Array = new Array(
			"SHOVE THE FAT GUY OUT",
			"USE YOUR SUPERIOR LEVERAGE TO PUSH OUT THE OBESE MAN",
			"WELL, ULTIMATELY IT'S HIM OR ME AND I'D RATHER IT WAS HIM. MAYBE HE'S A GOOD SWIMMER?",
			"DEBUG");
		
		public static var _shoveResults:Array = null;
		
		
		
		[Embed(source="assets/png/Signal50.png")]
		public static var SignalSheet:Class;
		[Embed(source="assets/png/SignalPostShove50.png")]
		public static var SignalPostShoveSheet:Class;
		public static var _signalWidth:int = 75;//600;
		public static var _signalHeight:int = 50;//400;
		public static var _signalPreFrames:Array = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42);
		public static var _signalPreLoopFrames:Array = new Array(43, 44, 45, 46, 47, 48, 49, 50, 51, 52);
		public static var _signalWinFrames:Array = new Array(53, 54, 55, 56, 57, 58, 59, 60, 61, 62);
		public static var _signalFailFrames:Array = new Array(43, 44, 45, 46, 47, 48, 49, 50, 51, 52);
		public static var _signalPostFailFrames:Array = new Array(43, 44, 45, 46, 47, 48, 49, 50, 51, 52);
		public static var _signalPostWinFrames:Array = new Array(53, 54, 55, 56, 57, 58, 59, 60, 61, 62);


		public static var _signalText:Array = new Array(
			"SIGNAL THE PASSING SHIP",
			"WAVE YOUR ARMS LIKE CRAZY AT THE PASSING SHIP",
			"THERE IS NO WAY IN HELL THAT SHIP IS GOING TO SEE US. WE ARE DEFINITELY GOING TO DIE.",
			"DEBUG");
		
		public static var _signalResults:Array = new Array(
			"SAVED?",
			"(PRESS SPACE)",
			"DEAD?",
			"(PRESS SPACE)");
		
	
		
		[Embed(source="assets/png/Lost50.png")]
		public static var LostSheet:Class;
		public static var _lostWidth:int = 50;//400;
		public static var _lostHeight:int = 50;//400;
		public static var _lostPreLoopFrames:Array = new Array(0,1,2,3,4,5,6,7);
		public static var _lostFailFrames:Array = new Array(8,9,10,11,12,13,14,15);
		public static var _lostReverseFailFrames:Array = new Array(15,14,13,12,11,10,9,8);
		public static var _lostImpactFrames:Array = new Array(12, 12);
		public static var _lostPostFailFrames:Array = new Array(16,17,18,19,20,21,22,23);
		
		public static var _lostText:Array = new Array(
			"YOU SHOULD NEVER SEE THIS",
			"YOU SHOULD NEVER SEE THIS",
			"WHAT? WHERE AM I? WHY AM I ON A BEACH? I... I THOUGHT I WAS IN A PLANE CRASH... IT'S WEIRD THOUGH... I FEEL LIKE I'M MEANT TO BE HERE...",
			"DEBUG");
		

		public static var _lostResults:Array = new Array(
			"WHAT THE...",
			"(REALLY SHOULDN'T EVER HAPPEN)",
			"LOST?",
			"(PRESS SPACE)");
		
		public static var _lostWinResults:Array = new Array(
			"WHAT THE...",
			"DID YOU JUST WIN?",
			"... HOW?!",
			"WELL... FINE.",
			"IF I CAN'T GET YOU, THE POLAR BEAR WILL.",
			"ENJOY YOUR ISLAND HOLIDAY.");			
	
	
		public function Assets()
		{
		}
	}
}