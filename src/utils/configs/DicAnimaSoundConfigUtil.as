package utils.configs
{
	import flash.utils.Dictionary;
	
	import game.manager.dicManager.DicConfigUtility;
	
	import vo.configInfo.ObjAnimaSoundConfig;

	/**
	 * 动画音效配置 
	 * @author songdu
	 * 
	 */	
	public class DicAnimaSoundConfigUtil
	{
		private static var _dic:Dictionary;
		
		/**
		 * 由动作名称获取动作音效配置 
		 * @param animaName
		 * @return 
		 * 
		 */		
		public static function getConfigByAnimaName(animaName:String,frame:Number):ObjAnimaSoundConfig
		{
			if(_dic == null)
				parse();
			return _dic[animaName+"_"+frame];
		}
		
		private static function parse():void
		{
			var xml:XML = DicConfigUtility.getAnimaSoundConfig();
			
			_dic = new Dictionary;
			for each (var xmlNode:XML in xml.Node)
			{
				var info:ObjAnimaSoundConfig = new ObjAnimaSoundConfig();
				info.animaName = xmlNode.@anima_name;
				info.startFrame =[];
				
				var startFrameInfoArr:Array = String(xmlNode.@start_frame).split(",");
				
				for(var i:Number = 0; i< startFrameInfoArr.length; i++)
				{
					info.startFrame.push(int(startFrameInfoArr[i]));
				}
				
				info.soundId = xmlNode.@sounds_id;				
				_dic[info.animaName + "_" +startFrameInfoArr[0]] = info;
				_dic[info.animaName + "_" +startFrameInfoArr[1]] = info;
				_dic[info.animaName + "_" +startFrameInfoArr[2]] = info;
			}
		}
	}
}