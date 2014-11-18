package game.scenceInterac.movingPlatform
{
	import citrus.objects.platformer.nape.MovingPlatform;
	
	import game.manager.gameLevelManager.GameLevelManager;
	
	import vo.configInfo.ObjScenceInteracConfigInfo;
	
	/**
	 * 横向移动的平台 
	 * @author admin
	 * 
	 */	
	public class LandscapePlatform extends MovingPlatform
	{
		private var _platView:MoveingPlatView = null;
		private var _scenceConfig:ObjScenceInteracConfigInfo = null;
		public var endXPlus:Number = NaN;
		public function LandscapePlatform(name:String, params:Object=null)
		{
			if(params)
			{
				endXPlus = params.endXPlus;
				if(!params.view)
				{
					_platView = new MoveingPlatView(params.width);
					params.view = _platView;
				}
			}
			super(name, params);	
			
			_scenceConfig = GameLevelManager.instance.getScenceInteracConfigInfo();
			
		}
		
		override public function set x(value:Number):void
		{
			super.x = value;			
			_start.x = value;
			this.endX = value + endXPlus;
		}
		
		override public function set y(value:Number):void
		{
			super.y = value;			
			_start.y = value;
			this.endY = value;
		}
		
	}
}