package game.view.stageBgView
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * 游戏背景视图控制器 
	 * @author songdu.greg
	 * 
	 */	
	public class GameStageBgViewController extends BaseViewerController
	{
		private var _view:GameStageBgView = null;
		
		public function GameStageBgViewController()
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
			_view = new GameStageBgView();
		}
		
		
	}
}