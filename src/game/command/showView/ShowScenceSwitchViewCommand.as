package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.manager.CEEngineManager;
	import game.view.scenceSwitch.ScenceSwitchMaskViewController;
	
	/**
	 * 显示场景切换视图命令 
	 * @author admin
	 * 
	 */	
	public class ShowScenceSwitchViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.scenceSwitchMaskViewController)
				uiDelegate.removePanel(uiDelegate.scenceSwitchMaskViewController,CommandViewType.SCENCE_SWITCH);
			var controller:ScenceSwitchMaskViewController = uiDelegate.scenceSwitchMaskViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.SCENCE_SWITCH);
			
			if(uiDelegate.controlViewController)
				uiDelegate.controlViewController.activeControl(false);
			
			
		}
		
		private function createController():ScenceSwitchMaskViewController
		{
			return new ScenceSwitchMaskViewController();
		}
	}
}