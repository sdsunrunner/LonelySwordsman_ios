package game.model
{
	import com.lzm.anesdk.openqq.OpenQQ;
	import com.lzm.anesdk.weixin.WeiXin;

	/**
	 * 外部接口 数据模型
	 * @author admin
	 * 
	 */	
	public class InterfaceModel
	{
		private static var _instance:InterfaceModel = null;
		private var _weixinInstance:WeiXin = null;
		private var _openQQInstance:OpenQQ = null;
		public function InterfaceModel(code:InnerClass)
		{
			
		}
	

		public function get openQQInstance():OpenQQ
		{
			return _openQQInstance;
		}

		public function set openQQInstance(value:OpenQQ):void
		{
			_openQQInstance = value;
		}

		public function get weixinInstance():WeiXin
		{
			return _weixinInstance;
		}

		public function set weixinInstance(value:WeiXin):void
		{
			_weixinInstance = value;
		}

		public static function get instance():InterfaceModel
		{
			return _instance ||= new InterfaceModel(new InnerClass);
		}
		
		
	}
}

class InnerClass{}