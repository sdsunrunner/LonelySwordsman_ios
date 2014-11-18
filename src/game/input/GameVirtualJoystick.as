package game.input
{
	
	import citrus.input.controllers.starling.VirtualJoystick;
	
	import game.manager.assetManager.GameAssetManager;
	
	import starling.display.Image;
	
	/**
	 * 虚拟摇杆 
	 * @author songdu
	 * 
	 */	
	public class GameVirtualJoystick extends VirtualJoystick
	{
		public function GameVirtualJoystick(name:String, params:Object=null)
		{
			this.back = new Image(GameAssetManager.instance.getTextureAtlas("gui_images").getTexture("back"));
			this.knob = new Image(GameAssetManager.instance.getTextureAtlas("gui_images").getTexture("knob"));
			
			this.back.alpha = 0.7;
			this.knob.alpha = 0.7;
			super(name, params);
		}		
	}
}