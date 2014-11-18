package game.command
{
	import frame.command.cmdInterface.INotification;
	
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	
	import playerData.GamePlayerDataProxy;

	/**
	 * 游戏结束处理 
	 * @author admin
	 * 
	 */	
	public class GameEndHandlerCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			while(Const.collideLayer.numChildren)
			{
				Const.collideLayer.removeChildAt(0);
			}
		
			GamePlayerDataProxy.instance.saveGamelLevInfo();
			GamePlayerDataProxy.instance.newGameReadData();
			
			gameLevManager.resetGameLev();
			if(uiDelegate.storyCgViewController)
				uiDelegate.removePanel(uiDelegate.storyCgViewController,CommandViewType.GAME_STORY_CG);
			this.notify(CommandInteracType.GAME_END_SHOW_MAIN_MENU_SCENCE);
			
		}
	}
}