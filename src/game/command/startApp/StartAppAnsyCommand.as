package game.command.startApp
{
	import frame.command.BaseMacroAsynCommand;
	
	import game.command.initApplication.InitInterfaceCommand;
	import game.command.initApplication.InitStageBgWidgetsResCommand;
	import game.command.initGameLev.initScenceRes.InitGameConfigCommand;
	
	/**
	 * 启动异步命令 
	 * @author songdu.greg
	 * 
	 */	
	public class StartAppAnsyCommand extends BaseMacroAsynCommand
	{
		public function StartAppAnsyCommand()
		{			
			////加载游戏配置
			this.addsubAsynCommands (InitGameConfigCommand);
			
			//加载游戏背景和界面部件资源 
			this.addsubAsynCommands(InitStageBgWidgetsResCommand);
		
			//注册数据代理
			this.addsubAsynCommands(InitInterfaceCommand);		
			
			this.start(null);
		}
	}
}