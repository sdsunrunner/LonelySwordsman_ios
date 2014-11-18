package game.scenceInterac.movingPlatform
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	
	/**
	 * 移动平台视图 
	 * @author admin
	 * 
	 */	
	public class MoveingPlatView extends BaseViewer
	{
		private var _image:Image = null;
		private var _width:Number;
		public function MoveingPlatView(width:Number)
		{
			_width = width;
			super();
			this.initView();
		}
		
		private function initView():void
		{
			this._image = new Image(assetManager.getTextureAtlas("gui_images").getTexture("blackMask"));
			this._image.height = 30;
			this._image.width = 150;
			_image.y = 0;
			_image.x = 0;
			this.addChild(this._image);
		}
	}
}