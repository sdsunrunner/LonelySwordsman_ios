package game.command.store.buySuccess
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	
	import playerData.GamePlayerDataProxy;
	
	import utils.console.infoCh;
	
	/**
	 * 购买对决模式英雄成功 O
	 * @author admin
	 * 
	 */	
	public class BuyBossSuccessCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			infoCh("buy success handler","BuyBossSuccessCommand");
//			ProtoDataInfoModel.instance.isHeroLock = true;
			GamePlayerDataProxy.instance.saveGamelLevInfo();
			if(uiDelegate.welcomeSenceViewController)
				uiDelegate.welcomeSenceViewController.buyBossSuccess();
			
		}
	}
}