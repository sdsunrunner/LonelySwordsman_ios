package game.view.welcomeScence
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.manager.gameLevelManager.GameLevelManager;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.event.MainScenceEvent;
	
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	/**
	 * 欢迎场景视图控制器 
	 * @author songdu.greg
	 * 
	 */	
	public class WelcomeSenceViewController extends BaseViewerController
	{
		private var _view:WelcomeSenceView = null;
		private var _gameLevelManager:GameLevelManager = null;
		public function WelcomeSenceViewController()
		{
			super();
			this.initView();
			this.addListeners();
		}
		
		public function smothHideView():void
		{
			_view.smothHideView();
		}
		public function buyBossSuccess():void
		{
			this._view.buyBossSuccess();
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
			_view = new WelcomeSenceView();			
			_gameLevelManager = GameLevelManager.instance;
		}
		
		private function addListeners():void
		{
			viewer.addEventListener(MainScenceEvent.START_GAME_LEV, startGameLevHandler);
			viewer.addEventListener(MainScenceEvent.START_NEW_GAME, startNewGameHandler);
			viewer.addEventListener(MainScenceEvent.HIDE_VIEW_READY, destroyViewHandler);
			viewer.addEventListener(MainScenceEvent.SURVIVAL_MODEL_BTN_CLICK, gameSurModelHandler);
			viewer.addEventListener(MainScenceEvent.BATTLE_MODEL_CLOSE_BTN_CLICK,closeBattleModeView);
			viewer.addEventListener(MainScenceEvent.BATTLE_MODEL_START,startBattleModehandler);
			viewer.addEventListener(MainScenceEvent.SHOW_STORE, showStoreHandler);
			viewer.addEventListener(MainScenceEvent.SHARE_TO_WEIXIN, shareToWeiXinHandler);
			viewer.addEventListener(MainScenceEvent.GOTO_GIVE_SCORE, giveScoreHandler);
			viewer.addEventListener(MainScenceEvent.CALL_ME, callMeHandler);
		}
		
		
		
		private function startGameLevHandler(evt:Event):void
		{
			_view.touchable = false;
			_gameLevelManager.currentGameModel = GameModeEnum.TYPE_STORY_MODEL;
			this.sendNotification(CommandInteracType.CLEAR_WELCOME_SCENCE);
		}
		
		private function startNewGameHandler(evt:Event):void
		{
			_view.touchable = false;
			_gameLevelManager.currentGameModel = GameModeEnum.TYPE_STORY_MODEL;
			this.sendNotification(CommandInteracType.START_NEW_GAME);
		}
		
		private function destroyViewHandler(evt:Event):void
		{
			this.sendNotification(CommandViewType.CLOSE_WELCOME_SCENCE);
		}
		
		private function gameSurModelHandler():void
		{
			_view.touchable = false;
			_gameLevelManager.currentGameModel = GameModeEnum.TYPE_SURVIVAL_MODEL;
			this.sendNotification(CommandInteracType.CLEAR_WELCOME_SCENCE);
		}
		
		private function closeBattleModeView():void
		{
			_view.quitBattleMode();
		}
		
		
		private function startBattleModehandler():void
		{
			_view.touchable = false;			
			this.sendNotification(CommandInteracType.CLEAR_WELCOME_SCENCE);
		}
		
		private function showStoreHandler():void
		{
			this.sendNotification(CommandViewType.PRODUCT_STORE_VIEW);
		}
		
		private function shareToWeiXinHandler():void
		{
			this.sendNotification(CommandInteracType.SHARE_IMAGE_TO_WEIXIN,"welcomePage");
		}
		
		private function callMeHandler():void
		{
			this.sendNotification(CommandInteracType.CALL_ME);
		}
		
		private function giveScoreHandler():void
		{
			// TODO Auto Generated method stub
			this.sendNotification(CommandInteracType.GIVE_SCORE,"welcomePage");
		}
	}
}