package utils.configs
{
	import flash.utils.Dictionary;
	
	import game.manager.dicManager.DicConfigUtility;
	
	import vo.configInfo.ObjScenceInteracConfigInfo;

	/**
	 * 场景交互配置表 
	 * @author admin
	 * 
	 */	
	public class DicGameScenceInterConfigUtil
	{
		private static var _dic:Dictionary;
		
		public static function getGameLevConfigById(levId:String):ObjScenceInteracConfigInfo
		{
			if(_dic == null)
				parse();
			return _dic[levId];
		}
		
		private static function parse():void
		{
			var xml:XML = DicConfigUtility.getDicScenceInteracConfig();
			
			_dic = new Dictionary;
			for each (var xmlNode:XML in xml.Node)
			{
				var info:ObjScenceInteracConfigInfo = new ObjScenceInteracConfigInfo();
				info.levId = xmlNode.@lev_id;
				info.ladderMoveRange = xmlNode.@ladder_move_range;
				
				var ladderInfoStr:String = xmlNode.@ladder_param;
				if("" != ladderInfoStr)
				{
					var ladderInfo:Array = ladderInfoStr.split(",");
					info.ladderOffsetX = ladderInfo[0];
					info.ladderOffsetY = ladderInfo[1];
					info.ladderHeight = ladderInfo[2];
				}
				
				var landscapePlatformSpeedStr:String = xmlNode.@landscape_platform_speed;
				if("" != landscapePlatformSpeedStr)
					info.landscapePlatformSpeed = landscapePlatformSpeedStr.split(",");
				
				var landscapePlatformRangeStr:String = xmlNode.@landscape_platform_range;
				if("" != landscapePlatformRangeStr)
					info.landscapePlatformRange = landscapePlatformRangeStr.split(",");
				
				info.trapPlatformImageHeight = int( xmlNode.@trap_platform_img_height);
				info.trapPlatformImageWidth = int( xmlNode.@trap_platform_img_width);
				info.imageX = int(xmlNode.@imageX);
				info.imageY = int(xmlNode.@imageY);
				info.smokeAnimaX = int(xmlNode.@smokeAnimaX);
				info.smokeAnimaY = int(xmlNode.@smokeAnimaY);
				
				_dic[info.levId] = info;
			}
		}
	}
}