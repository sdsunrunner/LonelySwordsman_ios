package game.command.initGameLev
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.view.bgView.mountainView.BgMountainViewController;
	import game.view.superView.model.BaseCycleViewMoveDataModel;
	import game.view.superView.model.BaseCycleViewMoveTypeEnum;
	import game.view.welcomeScence.WelcomeSenceViewController;
	
	/**
	 * 清理欢迎场景命令 
	 * @author songdu.greg
	 * 
	 */	
	public class WelcomeScenceClearCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			BaseCycleViewMoveDataModel.instance.moveType 
				= BaseCycleViewMoveTypeEnum.GAME_SCENCE_MOVE;
			
			//暂停并清理欢迎视图
			var controller:WelcomeSenceViewController = uiDelegate.welcomeSenceViewController;
			if(controller)
				controller.smothHideView();
			var bgController:BgMountainViewController = uiDelegate.bgMountainViewController;
			if(bgController)
				bgController.smothResetView();
			
			if(!Const.gameInitEd)
				this.notify(CommandInteracType.INIT_GAME_ANSY);
			else
				this.notify(CommandViewType.SHOW_GAME_LEVEL_VIEW_SCENCE);
		}
	}
}