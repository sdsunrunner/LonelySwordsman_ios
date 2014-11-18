package game.command.initApplication
{
	import flash.filesystem.File;
	
	import game.command.GameBaseAsyncCommand;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.manager.gameLevelManager.GameLevelManager;
	
	import playerData.GamePlayerDataProxy;
	import playerData.ObjPlayerInfo;
	
	/**
	 * 加载游戏背景和界面部件资源场景点缀 
	 * @author songdu.greg
	 * 
	 */	
	public class InitStageBgWidgetsResCommand extends GameBaseAsyncCommand
	{
		public function InitStageBgWidgetsResCommand()
		{
			var appDir:File = File.applicationDirectory;
			assetManager.enqueue(appDir.resolvePath(ResConst.BG_MOUNTAIN));
			assetManager.enqueue(appDir.resolvePath(ResConst.BG_MOUNTAIN_XML));
			
			assetManager.enqueue(appDir.resolvePath(ResConst.GUI_RES));
			assetManager.enqueue(appDir.resolvePath(ResConst.GUI_RES_XML));
			
			assetManager.enqueue(appDir.resolvePath(Const.SOUND_FILE_URL));
			assetManager.enqueue(appDir.resolvePath(Const.ANIMA_SOUND_CONFIG_URL));
		
			
			assetManager.loadQueue(function(ratio:Number):void
			{
				if (ratio == 1.0)
				{
					gameStart();
					excuteCompleteHandler();
				}
			});
		}
		
		private function gameStart():void
		{
			this.initSetGameLev();
			if(!GameLevelManager.instance.isNewGame())
				this.notify(CommandInteracType.SCENCE_WELCOME_INIT);
			else
				this.notify(CommandViewType.GAME_STORY_START_CG);
		}
		
		/**
		 * 初始化设置故事模式关卡 
		 * 
		 */		
		private function initSetGameLev():void
		{
			var playerInfo:ObjPlayerInfo = GamePlayerDataProxy.instance.getPlayerInfo();
			GameLevelManager.instance.gameLevIndex = playerInfo.storyModeGameLevId;
		}
	}
}