package game.manager.dicManager
{
	import game.manager.assetManager.GameAssetManager;
	
	import utils.AssetUtils;

	/**
	 * 字典配置管理器 
	 * @author songdu
	 * 
	 */	
	public class DicConfigUtility
	{
		
		private static var _assetManager:GameAssetManager = null;
		private static var _scenceConfigXML:XML = null; // 场景配置
		private static var _roleConfigXML:XML = null; // 角色配置
		private static var _roleAttackConfigXML:XML = null; // 角色攻击配置
		private static var _scenceInteracConfigXML:XML = null; // 场景交互配置
		private static var _animaSoundConfigXML:XML = null; //动画音效配置
		private static var _soundConfigXML:XML = null; //音效配置		
		private static var _finalBossAiConfigXML:XML = null; //最终bossai
		
		/**
		 * 获取技能字典表内容
		 */
		public static function getDicScenceConfig():XML
		{
			if (_scenceConfigXML == null)
				_scenceConfigXML = getXmlByUlr(Const.GAME_LEVEL_CONFIG_URL);
			return _scenceConfigXML;
		}
		
		/**
		 * 获取场景交互配置 
		 * @return 
		 * 
		 */		
		public static function getDicScenceInteracConfig():XML
		{
			if (_scenceInteracConfigXML == null)
				_scenceInteracConfigXML = getXmlByUlr(Const.GAME_SCENCE_INTERAC_CONFIG_URL);
			return _scenceInteracConfigXML;
		}
		/**
		 * 获取角色配置xml 
		 * @return 
		 * 
		 */		
		public static function getGameRoleConfig():XML
		{
			if (_roleConfigXML == null)
				_roleConfigXML = getXmlByUlr(Const.ROLE_CONFIG_URL);
			return _roleConfigXML;
		}
		
		/**
		 * 获取角色攻击配置xml
		 * @return 
		 * 
		 */		
		public static function getGameRoleAttackConfig():XML
		{
			if (_roleAttackConfigXML == null)
				_roleAttackConfigXML = getXmlByUlr(Const.ROLE_ATTACK_MOVE_CONFIG_URL);
			return _roleAttackConfigXML;
		}
		
		/**
		 * 获取动画音效配置文件 
		 * @return 
		 * 
		 */		
		public static function getAnimaSoundConfig():XML
		{
			if (_animaSoundConfigXML == null)
				_animaSoundConfigXML = getXmlByUlr(Const.ANIMA_SOUND_CONFIG_URL);
			return _animaSoundConfigXML;
		}
		
		/**
		 * 获取音效配置文件 
		 * @return 
		 * 
		 */		
		public static function getSoundConfig():XML
		{
			if (_soundConfigXML == null)
				_soundConfigXML = getXmlByUlr(Const.SOUND_FILE_URL);
			return _soundConfigXML;
		}
		
		/**
		 * 获取最终bossai 
		 * @return 
		 * 
		 */		
		public static function getFinalBossAiConfig():XML
		{
			if (_finalBossAiConfigXML == null)
				_finalBossAiConfigXML = getXmlByUlr(Const.FIANL_BOSS_AI);
			return _finalBossAiConfigXML;
		}
		
		
		/**
		 * 获取关卡地图xml 
		 * @param xmlUrl
		 * @return 
		 * 
		 */		
		public static function getMapXmlByName(xmlUrl:String):XML
		{
			return getXmlByUlr(xmlUrl);
		}
		
		/**
		 * 由xml路径获取xml  
		 * @param xmlUrl
		 * @return 
		 * 
		 */		
		private static function getXmlByUlr(xmlUrl:String):XML
		{
			if(null == _assetManager)
				_assetManager = GameAssetManager.instance;
			var xmlName:String = AssetUtils.getAssetNameByUrl(xmlUrl);
			return _assetManager.getOther(xmlName) as XML;
		}
		
	}
}