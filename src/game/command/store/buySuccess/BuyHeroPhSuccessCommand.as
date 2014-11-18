package game.command.store.buySuccess
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.models.HeroStatusModel;
	
	import playerData.GamePlayerDataProxy;
	
	import utils.console.infoCh;
	
	/**
	 * 购买英雄复活成功处理命令 
	 * @author admin
	 * 
	 */	
	public class BuyHeroPhSuccessCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			infoCh("buy success handler","BuyHeroPhSuccessCommand");
			HeroStatusModel.instance.heroLifeCount = 3;
			HeroStatusModel.instance.setHeroStatusFull();
			GamePlayerDataProxy.instance.saveGamelLevInfo();
			
			if(uiDelegate.gameLevViewController)
			{
				this.notify(CommandViewType.GAME_LEVEL_RESET);
				this.notify(CommandViewType.CLOSE_STORE_VIEW);				
			}
			if(uiDelegate.gameEndMenuController)
				uiDelegate.removePanel(uiDelegate.gameEndMenuController,CommandViewType.GAMEEND_MENU);
		}
	}
}