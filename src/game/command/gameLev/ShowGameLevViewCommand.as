package game.command.gameLev
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.bgView.mountainView.BgMountainViewController;
	
	/**
	 * 显示游戏关卡命令 
	 * @author songdu
	 * 
	 */	
	public class ShowGameLevViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
            this.setGameLevMountainPos();
			this.showCurrentGameLev();
		}
		
		private function setGameLevMountainPos():void
		{
			var controller:BgMountainViewController = uiDelegate.bgMountainViewController;
			if(controller)
				controller.setGameLevPos();
		}
		private function showCurrentGameLev():void
		{	
			this.notify(CommandViewType.GAME_LEVEL_VIEW);
		}
	}
}