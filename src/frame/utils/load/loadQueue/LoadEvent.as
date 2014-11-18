package  frame.utils.load.loadQueue
{
	import flash.events.Event;
	
	/**
	 * 加载信息事件 
	 * 
	 */	
	public class LoadEvent extends Event
	{
		public static const LOAD_SUC:String = "loadSuc";	// 加载成功
		public static const LOAD_ERR:String = "loadErr";	// 加载失败
		
		public function LoadEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

	}
}