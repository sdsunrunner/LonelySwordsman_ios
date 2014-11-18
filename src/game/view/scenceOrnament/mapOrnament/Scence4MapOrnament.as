package game.view.scenceOrnament.mapOrnament
{
	import game.view.superView.baseScenceView.BaseScenceMapOrnamentView;
	
	import starling.display.Image;
	
	/**
	 * 场景4地图装饰层 
	 * @author admin
	 * 
	 */
	public class Scence4MapOrnament extends BaseScenceMapOrnamentView
	{
		private var _imageXiaoShu1:Image = null;
		private var _imageXiaoShu2:Image = null;		
		private var _imageXiaoShu3:Image = null;
		public function Scence4MapOrnament()
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
			_imageXiaoShu1 = new Image(assetManager.getTextureAtlas("map_items").getTexture("MiddleTreeE"));
			_imageXiaoShu1.x = 350;
			_imageXiaoShu1.y = 865;			
			this.addChild(_imageXiaoShu1);
			
			_imageXiaoShu2 = new Image(assetManager.getTextureAtlas("map_items").getTexture("shumuDaiye"));
			_imageXiaoShu2.x = 1200;
			_imageXiaoShu2.y = 730;
			this.addChild(_imageXiaoShu2);			
			
			_imageXiaoShu3 = new Image(assetManager.getTextureAtlas("map_items").getTexture("xiaoshu"));
			_imageXiaoShu3.x = 2500;
			_imageXiaoShu3.y = 415;			
			this.addChild(_imageXiaoShu3);
		}
	}
}