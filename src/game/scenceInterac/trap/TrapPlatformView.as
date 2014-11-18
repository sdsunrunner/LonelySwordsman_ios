package game.scenceInterac.trap
{
	import citrus.view.starlingview.AnimationSequence;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.manager.gameLevelManager.GameLevelManager;
	
	import starling.display.Image;
	
	import vo.configInfo.ObjScenceInteracConfigInfo;
	
	/**
	 * 陷阱平台试视图 
	 * @author admin
	 * 
	 */	
	public class TrapPlatformView extends BaseViewer
	{
		private var _image:Image = null;
		private var _width:Number;
		
		private var _smokeAnima:AnimationSequence = null;
		
		private var _scenceConfig:ObjScenceInteracConfigInfo = null;
		public function TrapPlatformView(width:Number)
		{
			_width = width;
			_scenceConfig = GameLevelManager.instance.getScenceInteracConfigInfo();
			this.initView();
		}
		
		override public function dispose():void
		{
			super.dispose();
			if(_image)
				_image.dispose();
			if(_smokeAnima)
			{
				_smokeAnima.removeAllAnimations();
				_smokeAnima = null;
			}
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
		}
		public function showSmoke():void
		{
			var smokeanimaName:Array = ["expsmoke"];			
			_smokeAnima = new AnimationSequence(assetManager.getTextureAtlas("scence_effect"),smokeanimaName,"expsmoke",Const.GAME_ANIMA_FRAMERATE,false);
		
			this.addChild(_smokeAnima);
			_smokeAnima.x = _scenceConfig.smokeAnimaX;
			_smokeAnima.y = _scenceConfig.smokeAnimaY;
			soundExpressions.playActionSound("expsmoke",1);
		}
		
		private function initView():void
		{
			this._image = new Image(assetManager.getTextureAtlas("gui_images").getTexture("blackMask"));
			this._image.height = _scenceConfig.trapPlatformImageHeight;
			this._image.width = _scenceConfig.trapPlatformImageWidth;
			_image.x = _scenceConfig.imageX;
			_image.y = _scenceConfig.imageY;
			this.addChild(this._image);
		}
	}
}