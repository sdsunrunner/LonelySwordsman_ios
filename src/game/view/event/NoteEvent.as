package game.view.event
{
	import starling.events.Event;
	
	/**
	 * 提示 
	 * @author admin
	 * 
	 */	
	public class NoteEvent extends Event
	{
		public static const BUY_HERO_PH_HANDLER:String = "BUY_HERO_PH_HANDLER";
		
		public static const BUY_BOSS_HANDLER:String = "BUY_BOSS_HANDLER";
		
		public static const BUY_PROTO_HANDLER:String = "BUY_PROTO_HANDLER";
		
		public static const SHARE_BOSS_UNCLOCK:String = "SHARE_BOSS_UNCLOCK";
		
		public static const SHARE_SURVER_MODEL_SCORE:String = "SHARE_SURVER_MODEL_SCORE";
		
		public static const SHOW_STORE:String = "SHOW_STORE";
		public static const SHOW_NEXT_LEV:String = "SHOW_NEXT_LEV";
	}
}