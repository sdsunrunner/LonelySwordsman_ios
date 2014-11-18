package frame.command
{
	import frame.command.cmdInterface.ICommand;
	import frame.command.cmdInterface.INotification;

	/**
	 * 异步宏命令基类 
	 * @author songdu.greg
	 * 
	 */	
	
	public class BaseMacroAsynCommand implements ICommand
	{
		private var subAsynCommands:Array = null;
//==============================================================================
// Public Functions
//==============================================================================
		public function BaseMacroAsynCommand()
		{
			subAsynCommands = [];
		}
		
		public final function excute(note:INotification):void
		{
			
		}
		
		protected function addsubAsynCommands(asynCommand:Class):void
		{
			subAsynCommands.push(asynCommand);
		}	
		
		public function next():void
		{
			if(subAsynCommands.length > 0)
			{
				var classRef:Class = subAsynCommands[0];
				var command:BaseAsynCommand = new classRef();
				
				command.initAsync(this);
				command.excute(null);
			}
			subAsynCommands.shift();
		}
		
		public final function start(note:INotification):void
		{
			var classRef:Class = subAsynCommands[0];
			var command:BaseAsynCommand = new classRef();
			command.initAsync(this);
			command.excute(null);
			subAsynCommands.shift();
		}
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	}
}