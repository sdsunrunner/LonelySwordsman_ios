package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.guiLayer.GuiViewController;
	
	/**
	 * 显示游戏gui视图命令 
	 * @author admin
	 * 
	 */	
	public class ShowGuiViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.guiViewController)
				uiDelegate.removePanel(uiDelegate.guiViewController,CommandViewType.GAME_GUI_VIEW);
			var controller:GuiViewController = uiDelegate.guiViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.GAME_GUI_VIEW);
			
			
			//更改背景移动模式
			if(uiDelegate.bgMountainViewController)
				uiDelegate.bgMountainViewController.updateBgMode();
		}
		
		private function createController():GuiViewController
		{
			return new GuiViewController();
		}
	}
}