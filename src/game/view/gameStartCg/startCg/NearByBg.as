package game.view.gameStartCg.startCg
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	
	/**
	 * 近景视图 
	 * @author admin
	 * 
	 */	
	public class NearByBg extends BaseViewer
	{
		private static const SOLDIER_COUNT_MAX:Number = 10;
		
		public function NearByBg()
		{
			super();
			this.initView();
		}
		
		private function initView():void
		{
			for(var i:Number = 0; i < SOLDIER_COUNT_MAX; i++)
			{
				var soldier:Image = new Image(assetManager.getTextureAtlas("start_cg").getTexture("bgSoldier1"));
				soldier.x = i*150 + 50 - 200;
				this.addChild(soldier);
			}
		}
	}
}