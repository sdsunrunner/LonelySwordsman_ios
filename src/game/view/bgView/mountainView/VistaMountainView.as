package game.view.bgView.mountainView
{
	import game.view.superView.model.BaseCycleViewMoveTypeEnum;
	
	import starling.display.Image;
	import game.view.superView.BaseCycleView;
	
	/**
	 * 远景山脉 
	 * @author songdu.greg
	 * 
	 */	
	public class VistaMountainView extends BaseCycleView
	{
		public function VistaMountainView()
		{
			super();
			this.initView();			
		}
		
		private function initView():void
		{
			_bgLeft = new Image(assetManager.getTextureAtlas("bg_mountain").getTexture("vista_mountaion_left"));
			_bgLeft.x = -1*BaseCycleViewMoveTypeEnum.MOUNTAIN_TILD_WIDTH>>1;
			_bgLeft.width = 1150;
			_bgLeft.height = 200;
			this.addChild(_bgLeft);
			
			_bgRight = new Image(assetManager.getTextureAtlas("bg_mountain").getTexture("vista_mountaion_right"));
			_bgRight.x =  BaseCycleViewMoveTypeEnum.MOUNTAIN_TILD_WIDTH>>1;
			_bgRight.width = 1150;
			_bgRight.height = 200;
			this.addChild(_bgRight);
			
			
		}	
	}

}