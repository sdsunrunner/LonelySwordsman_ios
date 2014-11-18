package game.command.gameMenu
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.guiLayer.enemyInfo.EnemyGuiInfoDataModel;
	import game.view.models.HeroStatusModel;
	
	import playerData.GamePlayerDataProxy;
	
	/**
	 * 游戏结束重玩关卡 
	 * @author admin
	 * 
	 */	
	public class GameEndHeroRebornCommand extends GameBaseCommand
	{
		private var _herotstatus:HeroStatusModel = null;
		
		override public function excute(note:INotification):void
		{
			_herotstatus = HeroStatusModel.instance;
			
			if(uiDelegate.controlViewController)
				uiDelegate.controlViewController.activeControl(true);			
			
			if(_herotstatus.heroLifeCount>0 
				|| gameLevManager.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_BOSS 
				||gameLevManager.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_MONSTER
				||gameLevManager.currentGameModel == GameModeEnum.TYPE_SURVIVAL_MODEL)
			{
				if(uiDelegate.gameEndMenuController)
					uiDelegate.removePanel(uiDelegate.gameEndMenuController,CommandViewType.GAMEEND_MENU);
				
				_herotstatus.heroReborn();
				_herotstatus.setHeroStatusFull();
				_herotstatus.gameEndResetGameLev();
				EnemyGuiInfoDataModel.instance.resetEnemyInfo();
				
				if(gameLevManager.isStoryMode)
					GamePlayerDataProxy.instance.saveGamelLevInfo();
				this.notify(CommandViewType.GAME_LEVEL_RESET);		
			}
			else
				this.notify(CommandInteracType.GAME_PAUSE_SHOW_STORE);
		}
	}
}