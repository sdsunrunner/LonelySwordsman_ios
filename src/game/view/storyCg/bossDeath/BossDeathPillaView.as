package game.view.storyCg.bossDeath
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	
	/**
	 * 死亡cg背景 
	 * @author admin
	 * 
	 */	
	public class BossDeathPillaView extends BaseViewer
	{
		private var _bgBuilding:Image = null;
		
		public function BossDeathPillaView()
		{
			super();
			this.initView();
		}
		
		private function initView():void
		{
			_bgBuilding =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("bgBuilding"));
			_bgBuilding.x = 0;
			_bgBuilding.y = 0;
			_bgBuilding.width = Const.STAGE_WIDTH;
			_bgBuilding.scaleY = 2.4;
			this.addChild(_bgBuilding);
		}
	}
}