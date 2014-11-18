package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.infoAlert.AlertViewController;
	
	/**
	 * 显示信息弹出框 
	 * @author admin
	 * 
	 */	
	public class ShowAlertViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			var notyType:String = note.data as String;
			
			if(uiDelegate.alertViewController)
				uiDelegate.removePanel(uiDelegate.alertViewController,CommandViewType.INFO_ALERT_VIEW);
			var controller:AlertViewController = uiDelegate.alertViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.INFO_ALERT_VIEW);
			
			controller.setNoteType(notyType);
		}
		
		private function createController():AlertViewController
		{
			return new AlertViewController();
		}
	}
}