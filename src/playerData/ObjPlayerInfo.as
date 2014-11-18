package playerData
{	
	/**
	 * 玩家信息 
	 * @author admin
	 * 
	 */	
	public class ObjPlayerInfo
	{
		/**
		 * 击杀总数
		 */		
		public var killCount:Number = 0;
		
		/**
		 * 生存模式最好得分 
		 */		
		public var surverModeBestScore:Number = 0;
		
		/**
		 * 故事模式英雄hp 
		 */		
		public var storyModeHeroLifeCount:Number = 3;
		
		/**
		 * 故事模式英雄hp 
		 */		
		public var storyModeHeroHp:Number = 0;
		
		/**
		 *  故事模式英雄mp 
		 */		
		public var storyModeHeroMp:Number = 0;
		
		/**
		 * 故事模式英雄hp道具数量 
		 */		
		public var storyModeHeroHpProto:Number = 0;
		
		/**
		 *  故事模式英雄mp道具数量 
		 */		
		public var storyModeHeroMpProto:Number = 0;
		
		/**
		 * 故事模式当前关卡 
		 */		
		public var storyModeGameLevId:Number = 0;
		
		/**
		 * 对决模式boss是否解锁 
		 */		
		public var battleModeBossIsUnLock:Boolean = false;
		
		/**
		 * 对决模式怪物是否解锁 
		 */		
		public var battleModeMonsterIsUnLock:Boolean = false;
	}
}