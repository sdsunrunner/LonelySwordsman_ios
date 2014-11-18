package game.view.stageBgView
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	
	/**
	 * 游戏背景视图 
	 * @author songdu.greg
	 * 
	 */	
	public class GameStageBgView extends BaseViewer
	{
		private var _stageBgImage:Image = null;
		
		public function GameStageBgView()
		{
			super();
			this.initView();
		}
		
		private function initView():void
		{
			_stageBgImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("bgMask"));
			_stageBgImage.x = -50;
			_stageBgImage.width = Const.STAGE_WIDTH + 100;
			_stageBgImage.height = Const.STAGE_HEIGHT;
			
			this.addChild(_stageBgImage);
			
			if(Const.isNewPad)
			{
				_stageBgImage.width = 2048;
				_stageBgImage.height = 1024;
			}
		}
	}
}