package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.stageBgView.GameStageBgViewController;
	
	/**
	 * 显示舞台背景 
	 * @author songdu.greg
	 * 
	 */	
	public class ShowStageBgViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.gameStageBgViewController)
				uiDelegate.removePanel(uiDelegate.gameStageBgViewController,CommandViewType.STAGE_BG);
			var controller:GameStageBgViewController = uiDelegate.gameStageBgViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.STAGE_BG);
		}
		
		private function createController():GameStageBgViewController
		{
			return new GameStageBgViewController();
		}
	}
}