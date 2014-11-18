package  frame.command
{
	import frame.command.cmdInterface.ICommand;
	import frame.command.cmdInterface.INotification;

	/**
	 * 异步命令基类 
	 * @author songdu.greg
	 * 
	 */	
	public class BaseAsynCommand  implements ICommand
	{
		private var _parent:BaseMacroAsynCommand = null;
//==============================================================================
// Public Functions
//==============================================================================
		public function BaseAsynCommand()
		{
			
		}
		
		public function initAsync(parent:BaseMacroAsynCommand):void
		{
			_parent = parent;
		}

		public function excute(note:INotification):void
		{
			
		}
		
		public function excuteCompleteHandler():void
		{
			_parent.next();
		}
		
		protected function notify(type:String, data:* = null):void
		{
			var notification:INotification = new BaseNotification();
			notification.data = data;
			var note:AppNotification = new AppNotification(type, notification);
			
			note.dispatch();
		}
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------
		
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	}
}