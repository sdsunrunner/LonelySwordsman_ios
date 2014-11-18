package game.command.closeView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	
	/**
	 * 删除场景遮挡视图 
	 * @author admin
	 * 
	 */	
	public class CloseScenceSwitchViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.scenceSwitchMaskViewController)
				uiDelegate.scenceSwitchMaskViewController.fadeOut();			
			
			if(uiDelegate.controlViewController&&!gameLevManager.isCgLev)
				uiDelegate.controlViewController.activeControl(true);
		}
	}
}