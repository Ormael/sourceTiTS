import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

// TODO:
// Izma lost kids
public function boatExplore():void
{
	if (helSexualAmbush()) return;
	
	userInterface.setLocation("\nLAKE", "EXPLORATION", "PLANET: MARETH");
	
	IncrementFlag("COC.EXPLORED_BOAT");
	
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	//3% chance of finding lost daughters
	//if (rand(100) <= 3 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00412] > 0 && kGAMECLASS.izmaScene.izmaFollower()) {
		//kGAMECLASS.izmaScene.findLostIzmaKids();
		//return;
	//}
	
	// TODO: wrap this in function to make it actually work
	output("You reach the dock without any incident and board the small rowboat.  The water is calm and placid, perfect for rowing.  ");
	if (flags["COC.FACTORY_SHUTDOWN"] == 2) {
		output("The water appears somewhat muddy and has a faint pungent odor.  ");
		if (pc.IQ() > 40) output("You realize what it smells like – sex.  ");
	}
	output("You set out, wondering if you'll find any strange islands or creatures in the lake.\n\n");
	
	////BUILD LIST OF CHOICES
	var choice:Array = [];
	var chance:Array = [];
	
	//20% chance if not done with marae of meeting her.
	if (flags["COC.MARAE_QUEST_COMPLETE"] == undefined && flags["COC.MET_MARAE_CORRUPTED"] == undefined) {
		choice.push(encounterMarae);
		chance.push((flags["COC.MARAE_QUEST_START"] == undefined || flags["COC.FACTORY_SHUTDOWN"] > 0) && pc.cor() <= 66 ? 1 : 10); // high chance to meet her first time to get quest or after blowing factory to get reward
	}
	if (flags["COC.FACTORY_SHUTDOWN"] == 1 && flags["COC.MARAE_QUEST_COMPLETE"] >= 1 && flags["COC.MINERVA_PURIFICATION_MARAE_TALKED"] == 1) {
		choice.push(talkToMaraeAboutMinervaPurification);
		chance.push(10);
	}
	if (flags["COC.FACTORY_SHUTDOWN"] == 1 && flags["COC.MARAE_QUEST_COMPLETE"] >= 1 && flags["COC.MINERVA_PURIFICATION_MARAE_TALKED"] != 1 && flags["COC.LETHICE_DEFEATED"] > 0 && flags["COC.PURE_MARAE_ENDGAME"] < 2 && pc.level >= 30) {
		choice.push(encounterPureMaraeEndgame);
		chance.push(10);
	}
	//10% chance of corrupt Marae followups
	if ((debug || rand(10) == 0) && flags["COC.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE"] == undefined && flags["COC.MET_MARAE_CORRUPTED"] > 0 && pc.hasGenitals() && flags["COC.CORRUPTED_MARAE_KILLED"] == undefined) {
		choice.push(level2MaraeEncounter);
		chance.push(20);
	}
	////Done to allow player who has both perks to fight Marae.
	if ((debug || rand(10) == 0) && flags["COC.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE"] == 2 && flags["COC.MET_MARAE_CORRUPTED"] > 0 && pc.hasGenitals() > 0 && flags["COC.CORRUPTED_MARAE_KILLED"] == undefined) {
		choice.push(level3MaraeEncounter);
		chance.push(20);
	}
	
	if (flags["COC.FACTORY_SHUTDOWN"] > 0 && pc.level > 2) {
		choice.push(zealotBoat);
		chance.push(1);
	}
	
	choice.push(mortalAnemoneeeeee);
	chance.push(1);
	
	choice.push(sharkGirlEncounter);
	chance.push(1);
	
	choice.push(rowUntilArmsDropOffAndAllForNothing);
	chance.push(2);
	
	//MAKE YOUR CHOICE
	WeightedRandom(choice, chance, true)();
}

public function discoverBoat():void {
	clearOutput()
	flags["COC.BOAT_DISCOVERED"] = 1;
	flags["COC.EXPLORED_BOAT"] = 0;
	output("You journey around the lake, seeking demons to fight");
	if(pc.cor() > 60) output(" or fuck");
	output(".  The air is fresh, and the grass is cool and soft under your feet.   Soft waves lap against the muddy sand of the lake-shore, as if radiating outward from the lake.   You pass around a few bushes carefully, being wary of hidden 'surprises', and come upon a small dock.  The dock is crafted from old growth trees lashed together with some crude rope.  Judging by the appearance of the rope, it is very old and has not been seen to in quite some time.  Tied to the dock is a small rowboat, only about seven feet long and three feet wide.   The boat appears in much better condition than the dock, and appears to be brand new.\n\n");
	output("<b>You have discovered the lake boat!</b>\n(You may return and use the boat to explore the lake's interior by using the 'places' menu.)");
	processTime(20 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function rowUntilArmsDropOffAndAllForNothing():void {
	clearOutput()
	if(rand(2) == 0) output("You give up on finding anything interesting, and decide to go check up on your camp.");
	else output("You row for nearly an hour, until your arms practically burn with exhaustion from all the rowing.");
	processTime(10 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}