package game.command.gameLev
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.manager.gameLevelManager.GameLevelManager;
	import game.manager.gameLevelManager.GameModeEnum;
	
	/**
	 * 开始新游戏，cg结束 
	 * @author admin
	 * 
	 */	
	public class StartNewGameCgEndCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			GameLevelManager.instance.isStartNewGame = false;
			GameLevelManager.instance.currentGameModel = GameModeEnum.TYPE_STORY_MODEL;
			if(uiDelegate.storyCgViewController)
				uiDelegate.removePanel(uiDelegate.storyCgViewController,CommandViewType.GAME_STORY_CG);
			//显示背景山脉
			this.notify(CommandViewType.BG_MOUNTAIN_VIEW);
			
			this.notify(CommandInteracType.CLEAR_WELCOME_SCENCE);
		}
	}
}