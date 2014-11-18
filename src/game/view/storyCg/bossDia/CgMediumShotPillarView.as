package game.view.storyCg.bossDia
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	
	/**
	 * cg中景柱子 
	 * @author admin
	 * 
	 */	
	public class CgMediumShotPillarView extends BaseViewer
	{
		public function CgMediumShotPillarView()
		{
			super();
			this.initView();
		}
		
		public function updatePos(num:Number):void
		{
			this.y-=num;			
		}
		
		private function initView():void
		{
			for(var i:Number = 0; i < 5; i++)
			{
				var image:Image = new Image(assetManager.getTextureAtlas("map_items").getTexture("bgpillar"));
				image.x = 200+i*200;
				image.scaleX = 2;
				image.scaleY = 2;
//				image.y = 30;
				this.addChild(image);
			}
		}
	}
}