package game.view.gameEndMenu
{
	import com.greensock.TweenMax;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.MainScenceEvent;
	
	import lzm.starling.gestures.TapGestures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * 游戏结束菜单视图 
	 * @author admin
	 * 
	 */	
	public class HeroDeathGameEndMenu extends BaseViewer
	{
		private var _bgMask:Image = null;
		private var _resetMenu:Image = null;
		private var _mainMenu:Image = null;
		private var _pingfen:Image = null;
		private var _menuContainer:Sprite = null;
		
		private var _battleModeResult:BattModeGameEndView = null;
		private var _suverModeResult:SurverModeGameEndView = null;
		
		public function HeroDeathGameEndMenu()
		{
			super();
			this.initView();
			this.addListeners();
		}
		override public function get width():Number
		{
		 	return Const.STAGE_WIDTH;
		}
		
		override public function get height():Number
		{
			return Const.STAGE_HEIGHT;
		}
		
		override public function dispose():void
		{
			_resetMenu.dispose();
			_mainMenu.dispose();
			
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}		
		}
		
		public function closeBattleEndResuLtView():void
		{
			if(_battleModeResult)
				hideBattleModeResultHandler();
			if(_suverModeResult)
				hideSurverModeResultHandler();
		}
		
		/**
		 * 显示对战模式结果 
		 * @param win
		 * 
		 */		
		public function showBattleResult(win:Boolean):void
		{
			_battleModeResult = new BattModeGameEndView();
			this.addChild(_battleModeResult);
			_battleModeResult.showResult(win);
			
//			var battleResultTap:TapGestures = new TapGestures(_battleModeResult, hideResultHandler);
//			TweenMax.to(_battleModeResult,0.5,{alpha:1});
		}
		
		/**
		 * 显示生存模式结果 
		 * @param score
		 * 
		 */		
		public function showSurverModeResult():void
		{
			_suverModeResult = new SurverModeGameEndView();
			this.addChild(_suverModeResult);
		}
		
		private function initView():void
		{
			this.alpha = 0;
			_menuContainer = new Sprite();
			this.addChild(_menuContainer);
			
			_bgMask =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("blackMask"));
			_bgMask.x = -10;
			_bgMask.y = -10;
			
			_bgMask.width = Const.STAGE_WIDTH+20;
			_bgMask.height = Const.STAGE_HEIGHT+20;
			_bgMask.alpha = 0.5;
			
			_resetMenu = new Image(assetManager.getTextureAtlas("gui_images").getTexture("restLev"));
			_mainMenu = new Image(assetManager.getTextureAtlas("gui_images").getTexture("menu"));
			_pingfen =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("giveScore"));
			
			_menuContainer.addChild(_bgMask);
			_menuContainer.addChild(_resetMenu);
			_menuContainer.addChild(_mainMenu);
			
			_menuContainer.addChild(_pingfen);
			
			_resetMenu.x = (Const.STAGE_WIDTH - _resetMenu.width)/2;
			

			_resetMenu.y = (Const.STAGE_HEIGHT - _resetMenu.height)/2-120;
			_mainMenu.y = (Const.STAGE_HEIGHT - _mainMenu.height)/2 ;
			_pingfen.y =  (Const.STAGE_HEIGHT - _mainMenu.height)/2 + 120;
				
			_mainMenu.x = _resetMenu.x;	
			_pingfen.x =  _resetMenu.x;
			
			TweenMax.to(this,0.2,{alpha:1});
		}
		
		private function addListeners():void
		{
			var tapRestart:TapGestures = new TapGestures(_resetMenu, resetGameBtnTapHandler);
			var menutab:TapGestures = new TapGestures(_mainMenu, showMainMenuScenceBtnTapHandler);		
//			var moreGame:TapGestures = new TapGestures(_resetGameLevMenu, resetGameLevBtnTapHandler);
			var pingfen:TapGestures = new TapGestures(_pingfen, pingfenTapHandler);
		}
		
		private function resetGameBtnTapHandler():void
		{
//			this.touchable = false;
			this.dispatchEventWith(MainScenceEvent.GAME_END_REST_GAME_LEV);
		}
		
		private function showMainMenuScenceBtnTapHandler():void
		{
//			this.touchable = false;
			this.dispatchEventWith(MainScenceEvent.GAME_END_SHOW_MAIN_MENU_SCENCE);
		}
		
		private function resetGameLevBtnTapHandler():void
		{
//			this.touchable = false;
			this.dispatchEventWith(MainScenceEvent.GAME_END_REST_GAME_LEV);
		}
		private function pingfenTapHandler():void
		{
			//			this.touchable = false;
			this.dispatchEventWith(MainScenceEvent.GOTO_GIVE_SCORE);
		}
		
		private function hideBattleModeResultHandler():void
		{
			this.removeChild(_battleModeResult,true);
			_battleModeResult.touchable = false;
			_battleModeResult.dispose();
			_battleModeResult = null;
		}
		
		private function hideSurverModeResultHandler():void
		{
			this.removeChild(_suverModeResult,true);
			_suverModeResult.touchable = false;
			_suverModeResult.dispose();
			_suverModeResult = null;
		}
		
	}
}