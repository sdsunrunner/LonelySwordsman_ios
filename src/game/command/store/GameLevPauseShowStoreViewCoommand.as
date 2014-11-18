package game.command.store
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.manager.CEEngineManager;
	import game.view.gameScenceView.viewLayers.ScenceCeView;

	/**
	 * 游戏暂停显示商店 
	 * @author admin
	 * 
	 */	
	public class GameLevPauseShowStoreViewCoommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			//显示商店
			this.notify(CommandViewType.PRODUCT_STORE_VIEW);
			
			if(uiDelegate.controlViewController)
				uiDelegate.controlViewController.activeControl(false);
			
			if(CEEngineManager.instance.ceEngine&&CEEngineManager.instance.ceEngine.state)
				ScenceCeView(CEEngineManager.instance.ceEngine.state).pauseEnemy();			
		}
	}
}