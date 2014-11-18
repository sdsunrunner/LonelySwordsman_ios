package utils.configs
{
	import flash.utils.Dictionary;
	
	import enum.GameRoleEnum;
	
	import game.manager.dicManager.DicConfigUtility;
	
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;

	/**
	 * 游戏角色配置  
	 * @author admin
	 * 
	 */	
	public class DicGameRoleConfigUtil
	{
		private static var _roleDic:Dictionary;
	
		private static var _hurtMovedisDic:Dictionary;
		
		/**
		 * 由英雄id获取英雄配置信息
		 * @param scenceId
		 * @return 
		 * 
		 */		
		public static function getRoleConfigById(roleId:Number):ObjRoleConfigInfo
		{
			if(_roleDic == null)
				parse();
			return _roleDic[roleId];
		}
	
		/**
		 * 获取受伤移动距离 
		 * @param roleId
		 * @param frame
		 * @return 
		 * 
		 */		
		public static function getRoleHurtPos(roleId:Number, frame:Number):Number
		{
			if(_roleDic == null)
				parse();
//			if(_hurtMovedisDic[roleId + "_" + frame])				
//				return _hurtMovedisDic[roleId + "_" + frame];
			return 0;
		}
		
		/**
		 * 构建受伤移动dic 
		 * @param roleId
		 * @param hurtFrames
		 * @param hurtMovePos
		 * 
		 */		
		private static function buidhurtMovedisDic(roleId:Number, hurtFrames:String, hurtMovePos:String):void
		{
			if(null == _hurtMovedisDic)
				_hurtMovedisDic = new Dictionary();
			
			var hurtMoveframesArr:Array = hurtFrames.split(",");
			var hurtMovePosArr:Array = hurtMovePos.split(",");
			for (var i:Number = 0; i < hurtFrames.length-1; i++)			
				_hurtMovedisDic[roleId + "_" + hurtMoveframesArr[i]] = hurtMovePosArr[i];
		}
		
		
		private static function parse():void
		{
			var xml:XML = DicConfigUtility.getGameRoleConfig();
			
			_roleDic = new Dictionary();		
			_hurtMovedisDic = new Dictionary();
			
			for each (var xmlNode:XML in xml.Node)
			{
				var info:ObjRoleConfigInfo = new ObjRoleConfigInfo();
				info.roleConfigId = xmlNode.@id;
				info.roleType = GameRoleEnum.TYPE_HERO;
				info.maxVelocity =  Number(xmlNode.@max_velocity);
				info.maxMp	=  Number( xmlNode.@max_mp);
				info.maxHp =  Number( xmlNode.@max_hp);				
				info.headName = xmlNode.@head_name;
				info.statusBarType = xmlNode.@status_bar_type;
				
				_roleDic[info.roleConfigId] = info;
				buidhurtMovedisDic(info.roleConfigId,xmlNode.@hurt_move_frames,xmlNode.@hurt_move_dis);
				
			}
		}
	}
}