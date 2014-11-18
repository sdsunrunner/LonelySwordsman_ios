package game.command.gameMenu
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	
	/**
	 * 游戏结束显示主菜单场景 
	 * @author admin
	 * 
	 */	
	public class GameEndShowMainMenuScenceCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{			
			this.notify(CommandViewType.SHOW_MAIN_MENU_SCENCE);
			
		}
	}
}