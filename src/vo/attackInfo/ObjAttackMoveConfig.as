package vo.attackInfo
{
	/**
	 * 攻击招式配置信息 
	 * @author admin
	 * 
	 */	
	public class ObjAttackMoveConfig
	{
		/**
		 * 招式配置 id 
		 */		
		public var attackMoveId:Number = NaN;
		
		/**
		 * 招式所属角色id 
		 */		
		public var movesOwnerId:Number = NaN;
		
		/**
		 * 攻击输出值 
		 */		
		public var hitValue:Number = NaN;
		
		/**
		 * 攻击招式icone名
		 */		
		public var moveIconName:String ="";
		
		/**
		 * 效果释放帧
		 */		
		public var releaseLab:Vector.<Number> = null;
		
		/**
		 * 攻击躲避帧 
		 */		
		public var avoidlab:Number = NaN;
		
		/**
		 * 消耗mp 
		 */		
		public var costMp:Number = NaN;
		
		/**
		 * 回血 
		 */		
		public var addHp:Number = NaN;
		
		/**
		 * 无敌帧 
		 */		
		public var unconquerableLabMin:Number = NaN;
		
		/**
		 * 无敌帧 
		 */		
		public var unconquerableLabMax:Number = NaN;
		
		/**
		 * 受攻击者位移 
		 */		
		public var targetPosMove:Number = NaN;
		
		/**
		 * 受攻击者y轴位移 
		 */		
		public var targetPosMoveY:Number = NaN;
		
		/**
		 * 世界震动信息 
		 */		
		public var shakeWordInfo:String = "";
	}
}