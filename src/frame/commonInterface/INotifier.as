package frame.commonInterface
{
	/**
	 * 通知发送接口 
	 * @author songdu.greg
	 * 
	 */	
	public interface INotifier
	{
		/**
		 * 发送命令 
		 * @param commandType
		 * @param data
		 * 
		 */		
		function sendNotification(notificationName:String, data:Object = null):void;
	}
}