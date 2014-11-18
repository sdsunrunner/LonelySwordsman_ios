package vo.configInfo
{
	/**
	 * 场景交互配置  
	 * @author admin
	 * 
	 */	
	public class ObjScenceInteracConfigInfo
	{
		/**
		 * 关卡id 
		 */		
		public var levId:String = "";
		
		/**
		 * 梯子x偏移 
		 */		
		public var ladderOffsetX:Number = 0;
		
		/**
		 * 梯子y偏移  
		 */		
		public var ladderOffsetY:Number = 0;
		
		/**
		 * 梯子高度		
		 */	
		public var ladderHeight:Number = 0;
		
		/**
		 * 梯子移动范围 
		 */		
		public var ladderMoveRange:Number = 0;
		
		/**
		 * 水平移动平台速度 
		 */		
		public var landscapePlatformSpeed:Array = null;
		
		/**
		 * 水平移动平台范围 
		 */		
		public var landscapePlatformRange:Array = null;
		
		/**
		 * 陷阱宽度 
		 */		
		public var trapPlatformImageHeight:Number = 0;
		
		/**
		 * 陷阱宽度 
		 */		
		public var trapPlatformImageWidth:Number = 0;
		
		/**
		 * 陷阱图posX 
		 */		
		public var imageX:Number = 0;
		
		/**
		 * 陷阱图posY 
		 */		
		public var imageY:Number = 0;
		
		/**
		 * 烟雾效果posX 
		 */		
		public var smokeAnimaX:Number = 0;
		
		/**
		 * 烟雾效果posY 
		 */		
		public var smokeAnimaY:Number = 0;
		
	}
}