package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	
	/**
	 * 显示空背景 
	 * @author admin
	 * 
	 */	
	public class ShowEmptyViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.bgMountainViewController)
				uiDelegate.removePanel(uiDelegate.bgMountainViewController,CommandViewType.BG_MOUNTAIN_VIEW);
			
			if(uiDelegate.bgPillarViewController)
				uiDelegate.removePanel(uiDelegate.bgPillarViewController,CommandViewType.BG_PILLAR_VIEW);
		}
	}
}