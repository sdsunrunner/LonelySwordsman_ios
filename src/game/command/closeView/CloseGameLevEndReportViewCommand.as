package game.command.closeView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	
	/**
	 * 关闭关卡结算视图 
	 * @author admin
	 * 
	 */	
	public class CloseGameLevEndReportViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.controlViewController)
				uiDelegate.controlViewController.activeControl(true);				
			
			if(uiDelegate.levReportViewController)
				uiDelegate.removePanel(uiDelegate.levReportViewController,CommandViewType.LEV_REPORT_VIEW);
		}
	}
}