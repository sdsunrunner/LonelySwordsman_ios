package frame.command
{
	import frame.command.cmdInterface.ICommand;
	import frame.command.cmdInterface.INotification;
	
	
	public class SuperCommand implements ICommand
	{
//==============================================================================
// Public Functions
//==============================================================================
		public function SuperCommand()
		{
		}
		
		public function excute(note:INotification):void
		{
			
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