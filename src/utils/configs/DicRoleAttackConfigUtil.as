package utils.configs
{
	import flash.utils.Dictionary;
	
	import game.manager.dicManager.DicConfigUtility;
	
	import vo.attackInfo.ObjAttackMoveConfig;

	/**
	 * 角色攻击招式配置信息 
	 * @author admin
	 * 
	 */	
	public class DicRoleAttackConfigUtil
	{
		private static var _dic:Dictionary;
		
		/**
		 * 由招式id获取招式配置信息
		 * @param scenceId
		 * @return 
		 * 
		 */		
		public static function getAttackMoveConfigById(id:Number):ObjAttackMoveConfig
		{
			if(_dic == null)
				parse();
			return _dic[id];
		}
		
		private static function parse():void
		{
			var xml:XML = DicConfigUtility.getGameRoleAttackConfig();
			
			_dic = new Dictionary;
			for each (var xmlNode:XML in xml.Node)
			{
				var info:ObjAttackMoveConfig = new ObjAttackMoveConfig();
				info.attackMoveId = xmlNode.@moves_id;
				info.movesOwnerId = xmlNode.@moves_owner;
				info.hitValue = xmlNode.@hit_value;
				info.moveIconName = xmlNode.@icone_name;
				var numArr:Array =  String(xmlNode.@release_lab).split(",");
				info.releaseLab = new Vector.<Number>();
				for(var i:Number = 0; i <numArr.length; i++ )
				{
					info.releaseLab.push(numArr[i]);
				}
				info.avoidlab =  xmlNode.@avoid_lab;
				info.costMp =  xmlNode.@cost_mp;
				info.addHp =  xmlNode.@add_hp;
				info.targetPosMove =  xmlNode.@target_pos_move;
				info.targetPosMoveY =  xmlNode.@target_y_move;
				info.unconquerableLabMin =  xmlNode.@unconquerable_lab_min;
				info.unconquerableLabMax =  xmlNode.@unconquerable_lab_max;
				info.shakeWordInfo =  xmlNode.@shak_world;
				
				_dic[info.attackMoveId] = info;
			}
		}

	}
}