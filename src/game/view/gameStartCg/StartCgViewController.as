package game.view.gameStartCg
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import game.interactionType.CommandInteracType;
	import game.view.event.MainScenceEvent;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * 开场cg视图控制器 
	 * @author admin
	 * 
	 */	
	public class StartCgViewController extends BaseViewerController
	{
		private var _view:StartCgView = null;
		
		public function StartCgViewController()
		{
			super();
			this.initView();
			this.addListeners();
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
			_view = new StartCgView();
		}
		
		private function addListeners():void
		{
			_view.addEventListener(MainScenceEvent.GAME_START_CG_END, gameStartCgEndHandler);
		}		
		
		private function gameStartCgEndHandler():void
		{	
//			if(GameLevelManager.instance.isStartNewGame)			
//				this.sendNotification(CommandInteracType.START_NEW_GAME_CG_END);
//			else
				this.sendNotification(CommandInteracType.SCENCE_WELCOME_INIT);
		}
	}
}