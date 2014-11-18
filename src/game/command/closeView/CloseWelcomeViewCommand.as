package game.command.closeView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	
	/**
	 * 关闭欢迎场景 
	 * @author songdu.greg
	 * 
	 */	
	public class CloseWelcomeViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.welcomeSenceViewController)
				uiDelegate.removePanel(uiDelegate.welcomeSenceViewController,CommandViewType.WELCOME_SCENCE);
			
			
		}
	}
}