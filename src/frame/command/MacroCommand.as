package frame.command
{
	import frame.command.cmdInterface.ICommand;
	import frame.command.cmdInterface.INotification;

	/**
	 * 宏命令 
	 * @author songdu.greg
	 * 
	 */	
	public class MacroCommand implements ICommand
	{
		protected var subCommands:Array = null;
//==============================================================================
// Public Functions
//==============================================================================
		public function MacroCommand()
		{
			subCommands = [];
		}	
		
		protected function addsubCommands(commandClass:Class):void
		{
			subCommands.push(commandClass);
		}
		
		public final function excute(notification:INotification):void
		{
			while(subCommands.length > 0)
			{
				var commandClassRef:Class = subCommands.shift();
				var commandInstance:ICommand = new commandClassRef();
				commandInstance.excute(notification);
			}
		}
	}
}