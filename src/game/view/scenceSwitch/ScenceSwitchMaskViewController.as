package game.view.scenceSwitch
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * 场景切换遮挡视图控制器  
	 * @author admin
	 * 
	 */	
	public class ScenceSwitchMaskViewController extends BaseViewerController
	{
		private var _view:ScenceSwitchMaskView = null;
		
		public function ScenceSwitchMaskViewController()
		{
			super();
			this.initView();
		}
		
		override public function get viewer():DisplayObjectContainer
		{
			return _view;
		}
		
		override public function dispose():void
		{
			_view.dispose();
		}
		public function fadeOut():void
		{
			_view.fadeOut();
		}
		
		private function initView():void
		{
			_view = new ScenceSwitchMaskView();
		}
	}
}