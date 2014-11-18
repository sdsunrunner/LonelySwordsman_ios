package game.command.showView
{
	import enum.ProcuctIdEnum;
	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.gameEndMenu.GameEndMenuController;
	
	import playerData.GamePlayerDataProxy;
	
	/**
	 * 显示游戏结束菜单 
	 * @author admin
	 * 
	 */	
	public class ShowGameEndMenuCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.gameEndMenuController)
				uiDelegate.removePanel(uiDelegate.gameEndMenuController,CommandViewType.GAMEEND_MENU);
			
			
			var controller:GameEndMenuController = uiDelegate.gameEndMenuController || this.createController();
			
			if(uiDelegate.controlViewController)
				uiDelegate.controlViewController.activeControl(false);
			if(gameLevManager.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_BOSS ||
				gameLevManager.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_MONSTER)
			{
				controller.showResult(note.data as Boolean);
			}
			else if(gameLevManager.currentGameModel == GameModeEnum.TYPE_SURVIVAL_MODEL)
			{
				controller.showSurverModeResult();
				GamePlayerDataProxy.instance.saveGamelLevInfo();
			}
			
			this.createAndAddPanel(controller, CommandViewType.GAMEEND_MENU);
			
			if(gameLevManager.currentGameModel == GameModeEnum.TYPE_STORY_MODEL)
			{
				GamePlayerDataProxy.instance.saveGamelLevInfo();
			}
		}
		
		private function createController():GameEndMenuController
		{
			return new GameEndMenuController();
		}
	}
}