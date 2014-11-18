package game.view.event
{
	import starling.events.Event;
	
	/**
	 * 角色受伤事件 
	 * @author admin
	 * 
	 */	
	public class RoleHurtEvent extends Event
	{
		public static const ROLE_HURT:String = "ROLE_HURT";
		public static const ROLE_DEATH:String = "ROLE_DEATH";		
		public var disX:Number = 0;
		public var disY:Number = 0;
		public function RoleHurtEvent(type:String, bubbles:Boolean=true, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}