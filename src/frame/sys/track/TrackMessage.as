package frame.sys.track
{
	import flash.utils.Dictionary;
	
	public class TrackMessage implements ITrackMessage
	{
		protected var msg:Object=null;
		protected var observerDic:Dictionary=null;
		protected var msgName:String="";
//==============================================================================
// Public Functions
//==============================================================================
		
		public function register(ob:ITrackable):void
		{
			if (null == observerDic)
				observerDic = new Dictionary(false);
			observerDic[ob] = null;
		}
		
		public function unRegister(ob:ITrackable):void
		{
			if(observerDic)
				delete observerDic[ob];
		}
		
		public function unRegisterAll():void
		{
			observerDic=null;
		}
		
		public function notifyTrack():void
		{
			for (var key:* in observerDic)
			{
				var observer:ITrackable=key;
				observer.track(msg, msgName);
			}
		}
	}
}