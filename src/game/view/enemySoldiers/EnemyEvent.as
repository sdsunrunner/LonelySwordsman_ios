package game.view.enemySoldiers
{
	import starling.events.Event;
	
	/**
	 * 角色事件 
	 * @author admin
	 * 
	 */	
	public class EnemyEvent extends Event
	{
		public static const REMOVE_ENMY_NOTE:String = "REMOVE_ENMY_NOTE";
		
		public static const ENMY_DEATH_NOTE:String = "ENMY_DEATH_NOTE";
		public function EnemyEvent(type:String, bubbles:Boolean=true, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}