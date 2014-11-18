package vo.attackInfo
{
	import flash.display.Bitmap;

	/**
	 * 攻击碰撞信息 
	 * @author admin
	 * 
	 */	
	public class ObjHitInfo
	{
		/**
		 * 攻击输出者是否面向右边 
		 */		
		public var faceForward:Boolean = false;
		/**
		 * 攻击范围 
		 */		
		public var hitBounds:Bitmap = null;
		
		/**
		 * 攻击招式id 
		 */		
		public var attackMoveId:Number = NaN;
		
		/**
		 * 攻击输出值 
		 */		
		public var attackHurtValue:Number = NaN;
		
		/**
		 * 受击者位移 
		 */		
		public var targetBeenHitMove:Number = 0;
		public var targetBeenHitMoveY:Number = 0;
		
	}
}