package game.view.boss
{
	import citrus.objects.platformer.nape.Hero;
	
	import frame.command.AppNotification;
	import frame.command.BaseNotification;
	import frame.command.cmdInterface.INotification;
	
	/**
	 * 敌人英雄 
	 * @author admin
	 * 
	 */	
	public class BaseEnemyHero extends Hero
	{
		public var isPause:Boolean = false;
		public function BaseEnemyHero(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		public function pause():void
		{
			isPause = true;
		}
		
		public function resume():void
		{
			isPause = false;
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