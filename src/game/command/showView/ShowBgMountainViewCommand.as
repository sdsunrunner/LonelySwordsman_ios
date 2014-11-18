package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.bgView.mountainView.BgMountainViewController;

	/**
	 * 显示背景山脉视图命令 
	 * @author songdu.greg
	 * 
	 */	
	public class ShowBgMountainViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.bgMountainViewController)
				uiDelegate.removePanel(uiDelegate.bgMountainViewController,CommandViewType.BG_MOUNTAIN_VIEW);
			var controller:BgMountainViewController = uiDelegate.bgMountainViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.BG_MOUNTAIN_VIEW);
		}
		
		private function createController():BgMountainViewController
		{
			return new BgMountainViewController();
		}
	}
}