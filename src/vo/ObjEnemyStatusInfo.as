package vo
{
	import flash.geom.Point;
	
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;

	/**
	 * 敌人信息 
	 * @author admin
	 * 
	 */	
	public class ObjEnemyStatusInfo
	{
		/**
		 * 实体id 
		 */		
		public var enemyId:String = "";
		/**
		 * 配置id 
		 */		
		public var enemyConfigInfo:ObjRoleConfigInfo = null;
		
		/**
		 * 当前hp
		 */		
		public var currentHp:Number = 0;
		
		/**
		 * 当前hp
		 */		
		public var currentMp:Number = 0;
		
		/**
		 * 当前坐标 
		 */		
		public var currentPos:Point = null;
		
		public var isDead:Boolean = false;
	}
}