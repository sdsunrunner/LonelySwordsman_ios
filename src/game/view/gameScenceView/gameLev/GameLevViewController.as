package game.view.gameScenceView.gameLev
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import game.interactionType.CommandViewType;
	import game.view.gameScenceView.gameLevInterface.IGameLevViewController;
	
	import starling.display.DisplayObjectContainer;
	
	import vo.configInfo.ObjGameLevelConfigInfo;
	
	/**
	 * 关卡视图控制器 
	 * @author songdu
	 * 
	 */	
	public class GameLevViewController extends BaseViewerController implements IGameLevViewController
	{
		private var _view:GameLevView = null;
		
		public function GameLevViewController()
		{
			super();
			this.initView();
		}
		
		public function zoomCloseShotView():void
		{
			_view.zoomCloseShotView();
		}
		
		public function initGameLev(tmxXml:XML,levConfigInfo:ObjGameLevelConfigInfo):void
		{
			_view.initGameLevView(tmxXml,levConfigInfo);
			this.sendNotification(CommandViewType.CLOSE_SCENCE_MASK);
		}
		
		override public function get viewer():DisplayObjectContainer
		{
			return _view;
		}
		
		override public function dispose():void
		{
			_view.dispose();
			_view = null;
		}
		
		private function initView():void
		{
			_view = new GameLevView();
		}
		
		
	}
}