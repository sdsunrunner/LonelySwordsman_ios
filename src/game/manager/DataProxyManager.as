package game.manager
{
	import flash.utils.Dictionary;

	/**
	 * 数据代理管理器 
	 * @author songdu.greg
	 * 
	 */	
	public class DataProxyManager
	{
		
		private static var _instance:DataProxyManager = null;
		
		private var _dataProxyDic:Dictionary = null;
		
		public function DataProxyManager(code:$)
		{
			_dataProxyDic = new Dictionary();
		}
		
		public static function get instance():DataProxyManager
		{
			return _instance ||= new DataProxyManager(new $);
		}
		
		public function addDataProxy(proxyName:String, instance:Object):void
		{
			_dataProxyDic[proxyName] = instance;
		}
		
		public function getDataProxy(proxyName:String):Object
		{
			return _dataProxyDic[proxyName];
		}
		
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	}
}
class ${}