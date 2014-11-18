package game.view.scenceOrnament.closeShot
{
	import game.view.superView.baseScenceView.BaseScenceCloseShotOrnamentView;
	
	import starling.display.Image;
	
	/**
	 * 场景1000近景点缀视图 
	 * @author admin
	 * 
	 */	
	public class Scence1CloseShot extends BaseScenceCloseShotOrnamentView
	{
		private var _imageShu:Image = null;	
			
		public function Scence1CloseShot()
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
			_imageShu = new Image(assetManager.getTextureAtlas("gui_images").getTexture("duanshu"));
			_imageShu.scaleX = 1.2;
			_imageShu.scaleY = 1.2;
			_imageShu.x = 1400;
			this.addChild(_imageShu);
			
			this.alpha = 0.9;
		}
	}
}