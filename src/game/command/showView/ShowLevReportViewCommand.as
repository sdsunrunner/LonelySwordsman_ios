package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.levReport.LevReportViewController;
	
	/**
	 * 显示关卡结算视图 
	 * @author admin
	 * 
	 */	
	public class ShowLevReportViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.controlViewController)
				uiDelegate.controlViewController.activeControl(false);	
			
			if(uiDelegate.levReportViewController)
				uiDelegate.removePanel(uiDelegate.levReportViewController,CommandViewType.LEV_REPORT_VIEW);
			var controller:LevReportViewController = uiDelegate.levReportViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.LEV_REPORT_VIEW);
		}
		
		private function createController():LevReportViewController
		{
			return new LevReportViewController();
		}
	}
}