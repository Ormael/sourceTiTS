package classes.Engine.Utility 
{
	/**
	 * If flag is undefined, initialize it as 0. Possibly updates value if new value is defined (as set or add depending on third arg, set by default). Returns value after initializing, but before changing.
	 * @author Etis
	 */
	import classes.kGAMECLASS;
	public function Flag(flagName:String, newValue:Number = Number.NaN, add:Boolean = false):*
	{
		if (kGAMECLASS.flags[flagName] == undefined) kGAMECLASS.flags[flagName] = 0;
		
		var ret:* = kGAMECLASS.flags[flagName];
		
		if (!isNaN(newValue)) {
			if (add) kGAMECLASS.flags[flagName] += newValue;
			else kGAMECLASS.flags[flagName] = newValue;
		}
		
		return ret;
	}
}