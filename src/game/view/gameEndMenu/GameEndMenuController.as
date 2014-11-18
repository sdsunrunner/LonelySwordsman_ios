package game.view.gameEndMenu
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.view.event.MainScenceEvent;
	
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	/**
	 * 游戏结束菜单控制器 
	 * @author admin
	 * 
	 */	
	public class GameEndMenuController extends BaseViewerController
	{
		private var _view:HeroDeathGameEndMenu = null;
		
		public function GameEndMenuController()
		{
			super();
			this.initView();
			this.addListeners();
		}
		
		public function showResult(win:Boolean):void
		{
			this._view.showBattleResult(win);
		}
		
		public function showSurverModeResult():void
		{
			this._view.showSurverModeResult();
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
			_view = new HeroDeathGameEndMenu();
		}
		
		private function addListeners():void
		{
			_view.addEventListener(MainScenceEvent.GAME_END_REST_GAME_LEV, gameEndResetHandler);
			_view.addEventListener(MainScenceEvent.GAME_END_SHOW_MAIN_MENU_SCENCE,gameEndShowMainMenuScencehandler);
			_view.addEventListener(MainScenceEvent.GAME_END_SHOW_MORE_GAME,gameEndShowMoreGameHandler);
			_view.addEventListener(MainScenceEvent.GOTO_GIVE_SCORE,gameEndPingfenHandler);
			
			_view.addEventListener(MainScenceEvent.SHARE_TO_WEIXIN, shareToWeiXinhandler);
			_view.addEventListener(MainScenceEvent.SHARE_TO_WEIBO, shareToWeiBohandler);
			_view.addEventListener(MainScenceEvent.CLOSE_BATTLE_END_RESULR_VIEW, closeBattleEndResuLtView);
		}
		
		private function gameEndResetHandler(evt:Event):void
		{
			this.sendNotification(CommandInteracType.GAME_END_HERO_REBORN);
		}
		
		private function gameEndShowMainMenuScencehandler(evt:Event):void
		{
			this.sendNotification(CommandInteracType.GAME_END_SHOW_MAIN_MENU_SCENCE);
		}
		
		private function gameEndShowMoreGameHandler(evt:Event):void
		{
			this.sendNotification(CommandViewType.SHOW_MAIN_MENU_SCENCE);
		}
		
		private function gameEndPingfenHandler(evt:Event):void
		{
			this.sendNotification(CommandInteracType.GIVE_SCORE,"heroDeath");
		}
		
		
		private function shareToWeiXinhandler(evt:Event):void
		{
			this.sendNotification(CommandInteracType.SHARE_IMAGE_TO_WEIXIN,"heroDeath");
		}
		
		private function shareToWeiBohandler(evt:Event):void
		{
			this.sendNotification(CommandInteracType.SHARE_IMAGE_TO_WEIBO);
		}
		
		private function closeBattleEndResuLtView(evt:Event):void
		{
			_view.closeBattleEndResuLtView();
		}
	}
	
}