package classes.Items.Apparel 
{
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Interfaces.output;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;

	public class IllusoryAttire extends ItemSlotClass
	{
		public function IllusoryAttire() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.CLOTHING;
			
			this.shortName = "Illus.Attire";
			
			this.longName = "illusory attire";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "an illusory attire";
			
			this.tooltip = "A set of ornate bands designed to be worn on wrists, feet (or shins for plantigrade) and tails. Enchanted with Kitsune's glamour, distracting unfocused attention. As long as your body is animalistic enough, you won't be accused in public indecency while wearing them. As side effect they can partially protect you from psionic attacks, but nothing else. Illusion requires several specific body points for proper work: fur or scales, long tail, digitigrade paws or other sort of inhuman legs, C-cup or smaller breasts. Also, it only can hide your male parts if your have genital slit or all your cocks are sheathed and your balls are not too large.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 5000;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.sexiness = 6;
			this.critBonus = 0;
			this.evasion = 3;
			this.fortification = 0;
			
			this.resistances.addFlag(DamageFlag.NULLIFYING);
			
			this.itemFlags = [GLOBAL.ITEM_FLAG_EXPOSE_FULL];
			
			this.version = this._latestVersion;
		}
		
		public function isActive(target:Creature):Boolean {
			if (!target.hasFur() && !target.hasScales()) return false;
			if (target.hasLegFlag(GLOBAL.FLAG_PLANTIGRADE)) return false;
			if (!(target.hasTail() && target.hasTailFlag(GLOBAL.FLAG_LONG)) && !target.isNaga()) return false;
			if (target.biggestTitSize() > 3 && target.isChestExposed()) return false; // taurs variant: garbed chest and exposed crotch
			
			if (target.hasStatusEffect("Genital Slit") || !target.isCrotchExposed()) return true; // no further checks if all genitals are hidden
			
			if (target.balls > 0 && target.balls * target.ballVolume() * (target.hasStatusEffect("Uniball") ? 0.75 : 1) > 200) return false;
			if (target.hasCock() && !target.hasFullSheaths()) return false;
			
			return true;
		}
		
		override public function onEquip(targetCreature:Creature):void
		{
			if (targetCreature.isExposed()) {
				if (isActive(targetCreature)) {
					output("\n\nWhile not covering anything, this bands still somehow give you decent appearance.");
				}
				else output("\n\nWith this bands your appearance is even more provoking than simple nudity.");
			}
			if ((targetCreature.hasPerk("Enlightened Nine-tails") || targetCreature.hasPerk("Corrupted Nine-tails")) && this.defense == 0) {
				output("\n\nYou feel your power resonating with your bands... You are now fully in tune with them! Enchantement now provides some protection from physical attacks as well and evasion bonus is increased.");
				this.type = GLOBAL.ARMOR;
				this.defense = 5;
				this.evasion = 6;
				this.resistances.psionic.resistanceValue = 20;
				this.hasRandomProperties = true;
			}
		}
	}
}
