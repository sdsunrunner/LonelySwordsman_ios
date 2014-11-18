package game.command.gameLev
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.guiLayer.enemyInfo.EnemyGuiInfoDataModel;
	
	/**
	 * 关卡重置 
	 * @author admin
	 * 
	 */	
	public class GameLevResetCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			EnemyGuiInfoDataModel.instance.resetEnemyInfo();
			this.notify(CommandViewType.SHOW_GAME_LEVEL_VIEW_SCENCE);
		}
	}
}