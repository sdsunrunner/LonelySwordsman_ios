package frame.config
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import frame.utils.load.XMLLoadUtility;

	/**
	 * 字典文件配置管理器
	 * @author songdu.greg
	 *
	 */
	public class DicConfigUtil extends EventDispatcher
	{
		private  static var _dicXml:Dictionary = null;

		private  var _dicXmlFile:Dictionary = null;
		
		private  var _xmlNum:Number = 0;
		private  var _completeCounter:Number = 0;
		
		private static var _instance:DicConfigUtil = null;
//==============================================================================
// Public Functions
//==============================================================================
		public function DicConfigUtil(code:$)
		{
			
		}
		
		public static function get instance():DicConfigUtil
		{
			return _instance ||= new DicConfigUtil(new $);
		}
		
		/**
		 * 添加xml配置文件
		 * @param name
		 * @param url
		 *
		 */
		public  function addXmlFile(url:String):void
		{
			if(null == _dicXmlFile)
				_dicXmlFile = new Dictionary(false);
			_dicXmlFile[url] = null;
			_xmlNum++;
		}
		
		/**
		 * 加载所有的xml配置文件 
		 * 
		 */		
		public  function loadConfigXml():void
		{
			for (var key:* in _dicXmlFile)
			{
				var xmlloader:XMLLoadUtility = new XMLLoadUtility();
				xmlloader.loadXMLFile(key, configXmlLoadComplete);
			}
		}

		public static function getConfigXMLByName(name:String):XML
		{
			name = name.replace("null", "");
			return _dicXml[name];
		}
		
		public function addOneLoadedXml(xmlName:String, xml:XML):void
		{
			if(null == _dicXml)
				_dicXml = new Dictionary();
			_dicXml[xmlName] = xml;
		}
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------
		private  function configXmlLoadComplete(xmlName:String, xml:XML):void
		{
			if(null == _dicXml)
				_dicXml = new Dictionary();
			
			_dicXml[xmlName] = xml;
			_completeCounter++;
			
			checkXmlLoaded();
		}
		
		private  function checkXmlLoaded():void
		{
			if(_xmlNum == _completeCounter)
			{
				_xmlNum = 0;
				_completeCounter = 0;
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	}
}

class ${}
