package game.view.bgView.pillarView
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	
	/**
	 * 中景柱子视图 
	 * @author admin
	 * 
	 */	
	public class MediumShotPillarView extends BaseViewer
	{
		public function MediumShotPillarView()
		{
			super();
			this.initView();
		}
		
		public function updatePos(num:Number):void
		{
			this.x+=num;			
		}
		
		private function initView():void
		{
			for(var i:Number = 0; i < 5; i++)
			{
				var image:Image = new Image(assetManager.getTextureAtlas("map_items").getTexture("bgpillar"));
				image.x = 200+i*200;
				image.scaleX = 1.2;
				image.scaleY = 1.2;
				image.y = 30;
				this.addChild(image);
			}
		}
	}
}