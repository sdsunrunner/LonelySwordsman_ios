package game.command.storyCg
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.storyCg.StoryCgViewController;
	
	/**
	 * 显示故事cg 
	 * @author admin
	 * 
	 */	
	public class ShowStoryCgCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			if(uiDelegate.controlViewController)
				uiDelegate.controlViewController.activeControl(false);
			
			if(uiDelegate.guiViewController)
				uiDelegate.guiViewController.activeGui(false);
			
			var cgType:String = note.data as String;
			
			if(uiDelegate.storyCgViewController)
				uiDelegate.removePanel(uiDelegate.storyCgViewController,CommandViewType.GAME_STORY_CG);
			
			var controller:StoryCgViewController = uiDelegate.storyCgViewController || this.createController();		
			controller.showStoryCg(cgType);
			this.createAndAddPanel(controller, CommandViewType.GAME_STORY_CG);				
		}
		
		private function createController():StoryCgViewController
		{
			return new StoryCgViewController();
		}
	}
}