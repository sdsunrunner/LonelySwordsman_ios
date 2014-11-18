package game.command.gameLev
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.manager.gameLevelManager.GameLevelManager;
	import game.view.guiLayer.enemyInfo.EnemyGuiInfoDataModel;
	
	import playerData.GamePlayerDataProxy;
	import playerData.ObjPlayerInfo;
	
	/**
	 * 开始新游戏命令 
	 * @author admin
	 * 
	 */	
	public class StartNewGameCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{			
			this.notify(CommandViewType.EMPTY_BG);		
			GamePlayerDataProxy.instance.newGameReadData();
			GamePlayerDataProxy.instance.savePlayerLevInfo()
			EnemyGuiInfoDataModel.instance.resetEnemyInfo();
			this.initSetGameLev();
			
			this.notify(CommandViewType.GAME_STORY_START_CG);
		}
		
		/**
		 * 初始化设置故事模式关卡 
		 * 
		 */		
		private function initSetGameLev():void
		{
			var playerInfo:ObjPlayerInfo = GamePlayerDataProxy.instance.getPlayerInfo();
			GameLevelManager.instance.gameLevIndex = playerInfo.storyModeGameLevId;
		}
	}
}