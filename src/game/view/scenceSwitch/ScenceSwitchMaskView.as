 package game.view.scenceSwitch
{
	import com.greensock.TweenMax;
	
	import extend.draw.display.Shape;
	
	import frame.view.viewDelegate.BaseViewer;
	
	/**
	 * 场景切换黑屏遮罩 
	 * @author admin
	 * 
	 */	
	public class ScenceSwitchMaskView extends BaseViewer
	{
		private var _shap:Shape = null;
		
		public function ScenceSwitchMaskView()
		{
			super();
			this.initView();
			this.touchable = false;
		}
		
		public function fadeOut():void
		{
			TweenMax.to(_shap,1,{alpha:0});
		}
		
		private function  initView():void
		{
			_shap = new Shape();
			_shap.graphics.beginFill(0xffffff);
			_shap.graphics.drawRect(0,0,Const.STAGE_WIDTH+50,Const.STAGE_HEIGHT+50);
			_shap.alpha = 1;
			this.addChild(_shap);	
		}
	}
}