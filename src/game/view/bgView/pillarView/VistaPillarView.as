package game.view.bgView.pillarView
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	
	/**
	 * 远景柱子视图 
	 * @author admin
	 * 
	 */	
	public class VistaPillarView extends BaseViewer
	{
		public function VistaPillarView()
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
			for(var i:Number = 0; i < 7; i++)
			{
				var image:Image = new Image(assetManager.getTextureAtlas("map_items").getTexture("farpillar"));
				image.x = 100+i*150;
				image.y = 100;
				this.addChild(image);
			}			
		}
	}
}