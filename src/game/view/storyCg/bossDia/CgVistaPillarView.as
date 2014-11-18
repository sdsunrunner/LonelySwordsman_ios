package game.view.storyCg.bossDia
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	
	/**
	 * cg远景柱子 
	 * @author admin
	 * 
	 */	
	public class CgVistaPillarView extends BaseViewer
	{
		public function CgVistaPillarView()
		{
			this.initView();
		}
		
		public function updatePos(num:Number):void
		{
			this.x+=num;			
		}
		private function initView():void
		{
			for(var i:Number = 0; i < 7; i++)
			{
				var image:Image = new Image(assetManager.getTextureAtlas("map_items").getTexture("farpillar"));
				image.x = 100+i*150;
				image.y = 100;
				image.scaleX = 1.5;
				image.scaleY = 1.5;
				this.addChild(image);
			}			
		}
		
		
	}
}