package game.view.scenceOrnament.mapOrnament
{
	import game.view.superView.baseScenceView.BaseScenceMapOrnamentView;
	
	import starling.display.Image;

	/**
	 * 场景2地图装饰层 
	 * @author admin
	 * 
	 */	
	public class Scence2MapOrnament extends BaseScenceMapOrnamentView
	{
		private var _shumu:Image = null;	
		public function Scence2MapOrnament()
		{
			super();
			this.initView();
		}
		
		override public function dispose():void
		{
			_shumu.dispose();
			_shumu = null;
			while(this.numChildren > 0 )
			{
				this.removeChildAt(0);
			}
		}
		
		private function initView():void
		{
			_shumu = new Image(assetManager.getTextureAtlas("map_items").getTexture("dashu"));
			_shumu.x = 1600;
			_shumu.y = 62;
			_shumu.scaleX = 1.5;
			_shumu.scaleY = 1.5;
			this.addChild(_shumu);
		}
	}
}