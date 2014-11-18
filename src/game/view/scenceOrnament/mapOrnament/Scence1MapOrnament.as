package game.view.scenceOrnament.mapOrnament
{
	import game.view.superView.baseScenceView.BaseScenceMapOrnamentView;
	import starling.display.Image;
	
	/**
	 * 场景1地图装饰层 
	 * @author admin
	 * 
	 */	
	public class Scence1MapOrnament extends BaseScenceMapOrnamentView
	{
		private var _imageXiaoShu1:Image = null;
		private var _imageXiaoShu2:Image = null;		
		private var _imageXiaoShu3:Image = null;
		private var _imageXiaoShu4:Image = null;
		
		public function Scence1MapOrnament()
		{
			super();
			this.initView();
		}
		override public function dispose():void
		{
			_imageXiaoShu1.dispose();
			_imageXiaoShu1 = null;
			while(this.numChildren > 0 )
			{
				this.removeChildAt(0);
			}
		}
		private function initView():void
		{
			_imageXiaoShu1 = new Image(assetManager.getTextureAtlas("map_items").getTexture("xiaoshu"));
			_imageXiaoShu1.x = 900;
			_imageXiaoShu1.y = 610;
			_imageXiaoShu1.scaleX = -1;
			this.addChild(_imageXiaoShu1);
			
			_imageXiaoShu2 = new Image(assetManager.getTextureAtlas("map_items").getTexture("xiaoshu"));
			_imageXiaoShu2.x = 1400;
			_imageXiaoShu2.y = 610;
			
			this.addChild(_imageXiaoShu2);
			
			_imageXiaoShu3 = new Image(assetManager.getTextureAtlas("map_items").getTexture("xiaoshu5"));
			_imageXiaoShu3.x = 1800;
			_imageXiaoShu3.y = 610;
			
			this.addChild(_imageXiaoShu3);
			
			_imageXiaoShu4 = new Image(assetManager.getTextureAtlas("map_items").getTexture("xiaoshu2"));
			_imageXiaoShu4.x = 2400;
			_imageXiaoShu4.y = 580;
			
			this.addChild(_imageXiaoShu4);
		}
	}
}