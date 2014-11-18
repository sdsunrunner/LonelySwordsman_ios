package game.command.share
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	
	import utils.console.errorCh;
	
	/**
	 * 分享到微博命令 
	 * @author admin
	 * 
	 */	
	public class ShareToWeiBoCommand extends GameBaseCommand
	{
	
		private var  _imageName:String = "game_share.png";
		override public function excute(note:INotification):void
		{
			try
			{
//				var weibo:WeiBo = sharePlatformManager.weibo;
//				if(!sharePlatformManager.isWeiBoLogin)
//				{
//					AneSDK.addCodelistener(WeiBo.EVENT_SINAWEIBODIDLOGIN,onLogin);
//					weibo.login();			
//				}
//				var file:File = File.applicationDirectory;
//				var imagePath:String = file.resolvePath("shareImage/"+_imageName).nativePath;
//				weibo.share("孤影剑客",imagePath);
			}
			catch(error:Error)
			{
				errorCh("分享到微博失败",error.getStackTrace());
			}
		}
		
		private function onLogin(data:String):void
		{
			sharePlatformManager.isWeiBoLogin = true;
		}
	}
}