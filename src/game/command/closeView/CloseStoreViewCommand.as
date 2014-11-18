package game.command.closeView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.manager.CEEngineManager;
	import game.view.gameScenceView.viewLayers.ScenceCeView;
	
	/**
	 * 关闭商店 
	 * @author admin
	 * 
	 */	
	public class CloseStoreViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.storeViewController)
				uiDelegate.removePanel(uiDelegate.storeViewController,CommandViewType.PRODUCT_STORE_VIEW);
			
//			if(uiDelegate.controlViewController)
//				uiDelegate.controlViewController.activeControl(true);
			
			if(CEEngineManager.instance.ceEngine&&CEEngineManager.instance.ceEngine.state)
				ScenceCeView(CEEngineManager.instance.ceEngine.state).resumeEnemy();
		}
	}
}