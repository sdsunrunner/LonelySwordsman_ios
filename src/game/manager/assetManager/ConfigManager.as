package game.manager.assetManager
{
	import flash.utils.Dictionary;

	/**
	 * 配置管理器 
	 * @author songdu.greg
	 * 
	 */	
	public class ConfigManager 
	{
		private static var _instance:ConfigManager = null;
		
		private var _configDic:Dictionary = null;
		
		public function ConfigManager(code:$)
		{
			_configDic = new Dictionary();
		}
		
		public static function get instance():ConfigManager
		{
			return _instance ||= new ConfigManager(new $);
		}
		
		/**
		 * 添加一个配置xml 
		 * @param configName
		 * @param xml
		 * 
		 */		
		public function addConfig(configName:String, xml:XML):void
		{
			_configDic[configName] = xml;
		}
		
		/**
		 * 由名字获取配置xml 
		 * @param configName
		 * @return 
		 * 
		 */		
		public  function getXmlByName(configName:String):XML
		{
			return _configDic[configName];
		}
		
	}
}

class ${}