package game.view.gameStartCg.startCg
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	
	/**
	 * 远景视图 
	 * @author admin
	 * 
	 */	
	public class FarAwayBgView extends BaseViewer
	{
		private static const SOLDIER_COUNT_MAX:Number = 10;
		
		public function FarAwayBgView()
		{
			super();
			this.initView();
		}
		
		private function initView():void
		{
			for(var i:Number = 0; i < SOLDIER_COUNT_MAX; i++)
			{
				var soldier:Image = new Image(assetManager.getTextureAtlas("start_cg").getTexture("bgSoldier2"));
				soldier.x = i*100 - 200;
				this.addChild(soldier);
			}
		}
	}
}