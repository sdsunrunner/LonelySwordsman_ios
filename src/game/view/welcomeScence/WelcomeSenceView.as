package game.view.welcomeScence
{
	import com.greensock.TweenMax;
	
	import flash.utils.setTimeout;
	
	import extend.draw.display.Shape;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.manager.gameLevelManager.GameLevelManager;
	import game.view.event.MainScenceEvent;
	import game.view.welcomeScence.battleModelStart.BattleStartView;
	import game.view.welcomeScence.ornamentView.CloseShotOrnamentView;
	import game.view.welcomeScence.ornamentView.MediumOrnamentView;
	
	import lzm.starling.gestures.TapGestures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * 欢迎场景 
	 * @author songdu.greg
	 * 
	 */	
	public class WelcomeSenceView extends BaseViewer
	{
		private var _mainScenceContainer:Sprite = null;
		
		private var _continueBtn:Image = null;
		
		
		private var _startNewGameBtn:Image = null;
		private var _gameLogo:Image = null;
		private var _shujian:Image = null;
		private var _mediumOrnamentView:MediumOrnamentView = null;
		private var _closeShotOrnamentView:CloseShotOrnamentView = null;

		private var _menuContainer:Sprite = null;	
		private var _shap:Shape = null;
		private var _mainMenuView:MainMenuView = null;			
		private var _battleModelView:BattleStartView = null;
		
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
			super.dispose();
			if(_battleModelView)
				_battleModelView.dispose();
			
			while(_mainScenceContainer.numChildren>0)
			{
				_mainScenceContainer.removeChildAt(0,true);
			}
			
			while(this.numChildren > 0)
			{
				this.removeChildAt(0,true);
			}		
			
			soundExpressions.stopSound(Const.WEL_COME_SCENCE_BG_SOUND);
		}
		
		
		public function buyBossSuccess():void
		{
			if(_battleModelView)
				_battleModelView.buyBossSuccess();
		}
		public function quitBattleMode():void
		{
			_mainScenceContainer.visible = true;
			_battleModelView.dispose();
			this.removeChild(_battleModelView,true);
		}	
		
		public function smothHideView():void
		{
			_closeShotOrnamentView.reset();
			_mediumOrnamentView.reset();
			
			TweenMax.to(this, 1,{alpha:0, onComplete:function():void
			{
				noteViewHideReady();
			}
			});
		
		}
		
		public function WelcomeSenceView()
		{
			this.initView();
			this.addListeners();
		}
		
		private function initView():void
		{
			this.playScenceSound();
			
			_mainScenceContainer = new Sprite();
			this.addChild(_mainScenceContainer);
			
			//中景视图
			_mediumOrnamentView = new MediumOrnamentView();
			
			_mainScenceContainer.addChild(_mediumOrnamentView);
			
			//底部遮罩
			_shap = new Shape();
			_shap.graphics.beginFill(ColorConst.ROAD_COLOR);
			
				_shap.graphics.drawRect(0,Const.STAGE_HEIGHT*4.8/6,Const.STAGE_WIDTH,Const.STAGE_HEIGHT*1.2/6);
			
			_mainScenceContainer.addChild(_shap);
			
				_mediumOrnamentView.y = Const.STAGE_HEIGHT*4.8/6-130;
			//近景视图
			_closeShotOrnamentView = new CloseShotOrnamentView();
			_mainScenceContainer.addChild(_closeShotOrnamentView);
			
			
			_gameLogo = new Image(assetManager.getTextureAtlas("gui_images").getTexture("gameName"));
			_gameLogo.x = Math.ceil(Const.STAGE_WIDTH * 1.2/2);
			if(Const.STAGE_HEIGHT<700)
				_gameLogo.y = 40;
			else
				_gameLogo.y = 100;
			
		
			_mainScenceContainer.addChild(_gameLogo);
			
			_shujian = new Image(assetManager.getTextureAtlas("gui_images").getTexture("shujian"));
			_shujian.x = _gameLogo.x + 150;
			_shujian.y = _gameLogo.y+90;
			_mainScenceContainer.addChild(_shujian);
			
			_menuContainer = new Sprite();
			_menuContainer.x = _gameLogo.x ;
			if(Const.STAGE_HEIGHT<700)
				_menuContainer.y = 250;
			else
				_menuContainer.y = 320;
			_mainScenceContainer.addChild(_menuContainer);
		
			
			_continueBtn =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("playBtn"));
			_continueBtn.x = 70;
			_menuContainer.addChild(_continueBtn);
			
			_startNewGameBtn = new Image(assetManager.getTextureAtlas("gui_images").getTexture("newGameBtn"));
			_startNewGameBtn.y = _continueBtn.y + 200;
			_startNewGameBtn.x = _continueBtn.x;
	
//			_menuContainer.addChild(_startNewGameBtn);
		
			_menuContainer.alpha = 0;
			_menuContainer.touchable = true;
			setTimeout(delayShowMainMenu,500);
		}
		
		private function playScenceSound():void
		{
			this.soundExpressions.playWelcomeScenceSound();
		}
		
		private function delayShowMainMenu():void
		{
			_mainMenuView = new MainMenuView();
			_mainMenuView.y = _gameLogo.y ;
			_mainMenuView.x = 10;
			_mainScenceContainer.addChild(_mainMenuView);
			_mainMenuView.alpha = 0;
			TweenMax.to(_mainMenuView,1,{alpha:1});
			TweenMax.to(_menuContainer,1,{alpha:1})
			addGestures();
		}
		
		private function addListeners():void
		{
			this.addEventListener(MainScenceEvent.NOTE_VIEW_READY, viewReadyHandler);
		}
		
		private function addGestures():void
		{
			var continuetab:TapGestures = new TapGestures(_continueBtn, continueGameBtnTapHandler);		
			this.addEventListener(MainScenceEvent.BATTLE_MODEL_BTN_CLICK, gameBttleModelHandler);
			var startNewGame:TapGestures = new TapGestures(_startNewGameBtn, startNewGameTapHandler);
		}
		
		private function viewReadyHandler(evt:Event):void
		{
			TweenMax.to(_menuContainer,1,{alpha:1, onComplete:function():void
			{
			
			}
			});
		}
		
		private function continueGameBtnTapHandler():void
		{
			
			GameLevelManager.instance.isStartNewGame = false;
			this.touchable = false;			
			this.dispatchEventWith(MainScenceEvent.START_GAME_LEV);
		}
		
		private function startNewGameTapHandler():void
		{
			
			GameLevelManager.instance.isStartNewGame = true;
			this.touchable = false;			
			this.dispatchEventWith(MainScenceEvent.START_NEW_GAME);
		}
		
		private function noteViewHideReady():void
		{		
			
			this.dispatchEventWith(MainScenceEvent.HIDE_VIEW_READY);
		}
		
		private function gameBttleModelHandler():void
		{		
			
			_mainScenceContainer.visible = false;
			_battleModelView = new BattleStartView();
			this.addChild(_battleModelView);
		}
	}
}