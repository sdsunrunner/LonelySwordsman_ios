package game.basewidget
{
	import citrus.objects.platformer.nape.Sensor;
	
	import frame.command.AppNotification;
	import frame.command.BaseNotification;
	import frame.command.cmdInterface.INotification;
	
	/**
	 * 场景探测器基类  
	 * @author admin
	 * 
	 */	
	public class ScenceBaseSensor extends Sensor
	{
		public function ScenceBaseSensor(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		/**
		 * 发送通知 
		 * @param commandType
		 * @param data
		 * 
		 */		
		public function sendNotification(commandType:String, data:Object = null):void
		{
			var notification:INotification = new BaseNotification();
			notification.data = data;
			
			var note:AppNotification = new AppNotification(commandType, notification);
			note.dispatch();
		}
	}
}