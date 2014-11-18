package game.view.welcomeScence.ornamentView
{
	import game.view.superView.BaseCycleView;
	import game.view.superView.model.BaseCycleViewMoveTypeEnum;
	
	import starling.display.Image;
	import starling.events.Event;
	
	/**
	 * 中景点缀视图  
	 * @author songdu.greg
	 * 
	 */	
	public class MediumOrnamentView extends BaseCycleView
	{
		public function MediumOrnamentView()
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
		
		override public function enterFrameHandler(evt:Event):void
		{
			this.updateScencePos(Const.WELCOME_SCENCE_MOVE_SPEED * Const.MEDIUM_SCENCE_MOVE_OFFSET_VALUE);
		}
		
		private function initView():void
		{
			_bgLeft = new Image(assetManager.getTextureAtlas("gui_images").getTexture("xiaoshu"));
			_bgLeft.x = -1*BaseCycleViewMoveTypeEnum.MOUNTAIN_TILD_WIDTH;
			
			this.addChild(_bgLeft);
			
			_bgRight = new Image(assetManager.getTextureAtlas("gui_images").getTexture("xiaoshu"));
			_bgRight.x =  BaseCycleViewMoveTypeEnum.MOUNTAIN_TILD_WIDTH;
			
			
			this.addChild(_bgRight);
		}
	}
}