package game.command.initApplication
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	
	/**
	 * 初始场景命令 
	 * @author songdu.greg
	 * 
	 */	
	public class GameWelcomeScenceInitCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{			
			if(uiDelegate.storyCgViewController)
				uiDelegate.removePanel(uiDelegate.storyCgViewController,CommandViewType.GAME_STORY_CG);
							
			//显示背景山脉
			this.notify(CommandViewType.BG_MOUNTAIN_VIEW);
			
			//显示欢迎视图
			this.notify(CommandViewType.WELCOME_SCENCE);
		}
	}
}