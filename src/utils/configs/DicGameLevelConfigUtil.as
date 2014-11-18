package utils.configs
{
	import flash.utils.Dictionary;
	
	import game.manager.dicManager.DicConfigUtility;
	
	import vo.configInfo.ObjGameLevelConfigInfo;

	/**
	 * 关卡数据转换器 
	 * @author songdu
	 * 
	 */	
	public class DicGameLevelConfigUtil
	{
		private static var _dic:Dictionary;
		
		/**
		 * 由关卡id获取配置信息 
		 * @param scenceId
		 * @return 
		 * 
		 */		
		public static function getGameLevConfigById(levId:String):ObjGameLevelConfigInfo
		{
			if(_dic == null)
				parse();
			return _dic[levId];
		}
		
		private static function parse():void
		{
			var xml:XML = DicConfigUtility.getDicScenceConfig();
			
			_dic = new Dictionary;
			for each (var xmlNode:XML in xml.Node)
			{
				var info:ObjGameLevelConfigInfo = new ObjGameLevelConfigInfo();
				info.levId = xmlNode.@lev_id;
				info.levMapName = xmlNode.@lev_map;
				info.closeShotViewClassName = xmlNode.@close_shot_view;
				info.mapOrnamentView = xmlNode.@map_ornament_view;
				info.changeBgMsg = xmlNode.@change_bg_msg;				
				info.scenceSoundId = xmlNode.@bg_sound_id;	
				info.scenceResCollection = String(xmlNode.@texture_res).split(",");	
				info.showCgCmdType = xmlNode.@show_cg_type;	
				_dic[info.levId] = info;
			}
		}

	}
}