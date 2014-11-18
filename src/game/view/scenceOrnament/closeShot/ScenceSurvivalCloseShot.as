package game.view.scenceOrnament.closeShot
{
	import game.view.superView.baseScenceView.BaseScenceCloseShotOrnamentView;
	
	import starling.display.Image;
	
	/**
	 * 生存模式近景点缀视图  
	 * @author admin
	 * 
	 */	
	public class ScenceSurvivalCloseShot extends BaseScenceCloseShotOrnamentView
	{
		private var _imageShu:Image = null;
		public function ScenceSurvivalCloseShot()
		{
			super();
			this.initView();
		}
		
		override public function dispose():void
		{
			_imageShu.dispose();
			
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		private function initView():void
		{
			_imageShu = new Image(assetManager.getTextureAtlas("map_items").getTexture("dashu"));
			_imageShu.scaleX = 1.2;
			_imageShu.scaleY = 1.2;
			if(Const.STAGE_HEIGHT < 700)
				_imageShu.y = -1* Const.STAGE_HEIGHT*2/5;
			else
				_imageShu.y = -150;
			_imageShu.x = 500;
			this.addChild(_imageShu);
			
			this.flatten();
		}
	}
}