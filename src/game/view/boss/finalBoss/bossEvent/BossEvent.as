package game.view.boss.finalBoss.bossEvent
{
	import starling.events.Event;
	
	/**
	 * 最终boss事件 
	 * @author admin
	 * 
	 */	
	public class BossEvent extends Event
	{
		public static const BOSS_FLASH_RUN_AWAY:String = "BOSS_FLASH_RUN_AWAY";
		
		public static const BOSS_BATTLE_END:String = "BOSS_BATTLE_END";
		public function BossEvent(type:String, bubbles:Boolean=true, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}