package game.view.scenceOrnament.mapOrnament
{
	import game.view.superView.baseScenceView.BaseScenceMapOrnamentView;
	
	import starling.display.Image;
	
	/**
	 * 生存模式地图点缀 
	 * @author admin
	 * 
	 */	
	public class ScenceSurvivalMapOrnament extends BaseScenceMapOrnamentView
	{
		private var _imageXiaoShu1:Image = null;
		private var _imageXiaoShu2:Image = null;		
		private var _imageXiaoShu3:Image = null;
		private var _imageXiaoShu4:Image = null;		
		private var _imageXiaoShu5:Image = null;
		
		public function ScenceSurvivalMapOrnament()
		{
			super();
			this.initView();
		}
		override public function dispose():void
		{
			if(_imageXiaoShu1)
				_imageXiaoShu1.dispose();
			_imageXiaoShu1 = null;
			while(this.numChildren > 0 )
			{
				this.removeChildAt(0);
			}
		}
		private function initView():void
		{
			
			_imageXiaoShu1 = new Image(assetManager.getTextureAtlas("map_items").getTexture("xiaoshu1"));
			_imageXiaoShu1.x = 800;
			_imageXiaoShu1.y = 610;
			_imageXiaoShu1.scaleX = -1;
			this.addChild(_imageXiaoShu1);
			
			_imageXiaoShu2 = new Image(assetManager.getTextureAtlas("map_items").getTexture("xiaoshu5"));
			_imageXiaoShu2.x = 1400;
			_imageXiaoShu2.y = 610;
			
			this.addChild(_imageXiaoShu2);
		
			_imageXiaoShu3 = new Image(assetManager.getTextureAtlas("map_items").getTexture("shumu"));
			_imageXiaoShu3.x = 1800;
			_imageXiaoShu3.y = 500;			
			this.addChild(_imageXiaoShu3);
			
			_imageXiaoShu4 = new Image(assetManager.getTextureAtlas("map_items").getTexture("shuzhi1"));
			_imageXiaoShu4.x = 445;
			_imageXiaoShu4.y = 400;			
			this.addChild(_imageXiaoShu4);
		
			_imageXiaoShu5 = new Image(assetManager.getTextureAtlas("map_items").getTexture("shuzhi5"));
			_imageXiaoShu5.x = 2280;
			_imageXiaoShu5.y = 400;		
			_imageXiaoShu5.scaleX = -1;
			this.addChild(_imageXiaoShu5);
			
			this.flatten();
		}
	}
}