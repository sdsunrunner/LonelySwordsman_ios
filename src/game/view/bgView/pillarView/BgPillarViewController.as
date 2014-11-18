package game.view.bgView.pillarView
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * 背景柱子视图控制器 
	 * @author admin
	 * 
	 */	
	public class BgPillarViewController extends BaseViewerController
	{
		private var _view:BgPillarView = null;
		
		public function BgPillarViewController()
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
		
		
		private function initView():void
		{
			_view = new BgPillarView();
		}
	}
}