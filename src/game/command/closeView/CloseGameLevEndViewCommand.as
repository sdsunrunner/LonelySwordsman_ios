package game.command.closeView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	
	/**
	 * 关闭关卡结束视图 
	 * @author admin
	 * 
	 */	
	public class CloseGameLevEndViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.controlViewController)
				uiDelegate.controlViewController.activeControl(true);				
			
			if(uiDelegate.levEndViewController)
				uiDelegate.removePanel(uiDelegate.levEndViewController,CommandViewType.GAME_LEV_END_VIEW);
		}
	}
}