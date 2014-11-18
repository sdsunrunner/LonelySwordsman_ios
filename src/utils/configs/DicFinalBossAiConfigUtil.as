package utils.configs
{
	import flash.utils.Dictionary;
	
	import game.manager.dicManager.DicConfigUtility;
	
	import vo.configInfo.ObjfinalBossAiConfig;

	/**
	 * 最终bossAi配置 
	 * @author admin
	 * 
	 */	
	public class DicFinalBossAiConfigUtil
	{
		private static var _dic:Dictionary;
		
		public static function getConfigByAnimaName(bossMp:String, bossHp:String, heroHp:String):ObjfinalBossAiConfig
		{			
			if(_dic == null)
				parse();
			if(!_dic[bossMp + "_"+ bossHp +"_" + heroHp])
			{
				trace("bossMp:"+bossMp);
				trace("bossHp:"+bossHp);
				trace("heroHp:"+heroHp);
			}
				
			return _dic[bossMp + "_"+ bossHp +"_" + heroHp];
		}
		
		private static function parse():void
		{
			var xml:XML = DicConfigUtility.getFinalBossAiConfig();
			
			_dic = new Dictionary;
			for each (var xmlNode:XML in xml.Node)
			{
				var info:ObjfinalBossAiConfig = new ObjfinalBossAiConfig();
				info.configId = xmlNode.@boss_mp + "_" + xmlNode.@boss_hp + "_" + xmlNode.@hero_hp;
				
				info.avoidProba = xmlNode.@avoid;
				info.addHpMoveProba = xmlNode.@add_hp;				
				_dic[info.configId] = info;
			}
		}
	}
}