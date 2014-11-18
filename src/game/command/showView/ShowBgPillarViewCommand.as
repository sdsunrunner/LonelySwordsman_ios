package game.command.showView
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.bgView.pillarView.BgPillarViewController;
	
	/**
	 * 显示背景柱子视图 
	 * @author admin
	 * 
	 */	
	public class ShowBgPillarViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.bgPillarViewController)
				uiDelegate.removePanel(uiDelegate.bgPillarViewController,CommandViewType.BG_PILLAR_VIEW);
			var controller:BgPillarViewController = uiDelegate.bgPillarViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.BG_PILLAR_VIEW);
		}
		
		private function createController():BgPillarViewController
		{
			return new BgPillarViewController();
		}
	}
}