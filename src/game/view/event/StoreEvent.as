package game.view.event
{
	import starling.events.Event;
	
	/**
	 * 商店事件 
	 * @author admin
	 * 
	 */	
	public class StoreEvent extends Event
	{
		public static const BUY_HERO_PH_HANDLER:String = "BUY_HERO_PH_HANDLER";
		
		public static const BUY_BOSS_HANDLER:String = "BUY_BOSS_HANDLER";
		
		public static const BUY_PROTO_HANDLER:String = "BUY_PROTO_HANDLER";
		
		public static const SHARE_BOSS_UNCLOCK:String = "SHARE_BOSS_UNCLOCK";
	}
}