package game.view.scenceOrnament.mapOrnament
{
	import game.view.superView.baseScenceView.BaseScenceMapOrnamentView;
	
	import starling.display.Image;
	
	/**
	 * 场景5地图装饰层 
	 * @author admin
	 * 
	 */
	public class Scence5MapOrnament extends BaseScenceMapOrnamentView
	{
		private var _imageXiaoshu1:Image = null;
		private var _imageXiaoshu2:Image = null;
		private var _imageXiaoshu3:Image = null;
		private var _imageXiaoshu4:Image = null;
		private var _imageXiaoshu5:Image = null;
		private var _imageXiaoshu6:Image = null;
		public function Scence5MapOrnament()
		{
			super();
			this.initView();
		}
		override public function dispose():void
		{
			_imageXiaoshu1.dispose();
			_imageXiaoshu1 = null;
			_imageXiaoshu2.dispose();
			_imageXiaoshu2 = null;
			
			_imageXiaoshu3.dispose();
			_imageXiaoshu3 = null;
			while(this.numChildren > 0 )
			{
				this.removeChildAt(0);
			}
		}
		private function initView():void
		{
			_imageXiaoshu1 = new Image(assetManager.getTextureAtlas("map_items").getTexture("shuzhi2"));
			_imageXiaoshu1.x = 400;
			_imageXiaoshu1.y = 660;
			_imageXiaoshu1.scaleX = 0.5;
			_imageXiaoshu1.scaleY = 0.5;
			this.addChild(_imageXiaoshu1);
			
			_imageXiaoshu2 = new Image(assetManager.getTextureAtlas("map_items").getTexture("shumu"));
			_imageXiaoshu2.x = 1600;
			_imageXiaoshu2.y = 620;
			_imageXiaoshu2.scaleX = 0.5;
			_imageXiaoshu2.scaleY = 0.5;
			this.addChild(_imageXiaoshu2);
			
			
			_imageXiaoshu3 = new Image(assetManager.getTextureAtlas("map_items").getTexture("shumu2"));
			_imageXiaoshu3.x = 2200;
			_imageXiaoshu3.y = 550;
			this.addChild(_imageXiaoshu3);
			
			_imageXiaoshu4 = new Image(assetManager.getTextureAtlas("map_items").getTexture("meihua"));
			_imageXiaoshu4.x = 2900;
			_imageXiaoshu4.y = 590;		
			this.addChild(_imageXiaoshu4);
			
			_imageXiaoshu5 = new Image(assetManager.getTextureAtlas("map_items").getTexture("huashu"));
			_imageXiaoshu5.x = 3500;
			_imageXiaoshu5.y = 430;		
			this.addChild(_imageXiaoshu5);
			
			_imageXiaoshu6 = new Image(assetManager.getTextureAtlas("map_items").getTexture("shumu2"));
			_imageXiaoshu6.x = 4600;
			_imageXiaoshu6.y = 550;		
			this.addChild(_imageXiaoshu6);
		}
	}
}