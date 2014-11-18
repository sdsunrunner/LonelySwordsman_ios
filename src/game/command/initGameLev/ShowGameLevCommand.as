package game.command.initGameLev
{
	import frame.command.BaseAsynCommand;
	import frame.command.cmdInterface.INotification;
	
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.view.models.HeroStatusModel;
	
	/**
	 * 显示游戏视图 
	 * @author admin
	 * 
	 */	
	public class ShowGameLevCommand extends BaseAsynCommand
	{
		override public function excute(note:INotification):void
		{
			//显示控制视图
			this.notify(CommandViewType.CONTROLLE_VIEW);
			
			//显示GUI视图
			this.notify(CommandViewType.GAME_GUI_VIEW);
			
			//显示关卡视图
			this.notify(CommandViewType.SHOW_GAME_LEVEL_VIEW);
			
			if(HeroStatusModel.instance.heroCurrentHp == 0)
				this.notify(CommandInteracType.GAME_END_HERO_REBORN);
		}
	}
}