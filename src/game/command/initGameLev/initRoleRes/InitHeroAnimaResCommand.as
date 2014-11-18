package game.command.initGameLev.initRoleRes
{
	import flash.filesystem.File;
	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseAsyncCommand;
	
	/**
	 * 初始化英雄动作资源 
	 * @author songdu
	 * 
	 */	
	public class InitHeroAnimaResCommand extends GameBaseAsyncCommand
	{
		override public function excute(note:INotification):void
		{
			var appDir:File = File.applicationDirectory;
			assetManager.enqueue(appDir.resolvePath(ResConst.HERO_ANIMA_RES));
			assetManager.enqueue(appDir.resolvePath(ResConst.HERO_ANIMA_RES_XML));
			
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