package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.view.superView.model.BaseCycleViewMoveDataModel;
	import game.view.superView.model.BaseCycleViewMoveTypeEnum;
	import game.view.welcomeScence.WelcomeSenceViewController;
	
	/**
	 * 显示欢迎视图 
	 * @author songdu.greg
	 * 
	 */	
	public class ShowWelcomeViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			while(Const.collideLayer.numChildren>0)
			{
				Const.collideLayer.removeChildAt(0);
			}
			
			
			BaseCycleViewMoveDataModel.instance.moveType 
				= BaseCycleViewMoveTypeEnum.WELCOME_SCENCE_MOVE;
			
			if(uiDelegate.welcomeSenceViewController)
				uiDelegate.removePanel(uiDelegate.welcomeSenceViewController,CommandViewType.WELCOME_SCENCE);
			var controller:WelcomeSenceViewController = uiDelegate.welcomeSenceViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.WELCOME_SCENCE);  
			this.notify(CommandInteracType.PRE_BUILD_SOUND);
		}
		
		private function createController():WelcomeSenceViewController
		{
			return new WelcomeSenceViewController();
		}
	}
}