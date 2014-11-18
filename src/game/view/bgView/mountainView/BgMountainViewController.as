package game.view.bgView.mountainView
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * 山脉背景视图控制器 
	 * @author songdu.greg
	 * 
	 */	
	public class BgMountainViewController extends BaseViewerController
	{
		private var _view:BgMountainView = null;
		
		public function BgMountainViewController()
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
		
		public function resetBgMoveModel():void
		{
			_view.resetBgMoveModel();
		}	
		
		public function updateBgMode():void
		{
			_view.updateBgMode();
		}
		
		public function setGameLevPos():void
		{
			_view.setGameLevPos();
		}
		
		public function smothResetView():void
		{
			_view.smothResetView();
		}
		
		private function initView():void
		{
			_view = new BgMountainView();
		}
	}
}