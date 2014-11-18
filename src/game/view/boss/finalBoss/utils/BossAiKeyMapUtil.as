package game.view.boss.finalBoss.utils
{
	/**
	 * bossAi map 
	 * @author admin
	 * 
	 */	
	public class BossAiKeyMapUtil
	{
		/**
		 * 获取 bossmp key
		 * @param bossMp
		 * @return 
		 * 
		 */		
		public static function getbossMpKey(bossMpRatio:Number):String
		{
			var key:String = "60_100";
			var ratio:Number = Math.floor(bossMpRatio*100);
			if(ratio>0 && ratio<40)
				key = "0_40";
			
			if(ratio>=40 && ratio<60)
				key = "40_60";
			
			if(ratio>=60 && ratio<=100)
				key = "60_100";			
			return key;
		}
		
		/**
		 * 获取  bossHp key
		 * @param bossHpRatio
		 * @return 
		 * 
		 */		
		public static function getbossHpKey(bossHpRatio:Number):String
		{
			var key:String = "60_100";
			var ratio:Number = Math.floor(bossHpRatio*100);
			if(ratio>0 && ratio<30)
				key = "0_30";
			
			if(ratio>=30 && ratio<60)
				key = "30_60";
			
			if(ratio>=60 && ratio<=100)
				key = "60_100";			
			return key;
		}
		
		
		/**
		 * 获取英雄 HpKey
		 * @param heroHpRatio
		 * @return 
		 * 
		 */		
		public static function getHeroHpKey(heroHpRatio:Number):String
		{
			var key:String = "70_100";
			var ratio:Number = Math.floor(heroHpRatio);
			if(ratio>0 && ratio<40)
				key = "0_40";
			
			if(ratio>=40 && ratio<70)
				key = "40_70";
			
			if(ratio>=70 && ratio<=100)
				key = "70_100";			
			return key;
		}
	}
}