package game.view.controlView.JoyStick
{
	import frame.view.viewDelegate.BaseViewer;
	
	import game.input.GameVirtualJoystick;
	import game.manager.CEEngineManager;
	
	import starling.display.Image;
	
	/**
	 * 虚拟摇杆 视图  
	 * @author songdu
	 * 
	 */	
	public class ControllerJoyStickView extends BaseViewer
	{
		private var _joyStick:GameVirtualJoystick = null;
		private var _backImage:Image = null;
		private var _knobImage:Image = null;
		public function ControllerJoyStickView()
		{
			super();
			this.initView();
		}
		
		public function activeController(active:Boolean):void
		{
			_joyStick.visible = active;
			_backImage.visible = active;
			_knobImage.visible = active;
		}
		
		override public function dispose():void
		{
			CEEngineManager.instance.ceEngine.input.removeController(_joyStick);
			if(_joyStick)
				_joyStick.destroy();
			_joyStick = null;
			if(_backImage)
				_backImage.dispose();
			_backImage = null;
			if(_knobImage)
				_knobImage.dispose();
			_knobImage = null;
			
		}
		private function initView():void
		{
			_backImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("back"));
			_knobImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("knob"));
			_joyStick = new GameVirtualJoystick("joyStick");
			
			CEEngineManager.instance.ceEngine.input.addController(_joyStick);
		}
	}
}