package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.dataProxy.AutoRecoverCenter;
	import game.interactionType.CommandViewType;
	import game.view.levEndView.LevEndViewController;
	
	/**
	 * 显示关卡结束视图 
	 * @author admin
	 * 
	 */	
	public class ShowGameLevEndViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			AutoRecoverCenter.instance.autoRecoverPause(true);
			if(uiDelegate.controlViewController)
				uiDelegate.controlViewController.activeControl(false);	
			
			if(uiDelegate.levEndViewController)
				uiDelegate.removePanel(uiDelegate.levEndViewController,CommandViewType.GAME_LEV_END_VIEW);
			var controller:LevEndViewController = uiDelegate.levEndViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.GAME_LEV_END_VIEW);
		}
		
		private function createController():LevEndViewController
		{
			return new LevEndViewController();
		}
	}
}