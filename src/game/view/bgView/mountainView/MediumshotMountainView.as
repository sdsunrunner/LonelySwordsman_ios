package game.view.bgView.mountainView
{
	import game.view.superView.BaseCycleView;
	import game.view.superView.model.BaseCycleViewMoveTypeEnum;
	
	import starling.display.Image;
	
	/**
	 * 中景山脉 
	 * @author songdu.greg
	 * 
	 */	
	public class MediumshotMountainView extends BaseCycleView
	{
		public function MediumshotMountainView()
		{
			super();
			this.initView();
		}
		
		private function initView():void
		{
			_bgLeft = new Image(assetManager.getTextureAtlas("bg_mountain").getTexture("medium_mountain_left"));
			_bgLeft.x = -1*BaseCycleViewMoveTypeEnum.MOUNTAIN_TILD_WIDTH>>1;
			_bgLeft.width = 1150;
			
			this.addChild(_bgLeft);
			
			_bgRight = new Image(assetManager.getTextureAtlas("bg_mountain").getTexture("medium_mountain_right"));
			_bgRight.x =  BaseCycleViewMoveTypeEnum.MOUNTAIN_TILD_WIDTH>>1;
			_bgRight.width = 1150;
			
			
			this.addChild(_bgRight);
		}
	}
}