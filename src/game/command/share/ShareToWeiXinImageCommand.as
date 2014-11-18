package game.command.share
{
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	
	import so.cuo.platform.wechat.WeChat;
	
	import utils.console.errorCh;
	
	/**
	 * 分享 
	 * @author admin
	 * 
	 */	
	public class ShareToWeiXinImageCommand extends GameBaseCommand
	{
		private var  _imageName:String = "game_share.png";
		private var _weixin:WeChat = sharePlatformManager.weiXin;
		
		private var _file:File = null;
		private var _imagePath:String = "";
		private var _msg:String = "";
		override public function excute(note:INotification):void
		{	

			_msg = note.data as String;
//			behaviorAnalyseManager.umeng.dispatchEventWithParams("shareToWeiXinClick","type=" + note.data);
			
			_file = File.applicationDirectory;
			_imagePath = _file.resolvePath("shareImage/"+_imageName).nativePath;
				
			try
			{
				errorCh("微信是否安装：",_weixin.isWXAppInstalled());
				if(_weixin.isWXAppInstalled())
				{
					var openResult:Boolean = _weixin.openWXApp();
					if(openResult)
					{
						this.shareLinkImage()
					}
				}
				else
				{
					var installeUrl:String = _weixin.getWXAppInstallUrl();
					var newURL:URLRequest = new URLRequest(installeUrl);
					var fangshi:String="_blank";
					navigateToURL(newURL,fangshi);
				}
				
			}
			catch(error:Error)
			{
				errorCh("分享到微信错误", error.getStackTrace());
				trace("分享到微信错误");
			}			
		}
		
		private function shareLinkImage():void
		{
			
			_weixin.sendLinkMessage(_imagePath,"https://itunes.apple.com/us/app/gu-ying-jian-ke/id726049617?ls=1&mt=8","孤影剑客","孤影剑客 "+_msg,1);
		}
	}
}