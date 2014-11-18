package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.controlView.ControlViewController;
	
	/**
	 * 显示控制视图命令 
	 * @author songdu
	 * 
	 */	
	public class ShowControlleViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.controlViewController)
				uiDelegate.removePanel(uiDelegate.controlViewController,CommandViewType.CONTROLLE_VIEW);
			var controller:ControlViewController = uiDelegate.controlViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.CONTROLLE_VIEW);
		}
		
		private function createController():ControlViewController
		{
			return new ControlViewController();
		}
	}
}