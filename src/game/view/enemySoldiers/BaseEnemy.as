package game.view.enemySoldiers
{
	import citrus.objects.platformer.nape.Enemy;
	
	import frame.command.AppNotification;
	import frame.command.BaseNotification;
	import frame.command.cmdInterface.INotification;
	import frame.commonInterface.IDispose;
	
	import utils.MaterialUtils;
	
	/**
	 * 敌人超类 
	 * @author admin
	 * 
	 */	
	public class BaseEnemy extends Enemy implements IDispose
	{
		public var isPause:Boolean = false;
		public function BaseEnemy(name:String, params:Object=null)
		{
			super(name, params);
			this.touchable = false;
			
		}
		
		override protected function createMaterial():void 
		{			
			_material = MaterialUtils.createEnemyMaterial();
		}
		
		public function dispose():void
		{
			
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