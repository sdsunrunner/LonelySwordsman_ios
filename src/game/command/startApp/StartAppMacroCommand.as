package game.command.startApp
{
	import frame.command.MacroCommand;
	
	public class StartAppMacroCommand extends MacroCommand
	{
		public function StartAppMacroCommand()
		{
			super();
			//注册命令
			this.addsubCommands(StartApplicationCommand);		
			
		}
	}
}