package utils.configs
{
	import flash.utils.Dictionary;
	
	import game.manager.dicManager.DicConfigUtility;
	
	import vo.configInfo.ObjSoundFileConfig;

	/**
	 * 声音文件配置信息解析工具 
	 * @author songdu
	 * 
	 */	
	public class DicSoundConfigUtil
	{
		private static var _dic:Dictionary;
		private static var _welScenceBgSound:ObjSoundFileConfig = null;
		private static var _startSound:ObjSoundFileConfig = null;
		private static var _bossDiaSound:ObjSoundFileConfig = null;
		private static var _bossDiaExpSound:ObjSoundFileConfig = null;
		private static var _preLoadFile:Vector.<ObjSoundFileConfig> = null;
		/**
		 * 由动作名称获取动作音效配置 
		 * @param animaName
		 * @return 
		 * 
		 */		
		public static function getConfigByAnimaName(soundId:Number):ObjSoundFileConfig
		{
			if(_dic == null)
				parse();
			return _dic[soundId];
		}
		
		/**
		 * 获取欢迎场景的音效配置 
		 * @return 
		 * 
		 */		
		public static function getWelcomeBgSoundConfig():ObjSoundFileConfig
		{
			if(_dic == null)
				parse();
			return _welScenceBgSound;
		}
		
		public static function geStartSoundConfig():ObjSoundFileConfig
		{
			if(_dic == null)
				parse();
			return _startSound;
		}
		
		public static function geBossDiaSoundConfig():ObjSoundFileConfig
		{
			if(_dic == null)
				parse();
			return _bossDiaSound;
		}
		
		public static function geBossDiaExpSoundConfig():ObjSoundFileConfig
		{
			if(_dic == null)
				parse();
			return _bossDiaExpSound;
		}
		
		/**
		 * 获取场景音效文件配置 
		 * @param soundId
		 * @return 
		 * 
		 */		
		public static function getScenceBgSoundConfigInfoById(soundId:Number):ObjSoundFileConfig
		{
			if(_dic == null)
				parse();
			
			return 	_dic[soundId];
		}
		/**
		 * 获取预加载音效列表 
		 * @return 
		 * 
		 */		
		public static function getPreLoadFile():Vector.<ObjSoundFileConfig>
		{
			if(null == _preLoadFile)
				parse();
			return _preLoadFile;
		}
		
		private static function parse():void
		{
			var xml:XML = DicConfigUtility.getSoundConfig();
			
			_dic = new Dictionary;
			_preLoadFile = new  Vector.<ObjSoundFileConfig>();
			for each (var xmlNode:XML in xml.Node)
			{
				var info:ObjSoundFileConfig = new ObjSoundFileConfig();
				info.soundId = xmlNode.@id;
				info.fileName = xmlNode.@file_name;
				info.loadType = xmlNode.@load_type;
				_dic[info.soundId] = info;
				if(info.loadType == "pre_load")
					_preLoadFile.push(info);
				if(info.loadType == "welcome_scence")
					_welScenceBgSound = info;
				
				if(info.loadType == "start_cg")
					_startSound = info;
				if(info.loadType == "boss_dia_cg")
					_bossDiaSound = info;
				if(info.loadType == "boss_dia_cg_exp")
					_bossDiaExpSound = info;
			}
		}
		
	}
}