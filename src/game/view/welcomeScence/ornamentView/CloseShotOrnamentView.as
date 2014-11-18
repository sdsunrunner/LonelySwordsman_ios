package game.view.welcomeScence.ornamentView
{
	import game.view.superView.BaseCycleView;
	import game.view.superView.model.BaseCycleViewMoveTypeEnum;
	
	import starling.display.Image;
	import starling.events.Event;
	
	/**
	 * 近景 
	 * @author songdu.greg
	 * 
	 */	
	public class CloseShotOrnamentView extends BaseCycleView
	{
		public function CloseShotOrnamentView()
		{
			super();
			this.initView();
			this.setMoveStatus();
			this.touchable = false;
		}
		
		override public function dispose():void
		{
			super.dispose();
			_dataModel.unRegister(this);
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		override public function infoUpdate(data:Object, msgName:String):void
		{
			
		}
		
		private function initView():void
		{
			_bgLeft = new Image(assetManager.getTextureAtlas("gui_images").getTexture("duanshu"));
			_bgLeft.x = -1*BaseCycleViewMoveTypeEnum.MOUNTAIN_TILD_WIDTH;
			_bgLeft.visible = false;
			this.addChild(_bgLeft);
			
			_bgRight = new Image(assetManager.getTextureAtlas("gui_images").getTexture("duanshu"));
			_bgRight.x =  BaseCycleViewMoveTypeEnum.MOUNTAIN_TILD_WIDTH;
			
			
			this.addChild(_bgRight);
			
		
				this.scaleX = 1.7;
				this.scaleY = 1.7;
			
			
		}
		
		override public function enterFrameHandler(evt:Event):void
		{
			this.updateScencePos(Const.WELCOME_SCENCE_MOVE_SPEED * Const.CLOSE_SHOT_SCENCE_MOVE_OFFSET_VALUE);
		}
	}
}