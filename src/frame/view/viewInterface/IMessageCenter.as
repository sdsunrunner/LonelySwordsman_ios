package frame.view.viewInterface
{
	import frame.view.IObserver;

	public interface IMessageCenter
	{
		/**
		 * 注册为观察者 
		 * @param ob
		 * 
		 */		
		function register(ob:IObserver):void;
		
		/**
		 * 取消注册 
		 * @param ob
		 * 
		 */		
		function unRegister(ob:IObserver):void;
		
		/**
		 * 取消所有观察者 
		 * 
		 */		
		function unRegisterAll():void;
		
		/**
		 * 发送消息 
		 * 
		 */		
		function notify():void;
		
		
	}
}