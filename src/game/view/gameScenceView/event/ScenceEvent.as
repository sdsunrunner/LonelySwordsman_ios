package game.view.gameScenceView.event
{
	import starling.events.Event;
	
	/**
	 * 场景事件 
	 * @author admin
	 * 
	 */	
	public class ScenceEvent extends Event
	{
		/**
		 *  场景结束
		 */
		public static const GAME_SCENCE_END:String = "GAME_SCENCE_END";
		
		public function ScenceEvent(type:String, bubbles:Boolean=true, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}