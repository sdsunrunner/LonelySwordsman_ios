package game.command.initGameLev.initRoleRes
{
	import flash.filesystem.File;
	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseAsyncCommand;
	
	/**
	 * 加载敌人资源命令 
	 * @author admin
	 * 
	 */	
	public class InitEnemyResCommand extends GameBaseAsyncCommand
	{
		override public function excute(note:INotification):void
		{
			var appDir:File = File.applicationDirectory;	
			assetManager.enqueue(appDir.resolvePath(ResConst.HURT_HIT_RANG_RES));
			assetManager.enqueue(appDir.resolvePath(ResConst.HURT_HIT_RANG_RES_XML));
			
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