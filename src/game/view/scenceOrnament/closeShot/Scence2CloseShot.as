package game.view.scenceOrnament.closeShot
{
	import game.view.superView.baseScenceView.BaseScenceCloseShotOrnamentView;
	
	import starling.display.Image;
	
	/**
	 * 场景1000近景点缀视图 
	 * @author admin
	 * 
	 */	
	public class Scence2CloseShot extends BaseScenceCloseShotOrnamentView
	{
		private var _imageShu:Image = null;
	
			
		public function Scence2CloseShot()
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
			_imageShu =  new Image(assetManager.getTextureAtlas("map_items").getTexture("BranchTop1"));
			_imageShu.x = 1800;
			_imageShu.y = 0;
//			this.addChild(_imageShu);
		}
	}
}