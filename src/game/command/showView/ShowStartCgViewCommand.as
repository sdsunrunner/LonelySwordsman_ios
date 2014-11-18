package game.command.showView
{
	import flash.filesystem.File;
	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.interactionType.CommandViewType;
	import game.view.gameStartCg.StartCgViewController;
	
	import utils.AssetUtils;
	
	/**
	 * 显示游戏开场cg 
	 * @author admin
	 * 
	 */	
	public class ShowStartCgViewCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			gameLevManager.resetGameLev();			
			
			var appDir:File = File.applicationDirectory;
			var textureUrl:String = ResConst.START_CG_RES;
			if(!assetManager.getTextureAtlas(AssetUtils.getAssetNameByUrl(textureUrl)))
			{
				assetManager.enqueue(appDir.resolvePath(ResConst.START_CG_RES));
				assetManager.enqueue(appDir.resolvePath(ResConst.START_CG_RES_XML));
				
				assetManager.loadQueue(function(ratio:Number):void
				{
					if (ratio == 1.0)
					{
						showStartCg();
					}
				});	
			}
			else
				showStartCg();
		}
		
		private function showStartCg():void
		{
			if(uiDelegate.startCgViewController)
				uiDelegate.removePanel(uiDelegate.startCgViewController,CommandViewType.GAME_STORY_START_CG);
			var controller:StartCgViewController = uiDelegate.startCgViewController || this.createController();
			
			this.createAndAddPanel(controller, CommandViewType.GAME_STORY_START_CG);
		}
		
		private function createController():StartCgViewController
		{
			return new StartCgViewController();
		}
	}
}