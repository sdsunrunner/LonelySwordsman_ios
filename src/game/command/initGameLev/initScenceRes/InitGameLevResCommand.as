package game.command.initGameLev.initScenceRes
{
	import flash.filesystem.File;
	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseAsyncCommand;
	
	/**
	 * 加载关卡资源
	 * @author songdu.greg
	 * 
	 */	
	public class InitGameLevResCommand extends GameBaseAsyncCommand
	{
		override public function excute(note:INotification):void
		{
			var appDir:File =  File.applicationDirectory;
				
			assetManager.enqueue(appDir.resolvePath(ResConst.MAP_RES));
			assetManager.enqueue(appDir.resolvePath(ResConst.MAP_RES_XML));
			
			assetManager.enqueue(appDir.resolvePath(ResConst.SCENCE_SHUMU_RES));
			assetManager.enqueue(appDir.resolvePath(ResConst.SCENCE_SHUMU_RES_XML));
			
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