package frame.command
{
	import frame.command.cmdInterface.ICommand;
	import frame.command.cmdInterface.INotification;
	import frame.facade.AppFacade;
	
	/**
	 * Notification, 提供向command的映射方法
	 * @author songdu.greg
	 * 
	 */	
	public class AppNotification
	{
		private var _commandType:String = "";
		private var _note:INotification = null;
		
		private var _appCenter:AppFacade = AppFacade.instance;
//==============================================================================
// Public Functions
//==============================================================================
		public function AppNotification(commandType:String, note:INotification)
		{
			_commandType = commandType;
			_note = note;
		}	
		
		public function dispatch():void
		{
			if(_appCenter.hasCommand(_commandType))
			{
				var command:ICommand = _appCenter.instanceCommandByType(_commandType);
				command.excute(_note);
			}
			else
			{
				throw new Error("command " + _commandType + " has not been registed!");
			}
		}
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-	
	}
}