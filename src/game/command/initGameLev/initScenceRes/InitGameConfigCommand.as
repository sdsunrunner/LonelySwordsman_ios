package game.command.initGameLev.initScenceRes
{
	import flash.filesystem.File;
	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseAsyncCommand;
	
	/**
	 * 初始化游戏配置 
	 * @author songdu.greg
	 * 
	 */	
	public class InitGameConfigCommand extends GameBaseAsyncCommand
	{
		override public function excute(note:INotification):void
		{
			var appDir:File = File.applicationDirectory;
			assetManager.enqueue(appDir.resolvePath(Const.GAME_LEVEL_CONFIG_URL));
			assetManager.enqueue(appDir.resolvePath(Const.GAME_SCENCE_INTERAC_CONFIG_URL));
			assetManager.enqueue(appDir.resolvePath(Const.ROLE_CONFIG_URL));
			assetManager.enqueue(appDir.resolvePath(Const.ROLE_ATTACK_MOVE_CONFIG_URL));
			assetManager.enqueue(appDir.resolvePath(Const.FIANL_BOSS_AI));
			
			
			assetManager.loadQueue(function(ratio:Number):void
			{
				if (ratio == 1.0)
				{
					excuteCompleteHandler();
				}
			});
		}
	}
}