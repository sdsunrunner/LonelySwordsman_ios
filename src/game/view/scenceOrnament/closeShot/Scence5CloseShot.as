package game.view.scenceOrnament.closeShot
{
	import game.view.superView.baseScenceView.BaseScenceCloseShotOrnamentView;
	
	import starling.display.Image;
	
	/**
	 * 场景1004近景 
	 * @author admin
	 * 
	 */	
	public class Scence5CloseShot extends BaseScenceCloseShotOrnamentView
	{
		private var _imageShu1:Image = null;
		private var _imageShu:Image = null;
		private var _shuzhi1:Image = null;
		private var _shuzhi2:Image = null;
		
		private var _imageShu2:Image = null;
		public function Scence5CloseShot()
		{
			super();
			this.initView();
		}
		
		override public function dispose():void
		{
			if(_imageShu1)
				_imageShu1.dispose();
			_imageShu1 = null;
			if(_imageShu)
				_imageShu.dispose();
			_imageShu = null;
			if(_shuzhi1)
				_shuzhi1.dispose();
			_shuzhi1 = null;
			while(this.numChildren > 0)
			{
				this.removeChildAt(0,true);
			}
		}
		private function initView():void
		{
			_imageShu1 = new Image(assetManager.getTextureAtlas("map_items").getTexture("dashu"));
			_imageShu1.scaleX = 1.1;
			_imageShu1.scaleY = 1.1;
			_imageShu1.x = 1000;
			if(Const.STAGE_HEIGHT<700)
				_imageShu1.y = -200;
			else
				_imageShu1.y = -110;
			this.addChild(_imageShu1);
			
			
			_imageShu = new Image(assetManager.getTextureAtlas("gui_images").getTexture("duanshu"));
			_imageShu.scaleX = 1.2;
			_imageShu.scaleY = 1.2;
			_imageShu.x = 2500;
			this.addChild(_imageShu);
			
			
			_shuzhi1 = new Image(assetManager.getTextureAtlas("map_items").getTexture("BranchTop1"));
			_shuzhi1.x = 2600;
			_shuzhi1.scaleX = -1.5;
			_shuzhi1.scaleY = 1.5;
			this.addChild(_shuzhi1);
			
			_shuzhi2 = new Image(assetManager.getTextureAtlas("map_items").getTexture("BranchTop1"));
			_shuzhi2.x = 2900;
			_shuzhi2.scaleX = 1.5;
			_shuzhi2.scaleY = 1.5;			
			this.addChild(_shuzhi2);
			
			_imageShu2 = new Image(assetManager.getTextureAtlas("map_items").getTexture("dashu"));
			_imageShu2.scaleX = -1.1;
			_imageShu2.scaleY = 1.1;
			_imageShu2.x = 5000;
			if(Const.STAGE_HEIGHT<700)
				_imageShu2.y = -200;	
			else
				_imageShu2.y = -110;
			
			this.addChild(_imageShu2);
		}
	}
}