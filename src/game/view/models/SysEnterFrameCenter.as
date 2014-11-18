package game.view.models
{
	import flash.utils.Dictionary;
	
	import frame.sys.track.ITrackMessage;
	import frame.sys.track.ITrackable;
	
	/**
	 * enter frame发生器 
	 * @author songdu.greg
	 * 
	 */	
	public class SysEnterFrameCenter implements ITrackMessage
	{
		private static var _instance:SysEnterFrameCenter = null;
		
		private var msg:Object=null;
		private var observerDic:Dictionary=null;
		private var msgName:String="";
		private var _frameCount:Number = 0;				
		public function SysEnterFrameCenter(code:$)
		{
			super();
		}
		
		public static function get instance():SysEnterFrameCenter
		{
			return _instance ||= new SysEnterFrameCenter(new $);
		}
		
		
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
			_frameCount++;
			if(_frameCount > Const.FRAME_DELAY)			
				_frameCount = 0;				
			var count:Number = 0;
			
			for (var key:* in observerDic)
			{
				var observer:ITrackable=key;
				observer.track(msg, msgName,_frameCount == Const.FRAME_DELAY);
				count++;
			}
		}
	}
}

class ${}