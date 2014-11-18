package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.store.StoreViewController;
	
	/**
	 * 显示商店命令 
	 * @author admin
	 * 
	 */	
	public class ShowStoreViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.storeViewController)
				uiDelegate.removePanel(uiDelegate.storeViewController,CommandViewType.PRODUCT_STORE_VIEW);
			var controller:StoreViewController = uiDelegate.storeViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.PRODUCT_STORE_VIEW);
		}
		
		private function createController():StoreViewController
		{
			return new StoreViewController();
		}
	}
}