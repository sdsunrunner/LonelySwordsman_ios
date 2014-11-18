package game.manager
{
	import so.cuo.platform.wechat.WeChat;
	
	import utils.console.errorCh;

	/**
	 * 分享平台管理器 
	 * @author admin
	 * 
	 */	
	public class SharePlatformManager
	{
		private static var _instance:SharePlatformManager = null;
		
//		private var _weibo:WeiBo = null;
		private var _weiXin:WeChat = null;
		private var _isWeiBoLogin:Boolean = false;
		
		public function SharePlatformManager(code:InnerClass)
		{
			initWeiBo();
			initWeiXin();
		}
		
		public function get weiXin():WeChat
		{
			return _weiXin;
		}

		public function get isWeiBoLogin():Boolean
		{
			return _isWeiBoLogin;
		}

		public function set isWeiBoLogin(value:Boolean):void
		{
			_isWeiBoLogin = value;
		}

//		public function get weibo():WeiBo
//		{
//			return _weibo;
//		}

		public static function get instance():SharePlatformManager
		{
			return _instance ||= new SharePlatformManager(new InnerClass);
		}
		
		private function initWeiBo():void
		{
			try
			{
//				_weibo = new WeiBo();			
//				_weibo.initWeiBo(Const.WEI_BO_APP_KEY,Const.WEI_BO_APP_SECRET);
			}
			catch(error:Error)
			{
				errorCh("微博初始化失败",error.getStackTrace());	
			}
		}
		
		private function initWeiXin():void
		{
			try
			{
				_weiXin = WeChat.getInstance();
				if(!_weiXin.supportDevice)
				{
					errorCh("_weiXin.supportDevice",_weiXin.supportDevice);
				}
				else
				{
					_weiXin.registerApp(Const.WEI_XIN_APP_ID);
				}
			}
			catch(error:Error)
			{
				errorCh("微信初始化失败",error.getStackTrace());		
			}
		}
	}
}

class InnerClass{}