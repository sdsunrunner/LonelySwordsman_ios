package game.command.gameLev
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.superView.model.BaseCycleViewMoveDataModel;
	import game.view.superView.model.BaseCycleViewMoveTypeEnum;
	
	/**
	 * 显示游戏主菜单场景 
	 * @author admin
	 * 
	 */	
	public class ShowGameMainMenuScenceCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{	
			BaseCycleViewMoveDataModel.instance.moveType 
				= BaseCycleViewMoveTypeEnum.WELCOME_SCENCE_MOVE;
				
			this.notify(CommandViewType.EMPTY_BG);				
				
			if(uiDelegate.bgPillarViewController)
				uiDelegate.removePanel(uiDelegate.bgPillarViewController,CommandViewType.BG_PILLAR_VIEW);
			
			if(uiDelegate.gameLevViewController)
				uiDelegate.removePanel(uiDelegate.gameLevViewController,CommandViewType.GAME_LEVEL_VIEW);
			
			if(uiDelegate.controlViewController)
				uiDelegate.removePanel(uiDelegate.controlViewController,CommandViewType.CONTROLLE_VIEW);
			if(uiDelegate.guiViewController)
				uiDelegate.removePanel(uiDelegate.guiViewController,CommandViewType.GAME_GUI_VIEW);
			
			if(uiDelegate.gameEndMenuController)
				uiDelegate.removePanel(uiDelegate.gameEndMenuController,CommandViewType.GAMEEND_MENU);
			
			if(uiDelegate.bgMountainViewController)
				uiDelegate.bgMountainViewController.resetBgMoveModel();		
			
			if(!uiDelegate.bgMountainViewController)			
				this.notify(CommandViewType.BG_MOUNTAIN_VIEW);
			
			
			this.notify(CommandViewType.WELCOME_SCENCE);
		}
	}
}