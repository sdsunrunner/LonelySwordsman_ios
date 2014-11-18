package frame.sys.track
{
	public interface ITrackMessage
	{
		/**
		 * 注册为观察者 
		 * @param ob
		 * 
		 */		
		function register(ob:ITrackable):void;
		
		/**
		 * 取消注册 
		 * @param ob
		 * 
		 */		
		function unRegister(ob:ITrackable):void;
		
		/**
		 * 取消所有观察者 
		 * 
		 */		
		function unRegisterAll():void;
		
		/**
		 * 发送消息 
		 * 
		 */		
		function notifyTrack():void;
	}
}