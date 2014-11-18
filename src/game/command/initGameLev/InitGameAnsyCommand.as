package game.command.initGameLev
{
	import frame.command.BaseMacroAsynCommand;
	
	import game.command.initGameLev.initRoleRes.InitEnemyResCommand;
	import game.command.initGameLev.initRoleRes.InitHeroAnimaResCommand;
	import game.command.initGameLev.initScenceRes.InitGameLevResCommand;
	import game.command.initGameLev.initScenceRes.InitGameScenceCommand;
	
	/**
	 * 游戏场景初始化异步 命令
	 * @author songdu.greg
	 * 
	 */	
	public class InitGameAnsyCommand extends BaseMacroAsynCommand
	{
		public function InitGameAnsyCommand()
		{			
			//加载英雄动画资源
			this.addsubAsynCommands(InitGameLevResCommand);
			
			//初始化英雄会动画资源
			this.addsubAsynCommands(InitHeroAnimaResCommand);
			
			//初始化基础士兵动画资源
			this.addsubAsynCommands(InitEnemyResCommand);
			
			//初始化游戏场景
			this.addsubAsynCommands(InitGameScenceCommand);
			
			this.start(null);
		}
	}
}